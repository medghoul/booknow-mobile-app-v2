import 'dart:io';

import 'package:booknow_mobile/core/config/app_config.dart';
import 'package:booknow_mobile/core/services/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/// How a payment ended, from the app's point of view.
///
/// Three outcomes, not two: a customer who closed the sheet still holds the
/// slot and can try again, while a refused card is the state the design calls
/// 3b and needs its own screen. Treating the two the same would either nag
/// somebody who changed their mind or hide a decline behind a dismissal.
enum PaymentOutcome { paid, cancelled, failed }

/// The Stripe Payment Sheet, behind one method.
///
/// The app never sees a card number, never names an amount, and never confirms
/// anything itself: the sheet is Stripe's, driven entirely by the client
/// secret the server issued for a slot it has already held.
class PaymentService {
  const PaymentService();

  /// The country the money is settled in, not the customer's own.
  ///
  /// Apple and Google both ask for the *merchant's* country: it decides which
  /// card networks the wallet offers and which acquirer rules apply. The
  /// Stripe account is Italian, so this is fixed rather than read from the
  /// phone's locale — a customer paying from abroad still pays an Italian
  /// business.
  static const _merchantCountry = 'IT';

  /// Google Pay has two environments, and only the test one will hand back a
  /// token a test Stripe key can charge. Tying it to the key itself means a
  /// build can never end up asking the live wallet for a sandbox payment.
  static bool get _googlePayTest =>
      AppConfig.stripePublishableKey.startsWith('pk_test');

  /// Apple Pay only on an iPhone, and only with a merchant identifier
  /// registered with Apple: the plugin asserts on a missing one before it
  /// draws anything, even on Android. Without it the sheet still opens, with
  /// cards (and Google Pay on Android).
  static bool get _offerApplePay =>
      Platform.isIOS && (Stripe.merchantIdentifier ?? '').isNotEmpty;

  /// Google Pay is Android's wallet; there is nothing to offer elsewhere.
  static bool get _offerGooglePay => Platform.isAndroid;

  Future<PaymentOutcome> pay({
    required String clientSecret,
    required String merchantName,
  }) async {
    if (!AppConfig.hasStripe) {
      AppLogger.error(
        '[payments] STRIPE_PUBLISHABLE_KEY is empty in ${AppConfig.fileName}',
      );
      return PaymentOutcome.failed;
    }

    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: merchantName,
          // The sheet follows the phone, not the app's own theme toggle: it is
          // a system surface and should look like one.
          style: ThemeMode.system,
          // The wallets are opt-in on the client even when the PaymentIntent
          // already allows them. `automatic_payment_methods` decides what the
          // *server* will accept; these two decide what the sheet bothers to
          // draw, and without them Apple Pay and Google Pay never appear
          // however the Stripe dashboard is configured.
          applePay: _offerApplePay
              ? const PaymentSheetApplePay(
                  merchantCountryCode: _merchantCountry,
                )
              : null,
          googlePay: _offerGooglePay
              ? PaymentSheetGooglePay(
                  merchantCountryCode: _merchantCountry,
                  testEnv: _googlePayTest,
                )
              : null,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      return PaymentOutcome.paid;
    } on StripeException catch (error) {
      if (error.error.code == FailureCode.Canceled) {
        return PaymentOutcome.cancelled;
      }

      // The message is Stripe's and is shown by the sheet itself; logging it
      // is for the console, not the customer.
      AppLogger.warning('[payments] declined: ${error.error.code}');
      return PaymentOutcome.failed;
    } catch (error, stackTrace) {
      AppLogger.error('[payments] sheet failed', error, stackTrace);
      return PaymentOutcome.failed;
    }
  }
}
