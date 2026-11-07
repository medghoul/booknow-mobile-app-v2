import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// The scaffold every screen is built on.
///
/// It owns the horizontal screen gutter, so screens must not pad their own
/// content again — two gutters stack and squeeze the layout. Anything that
/// has to reach the screen edge (a full-bleed image, a horizontally scrolling
/// day strip) goes in [edgeToEdgeBody], which is laid out outside the gutter.
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.edgeToEdgeBody,
    this.scrollable = false,
    this.centerContent = false,
    this.canPop = true,
    this.onPopInvokedWithResult,
    this.backgroundColor,
    this.padding,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.useSafeArea = true,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;

  /// A docked action area pinned above the safe-area inset — the "Confirm and
  /// pay" bar on the booking summary, for instance. It keeps the screen's
  /// gutter but sits outside the scroll view, so it stays put.
  final Widget? bottomBar;

  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Content laid out without the screen gutter, above [body].
  final Widget? edgeToEdgeBody;

  final bool scrollable;
  final bool centerContent;

  /// False blocks the system back gesture — used while a payment is in flight.
  final bool canPop;

  final void Function(bool didPop, Object? result)? onPopInvokedWithResult;
  final Color? backgroundColor;

  /// Overrides the screen gutter. Pass [EdgeInsets.zero] for a screen that
  /// manages its own insets entirely.
  final EdgeInsetsGeometry? padding;

  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;

  /// False drops the top safe-area inset, so content centres on the whole screen rather than on the area below the status bar. The splash needs this: it has to land in exactly the same place as the native launch screen, which knows nothing about safe areas.
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: canPop,
      onPopInvokedWithResult: onPopInvokedWithResult,
      child: Scaffold(
        appBar: appBar,
        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: SafeArea(
          top: useSafeArea && !extendBodyBehindAppBar,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ?edgeToEdgeBody,
              Expanded(child: _body(context)),
              if (bottomBar != null) _bottomBar(context, bottomBar!),
            ],
          ),
        ),
      ),
    );
  }

  EdgeInsetsGeometry _gutter(BuildContext context) =>
      padding ?? context.spacing.screenGutter;

  Widget _body(BuildContext context) {
    final padded = Padding(padding: _gutter(context), child: body);

    if (scrollable) {
      return SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.spacing.xl.h),
        child: padded,
      );
    }

    return centerContent ? Center(child: padded) : padded;
  }

  /// Keeps the docked bar clear of the home indicator and of the keyboard.
  Widget _bottomBar(BuildContext context, Widget child) {
    return Padding(
      padding: _gutter(context).add(
        EdgeInsets.only(
          top: context.spacing.sm.h,
          bottom: context.spacing.lg.h + context.mediaQuery.padding.bottom,
        ),
      ),
      child: child,
    );
  }
}
