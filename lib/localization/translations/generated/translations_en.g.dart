///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$nav$en nav = Translations$nav$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
	late final Translations$bookingStatus$en bookingStatus = Translations$bookingStatus$en.internal(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
	late final Translations$auth$en auth = Translations$auth$en.internal(_root);
	late final Translations$profile$en profile = Translations$profile$en.internal(_root);
	late final Translations$help$en help = Translations$help$en.internal(_root);
	late final Translations$validation$en validation = Translations$validation$en.internal(_root);
	late final Translations$shopSetup$en shopSetup = Translations$shopSetup$en.internal(_root);
	late final Translations$weekdays$en weekdays = Translations$weekdays$en.internal(_root);
	late final Translations$notifications$en notifications = Translations$notifications$en.internal(_root);
	late final Translations$notificationSettings$en notificationSettings = Translations$notificationSettings$en.internal(_root);
	late final Translations$bookings$en bookings = Translations$bookings$en.internal(_root);
	late final Translations$account$en account = Translations$account$en.internal(_root);
	late final Translations$home$en home = Translations$home$en.internal(_root);
	late final Translations$agenda$en agenda = Translations$agenda$en.internal(_root);
	late final Translations$flow$en flow = Translations$flow$en.internal(_root);
	late final Translations$queue$en queue = Translations$queue$en.internal(_root);
	late final Translations$categories$en categories = Translations$categories$en.internal(_root);
	late final Translations$search$en search = Translations$search$en.internal(_root);
	late final Translations$live$en live = Translations$live$en.internal(_root);
	late final Translations$guest$en guest = Translations$guest$en.internal(_root);
	late final Translations$welcome$en welcome = Translations$welcome$en.internal(_root);
	late final Translations$shopScreen$en shopScreen = Translations$shopScreen$en.internal(_root);
	late final Translations$today$en today = Translations$today$en.internal(_root);
	late final Translations$chairs$en chairs = Translations$chairs$en.internal(_root);
	late final Translations$statistics$en statistics = Translations$statistics$en.internal(_root);
	late final Translations$homeWidgets$en homeWidgets = Translations$homeWidgets$en.internal(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'BookNow'
	String get appName => 'BookNow';

	/// en: 'Continue'
	String get continue_ => 'Continue';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Try again'
	String get retry => 'Try again';

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Not now'
	String get notNow => 'Not now';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Loading…'
	String get loading => 'Loading…';

	/// en: 'No connection'
	String get offline => 'No connection';

	/// en: '${name} ${price} · ${minutes} min'
	String serviceLine({required Object name, required Object price, required Object minutes}) => '${name} ${price} · ${minutes} min';
}

// Path: nav
class Translations$nav$en {
	Translations$nav$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Statistics'
	String get statistics => 'Statistics';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Calendar'
	String get calendar => 'Calendar';

	/// en: 'Shop'
	String get shop => 'Shop';

	/// en: 'Discover'
	String get discover => 'Discover';

	/// en: 'Activity'
	String get activity => 'Activity';

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Bookings'
	String get bookings => 'Bookings';

	/// en: 'Agenda'
	String get agenda => 'Agenda';

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'That customer has already moved on.'
	String get visitMoved => 'That customer has already moved on.';

	/// en: 'Something went wrong. Please try again.'
	String get generic => 'Something went wrong. Please try again.';

	/// en: 'You appear to be offline.'
	String get noConnection => 'You appear to be offline.';

	/// en: 'The request took too long.'
	String get timeout => 'The request took too long.';

	/// en: 'Our service is having trouble. Please try again shortly.'
	String get server => 'Our service is having trouble. Please try again shortly.';

	/// en: 'Your session has expired. Please sign in again.'
	String get unauthorized => 'Your session has expired. Please sign in again.';

	/// en: 'You don't have access to this.'
	String get forbidden => 'You don\'t have access to this.';

	/// en: 'We couldn't find that.'
	String get notFound => 'We couldn\'t find that.';

	/// en: 'Too many attempts. Please wait a moment.'
	String get tooManyRequests => 'Too many attempts. Please wait a moment.';

	/// en: 'That slot was just taken. Please pick another one.'
	String get slotTaken => 'That slot was just taken. Please pick another one.';

	/// en: 'Your slot was released because payment took too long.'
	String get holdExpired => 'Your slot was released because payment took too long.';

	/// en: 'That slot is too soon to book.'
	String get leadTimeTooShort => 'That slot is too soon to book.';

	/// en: 'That date isn't open for booking yet.'
	String get outsideBookingHorizon => 'That date isn\'t open for booking yet.';

	/// en: 'The shop is closed on that day.'
	String get shopClosed => 'The shop is closed on that day.';

	/// en: 'It's too late to cancel and be refunded.'
	String get cancellationWindowPassed => 'It\'s too late to cancel and be refunded.';

	/// en: 'That time can't be booked.'
	String get slotNotBookable => 'That time can\'t be booked.';

	/// en: 'That service is no longer available.'
	String get serviceNotAvailable => 'That service is no longer available.';

	/// en: 'That range can't be blocked.'
	String get invalidBlock => 'That range can\'t be blocked.';

	/// en: 'Some details are still missing before you can publish.'
	String get shopIncomplete => 'Some details are still missing before you can publish.';

	/// en: 'A shop can have up to 10 people working.'
	String get providerLimitReached => 'A shop can have up to 10 people working.';

	/// en: 'Customers are still booked with them or waiting for them. Move or cancel those first.'
	String get providerInUse => 'Customers are still booked with them or waiting for them. Move or cancel those first.';

	/// en: 'That's you, so you can't be removed.'
	String get defaultProvider => 'That\'s you, so you can\'t be removed.';

	/// en: 'They aren't available for this service. Please choose someone else.'
	String get providerNotAvailable => 'They aren\'t available for this service. Please choose someone else.';
}

// Path: bookingStatus
class Translations$bookingStatus$en {
	Translations$bookingStatus$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Awaiting payment'
	String get pendingPayment => 'Awaiting payment';

	/// en: 'Confirmed'
	String get confirmed => 'Confirmed';

	/// en: 'Arrived'
	String get arrived => 'Arrived';

	/// en: 'No-show'
	String get noShow => 'No-show';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Expired'
	String get expired => 'Expired';
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Skip'
	String get skip => 'Skip';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Get started'
	String get start => 'Get started';

	/// en: 'I already have an account'
	String get haveAccount => 'I already have an account';

	late final Translations$onboarding$slideOne$en slideOne = Translations$onboarding$slideOne$en.internal(_root);
	late final Translations$onboarding$slideTwo$en slideTwo = Translations$onboarding$slideTwo$en.internal(_root);
	late final Translations$onboarding$slideThree$en slideThree = Translations$onboarding$slideThree$en.internal(_root);
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Continue with Apple'
	String get continueWithApple => 'Continue with Apple';

	/// en: 'Continue with Google'
	String get continueWithGoogle => 'Continue with Google';

	/// en: 'Sign up with Apple'
	String get signUpWithApple => 'Sign up with Apple';

	/// en: 'Sign up with Google'
	String get signUpWithGoogle => 'Sign up with Google';

	late final Translations$auth$signIn$en signIn = Translations$auth$signIn$en.internal(_root);
	late final Translations$auth$signUp$en signUp = Translations$auth$signUp$en.internal(_root);
	late final Translations$auth$role$en role = Translations$auth$role$en.internal(_root);
	late final Translations$auth$profile$en profile = Translations$auth$profile$en.internal(_root);
}

// Path: profile
class Translations$profile$en {
	Translations$profile$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Signed out'
	String get signedOut => 'Signed out';

	/// en: 'Reminders off'
	String get remindersOff => 'Reminders off';

	/// en: 'On, ${when} before'
	String notificationsOnBefore({required Object when}) => 'On, ${when} before';

	/// en: 'Help'
	String get ownerHelp => 'Help';

	/// en: 'Questions, write to us'
	String get helpLine => 'Questions, write to us';

	/// en: 'Customers'
	String get modeRow => 'Customers';

	/// en: 'Your shop'
	String get shopTitle => 'Your shop';

	/// en: 'Live on BookNow'
	String get shopLive => 'Live on BookNow';

	/// en: 'Not visible to customers yet'
	String get shopHidden => 'Not visible to customers yet';

	/// en: 'See as customer'
	String get seeAsCustomer => 'See as customer';

	/// en: 'How you work'
	String get howYouWork => 'How you work';

	/// en: 'Your account'
	String get yourAccount => 'Your account';

	/// en: 'Profile'
	String get title => 'Profile';

	/// en: 'owner'
	String get roleOwner => 'owner';

	/// en: 'customer'
	String get roleCustomer => 'customer';

	/// en: 'What customers see'
	String get shopSection => 'What customers see';

	/// en: 'photo'
	String get shopPhotoPlaceholder => 'photo';

	/// en: 'Your shop'
	String get shopNameMissing => 'Your shop';

	/// en: 'Finish setting up your shop'
	String get shopDetailsMissing => 'Finish setting up your shop';

	/// en: 'Services'
	String get services => 'Services';

	/// en: '(one) {${n} service} (other) {${n} services}'
	String servicesCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} service',
		other: '${n} services',
	);

	/// en: 'Hours'
	String get hours => 'Hours';

	/// en: 'Not set'
	String get hoursNone => 'Not set';

	/// en: 'Team'
	String get team => 'Team';

	/// en: 'Just you'
	String get teamJustYou => 'Just you';

	/// en: '(one) {${n} person} (other) {${n} people}'
	String teamCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} person',
		other: '${n} people',
	);

	/// en: 'Booking rules'
	String get bookingRules => 'Booking rules';

	/// en: 'Appearance'
	String get appearanceSection => 'Appearance';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Account'
	String get accountSection => 'Account';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'On'
	String get notificationsOn => 'On';

	/// en: 'Off'
	String get notificationsOff => 'Off';

	/// en: 'Help and contact'
	String get help => 'Help and contact';

	/// en: 'Sign out'
	String get signOut => 'Sign out';

	/// en: 'Delete account'
	String get deleteAccount => 'Delete account';

	late final Translations$profile$signOutDialog$en signOutDialog = Translations$profile$signOutDialog$en.internal(_root);
	late final Translations$profile$deleteSheet$en deleteSheet = Translations$profile$deleteSheet$en.internal(_root);

	/// en: 'Personal details'
	String get personalData => 'Personal details';

	/// en: 'Edit profile'
	String get editProfile => 'Edit profile';

	/// en: 'Signed in with ${provider}'
	String signedInWith({required Object provider}) => 'Signed in with ${provider}';

	late final Translations$profile$personal$en personal = Translations$profile$personal$en.internal(_root);
}

// Path: help
class Translations$help$en {
	Translations$help$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Help and contacts'
	String get screenTitle => 'Help and contacts';

	/// en: 'Frequent questions'
	String get faqSection => 'Frequent questions';

	/// en: 'Need anything else?'
	String get needMore => 'Need anything else?';

	late final Translations$help$faq$en faq = Translations$help$faq$en.internal(_root);

	/// en: 'Call the shop'
	String get callShop => 'Call the shop';

	/// en: 'For hours, services and appointments'
	String get callShopSubtitle => 'For hours, services and appointments';

	/// en: 'Write to BookNow'
	String get writeUs => 'Write to BookNow';

	/// en: 'Payments, refunds and the app · within 24 hours'
	String get writeUsSubtitle => 'Payments, refunds and the app · within 24 hours';

	/// en: 'Terms'
	String get terms => 'Terms';

	/// en: 'Privacy'
	String get privacy => 'Privacy';

	/// en: 'Version ${version}'
	String version({required Object version}) => 'Version ${version}';

	/// en: 'Cannot open the phone app.'
	String get callFailed => 'Cannot open the phone app.';

	/// en: 'Cannot open the link.'
	String get linkFailed => 'Cannot open the link.';

	late final Translations$help$topics$en topics = Translations$help$topics$en.internal(_root);
	late final Translations$help$write$en write = Translations$help$write$en.internal(_root);
	late final Translations$help$mail$en mail = Translations$help$mail$en.internal(_root);
}

// Path: validation
class Translations$validation$en {
	Translations$validation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'This field is required.'
	String get required => 'This field is required.';

	/// en: '${field} is required.'
	String requiredNamed({required Object field}) => '${field} is required.';

	/// en: 'Enter a valid email address.'
	String get email => 'Enter a valid email address.';

	/// en: 'Enter a valid phone number.'
	String get phone => 'Enter a valid phone number.';

	/// en: 'At least ${min} characters.'
	String tooShort({required Object min}) => 'At least ${min} characters.';

	/// en: 'At most ${max} characters.'
	String tooLong({required Object max}) => 'At most ${max} characters.';
}

// Path: shopSetup
class Translations$shopSetup$en {
	Translations$shopSetup$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$shopSetup$team$en team = Translations$shopSetup$team$en.internal(_root);
	late final Translations$shopSetup$checklist$en checklist = Translations$shopSetup$checklist$en.internal(_root);

	/// en: '${current}/${total}'
	String stepOf({required Object current, required Object total}) => '${current}/${total}';

	/// en: 'Continue'
	String get continue_ => 'Continue';

	late final Translations$shopSetup$shop$en shop = Translations$shopSetup$shop$en.internal(_root);
	late final Translations$shopSetup$details$en details = Translations$shopSetup$details$en.internal(_root);
	late final Translations$shopSetup$address$en address = Translations$shopSetup$address$en.internal(_root);
	late final Translations$shopSetup$services$en services = Translations$shopSetup$services$en.internal(_root);
	late final Translations$shopSetup$hours$en hours = Translations$shopSetup$hours$en.internal(_root);
	late final Translations$shopSetup$review$en review = Translations$shopSetup$review$en.internal(_root);
}

// Path: weekdays
class Translations$weekdays$en {
	Translations$weekdays$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$weekdays$short$en short = Translations$weekdays$short$en.internal(_root);
	late final Translations$weekdays$long$en long = Translations$weekdays$long$en.internal(_root);
}

// Path: notifications
class Translations$notifications$en {
	Translations$notifications$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Turn on notifications'
	String get allow => 'Turn on notifications';

	/// en: 'Not now'
	String get skip => 'Not now';

	late final Translations$notifications$owner$en owner = Translations$notifications$owner$en.internal(_root);
	late final Translations$notifications$customer$en customer = Translations$notifications$customer$en.internal(_root);
}

// Path: notificationSettings
class Translations$notificationSettings$en {
	Translations$notificationSettings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get screenTitle => 'Notifications';

	late final Translations$notificationSettings$blocked$en blocked = Translations$notificationSettings$blocked$en.internal(_root);
	late final Translations$notificationSettings$lead$en lead = Translations$notificationSettings$lead$en.internal(_root);
	late final Translations$notificationSettings$customer$en customer = Translations$notificationSettings$customer$en.internal(_root);
	late final Translations$notificationSettings$owner$en owner = Translations$notificationSettings$owner$en.internal(_root);
}

// Path: bookings
class Translations$bookings$en {
	Translations$bookings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Right now'
	String get rightNow => 'Right now';

	/// en: 'Upcoming'
	String get upcoming => 'Upcoming';

	/// en: 'Past'
	String get past => 'Past';

	/// en: 'Nothing scheduled'
	String get emptyTitle => 'Nothing scheduled';

	/// en: 'The bookings you make show up here, with their current status.'
	String get emptyBody => 'The bookings you make show up here, with their current status.';

	/// en: 'No history yet'
	String get emptyPastTitle => 'No history yet';

	/// en: 'Past appointments appear here.'
	String get emptyPastBody => 'Past appointments appear here.';

	/// en: '${price} in shop'
	String inShop({required Object price}) => '${price} in shop';

	/// en: '(one) {Expires in ${n} min} (other) {Expires in ${n} min}'
	String expiresIn({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Expires in ${n} min',
		other: 'Expires in ${n} min',
	);

	/// en: 'The slot is no longer held'
	String get holdLapsed => 'The slot is no longer held';

	/// en: 'Pay now'
	String get payNow => 'Pay now';

	/// en: 'Free cancellation until ${when}'
	String freeUntil({required Object when}) => 'Free cancellation until ${when}';

	/// en: 'Book again'
	String get repeat => 'Book again';

	/// en: 'by you'
	String get byYou => 'by you';

	/// en: 'by the shop'
	String get byShop => 'by the shop';

	/// en: 'refunded'
	String get refunded => 'refunded';

	/// en: 'not refunded'
	String get notRefunded => 'not refunded';

	/// en: 'paid'
	String get paid => 'paid';

	/// en: 'paid · •••• ${card}'
	String paidWithCard({required Object card}) => 'paid · •••• ${card}';

	/// en: 'The haircut is paid in the shop. Here you only see the status of your spot.'
	String get feeNote => 'The haircut is paid in the shop. Here you only see the status of your spot.';

	/// en: 'Your booking'
	String get detailTitle => 'Your booking';

	/// en: '${service} · ${minutes} minutes'
	String serviceLine({required Object service, required Object minutes}) => '${service} · ${minutes} minutes';

	/// en: 'Map'
	String get map => 'Map';

	/// en: 'Call the shop'
	String get callShop => 'Call the shop';

	/// en: 'to pay in the shop'
	String get payInShop => 'to pay in the shop';

	/// en: 'BookNow service'
	String get bookNowService => 'BookNow service';

	/// en: 'Add to calendar'
	String get addToCalendar => 'Add to calendar';

	/// en: 'No calendar app on this device.'
	String get calendarFailed => 'No calendar app on this device.';

	/// en: 'No maps app on this device.'
	String get mapFailed => 'No maps app on this device.';

	late final Translations$bookings$cancel$en cancel = Translations$bookings$cancel$en.internal(_root);
}

// Path: account
class Translations$account$en {
	Translations$account$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile'
	String get title => 'Profile';

	/// en: 'Signed in with ${provider}'
	String signedInWith({required Object provider}) => 'Signed in with ${provider}';

	/// en: 'Edit profile'
	String get editProfile => 'Edit profile';

	/// en: 'Appearance and language'
	String get appearanceTitle => 'Appearance and language';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Notifications'
	String get notificationsTitle => 'Notifications';

	/// en: 'Cut reminder'
	String get reminderTitle => 'Cut reminder';

	/// en: '2 hours before'
	String get reminderBody => '2 hours before';

	/// en: 'Shop news'
	String get shopNewsTitle => 'Shop news';

	/// en: 'Opening hours and closures'
	String get shopNewsBody => 'Opening hours and closures';

	/// en: 'Account'
	String get accountTitle => 'Account';

	/// en: 'Payments and receipts'
	String get payments => 'Payments and receipts';

	/// en: 'Switch to barber'
	String get switchToBarber => 'Switch to barber';

	/// en: 'Help and contact'
	String get help => 'Help and contact';

	/// en: 'Sign out'
	String get signOut => 'Sign out';

	/// en: 'Sign out?'
	String get signOutConfirmTitle => 'Sign out?';

	/// en: 'You will need to sign in again to see your bookings.'
	String get signOutConfirmBody => 'You will need to sign in again to see your bookings.';

	/// en: 'Delete account'
	String get deleteAccount => 'Delete account';

	/// en: 'Available soon.'
	String get comingSoon => 'Available soon.';
}

// Path: home
class Translations$home$en {
	Translations$home$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${n} · ${from}–${to} min'
	String waitShort({required Object n, required Object from, required Object to}) => '${n} · ${from}–${to} min';

	/// en: 'Use my location'
	String get useLocation => 'Use my location';

	/// en: 'Show the nearest shops first'
	String get useLocationLine => 'Show the nearest shops first';

	/// en: 'Couldn't get your location. Check it's on and allowed for BookNow.'
	String get locationFailed => 'Couldn\'t get your location. Check it\'s on and allowed for BookNow.';

	/// en: 'Sign in to see the shops near you.'
	String get guestBlocked => 'Sign in to see the shops near you.';

	/// en: 'Right now'
	String get intentNow => 'Right now';

	/// en: 'Tomorrow'
	String get intentTomorrow => 'Tomorrow';

	/// en: 'Search shops or services'
	String get searchHint => 'Search shops or services';

	/// en: 'Clear category'
	String get clearCategory => 'Clear category';

	/// en: 'Where should we look?'
	String get whereTitle => 'Where should we look?';

	/// en: 'List'
	String get list => 'List';

	/// en: 'Map'
	String get map => 'Map';

	/// en: '(one) {${n} shop can see you now} (other) {${n} shops can see you now}'
	String headlineNow({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} shop can see you now',
		other: '${n} shops can see you now',
	);

	/// en: '(one) {${n} shop free today} (other) {${n} shops free today}'
	String headlineToday({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} shop free today',
		other: '${n} shops free today',
	);

	/// en: '(one) {${n} shop to book tomorrow} (other) {${n} shops to book tomorrow}'
	String headlineTomorrow({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} shop to book tomorrow',
		other: '${n} shops to book tomorrow',
	);

	/// en: 'Shortest wait first'
	String get feedNow => 'Shortest wait first';

	/// en: 'Next free times'
	String get feedToday => 'Next free times';

	/// en: 'Book for tomorrow'
	String get feedTomorrow => 'Book for tomorrow';

	/// en: 'Shops aren't sorted by category yet, so this is every shop.'
	String get categoryNotice => 'Shops aren\'t sorted by category yet, so this is every shop.';

	/// en: 'No one can see you right now'
	String get emptyNowTitle => 'No one can see you right now';

	/// en: 'Book a time later today instead.'
	String get emptyNowBody => 'Book a time later today instead.';

	/// en: 'See today's times'
	String get emptyNowCta => 'See today\'s times';

	/// en: 'Join the line'
	String get joinLine => 'Join the line';

	/// en: 'Book a time'
	String get bookTime => 'Book a time';

	/// en: 'See the line'
	String get seeLine => 'See the line';

	/// en: 'See the times'
	String get seeTimes => 'See the times';

	/// en: 'Book a chair or skip the line'
	String get headerTitle => 'Book a chair or skip the line';

	/// en: 'What do you need?'
	String get whatDoYouNeed => 'What do you need?';

	/// en: 'Search by name'
	String get searchByName => 'Search by name';

	/// en: 'Where'
	String get whereLabel => 'Where';

	/// en: 'When'
	String get whenLabel => 'When';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'All cities'
	String get allCities => 'All cities';

	/// en: 'Search ${category}'
	String searchCategory({required Object category}) => 'Search ${category}';

	/// en: 'Fold search'
	String get foldSearch => 'Fold search';

	/// en: 'Open full search'
	String get openSearch => 'Open full search';

	/// en: 'Explore categories'
	String get explore => 'Explore categories';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Near you'
	String get nearYou => 'Near you';

	/// en: 'Shortest wait right now'
	String get shortestWait => 'Shortest wait right now';

	/// en: 'Join'
	String get join => 'Join';

	/// en: 'Book'
	String get book => 'Book';

	/// en: 'Open now'
	String get filterOpenNow => 'Open now';

	/// en: 'Nearest'
	String get filterNearest => 'Nearest';

	/// en: 'Shortest queue'
	String get filterShortestQueue => 'Shortest queue';

	/// en: '${n} waiting · ${from}–${to} min'
	String waiting({required Object n, required Object from, required Object to}) => '${n} waiting · ${from}–${to} min';

	/// en: 'No wait'
	String get noWait => 'No wait';

	/// en: 'Queue closed'
	String get queueClosed => 'Queue closed';

	/// en: 'Next ${time}'
	String nextAt({required Object time}) => 'Next ${time}';

	/// en: 'In queue'
	String get inQueue => 'In queue';

	/// en: 'View'
	String get view => 'View';

	/// en: 'Now'
	String get mapNow => 'Now';

	/// en: '${from}–${to}''
	String mapWait({required Object from, required Object to}) => '${from}–${to}\'';

	/// en: 'in line'
	String get inLine => 'in line';

	/// en: 'Ciao ${name}'
	String greeting({required Object name}) => 'Ciao ${name}';

	/// en: 'Ciao'
	String get greetingNoName => 'Ciao';

	/// en: 'Next booking'
	String get nextBooking => 'Next booking';

	/// en: 'Free today'
	String get freeToday => 'Free today';

	/// en: 'Shops near you'
	String get shopsNearby => 'Shops near you';

	/// en: 'Nothing booked yet'
	String get nothingBooked => 'Nothing booked yet';

	/// en: 'Pick a time below: a deposit holds the spot.'
	String get nothingBookedBody => 'Pick a time below: a deposit holds the spot.';

	/// en: 'No free times today.'
	String get noFreeToday => 'No free times today.';

	/// en: 'No shops available right now.'
	String get noShops => 'No shops available right now.';

	/// en: 'more times'
	String get moreTimes => 'more times';

	/// en: '${metres} m'
	String metresAway({required Object metres}) => '${metres} m';

	/// en: '${km} km'
	String kilometresAway({required Object km}) => '${km} km';

	/// en: '(one) {${n} service} (other) {${n} services}'
	String servicesCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} service',
		other: '${n} services',
	);

	/// en: 'from ${price}'
	String fromPrice({required Object price}) => 'from ${price}';

	/// en: 'Open'
	String get openNow => 'Open';

	/// en: 'Open until ${time}'
	String openUntil({required Object time}) => 'Open until ${time}';

	/// en: 'Closed'
	String get closedNow => 'Closed';

	/// en: 'Closed · opens ${time}'
	String closedUntil({required Object time}) => 'Closed · opens ${time}';
}

// Path: agenda
class Translations$agenda$en {
	Translations$agenda$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Everyone'
	String get everyone => 'Everyone';

	/// en: '${length} · Tap to block'
	String freeLine({required Object length}) => '${length} · Tap to block';

	/// en: '${count} h'
	String hours({required Object count}) => '${count} h';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Pick a date'
	String get pickDate => 'Pick a date';

	/// en: 'Shut'
	String get closedShort => 'Shut';

	/// en: 'Closed'
	String get closedTitle => 'Closed';

	/// en: 'No opening hours on this day.'
	String get closedBody => 'No opening hours on this day.';

	/// en: 'Closed for the day. Nothing can be booked.'
	String get closureBody => 'Closed for the day. Nothing can be booked.';

	/// en: 'Nothing booked'
	String get emptyTitle => 'Nothing booked';

	/// en: 'No bookings for this day.'
	String get emptyBody => 'No bookings for this day.';

	/// en: '(one) {${n} booked} (other) {${n} booked}'
	String booked({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} booked',
		other: '${n} booked',
	);

	/// en: '(one) {${n} free} (other) {${n} free}'
	String free({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} free',
		other: '${n} free',
	);

	/// en: '${amount} to collect'
	String toCollect({required Object amount}) => '${amount} to collect';

	/// en: 'now'
	String get now => 'now';

	/// en: 'Free'
	String get freeLabel => 'Free';

	/// en: 'Customer'
	String get customerFallback => 'Customer';

	/// en: '${count} min'
	String minutes({required Object count}) => '${count} min';

	/// en: 'cancelled by ${name}'
	String cancelledBy({required Object name}) => 'cancelled by ${name}';

	/// en: 'until ${time} · ${amount} in shop'
	String until({required Object time, required Object amount}) => 'until ${time} · ${amount} in shop';

	/// en: 'Blocked'
	String get blockedLabel => 'Blocked';

	/// en: 'Open ${name}'s booking'
	String openBooking({required Object name}) => 'Open ${name}\'s booking';

	/// en: 'Block the free time at ${time}'
	String blockFree({required Object time}) => 'Block the free time at ${time}';

	/// en: 'Open the block at ${time}'
	String openBlock({required Object time}) => 'Open the block at ${time}';

	late final Translations$agenda$sheet$en sheet = Translations$agenda$sheet$en.internal(_root);
	late final Translations$agenda$block$en block = Translations$agenda$block$en.internal(_root);
}

// Path: flow
class Translations$flow$en {
	Translations$flow$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'You're booked'
	String get doneShort => 'You\'re booked';

	/// en: 'When suits you?'
	String get whenTitle => 'When suits you?';

	/// en: 'Morning'
	String get morning => 'Morning';

	/// en: 'Afternoon'
	String get afternoon => 'Afternoon';

	/// en: '${from} – ${to} · lunch break'
	String lunchBreak({required Object from, required Object to}) => '${from} – ${to} · lunch break';

	/// en: '— struck through: taken'
	String get legendTaken => '— struck through: taken';

	/// en: '— faded: past'
	String get legendPast => '— faded: past';

	/// en: 'Continue · ${when}, ${time}'
	String continueWith({required Object when, required Object time}) => 'Continue · ${when}, ${time}';

	/// en: 'Closed'
	String get closedTitle => 'Closed';

	/// en: 'The shop is not open on this day. Pick another one.'
	String get closedBody => 'The shop is not open on this day. Pick another one.';

	/// en: 'No free times'
	String get noTimesTitle => 'No free times';

	/// en: 'Try another day.'
	String get noTimesBody => 'Try another day.';

	/// en: 'Check and confirm'
	String get confirmTitle => 'Check and confirm';

	/// en: 'Change'
	String get change => 'Change';

	/// en: '${minutes} min · paid in the shop'
	String payInShopWithMinutes({required Object minutes}) => '${minutes} min · paid in the shop';

	/// en: 'BookNow service'
	String get bookNowService => 'BookNow service';

	/// en: 'paid now'
	String get payNow => 'paid now';

	/// en: 'Pay ${fee} and confirm'
	String payAndConfirm({required Object fee}) => 'Pay ${fee} and confirm';

	/// en: 'Pay and confirm'
	String get payAndConfirmNoFee => 'Pay and confirm';

	/// en: 'Free to cancel up to 2 hours before.'
	String get terms => 'Free to cancel up to 2 hours before.';

	/// en: 'Free cancellation until ${when}.'
	String freeCancellationUntil({required Object when}) => 'Free cancellation until ${when}.';

	/// en: 'Arrive 5 minutes early: the spot is held for 10 minutes.'
	String get arriveEarly => 'Arrive 5 minutes early: the spot is held for 10 minutes.';

	/// en: 'Payment failed'
	String get declinedTitle => 'Payment failed';

	/// en: 'The card was declined. You have not been charged.'
	String get declinedBody => 'The card was declined. You have not been charged.';

	/// en: '(one) {Slot held for ${n} more min} (other) {Slot held for ${n} more min}'
	String holdLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Slot held for ${n} more min',
		other: 'Slot held for ${n} more min',
	);

	/// en: 'The slot is no longer held'
	String get holdLapsed => 'The slot is no longer held';

	/// en: 'Try again'
	String get retry => 'Try again';

	/// en: 'Leave it'
	String get giveUp => 'Leave it';

	/// en: 'Confirming your booking'
	String get confirmingTitle => 'Confirming your booking';

	/// en: 'The payment went through. This takes a few seconds.'
	String get confirmingBody => 'The payment went through. This takes a few seconds.';

	/// en: 'You're all set'
	String get doneTitle => 'You\'re all set';

	/// en: 'Your spot is booked. We'll remind you 2 hours before.'
	String get doneBody => 'Your spot is booked. We\'ll remind you 2 hours before.';

	/// en: '${fee} paid'
	String feePaid({required Object fee}) => '${fee} paid';

	/// en: '${price} in shop'
	String inShop({required Object price}) => '${price} in shop';

	/// en: 'Done'
	String get done => 'Done';
}

// Path: queue
class Translations$queue$en {
	Translations$queue$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Live right now'
	String get liveNow => 'Live right now';

	/// en: 'Your turn'
	String get turnTitleShort => 'Your turn';

	/// en: 'You're #${n} at ${shop}'
	String splashPlace({required Object n, required Object shop}) => 'You\'re #${n} at ${shop}';

	/// en: 'It's your turn at ${shop}'
	String splashTurn({required Object shop}) => 'It\'s your turn at ${shop}';

	/// en: 'Live queue'
	String get live => 'Live queue';

	/// en: 'Walk-in'
	String get walkIn => 'Walk-in';

	/// en: 'Queue open'
	String get stateOpen => 'Queue open';

	/// en: 'Paused'
	String get statePaused => 'Paused';

	/// en: 'Full for today'
	String get stateFull => 'Full for today';

	/// en: 'Closed for today'
	String get stateClosed => 'Closed for today';

	/// en: 'Outside opening hours'
	String get stateOutside => 'Outside opening hours';

	/// en: '(one) {person waiting} (other) {people waiting}'
	String waitingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'person waiting',
		other: 'people waiting',
	);

	/// en: 'If you join now, estimated wait'
	String get estimateNow => 'If you join now, estimated wait';

	/// en: '${from}–${to} min'
	String range({required Object from, required Object to}) => '${from}–${to} min';

	/// en: 'The barber has paused the queue. People already in line keep their place: try again shortly.'
	String get pausedBody => 'The barber has paused the queue. People already in line keep their place: try again shortly.';

	/// en: 'Anyone joining now would finish after closing. Try again tomorrow.'
	String get fullBody => 'Anyone joining now would finish after closing. Try again tomorrow.';

	/// en: 'The queue is closed for today.'
	String get closedBody => 'The queue is closed for today.';

	/// en: 'The shop is closed right now.'
	String get outsideBody => 'The shop is closed right now.';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'What do you need?'
	String get pickService => 'What do you need?';

	/// en: '${minutes} min'
	String minutes({required Object minutes}) => '${minutes} min';

	/// en: '${price} in shop'
	String inShop({required Object price}) => '${price} in shop';

	/// en: 'You pay ${fee} for your place in the queue. The service is paid in the shop.'
	String feeHint({required Object fee}) => 'You pay ${fee} for your place in the queue. The service is paid in the shop.';

	/// en: 'Join'
	String get join => 'Join';

	/// en: 'Your turn in about'
	String get turnIn => 'Your turn in about';

	/// en: 'about ${range}'
	String about({required Object range}) => 'about ${range}';

	/// en: 'The fee comes back if you leave while 3 or more people are ahead.'
	String get refundRule => 'The fee comes back if you leave while 3 or more people are ahead.';

	/// en: 'We let you know when one person is left ahead of you and when it is your turn: from then you have 10 minutes to arrive.'
	String get graceRule => 'We let you know when one person is left ahead of you and when it is your turn: from then you have 10 minutes to arrive.';

	/// en: 'Pay ${fee} and join'
	String payAndJoin({required Object fee}) => 'Pay ${fee} and join';

	/// en: 'Your place is yours as soon as the payment goes through.'
	String get placeAfterPayment => 'Your place is yours as soon as the payment goes through.';

	/// en: 'Putting you in the queue'
	String get joiningTitle => 'Putting you in the queue';

	/// en: 'Your payment went through. This takes a few seconds.'
	String get joiningBody => 'Your payment went through. This takes a few seconds.';

	/// en: 'You're in the queue'
	String get inQueue => 'You\'re in the queue';

	/// en: 'Almost your turn'
	String get almost => 'Almost your turn';

	/// en: '#${n}'
	String position({required Object n}) => '#${n}';

	/// en: 'in line'
	String get inLine => 'in line';

	/// en: '(one) {1 person ahead of you} (other) {${n} people ahead of you}'
	String ahead({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '1 person ahead of you',
		other: '${n} people ahead of you',
	);

	/// en: 'You're next'
	String get next => 'You\'re next';

	/// en: 'We'll notify you when you're next. You can leave the shop and come back.'
	String get waitAnywhere => 'We\'ll notify you when you\'re next. You can leave the shop and come back.';

	/// en: 'You have at least 3 people ahead: if you leave now, we refund the service fee.'
	String get leaveRefund => 'You have at least 3 people ahead: if you leave now, we refund the service fee.';

	/// en: 'You have fewer than 3 people ahead: if you leave now, the service fee is not refunded.'
	String get leaveNoRefund => 'You have fewer than 3 people ahead: if you leave now, the service fee is not refunded.';

	/// en: 'Leave the queue'
	String get leave => 'Leave the queue';

	/// en: 'It's your turn'
	String get turnTitle => 'It\'s your turn';

	/// en: 'The barber is ready for you. You have 10 minutes to arrive.'
	String get turnBody => 'The barber is ready for you. You have 10 minutes to arrive.';

	/// en: 'to arrive'
	String get turnLeft => 'to arrive';

	/// en: 'After 10 minutes the barber can mark you as a no-show: the service fee is then not refunded.'
	String get turnLate => 'After 10 minutes the barber can mark you as a no-show: the service fee is then not refunded.';

	/// en: 'You're in the chair'
	String get servingTitle => 'You\'re in the chair';

	/// en: 'Your service has started. You pay for it in the shop, as usual.'
	String get servingBody => 'Your service has started. You pay for it in the shop, as usual.';

	late final Translations$queue$leaveSheet$en leaveSheet = Translations$queue$leaveSheet$en.internal(_root);

	/// en: 'You left the queue'
	String get leftTitle => 'You left the queue';

	/// en: 'We refund ${fee} within 5–10 business days.'
	String leftRefunded({required Object fee}) => 'We refund ${fee} within 5–10 business days.';

	/// en: 'The service fee was not refunded.'
	String get leftKept => 'The service fee was not refunded.';

	/// en: 'You're no longer in the queue'
	String get endedTitle => 'You\'re no longer in the queue';

	/// en: 'If the barber removed you or closed for today, we refund the service fee.'
	String get endedBody => 'If the barber removed you or closed for today, we refund the service fee.';

	/// en: 'Payment failed'
	String get declinedTitle => 'Payment failed';

	/// en: 'Your card was declined. You have not been charged.'
	String get declinedBody => 'Your card was declined. You have not been charged.';

	/// en: 'Try again'
	String get retry => 'Try again';

	/// en: 'Never mind'
	String get giveUp => 'Never mind';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'You're in the queue'
	String get homeTitle => 'You\'re in the queue';

	/// en: 'Paid'
	String get homePaid => 'Paid';

	/// en: 'See the queue'
	String get seeQueue => 'See the queue';

	late final Translations$queue$owner$en owner = Translations$queue$owner$en.internal(_root);
	late final Translations$queue$mode$en mode = Translations$queue$mode$en.internal(_root);
}

// Path: categories
class Translations$categories$en {
	Translations$categories$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Barber'
	String get barber => 'Barber';

	/// en: 'Hair salon'
	String get salon => 'Hair salon';

	/// en: 'Nails'
	String get nails => 'Nails';

	/// en: 'Beauty'
	String get beauty => 'Beauty';

	/// en: 'Spa'
	String get spa => 'Spa';

	/// en: 'Lashes'
	String get lashes => 'Lashes';

	/// en: 'Tattoo'
	String get tattoo => 'Tattoo';

	/// en: 'Makeup'
	String get makeup => 'Makeup';

	/// en: 'Kids cuts'
	String get kids => 'Kids cuts';

	/// en: 'More'
	String get more => 'More';
}

// Path: search
class Translations$search$en {
	Translations$search$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recent'
	String get recent => 'Recent';

	/// en: 'All shops'
	String get allShops => 'All shops';

	/// en: 'Find a shop'
	String get title => 'Find a shop';

	/// en: 'Name or street'
	String get hint => 'Name or street';

	/// en: 'No shops found.'
	String get noResults => 'No shops found.';

	/// en: 'Shops aren't sorted by category yet, so this is every shop, not only ${category}.'
	String categoryNotice({required Object category}) => 'Shops aren\'t sorted by category yet, so this is every shop, not only ${category}.';
}

// Path: live
class Translations$live$en {
	Translations$live$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Booked'
	String get overlineBooked => 'Booked';

	/// en: 'Free to cancel until ${when}'
	String freeUntil({required Object when}) => 'Free to cancel until ${when}';

	/// en: 'Cancel booking'
	String get cancelBooking => 'Cancel booking';

	/// en: 'Cancel this booking?'
	String get cancelTitle => 'Cancel this booking?';

	/// en: 'Keep my booking'
	String get keepBooking => 'Keep my booking';

	/// en: 'Yes, cancel'
	String get yesCancel => 'Yes, cancel';

	/// en: 'Your ${fee} fee will be refunded.'
	String refundYes2({required Object fee}) => 'Your ${fee} fee will be refunded.';

	/// en: 'It was free to book, so cancelling costs nothing.'
	String get refundFree => 'It was free to book, so cancelling costs nothing.';

	/// en: 'It's less than 2 hours away, so the ${fee} fee is not refunded.'
	String refundNo2({required Object fee}) => 'It\'s less than 2 hours away, so the ${fee} fee is not refunded.';

	/// en: 'Booking cancelled. ${fee} refunded.'
	String cancelledRefunded({required Object fee}) => 'Booking cancelled. ${fee} refunded.';

	/// en: 'Booking cancelled.'
	String get cancelledNoRefund => 'Booking cancelled.';

	/// en: 'Couldn't cancel. Your booking still stands.'
	String get cancelFailed => 'Couldn\'t cancel. Your booking still stands.';

	/// en: 'In the line'
	String get overline => 'In the line';

	/// en: 'Head in now · ${shop}'
	String headInAt({required Object shop}) => 'Head in now · ${shop}';

	/// en: 'Chair'
	String get chair => 'Chair';

	/// en: 'Get directions'
	String get directions => 'Get directions';

	/// en: 'In the chair'
	String get inChair => 'In the chair';

	/// en: 'Head in now. They'll hold your place for 10 minutes.'
	String get headIn => 'Head in now. They\'ll hold your place for 10 minutes.';

	/// en: 'Leave the line'
	String get leave => 'Leave the line';

	/// en: 'Leave the line?'
	String get leaveTitle => 'Leave the line?';

	/// en: 'Your service fee will be refunded.'
	String get refundYes => 'Your service fee will be refunded.';

	/// en: 'With fewer than 3 people ahead, the service fee is not refunded.'
	String get refundNo => 'With fewer than 3 people ahead, the service fee is not refunded.';

	/// en: 'Keep my place'
	String get keep => 'Keep my place';

	/// en: 'Yes, leave'
	String get leaveConfirm => 'Yes, leave';

	/// en: 'You left the line. Fee refunded.'
	String get leftRefunded => 'You left the line. Fee refunded.';

	/// en: 'You left the line.'
	String get leftNoRefund => 'You left the line.';

	/// en: 'Couldn't leave the line. You still have your place.'
	String get leaveFailed => 'Couldn\'t leave the line. You still have your place.';
}

// Path: guest
class Translations$guest$en {
	Translations$guest$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign in to your shop'
	String get ownerSheetTitle => 'Sign in to your shop';

	/// en: 'You are signed in, but this account is already a customer account, so it cannot be used for a shop.'
	String get ownerCustomerAccount => 'You are signed in, but this account is already a customer account, so it cannot be used for a shop.';

	/// en: 'Skip the wait, keep your place'
	String get title => 'Skip the wait, keep your place';

	/// en: 'One tap with the account you already have. New or returning, it's the same two buttons.'
	String get body => 'One tap with the account you already have. New or returning, it\'s the same two buttons.';

	/// en: 'Your visits live here'
	String get activityTitle => 'Your visits live here';

	/// en: 'Sign in to follow your place in line and keep your bookings together.'
	String get activityBody => 'Sign in to follow your place in line and keep your bookings together.';

	/// en: 'Sign in'
	String get signIn => 'Sign in';

	/// en: 'Sign in to BookNow'
	String get signInTitle => 'Sign in to BookNow';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'Auto'
	String get system => 'Auto';

	/// en: 'Do you run a shop?'
	String get ownerTitle => 'Do you run a shop?';

	/// en: 'Take bookings and run your queue from your phone.'
	String get ownerBody => 'Take bookings and run your queue from your phone.';

	/// en: 'Sign in to book this time'
	String get gateBook => 'Sign in to book this time';

	/// en: 'Sign in to join the line'
	String get gateJoin => 'Sign in to join the line';

	/// en: '${what}. Your choice is kept, and it takes one tap.'
	String gateBody({required Object what}) => '${what}. Your choice is kept, and it takes one tap.';
}

// Path: welcome
class Translations$welcome$en {
	Translations$welcome$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'What should the shop call you?'
	String get title => 'What should the shop call you?';

	/// en: 'Your name'
	String get nameLabel => 'Your name';

	/// en: 'Only shops you visit see it. You can change it later.'
	String get body => 'Only shops you visit see it. You can change it later.';

	/// en: 'Continue'
	String get cta => 'Continue';
}

// Path: shopScreen
class Translations$shopScreen$en {
	Translations$shopScreen$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'With whom?'
	String get whoLike => 'With whom?';

	/// en: 'Anyone free'
	String get anyone => 'Anyone free';

	/// en: 'with ${name}'
	String withWhom({required Object name}) => 'with ${name}';

	/// en: 'Closed on ${day}. Pick another day.'
	String closedDay({required Object day}) => 'Closed on ${day}. Pick another day.';

	/// en: 'No free times on this day. Pick another day.'
	String get noTimes => 'No free times on this day. Pick another day.';

	/// en: '${service} · join now'
	String joinNow({required Object service}) => '${service} · join now';

	/// en: 'Paying'
	String get paying => 'Paying';

	/// en: 'Try again'
	String get tryAgain => 'Try again';

	/// en: 'Pay ${fee}'
	String payFee({required Object fee}) => 'Pay ${fee}';

	/// en: '${shop} · we'll tell you when it's your turn'
	String placedAt({required Object shop}) => '${shop} · we\'ll tell you when it\'s your turn';

	/// en: 'Preview'
	String get previewTitle => 'Preview';

	/// en: 'This is what customers see.'
	String get previewBody => 'This is what customers see.';

	/// en: 'What would you like?'
	String get whatLike => 'What would you like?';

	/// en: 'When?'
	String get when => 'When?';

	/// en: 'Pick a time to continue'
	String get sumPick => 'Pick a time to continue';

	/// en: '${price} in shop'
	String sumShop({required Object price}) => '${price} in shop';

	/// en: '${price} in shop · ${fee} now'
	String sumShopFee({required Object price, required Object fee}) => '${price} in shop · ${fee} now';

	/// en: 'Continue'
	String get continue_ => 'Continue';

	/// en: 'Book ${when}?'
	String bookTitle({required Object when}) => 'Book ${when}?';

	/// en: 'Join the line at ${shop}?'
	String joinTitle({required Object shop}) => 'Join the line at ${shop}?';

	/// en: 'BookNow fee'
	String get feeLabel => 'BookNow fee';

	/// en: 'Paid now'
	String get feeWhen => 'Paid now';

	/// en: 'Paid to the shop'
	String get serviceWhen => 'Paid to the shop';

	/// en: 'Free to book'
	String get noFee => 'Free to book';

	/// en: 'Confirm booking'
	String get confirmFree => 'Confirm booking';

	/// en: 'Held for you for ${time}'
	String heldFor({required Object time}) => 'Held for you for ${time}';

	/// en: 'That card was declined. You have not been charged.'
	String get declined => 'That card was declined. You have not been charged.';

	/// en: 'You're in the line'
	String get placed => 'You\'re in the line';

	/// en: 'We'll tell you when it's your turn.'
	String get placedBody => 'We\'ll tell you when it\'s your turn.';
}

// Path: today
class Translations$today$en {
	Translations$today$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'until ${time}'
	String untilTime({required Object time}) => 'until ${time}';

	/// en: 'Booked'
	String get bookedTag => 'Booked';

	/// en: '${n} waiting · until about ${time}'
	String queueLine({required Object n, required Object time}) => '${n} waiting · until about ${time}';

	/// en: 'Now'
	String get nowLabel => 'Now';

	/// en: 'Next up'
	String get nextLabel => 'Next up';

	/// en: 'Coming up'
	String get comingUp => 'Coming up';

	/// en: 'Details'
	String get details => 'Details';

	/// en: 'Call ${name}'
	String callName({required Object name}) => 'Call ${name}';

	/// en: 'Nothing else booked today'
	String get nothingLeftTitle => 'Nothing else booked today';

	/// en: 'Your free time stays open to customers.'
	String get nothingLeftBody => 'Your free time stays open to customers.';

	/// en: '${name} marked as arrived'
	String markedArrived({required Object name}) => '${name} marked as arrived';

	/// en: '${name} marked as a no-show'
	String markedNoShow({required Object name}) => '${name} marked as a no-show';

	/// en: 'Mark ${name} as a no-show?'
	String noShowTitle({required Object name}) => 'Mark ${name} as a no-show?';

	/// en: 'This can't be undone.'
	String get noShowBody => 'This can\'t be undone.';

	/// en: 'Cancel ${name}'s booking?'
	String cancelTitle({required Object name}) => 'Cancel ${name}\'s booking?';

	/// en: 'The customer is told, and the time opens up again.'
	String get cancelBody => 'The customer is told, and the time opens up again.';

	/// en: 'Booking cancelled'
	String get cancelled => 'Booking cancelled';

	/// en: 'How's the queue today?'
	String get stateTitle => 'How\'s the queue today?';

	/// en: 'Open'
	String get stateOpenTitle => 'Open';

	/// en: 'People can join from the app.'
	String get stateOpenBody => 'People can join from the app.';

	/// en: 'Nobody new can join. People in line stay.'
	String get statePauseBody => 'Nobody new can join. People in line stay.';

	/// en: 'Nobody new can join. You still serve the ${n} in line, and anyone not served is refunded.'
	String stateCloseBody({required Object n}) => 'Nobody new can join. You still serve the ${n} in line, and anyone not served is refunded.';

	/// en: 'Paused. Nobody new can join.'
	String get pausedBanner => 'Paused. Nobody new can join.';

	/// en: 'Closed for today. Finish the people in line.'
	String get closedBanner => 'Closed for today. Finish the people in line.';

	/// en: 'Line'
	String get wayLine => 'Line';

	/// en: 'Bookings'
	String get wayBookings => 'Bookings';

	/// en: 'Calendar'
	String get calendarTitle => 'Calendar';

	/// en: 'Your shop runs a queue'
	String get calendarQueueTitle => 'Your shop runs a queue';

	/// en: 'Customers join the line instead of booking times, so there's nothing to plan here. Run the line from Today.'
	String get calendarQueueBody => 'Customers join the line instead of booking times, so there\'s nothing to plan here. Run the line from Today.';

	/// en: 'Change how you work'
	String get calendarQueueCta => 'Change how you work';
}

// Path: chairs
class Translations$chairs$en {
	Translations$chairs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Free'
	String get free => 'Free';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Start ${name}'
	String startName({required Object name}) => 'Start ${name}';

	/// en: '${minutes} min over plan'
	String overPlan({required Object minutes}) => '${minutes} min over plan';

	/// en: 'until ${time}'
	String until({required Object time}) => 'until ${time}';

	/// en: 'In line'
	String get nextInLine => 'In line';

	/// en: 'Next booking'
	String get nextBooking => 'Next booking';

	/// en: 'Someone turned away'
	String get turnedAway => 'Someone turned away';

	/// en: 'Recorded'
	String get turnedAwayRecorded => 'Recorded';
}

// Path: statistics
class Translations$statistics$en {
	Translations$statistics$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Statistics'
	String get title => 'Statistics';

	/// en: 'Today'
	String get today => 'Today';

	/// en: '7 days'
	String get sevenDays => '7 days';

	/// en: '30 days'
	String get thirtyDays => '30 days';

	/// en: 'Custom'
	String get custom => 'Custom';

	/// en: 'Everyone'
	String get everyone => 'Everyone';

	/// en: 'All services'
	String get allServices => 'All services';

	/// en: 'Staff'
	String get staffFilter => 'Staff';

	/// en: 'Service'
	String get serviceFilter => 'Service';

	/// en: 'Choose ${days} days or fewer'
	String rangeTooLong({required Object days}) => 'Choose ${days} days or fewer';

	/// en: '${value} min'
	String minutes({required Object value}) => '${value} min';

	/// en: 'Nothing to show yet'
	String get emptyTitle => 'Nothing to show yet';

	/// en: 'Figures appear here once you start using Start and Done on Today.'
	String get emptyBody => 'Figures appear here once you start using Start and Done on Today.';

	late final Translations$statistics$kpi$en kpi = Translations$statistics$kpi$en.internal(_root);
	late final Translations$statistics$detail$en detail = Translations$statistics$detail$en.internal(_root);
}

// Path: homeWidgets
class Translations$homeWidgets$en {
	Translations$homeWidgets$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'In line'
	String get inLine => 'In line';

	/// en: 'Next visit'
	String get nextVisit => 'Next visit';

	/// en: 'Book again'
	String get bookAgain => 'Book again';

	/// en: 'Find a shop'
	String get findTitle => 'Find a shop';

	/// en: 'Book a time or join a line'
	String get findLine => 'Book a time or join a line';

	/// en: 'Directions'
	String get directions => 'Directions';

	/// en: 'Head in within 10 min'
	String get headIn => 'Head in within 10 min';

	/// en: '(zero) {You're next} (one) {${n} person ahead} (other) {${n} people ahead}'
	String ahead({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		zero: 'You\'re next',
		one: '${n} person ahead',
		other: '${n} people ahead',
	);

	/// en: 'waiting'
	String get waiting => 'waiting';

	/// en: '${n} waiting'
	String waitingCount({required Object n}) => '${n} waiting';

	/// en: 'Nobody waiting'
	String get nobodyWaiting => 'Nobody waiting';

	/// en: 'Next up'
	String get nextUp => 'Next up';

	/// en: 'Called, on their way'
	String get calledLine => 'Called, on their way';

	/// en: 'Next appointment'
	String get nextAppointment => 'Next appointment';

	/// en: 'Nothing else today'
	String get nothingLeft => 'Nothing else today';

	/// en: '${n} more today'
	String moreToday({required Object n}) => '${n} more today';

	/// en: 'Open today'
	String get openToday => 'Open today';

	/// en: 'Open BookNow to check your place'
	String get staleQueue => 'Open BookNow to check your place';

	/// en: 'Open BookNow to see your next visit'
	String get staleBooking => 'Open BookNow to see your next visit';

	/// en: 'Open BookNow to see today'
	String get staleOwner => 'Open BookNow to see today';
}

// Path: onboarding.slideOne
class Translations$onboarding$slideOne$en {
	Translations$onboarding$slideOne$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Book your cut in 30 seconds'
	String get title => 'Book your cut in 30 seconds';

	/// en: 'Pick a free day and time at your barber. No phone calls, no waiting in the shop.'
	String get body => 'Pick a free day and time at your barber. No phone calls, no waiting in the shop.';
}

// Path: onboarding.slideTwo
class Translations$onboarding$slideTwo$en {
	Translations$onboarding$slideTwo$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'You pay for the cut in the shop'
	String get title => 'You pay for the cut in the shop';

	/// en: 'In the app you pay only €1.49 to hold the slot. The cut you pay at the barber, cash included.'
	String get body => 'In the app you pay only €1.49 to hold the slot. The cut you pay at the barber, cash included.';

	/// en: 'Haircut'
	String get serviceLabel => 'Haircut';

	/// en: 'in the shop, to the barber'
	String get serviceNote => 'in the shop, to the barber';

	/// en: 'BookNow service'
	String get feeLabel => 'BookNow service';

	/// en: 'now, in the app'
	String get feeNote => 'now, in the app';

	/// en: 'plus'
	String get plus => 'plus';

	/// en: '€18.00'
	String get serviceAmount => '€18.00';

	/// en: '€1.49'
	String get feeAmount => '€1.49';
}

// Path: onboarding.slideThree
class Translations$onboarding$slideThree$en {
	Translations$onboarding$slideThree$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Do you run a barber shop?'
	String get title => 'Do you run a barber shop?';

	/// en: 'Manage your agenda from your phone, free. Every booking arrives as a notification.'
	String get body => 'Manage your agenda from your phone, free. Every booking arrives as a notification.';

	/// en: 'Today · agenda'
	String get agendaToday => 'Today · agenda';

	/// en: 'free'
	String get agendaFree => 'free';

	/// en: 'New booking: Marco, Sat 3 Oct at 10:30'
	String get agendaPush => 'New booking: Marco, Sat 3 Oct at 10:30';

	/// en: '10:30'
	String get agendaBookedTime => '10:30';

	/// en: 'Marco R.'
	String get agendaBookedName => 'Marco R.';

	/// en: '11:00'
	String get agendaFreeTime => '11:00';
}

// Path: auth.signIn
class Translations$auth$signIn$en {
	Translations$auth$signIn$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome back'
	String get title => 'Welcome back';

	/// en: 'Sign in with one tap. We use your account only for your name and email.'
	String get body => 'Sign in with one tap. We use your account only for your name and email.';

	/// en: 'first time?'
	String get firstTime => 'first time?';

	/// en: 'Create an account'
	String get createAccount => 'Create an account';

	/// en: 'By continuing you accept the Terms and the Privacy policy.'
	String get terms => 'By continuing you accept the Terms and the Privacy policy.';

	/// en: 'Terms'
	String get termsLink => 'Terms';

	/// en: 'Privacy'
	String get privacyLink => 'Privacy';
}

// Path: auth.signUp
class Translations$auth$signUp$en {
	Translations$auth$signUp$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create your account'
	String get title => 'Create your account';

	/// en: 'No password to remember: use Apple or Google and you are in.'
	String get body => 'No password to remember: use Apple or Google and you are in.';

	/// en: 'No card saved'
	String get noCardTitle => 'No card saved';

	/// en: 'You pay €1.49 only when you book.'
	String get noCardBody => 'You pay €1.49 only when you book.';

	/// en: 'Name and email only'
	String get dataTitle => 'Name and email only';

	/// en: 'Your phone is optional, and only the barber sees it.'
	String get dataBody => 'Your phone is optional, and only the barber sees it.';

	/// en: 'Barber or customer'
	String get roleTitle => 'Barber or customer';

	/// en: 'You choose next. For shops it is free.'
	String get roleBody => 'You choose next. For shops it is free.';

	/// en: 'Already have an account?'
	String get alreadyHaveAccount => 'Already have an account?';

	/// en: 'Sign in'
	String get signInLink => 'Sign in';
}

// Path: auth.role
class Translations$auth$role$en {
	Translations$auth$role$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hi ${name}'
	String greeting({required Object name}) => 'Hi ${name}';

	/// en: 'How do you use BookNow?'
	String get title => 'How do you use BookNow?';

	/// en: 'You choose once. You can change it later from your profile.'
	String get body => 'You choose once. You can change it later from your profile.';

	/// en: 'I want to book'
	String get customerTitle => 'I want to book';

	/// en: 'Pick a slot, hold it for €1.49 and pay for the cut in the shop.'
	String get customerBody => 'Pick a slot, hold it for €1.49 and pay for the cut in the shop.';

	/// en: 'I run a barber shop'
	String get ownerTitle => 'I run a barber shop';

	/// en: 'Manage your agenda, price and hours. For shops BookNow is free.'
	String get ownerBody => 'Manage your agenda, price and hours. For shops BookNow is free.';

	/// en: 'The pilot has a single shop: ${shop}, ${address}.'
	String pilotNote({required Object shop, required Object address}) => 'The pilot has a single shop: ${shop}, ${address}.';

	/// en: 'Selected'
	String get selected => 'Selected';
}

// Path: auth.profile
class Translations$auth$profile$en {
	Translations$auth$profile$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Almost there'
	String get title => 'Almost there';

	/// en: 'These details come from your ${provider} account. Change them if you like.'
	String body({required Object provider}) => 'These details come from your ${provider} account. Change them if you like.';

	/// en: 'Full name'
	String get nameLabel => 'Full name';

	/// en: 'Please enter your name.'
	String get nameRequired => 'Please enter your name.';

	/// en: 'Phone'
	String get phoneLabel => 'Phone';

	/// en: 'optional'
	String get phoneOptional => 'optional';

	/// en: 'The barber only needs it if they have to reach you. We don't use it for anything else.'
	String get phoneHelper => 'The barber only needs it if they have to reach you. We don\'t use it for anything else.';

	/// en: 'Save and continue'
	String get save => 'Save and continue';
}

// Path: profile.signOutDialog
class Translations$profile$signOutDialog$en {
	Translations$profile$signOutDialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sign out?'
	String get title => 'Sign out?';

	/// en: 'Your shop and your agenda stay where they are.'
	String get bodyOwner => 'Your shop and your agenda stay where they are.';

	/// en: 'Your bookings stay saved.'
	String get bodyCustomer => 'Your bookings stay saved.';

	/// en: 'One tap on ${provider} brings you back.'
	String returnWith({required Object provider}) => 'One tap on ${provider} brings you back.';
}

// Path: profile.deleteSheet
class Translations$profile$deleteSheet$en {
	Translations$profile$deleteSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Delete your account?'
	String get title => 'Delete your account?';

	/// en: 'This can't be undone.'
	String get body => 'This can\'t be undone.';

	/// en: 'Keep my account'
	String get keep => 'Keep my account';

	/// en: 'Yes, delete'
	String get confirm => 'Yes, delete';

	/// en: '${name} and every booking it holds will be deleted.'
	String shopLost({required Object name}) => '${name} and every booking it holds will be deleted.';

	/// en: 'Your shop and every booking it holds will be deleted.'
	String get shopLostUnnamed => 'Your shop and every booking it holds will be deleted.';

	/// en: 'You lose your history and your payment receipts.'
	String get historyLost => 'You lose your history and your payment receipts.';
}

// Path: profile.personal
class Translations$profile$personal$en {
	Translations$profile$personal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shops you visit see your name.'
	String get initialsNote => 'Shops you visit see your name.';

	/// en: 'Owner of ${shop}'
	String ownerOf({required Object shop}) => 'Owner of ${shop}';

	/// en: 'Full name'
	String get nameLabel => 'Full name';

	/// en: 'Please enter your name.'
	String get nameRequired => 'Please enter your name.';

	/// en: 'Phone (optional)'
	String get phoneLabelCustomer => 'Phone (optional)';

	/// en: 'Phone (personal)'
	String get phoneLabelOwner => 'Phone (personal)';

	/// en: 'optional'
	String get phoneOptional => 'optional';

	/// en: 'personal'
	String get phonePersonal => 'personal';

	/// en: 'Only for the shops you book with, if they need to reach you.'
	String get phoneHelperCustomer => 'Only for the shops you book with, if they need to reach you.';

	/// en: 'Not the shop's number: we only use this one to reach you.'
	String get phoneHelperOwner => 'Not the shop\'s number: we only use this one to reach you.';

	/// en: 'Email'
	String get emailLabel => 'Email';

	/// en: 'Not editable here'
	String get emailLockedHint => 'Not editable here';

	/// en: 'Managed by Apple. Change it from your Apple ID.'
	String get emailApple => 'Managed by Apple. Change it from your Apple ID.';

	/// en: 'Managed by Google. Change it from your Google account.'
	String get emailGoogle => 'Managed by Google. Change it from your Google account.';

	/// en: 'Managed by the service you signed in with.'
	String get emailProvider => 'Managed by the service you signed in with.';

	/// en: 'Details updated'
	String get saved => 'Details updated';
}

// Path: help.faq
class Translations$help$faq$en {
	Translations$help$faq$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Why do I pay €1,49?'
	String get feeQuestion => 'Why do I pay €1,49?';

	/// en: 'It is the booking fee: it holds your place. You pay for the service itself at the shop, as always.'
	String get feeAnswer => 'It is the booking fee: it holds your place. You pay for the service itself at the shop, as always.';

	/// en: 'How do I cancel a booking?'
	String get cancelQuestion => 'How do I cancel a booking?';

	/// en: 'Open the booking and tap Cancel. Up to 2 hours before the start the fee is refunded; later the booking is still cancelled, but the fee is kept. After the start time it can no longer be cancelled.'
	String get cancelAnswer => 'Open the booking and tap Cancel. Up to 2 hours before the start the fee is refunded; later the booking is still cancelled, but the fee is kept. After the start time it can no longer be cancelled.';

	/// en: 'When does the refund arrive?'
	String get refundQuestion => 'When does the refund arrive?';

	/// en: 'It leaves as soon as you cancel and returns to the same card, usually within a few working days depending on your bank. If the shop cancels, the fee is always refunded.'
	String get refundAnswer => 'It leaves as soon as you cancel and returns to the same card, usually within a few working days depending on your bank. If the shop cancels, the fee is always refunded.';

	/// en: 'What if I am running late?'
	String get lateQuestion => 'What if I am running late?';

	/// en: 'Let the shop know. The slot stays yours until the owner marks you as a no-show, which they can do from 15 minutes after the start time: the fee is not refunded in that case.'
	String get lateAnswer => 'Let the shop know. The slot stays yours until the owner marks you as a no-show, which they can do from 15 minutes after the start time: the fee is not refunded in that case.';
}

// Path: help.topics
class Translations$help$topics$en {
	Translations$help$topics$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Payment'
	String get payment => 'Payment';

	/// en: 'Booking'
	String get booking => 'Booking';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: help.write
class Translations$help$write$en {
	Translations$help$write$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Write to BookNow'
	String get title => 'Write to BookNow';

	/// en: 'We reply within 24 hours to ${email}.'
	String replyTo({required Object email}) => 'We reply within 24 hours to ${email}.';

	/// en: 'We reply within 24 hours.'
	String get replyGeneric => 'We reply within 24 hours.';

	/// en: 'We will open your email app with the message ready.'
	String get handoff => 'We will open your email app with the message ready.';

	/// en: 'What is it about?'
	String get topicLabel => 'What is it about?';

	/// en: 'Message'
	String get messageLabel => 'Message';

	/// en: 'Tell us what happened'
	String get messageHint => 'Tell us what happened';

	/// en: 'We attach your account and the app version'
	String get attach => 'We attach your account and the app version';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'Message ready in your email app.'
	String get opened => 'Message ready in your email app.';

	/// en: 'No email app on this phone. Write to ${email}.'
	String noMailApp({required Object email}) => 'No email app on this phone. Write to ${email}.';
}

// Path: help.mail
class Translations$help$mail$en {
	Translations$help$mail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'BookNow — ${topic}'
	String subject({required Object topic}) => 'BookNow — ${topic}';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Role'
	String get role => 'Role';

	/// en: 'App version'
	String get appVersion => 'App version';

	/// en: 'owner'
	String get roleOwner => 'owner';

	/// en: 'customer'
	String get roleCustomer => 'customer';
}

// Path: shopSetup.team
class Translations$shopSetup$team$en {
	Translations$shopSetup$team$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Team'
	String get screenTitle => 'Team';

	/// en: 'Who takes customers here. Customers choose one of them, or whoever is free first.'
	String get subtitle => 'Who takes customers here. Customers choose one of them, or whoever is free first.';

	/// en: 'You'
	String get you => 'You';

	/// en: 'Add someone'
	String get add => 'Add someone';

	/// en: 'Added to the team'
	String get added => 'Added to the team';

	/// en: 'Changes saved'
	String get saved => 'Changes saved';

	/// en: '${name} is off the team'
	String removed({required Object name}) => '${name} is off the team';

	/// en: '${name} is back on the team'
	String restored({required Object name}) => '${name} is back on the team';

	/// en: 'Removed'
	String get removedSection => 'Removed';

	/// en: 'Bring back'
	String get restore => 'Bring back';

	/// en: 'Every service'
	String get everyService => 'Every service';

	/// en: '(one) {${n} service} (other) {${n} services}'
	String servicesCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} service',
		other: '${n} services',
	);

	/// en: 'Shop's hours'
	String get shopHours => 'Shop\'s hours';

	/// en: 'Own hours'
	String get ownHours => 'Own hours';

	/// en: '(one) {${n} day off} (other) {${n} days off}'
	String daysOff({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} day off',
		other: '${n} days off',
	);

	/// en: 'Options for ${name}'
	String actionsFor({required Object name}) => 'Options for ${name}';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Remove from the team'
	String get remove => 'Remove from the team';

	/// en: 'Remove ${name}?'
	String removeTitle({required Object name}) => 'Remove ${name}?';

	/// en: 'Customers can no longer book them or wait for them. Past bookings keep their name, and you can bring them back later.'
	String get removeBody => 'Customers can no longer book them or wait for them. Past bookings keep their name, and you can bring them back later.';

	/// en: 'New team member'
	String get newTitle => 'New team member';

	/// en: 'Team member'
	String get editTitle => 'Team member';

	/// en: 'Name'
	String get nameLabel => 'Name';

	/// en: 'Marco'
	String get nameHint => 'Marco';

	/// en: 'Customers see it when they choose who to book with.'
	String get nameHelper => 'Customers see it when they choose who to book with.';

	/// en: 'Who or what'
	String get typeLabel => 'Who or what';

	/// en: 'Person'
	String get typePerson => 'Person';

	/// en: 'Chair or station'
	String get typeResource => 'Chair or station';

	/// en: 'Services'
	String get servicesLabel => 'Services';

	/// en: 'Including services you add later'
	String get everyServiceHelper => 'Including services you add later';

	/// en: 'Choose at least one service.'
	String get noService => 'Choose at least one service.';

	/// en: 'Hours'
	String get hoursLabel => 'Hours';

	/// en: 'Same as the shop'
	String get sameAsShop => 'Same as the shop';

	/// en: 'Only inside the shop's hours. Nobody can book outside them.'
	String get ownHoursHelper => 'Only inside the shop\'s hours. Nobody can book outside them.';

	/// en: 'Days off'
	String get daysOffLabel => 'Days off';

	/// en: 'Add a day off'
	String get addDayOff => 'Add a day off';

	/// en: 'Remove ${day}'
	String removeDayOff({required Object day}) => 'Remove ${day}';

	/// en: 'None planned'
	String get noDaysOff => 'None planned';

	/// en: 'Add to the team'
	String get save => 'Add to the team';

	/// en: 'Save changes'
	String get saveChanges => 'Save changes';
}

// Path: shopSetup.checklist
class Translations$shopSetup$checklist$en {
	Translations$shopSetup$checklist$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Start from a typical week?'
	String get typicalTitle => 'Start from a typical week?';

	/// en: 'Tuesday to Saturday, ${hours}. You can change any day after.'
	String typicalBody({required Object hours}) => 'Tuesday to Saturday, ${hours}. You can change any day after.';

	/// en: 'Use this week'
	String get typicalCta => 'Use this week';

	/// en: 'Let's get your shop live'
	String get title => 'Let\'s get your shop live';

	/// en: '(one) {${n} step left. Customers can't see your shop yet.} (other) {${n} steps left. Customers can't see your shop yet.}'
	String left({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} step left. Customers can\'t see your shop yet.',
		other: '${n} steps left. Customers can\'t see your shop yet.',
	);

	/// en: 'All done. One tap and customers can find you.'
	String get allDone => 'All done. One tap and customers can find you.';

	/// en: 'Next: ${step}'
	String continueWith({required Object step}) => 'Next: ${step}';

	/// en: 'Optional'
	String get optional => 'Optional';

	/// en: 'Shop details'
	String get shop => 'Shop details';

	/// en: 'Name and phone'
	String get shopHint => 'Name and phone';

	/// en: 'Address'
	String get address => 'Address';

	/// en: 'Where customers find you'
	String get addressHint => 'Where customers find you';

	/// en: 'Services and prices'
	String get services => 'Services and prices';

	/// en: 'At least one, with its price'
	String get servicesHint => 'At least one, with its price';

	/// en: 'Opening hours'
	String get hours => 'Opening hours';

	/// en: 'When you take customers'
	String get hoursHint => 'When you take customers';

	/// en: 'You're live'
	String get liveTitle => 'You\'re live';

	/// en: 'Customers can find your shop now.'
	String get liveBody => 'Customers can find your shop now.';

	/// en: 'Open my shop'
	String get liveCta => 'Open my shop';
}

// Path: shopSetup.shop
class Translations$shopSetup$shop$en {
	Translations$shopSetup$shop$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your shop'
	String get overline => 'Your shop';

	/// en: 'How do customers find you?'
	String get title => 'How do customers find you?';

	/// en: 'Shop name'
	String get nameLabel => 'Shop name';

	/// en: 'Customers see it exactly like this.'
	String get nameHelper => 'Customers see it exactly like this.';

	/// en: 'Shop phone'
	String get phoneLabel => 'Shop phone';

	/// en: 'Customers can call you from the booking.'
	String get phoneHelper => 'Customers can call you from the booking.';

	/// en: 'Photo'
	String get photoLabel => 'Photo';

	/// en: 'optional'
	String get photoOptional => 'optional';

	/// en: 'Add a photo'
	String get photoAdd => 'Add a photo';

	/// en: 'The inside or the window · you can do it later'
	String get photoHint => 'The inside or the window · you can do it later';

	/// en: 'Shop photo'
	String get photoSource => 'Shop photo';

	/// en: 'Take a photo'
	String get photoCamera => 'Take a photo';

	/// en: 'Choose from the library'
	String get photoGallery => 'Choose from the library';

	/// en: 'Remove photo'
	String get photoRemove => 'Remove photo';

	/// en: 'Customers can see it'
	String get photoVisible => 'Customers can see it';

	/// en: 'Take a new photo'
	String get photoCameraNew => 'Take a new photo';

	/// en: 'It is the first thing customers see. The storefront or the inside, held landscape.'
	String get photoSourceBody => 'It is the first thing customers see. The storefront or the inside, held landscape.';

	/// en: 'For a good photo'
	String get photoTipsTitle => 'For a good photo';

	/// en: 'Natural light, in the daytime'
	String get photoTipLight => 'Natural light, in the daytime';

	/// en: 'Phone held landscape'
	String get photoTipLandscape => 'Phone held landscape';

	/// en: 'No customers' faces without permission'
	String get photoTipFaces => 'No customers\' faces without permission';

	/// en: 'We could not open that photo. Try again.'
	String get photoFailed => 'We could not open that photo. Try again.';
}

// Path: shopSetup.details
class Translations$shopSetup$details$en {
	Translations$shopSetup$details$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shop details'
	String get title => 'Shop details';

	/// en: 'Address'
	String get addressLabel => 'Address';

	/// en: 'No address yet'
	String get addressMissing => 'No address yet';

	/// en: 'Choose where the shop is'
	String get addressMissingHelper => 'Choose where the shop is';

	/// en: 'pinned on the map'
	String get addressPinned => 'pinned on the map';

	/// en: 'pin still to confirm'
	String get addressNotPinned => 'pin still to confirm';

	/// en: 'Changes are visible to customers right away.'
	String get liveNote => 'Changes are visible to customers right away.';

	/// en: 'Shop updated'
	String get saved => 'Shop updated';
}

// Path: shopSetup.address
class Translations$shopSetup$address$en {
	Translations$shopSetup$address$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Address'
	String get overline => 'Address';

	/// en: 'Where is it?'
	String get title => 'Where is it?';

	/// en: 'Street and number'
	String get searchHint => 'Street and number';

	/// en: 'map preview'
	String get mapPreview => 'map preview';

	/// en: 'Pick an address and we place the pin for you.'
	String get helper => 'Pick an address and we place the pin for you.';
}

// Path: shopSetup.services
class Translations$shopSetup$services$en {
	Translations$shopSetup$services$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Services'
	String get overline => 'Services';

	/// en: 'What do customers book?'
	String get title => 'What do customers book?';

	/// en: 'Add every service you offer. At least one is needed.'
	String get subtitle => 'Add every service you offer. At least one is needed.';

	/// en: 'New service'
	String get newService => 'New service';

	/// en: 'Service name'
	String get nameHint => 'Service name';

	/// en: 'Price'
	String get priceHint => 'Price';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit service'
	String get editTitle => 'Edit service';

	/// en: 'Actions for ${name}'
	String actionsFor({required Object name}) => 'Actions for ${name}';

	/// en: 'Continue · 1 service'
	String get continueOne => 'Continue · 1 service';

	/// en: '${count} min'
	String minutes({required Object count}) => '${count} min';

	/// en: 'Customers see the prices but pay you in the shop. The duration decides how much agenda space it takes.'
	String get helper => 'Customers see the prices but pay you in the shop. The duration decides how much agenda space it takes.';

	/// en: 'Continue · ${count} services'
	String continueWith({required Object count}) => 'Continue · ${count} services';

	/// en: 'Services'
	String get screenTitle => 'Services';

	/// en: 'Customers choose from these when they book. Tap a service to change it.'
	String get manageSubtitle => 'Customers choose from these when they book. Tap a service to change it.';

	/// en: 'Add service'
	String get add => 'Add service';

	/// en: 'No services yet'
	String get emptyTitle => 'No services yet';

	/// en: 'Add the first service customers can book.'
	String get emptyBody => 'Add the first service customers can book.';

	/// en: 'Service name'
	String get nameLabel => 'Service name';

	/// en: 'Duration'
	String get durationLabel => 'Duration';

	/// en: 'Price'
	String get priceLabel => 'Price';

	/// en: 'Save changes'
	String get saveChanges => 'Save changes';

	/// en: 'Previous price ${price}'
	String previousPrice({required Object price}) => 'Previous price ${price}';

	/// en: 'Delete ${name}?'
	String deleteTitle({required Object name}) => 'Delete ${name}?';

	/// en: 'Bookings already made stay valid. The service can no longer be booked.'
	String get deleteBody => 'Bookings already made stay valid. The service can no longer be booked.';

	/// en: 'Service deleted'
	String get deleted => 'Service deleted';

	/// en: 'Service updated'
	String get saved => 'Service updated';

	/// en: 'Service added'
	String get added => 'Service added';
}

// Path: shopSetup.hours
class Translations$shopSetup$hours$en {
	Translations$shopSetup$hours$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hours'
	String get overline => 'Hours';

	/// en: 'When are you open?'
	String get title => 'When are you open?';

	/// en: 'Closed'
	String get closed => 'Closed';

	/// en: 'Lunch break'
	String get lunchBreak => 'Lunch break';

	/// en: 'Copy to all open days'
	String get copyToOpenDays => 'Copy to all open days';

	/// en: '+ ${days}'
	String moreDays({required Object days}) => '+ ${days}';

	/// en: 'Opening hours'
	String get screenTitle => 'Opening hours';

	/// en: 'Your week'
	String get weekly => 'Your week';

	/// en: 'open all day'
	String get continuous => 'open all day';

	/// en: 'Open'
	String get open => 'Open';

	/// en: 'Time slots'
	String get slots => 'Time slots';

	/// en: 'Add slot'
	String get addSlot => 'Add slot';

	/// en: 'Remove slot'
	String get removeSlot => 'Remove slot';

	/// en: 'Copy to other days'
	String get copyTo => 'Copy to other days';

	/// en: 'None'
	String get copyNone => 'None';

	/// en: 'Two slots overlap.'
	String get overlap => 'Two slots overlap.';

	/// en: 'The end has to come after the start.'
	String get backwards => 'The end has to come after the start.';

	/// en: 'Hours updated'
	String get saved => 'Hours updated';
}

// Path: shopSetup.review
class Translations$shopSetup$review$en {
	Translations$shopSetup$review$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ready to open'
	String get title => 'Ready to open';

	/// en: 'Check it one last time. You can change everything later, from Shop.'
	String get subtitle => 'Check it one last time. You can change everything later, from Shop.';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'no photo'
	String get noPhoto => 'no photo';

	/// en: 'pin confirmed'
	String get pinConfirmed => 'pin confirmed';

	/// en: '${count} services · from ${price}'
	String servicesFrom({required Object count, required Object price}) => '${count} services · from ${price}';

	/// en: '${count} open days'
	String openDays({required Object count}) => '${count} open days';

	/// en: 'closed ${days}'
	String closedDays({required Object days}) => 'closed ${days}';

	/// en: 'Until you publish, your shop is'
	String get hiddenBefore => 'Until you publish, your shop is';

	/// en: 'not visible'
	String get hiddenStrong => 'not visible';

	/// en: 'to customers.'
	String get hiddenAfter => 'to customers.';

	/// en: 'Publish the shop'
	String get publish => 'Publish the shop';
}

// Path: weekdays.short
class Translations$weekdays$short$en {
	Translations$weekdays$short$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mon'
	String get mon => 'Mon';

	/// en: 'Tue'
	String get tue => 'Tue';

	/// en: 'Wed'
	String get wed => 'Wed';

	/// en: 'Thu'
	String get thu => 'Thu';

	/// en: 'Fri'
	String get fri => 'Fri';

	/// en: 'Sat'
	String get sat => 'Sat';

	/// en: 'Sun'
	String get sun => 'Sun';
}

// Path: weekdays.long
class Translations$weekdays$long$en {
	Translations$weekdays$long$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Monday'
	String get mon => 'Monday';

	/// en: 'Tuesday'
	String get tue => 'Tuesday';

	/// en: 'Wednesday'
	String get wed => 'Wednesday';

	/// en: 'Thursday'
	String get thu => 'Thursday';

	/// en: 'Friday'
	String get fri => 'Friday';

	/// en: 'Saturday'
	String get sat => 'Saturday';

	/// en: 'Sunday'
	String get sun => 'Sunday';
}

// Path: notifications.owner
class Translations$notifications$owner$en {
	Translations$notifications$owner$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Know who books, the moment they do'
	String get title => 'Know who books, the moment they do';

	/// en: 'Without notifications you only find out about bookings by opening the agenda.'
	String get body => 'Without notifications you only find out about bookings by opening the agenda.';

	/// en: 'Every new booking'
	String get pointOne => 'Every new booking';

	/// en: 'Cancellations, so you can refill the slot'
	String get pointTwo => 'Cancellations, so you can refill the slot';

	/// en: 'New booking'
	String get firstTitle => 'New booking';

	/// en: 'Marco R. · Haircut · Sat 3 Oct, 10:30'
	String get firstBody => 'Marco R. · Haircut · Sat 3 Oct, 10:30';

	/// en: 'now'
	String get firstWhen => 'now';

	/// en: 'Slot freed up'
	String get secondTitle => 'Slot freed up';

	/// en: 'Paolo M. cancelled 11:30.'
	String get secondBody => 'Paolo M. cancelled 11:30.';

	/// en: '8 min ago'
	String get secondWhen => '8 min ago';
}

// Path: notifications.customer
class Translations$notifications$customer$en {
	Translations$notifications$customer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'We'll remind you before your appointment'
	String get title => 'We\'ll remind you before your appointment';

	/// en: 'Only things about your own bookings. No advertising.'
	String get body => 'Only things about your own bookings. No advertising.';

	/// en: 'A reminder 2 hours before'
	String get pointOne => 'A reminder 2 hours before';

	/// en: 'Cancellations and refunds'
	String get pointTwo => 'Cancellations and refunds';

	/// en: 'In 2 hours'
	String get firstTitle => 'In 2 hours';

	/// en: 'Men's cut at Barbieri Navona at 10:30.'
	String get firstBody => 'Men\'s cut at Barbieri Navona at 10:30.';

	/// en: 'now'
	String get firstWhen => 'now';

	/// en: 'Booking cancelled'
	String get secondTitle => 'Booking cancelled';

	/// en: 'Barbieri Navona cancelled Sat 3 Oct. Fee refunded.'
	String get secondBody => 'Barbieri Navona cancelled Sat 3 Oct. Fee refunded.';

	/// en: 'yesterday'
	String get secondWhen => 'yesterday';
}

// Path: notificationSettings.blocked
class Translations$notificationSettings$blocked$en {
	Translations$notificationSettings$blocked$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications are off on this phone'
	String get title => 'Notifications are off on this phone';

	/// en: 'New bookings are not reaching you.'
	String get bodyOwner => 'New bookings are not reaching you.';

	/// en: 'Appointment reminders are not reaching you.'
	String get bodyCustomer => 'Appointment reminders are not reaching you.';

	/// en: 'Open Settings'
	String get action => 'Open Settings';
}

// Path: notificationSettings.lead
class Translations$notificationSettings$lead$en {
	Translations$notificationSettings$lead$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '1 hour'
	String get oneHour => '1 hour';

	/// en: '2 hours'
	String get twoHours => '2 hours';

	/// en: '1 day'
	String get oneDay => '1 day';
}

// Path: notificationSettings.customer
class Translations$notificationSettings$customer$en {
	Translations$notificationSettings$customer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reminders'
	String get reminderSection => 'Reminders';

	/// en: 'Before my appointment'
	String get reminder => 'Before my appointment';

	/// en: 'A reminder so you don't miss it'
	String get reminderSubtitle => 'A reminder so you don\'t miss it';

	/// en: 'Your queue and bookings'
	String get bookingsSection => 'Your queue and bookings';

	/// en: 'Your turn, cancellations, refunds'
	String get cancellations => 'Your turn, cancellations, refunds';

	/// en: 'Always on: they are about your money'
	String get cancellationsSubtitle => 'Always on: they are about your money';

	/// en: 'Always on'
	String get cancellationsLocked => 'Always on';
}

// Path: notificationSettings.owner
class Translations$notificationSettings$owner$en {
	Translations$notificationSettings$owner$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Agenda'
	String get agendaSection => 'Agenda';

	/// en: 'New bookings'
	String get newBookings => 'New bookings';

	/// en: 'As soon as a customer pays for the slot'
	String get newBookingsSubtitle => 'As soon as a customer pays for the slot';

	/// en: 'Cancellations'
	String get cancellations => 'Cancellations';

	/// en: 'The slot is free again'
	String get cancellationsSubtitle => 'The slot is free again';

	/// en: 'Summary'
	String get summarySection => 'Summary';

	/// en: 'Today's agenda'
	String get dailySummary => 'Today\'s agenda';

	/// en: 'How many customers you have today'
	String get dailySummarySubtitle => 'How many customers you have today';

	/// en: 'Sending time'
	String get summaryTime => 'Sending time';
}

// Path: bookings.cancel
class Translations$bookings$cancel$en {
	Translations$bookings$cancel$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel booking'
	String get action => 'Cancel booking';

	/// en: 'Cancel the haircut?'
	String get title => 'Cancel the haircut?';

	/// en: '${when} at ${time}, ${shop}.'
	String subtitle({required Object when, required Object time, required Object shop}) => '${when} at ${time}, ${shop}.';

	/// en: '${fee} refund'
	String refundTitle({required Object fee}) => '${fee} refund';

	/// en: 'Nothing to refund'
	String get freeTitle => 'Nothing to refund';

	/// en: 'This booking was free to make, so cancelling costs you nothing.'
	String get freeBody => 'This booking was free to make, so cancelling costs you nothing.';

	/// en: 'More than 2 hours to go, so the service fee comes back in 3–5 days.'
	String get refundBody => 'More than 2 hours to go, so the service fee comes back in 3–5 days.';

	/// en: 'More than 2 hours to go, so the service fee comes back to •••• ${card} in 3–5 days.'
	String refundBodyCard({required Object card}) => 'More than 2 hours to go, so the service fee comes back to •••• ${card} in 3–5 days.';

	/// en: 'The service fee is not refunded'
	String get noRefundTitle => 'The service fee is not refunded';

	/// en: 'Less than 2 hours to go, so ${fee} stays with the shop. You don't pay for the haircut.'
	String noRefundBody({required Object fee}) => 'Less than 2 hours to go, so ${fee} stays with the shop. You don\'t pay for the haircut.';

	/// en: 'The slot is free for other customers straight away.'
	String get slotFreed => 'The slot is free for other customers straight away.';

	/// en: 'Yes, cancel'
	String get confirm => 'Yes, cancel';

	/// en: 'Keep the booking'
	String get keep => 'Keep the booking';

	/// en: 'Booking cancelled.'
	String get done => 'Booking cancelled.';

	/// en: 'Booking cancelled · ${fee} refunded.'
	String doneRefunded({required Object fee}) => 'Booking cancelled · ${fee} refunded.';

	/// en: 'The booking could not be cancelled. Try again.'
	String get failed => 'The booking could not be cancelled. Try again.';
}

// Path: agenda.sheet
class Translations$agenda$sheet$en {
	Translations$agenda$sheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${from} – ${to} · ${service} · ${minutes} min'
	String timeLine({required Object from, required Object to, required Object service, required Object minutes}) => '${from} – ${to} · ${service} · ${minutes} min';

	/// en: 'To collect in shop'
	String get toCollect => 'To collect in shop';

	/// en: '${amount} hold already paid in app'
	String holdPaid({required Object amount}) => '${amount} hold already paid in app';

	/// en: 'Call ${name}'
	String call({required Object name}) => 'Call ${name}';

	/// en: 'Call'
	String get callGeneric => 'Call';

	/// en: 'Mark as arrived'
	String get markArrived => 'Mark as arrived';

	/// en: 'No-show'
	String get noShow => 'No-show';

	/// en: 'No-show · from ${time}'
	String noShowFrom({required Object time}) => 'No-show · from ${time}';

	/// en: 'Cancel booking'
	String get cancel => 'Cancel booking';

	/// en: 'No phone app on this device.'
	String get noDialler => 'No phone app on this device.';

	/// en: 'Available soon.'
	String get comingSoon => 'Available soon.';
}

// Path: agenda.block
class Translations$agenda$block$en {
	Translations$agenda$block$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Block time'
	String get title => 'Block time';

	/// en: 'From'
	String get from => 'From';

	/// en: 'To'
	String get to => 'To';

	/// en: 'Note'
	String get note => 'Note';

	/// en: 'Break, walk-in client…'
	String get noteHint => 'Break, walk-in client…';

	/// en: 'Block'
	String get save => 'Block';

	/// en: 'The end has to come after the start.'
	String get backwards => 'The end has to come after the start.';

	/// en: 'A block can't run longer than 8 hours.'
	String get tooLong => 'A block can\'t run longer than 8 hours.';

	/// en: 'Blocked time'
	String get blockedTitle => 'Blocked time';

	/// en: 'Unblock'
	String get remove => 'Unblock';

	/// en: 'Unblock this time?'
	String get removeTitle => 'Unblock this time?';

	/// en: 'Customers will be able to book it again.'
	String get removeBody => 'Customers will be able to book it again.';

	/// en: 'Time blocked.'
	String get blocked => 'Time blocked.';

	/// en: 'Time unblocked.'
	String get unblocked => 'Time unblocked.';
}

// Path: queue.leaveSheet
class Translations$queue$leaveSheet$en {
	Translations$queue$leaveSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Leave the queue?'
	String get title => 'Leave the queue?';

	/// en: 'You lose your place at ${shop}. If you change your mind you'll go back to the end of the line.'
	String body({required Object shop}) => 'You lose your place at ${shop}. If you change your mind you\'ll go back to the end of the line.';

	/// en: 'We refund ${fee} within 5–10 business days.'
	String refund({required Object fee}) => 'We refund ${fee} within 5–10 business days.';

	/// en: 'Your turn is close: if you leave now, ${fee} is not refunded.'
	String noRefund({required Object fee}) => 'Your turn is close: if you leave now, ${fee} is not refunded.';

	/// en: 'Yes, leave the queue'
	String get confirm => 'Yes, leave the queue';

	/// en: 'Leave anyway'
	String get confirmNoRefund => 'Leave anyway';

	/// en: 'Stay in the queue'
	String get stay => 'Stay in the queue';
}

// Path: queue.owner
class Translations$queue$owner$en {
	Translations$queue$owner$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Walk-in'
	String get walkInFab => 'Walk-in';

	/// en: 'Nobody waiting. Enjoy the coffee.'
	String get nobodyWaiting => 'Nobody waiting. Enjoy the coffee.';

	/// en: 'Reopen'
	String get reopen => 'Reopen';

	/// en: '${minutes} min left'
	String minutesLeft({required Object minutes}) => '${minutes} min left';

	/// en: 'Done with ${name}'
	String doneWith({required Object name}) => 'Done with ${name}';

	/// en: 'Called ${name}'
	String calledName({required Object name}) => 'Called ${name}';

	/// en: 'Waiting ${minutes} min'
	String waitingFor({required Object minutes}) => 'Waiting ${minutes} min';

	/// en: 'They're here, start'
	String get theyreHere => 'They\'re here, start';

	/// en: 'No-show in ${time}'
	String noShowIn({required Object time}) => 'No-show in ${time}';

	/// en: 'Chair'
	String get chair => 'Chair';

	/// en: 'Free now'
	String get freeNow => 'Free now';

	/// en: 'Nobody waiting'
	String get nobodyToCall => 'Nobody waiting';

	/// en: 'App'
	String get kindApp => 'App';

	/// en: 'Walk-in'
	String get kindWalkIn => 'Walk-in';

	/// en: 'Remove from the line'
	String get removeFromLine => 'Remove from the line';

	/// en: 'Removing someone always refunds their fee.'
	String get rowNoteApp => 'Removing someone always refunds their fee.';

	/// en: 'Walk-ins paid nothing in the app.'
	String get rowNoteWalkIn => 'Walk-ins paid nothing in the app.';

	/// en: 'Today's queue'
	String get title => 'Today\'s queue';

	/// en: '${waiting} waiting · the queue ends around ${until}'
	String summary({required Object waiting, required Object until}) => '${waiting} waiting · the queue ends around ${until}';

	/// en: 'Nobody waiting'
	String get summaryEmpty => 'Nobody waiting';

	/// en: 'Pause'
	String get pause => 'Pause';

	/// en: 'Resume'
	String get resume => 'Resume';

	/// en: 'Close for today'
	String get closeToday => 'Close for today';

	/// en: 'In the chair'
	String get inChair => 'In the chair';

	/// en: 'Called'
	String get called => 'Called';

	/// en: 'Waiting'
	String get waiting => 'Waiting';

	/// en: 'for ${minutes} min'
	String since({required Object minutes}) => 'for ${minutes} min';

	/// en: 'called at ${time}'
	String calledAt({required Object time}) => 'called at ${time}';

	/// en: 'in line since ${time}'
	String queuedAt({required Object time}) => 'in line since ${time}';

	/// en: '${minutes} min left'
	String graceLeft({required Object minutes}) => '${minutes} min left';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Start'
	String get start => 'Start';

	/// en: 'No-show'
	String get noShow => 'No-show';

	/// en: 'No-show · from ${time}'
	String noShowFrom({required Object time}) => 'No-show · from ${time}';

	/// en: 'Walk-in'
	String get walkInName => 'Walk-in';

	/// en: 'Remove ${name} from the queue'
	String remove({required Object name}) => 'Remove ${name} from the queue';

	/// en: 'Call next'
	String get callNext => 'Call next';

	/// en: 'Walk-in'
	String get addWalkIn => 'Walk-in';

	/// en: 'Nobody in the queue'
	String get emptyTitle => 'Nobody in the queue';

	/// en: 'Customers who join from the app show up here. Add people who walk in without it with Walk-in.'
	String get emptyBody => 'Customers who join from the app show up here. Add people who walk in without it with Walk-in.';

	late final Translations$queue$owner$removeSheet$en removeSheet = Translations$queue$owner$removeSheet$en.internal(_root);
	late final Translations$queue$owner$walkInSheet$en walkInSheet = Translations$queue$owner$walkInSheet$en.internal(_root);
}

// Path: queue.mode
class Translations$queue$mode$en {
	Translations$queue$mode$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'How you work'
	String get row => 'How you work';

	/// en: 'By appointment'
	String get booking => 'By appointment';

	/// en: 'Queue'
	String get queue => 'Queue';

	/// en: 'Both'
	String get both => 'Both';

	/// en: 'How you work'
	String get title => 'How you work';

	/// en: 'Choose how customers come to you. You can change it any time.'
	String get lead => 'Choose how customers come to you. You can change it any time.';

	/// en: 'Customers pick a day and time in the app. Best if you work from an agenda.'
	String get bookingBody => 'Customers pick a day and time in the app. Best if you work from an agenda.';

	/// en: 'Customers see how many people are waiting and join the line from the app. Best if you work without appointments.'
	String get queueBody => 'Customers see how many people are waiting and join the line from the app. Best if you work without appointments.';

	/// en: 'You can't switch right now. You can stop taking bookings once you have no future ones, and close the queue once it is empty.'
	String get blocked => 'You can\'t switch right now. You can stop taking bookings once you have no future ones, and close the queue once it is empty.';

	/// en: 'Customers choose to book a time or join the line. Booked times keep their place and the line flows around them.'
	String get bothBody => 'Customers choose to book a time or join the line. Booked times keep their place and the line flows around them.';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Mode updated'
	String get saved => 'Mode updated';
}

// Path: statistics.kpi
class Translations$statistics$kpi$en {
	Translations$statistics$kpi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Walk-in wait'
	String get wait => 'Walk-in wait';

	/// en: '9 in 10 within ${p90}'
	String waitDetail({required Object p90}) => '9 in 10 within ${p90}';

	/// en: 'Lost revenue'
	String get lost => 'Lost revenue';

	/// en: '${left} left · ${away} turned away'
	String lostDetail({required Object left, required Object away}) => '${left} left · ${away} turned away';

	/// en: 'Bookings on time'
	String get onTime => 'Bookings on time';

	/// en: 'Average delay ${delay}'
	String onTimeDetail({required Object delay}) => 'Average delay ${delay}';

	/// en: 'Chair utilization'
	String get utilization => 'Chair utilization';

	/// en: '${after} after closing'
	String utilizationDetail({required Object after}) => '${after} after closing';

	/// en: 'Over plan by 5+ min'
	String get overruns => 'Over plan by 5+ min';

	/// en: 'Typically ${real}, menu ${plan}'
	String overrunsDetail({required Object real, required Object plan}) => 'Typically ${real}, menu ${plan}';

	/// en: 'Estimated revenue'
	String get revenue => 'Estimated revenue';

	/// en: '${visits} visits, at menu prices'
	String revenueDetail({required Object visits}) => '${visits} visits, at menu prices';

	/// en: 'Wait estimates in range'
	String get estimates => 'Wait estimates in range';

	/// en: 'Typically off by ${miss}'
	String estimatesDetail({required Object miss}) => 'Typically off by ${miss}';
}

// Path: statistics.detail
class Translations$statistics$detail$en {
	Translations$statistics$detail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Services'
	String get servicesTitle => 'Services';

	/// en: 'Waits and walk-aways'
	String get waitsTitle => 'Waits and walk-aways';

	/// en: 'Bookings and no-shows'
	String get bookingsTitle => 'Bookings and no-shows';

	/// en: 'Busy hours'
	String get busyTitle => 'Busy hours';

	/// en: 'Estimate accuracy'
	String get estimatesTitle => 'Estimate accuracy';

	/// en: 'All services'
	String get allServices => 'All services';

	/// en: 'Real'
	String get real => 'Real';

	/// en: 'Menu'
	String get menu => 'Menu';

	/// en: 'Over plan by 5+ min'
	String get overPlan => 'Over plan by 5+ min';

	/// en: 'Visits'
	String get visits => 'Visits';

	/// en: 'Estimated revenue'
	String get estimatedRevenue => 'Estimated revenue';

	/// en: 'Deleted service'
	String get deletedService => 'Deleted service';

	/// en: 'Former staff'
	String get formerStaff => 'Former staff';

	/// en: '${real} · ${visits} visits'
	String medianOf({required Object real, required Object visits}) => '${real} · ${visits} visits';

	/// en: 'Walk-in wait'
	String get walkInWait => 'Walk-in wait';

	/// en: 'Average'
	String get average => 'Average';

	/// en: '9 in 10 waited less than'
	String get p90 => '9 in 10 waited less than';

	/// en: 'Customers served'
	String get served => 'Customers served';

	/// en: 'Customers lost'
	String get lostCustomers => 'Customers lost';

	/// en: 'Walked away'
	String get walkedAway => 'Walked away';

	/// en: 'Turned away'
	String get turnedAway => 'Turned away';

	/// en: 'Still waiting at closing'
	String get neverServed => 'Still waiting at closing';

	/// en: 'Estimated lost revenue'
	String get lostRevenue => 'Estimated lost revenue';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Based on menu prices, or your median price when nobody found out what they wanted.'
	String get lostNote => 'Based on menu prices, or your median price when nobody found out what they wanted.';

	/// en: 'Punctuality'
	String get punctuality => 'Punctuality';

	/// en: 'Started on time'
	String get onTime => 'Started on time';

	/// en: 'Average delay'
	String get averageDelay => 'Average delay';

	/// en: 'Bookings started'
	String get started => 'Bookings started';

	/// en: 'On time means within 5 minutes of the booked time.'
	String get onTimeNote => 'On time means within 5 minutes of the booked time.';

	/// en: 'No-shows'
	String get noShows => 'No-shows';

	/// en: 'No-show rate'
	String get noShowRate => 'No-show rate';

	/// en: 'Booked'
	String get booked => 'Booked';

	/// en: 'Cancelled'
	String get cancelled => 'Cancelled';

	/// en: 'When you're busiest'
	String get heatmapTitle => 'When you\'re busiest';

	/// en: 'Busiest on ${day} at ${hour}'
	String heatmapSummary({required Object day, required Object hour}) => 'Busiest on ${day} at ${hour}';

	/// en: 'Quiet'
	String get quiet => 'Quiet';

	/// en: 'Busy'
	String get busy => 'Busy';

	/// en: 'Chairs'
	String get chairs => 'Chairs';

	/// en: 'Utilization'
	String get utilization => 'Utilization';

	/// en: 'Time serving'
	String get busyTime => 'Time serving';

	/// en: 'Time available'
	String get availableTime => 'Time available';

	/// en: 'Worked after closing'
	String get afterClosing => 'Worked after closing';

	/// en: 'The wait we showed'
	String get estimateAccuracy => 'The wait we showed';

	/// en: 'Inside the range shown'
	String get withinRange => 'Inside the range shown';

	/// en: 'Typically off by'
	String get typicalMiss => 'Typically off by';

	/// en: 'Real waits ran longer by'
	String get longerThanShown => 'Real waits ran longer by';

	/// en: 'Real waits ran shorter by'
	String get shorterThanShown => 'Real waits ran shorter by';

	/// en: 'Waits compared'
	String get compared => 'Waits compared';

	/// en: 'Compares the wait shown when someone joined with the wait they really had.'
	String get estimateNote => 'Compares the wait shown when someone joined with the wait they really had.';
}

// Path: queue.owner.removeSheet
class Translations$queue$owner$removeSheet$en {
	Translations$queue$owner$removeSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Remove ${name}?'
	String title({required Object name}) => 'Remove ${name}?';

	/// en: 'They leave the queue and we refund their service fee.'
	String get body => 'They leave the queue and we refund their service fee.';

	/// en: 'Remove from the queue'
	String get confirm => 'Remove from the queue';

	/// en: 'Cancel'
	String get keep => 'Cancel';
}

// Path: queue.owner.walkInSheet
class Translations$queue$owner$walkInSheet$en {
	Translations$queue$owner$walkInSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add a walk-in'
	String get title => 'Add a walk-in';

	/// en: 'For someone who came in without the app. They go to the end of the line, so the wait stays right for everyone.'
	String get body => 'For someone who came in without the app. They go to the end of the line, so the wait stays right for everyone.';

	/// en: 'Service'
	String get service => 'Service';

	/// en: 'Name (optional)'
	String get name => 'Name (optional)';

	/// en: 'e.g. Andrea'
	String get nameHint => 'e.g. Andrea';

	/// en: 'Add to the line'
	String get add => 'Add to the line';

	/// en: 'Cancel'
	String get cancel => 'Cancel';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.appName' => 'BookNow',
			'common.continue_' => 'Continue',
			'common.cancel' => 'Cancel',
			'common.close' => 'Close',
			'common.confirm' => 'Confirm',
			'common.save' => 'Save',
			'common.edit' => 'Edit',
			'common.delete' => 'Delete',
			'common.retry' => 'Try again',
			'common.skip' => 'Skip',
			'common.notNow' => 'Not now',
			'common.back' => 'Back',
			'common.clear' => 'Clear',
			'common.search' => 'Search',
			'common.loading' => 'Loading…',
			'common.offline' => 'No connection',
			'common.serviceLine' => ({required Object name, required Object price, required Object minutes}) => '${name} ${price} · ${minutes} min',
			'nav.statistics' => 'Statistics',
			'nav.today' => 'Today',
			'nav.calendar' => 'Calendar',
			'nav.shop' => 'Shop',
			'nav.discover' => 'Discover',
			'nav.activity' => 'Activity',
			'nav.home' => 'Home',
			'nav.bookings' => 'Bookings',
			'nav.agenda' => 'Agenda',
			'nav.profile' => 'Profile',
			'errors.visitMoved' => 'That customer has already moved on.',
			'errors.generic' => 'Something went wrong. Please try again.',
			'errors.noConnection' => 'You appear to be offline.',
			'errors.timeout' => 'The request took too long.',
			'errors.server' => 'Our service is having trouble. Please try again shortly.',
			'errors.unauthorized' => 'Your session has expired. Please sign in again.',
			'errors.forbidden' => 'You don\'t have access to this.',
			'errors.notFound' => 'We couldn\'t find that.',
			'errors.tooManyRequests' => 'Too many attempts. Please wait a moment.',
			'errors.slotTaken' => 'That slot was just taken. Please pick another one.',
			'errors.holdExpired' => 'Your slot was released because payment took too long.',
			'errors.leadTimeTooShort' => 'That slot is too soon to book.',
			'errors.outsideBookingHorizon' => 'That date isn\'t open for booking yet.',
			'errors.shopClosed' => 'The shop is closed on that day.',
			'errors.cancellationWindowPassed' => 'It\'s too late to cancel and be refunded.',
			'errors.slotNotBookable' => 'That time can\'t be booked.',
			'errors.serviceNotAvailable' => 'That service is no longer available.',
			'errors.invalidBlock' => 'That range can\'t be blocked.',
			'errors.shopIncomplete' => 'Some details are still missing before you can publish.',
			'errors.providerLimitReached' => 'A shop can have up to 10 people working.',
			'errors.providerInUse' => 'Customers are still booked with them or waiting for them. Move or cancel those first.',
			'errors.defaultProvider' => 'That\'s you, so you can\'t be removed.',
			'errors.providerNotAvailable' => 'They aren\'t available for this service. Please choose someone else.',
			'bookingStatus.pendingPayment' => 'Awaiting payment',
			'bookingStatus.confirmed' => 'Confirmed',
			'bookingStatus.arrived' => 'Arrived',
			'bookingStatus.noShow' => 'No-show',
			'bookingStatus.cancelled' => 'Cancelled',
			'bookingStatus.completed' => 'Completed',
			'bookingStatus.expired' => 'Expired',
			'onboarding.skip' => 'Skip',
			'onboarding.next' => 'Next',
			'onboarding.start' => 'Get started',
			'onboarding.haveAccount' => 'I already have an account',
			'onboarding.slideOne.title' => 'Book your cut in 30 seconds',
			'onboarding.slideOne.body' => 'Pick a free day and time at your barber. No phone calls, no waiting in the shop.',
			'onboarding.slideTwo.title' => 'You pay for the cut in the shop',
			'onboarding.slideTwo.body' => 'In the app you pay only €1.49 to hold the slot. The cut you pay at the barber, cash included.',
			'onboarding.slideTwo.serviceLabel' => 'Haircut',
			'onboarding.slideTwo.serviceNote' => 'in the shop, to the barber',
			'onboarding.slideTwo.feeLabel' => 'BookNow service',
			'onboarding.slideTwo.feeNote' => 'now, in the app',
			'onboarding.slideTwo.plus' => 'plus',
			'onboarding.slideTwo.serviceAmount' => '€18.00',
			'onboarding.slideTwo.feeAmount' => '€1.49',
			'onboarding.slideThree.title' => 'Do you run a barber shop?',
			'onboarding.slideThree.body' => 'Manage your agenda from your phone, free. Every booking arrives as a notification.',
			'onboarding.slideThree.agendaToday' => 'Today · agenda',
			'onboarding.slideThree.agendaFree' => 'free',
			'onboarding.slideThree.agendaPush' => 'New booking: Marco, Sat 3 Oct at 10:30',
			'onboarding.slideThree.agendaBookedTime' => '10:30',
			'onboarding.slideThree.agendaBookedName' => 'Marco R.',
			'onboarding.slideThree.agendaFreeTime' => '11:00',
			'auth.continueWithApple' => 'Continue with Apple',
			'auth.continueWithGoogle' => 'Continue with Google',
			'auth.signUpWithApple' => 'Sign up with Apple',
			'auth.signUpWithGoogle' => 'Sign up with Google',
			'auth.signIn.title' => 'Welcome back',
			'auth.signIn.body' => 'Sign in with one tap. We use your account only for your name and email.',
			'auth.signIn.firstTime' => 'first time?',
			'auth.signIn.createAccount' => 'Create an account',
			'auth.signIn.terms' => 'By continuing you accept the Terms and the Privacy policy.',
			'auth.signIn.termsLink' => 'Terms',
			'auth.signIn.privacyLink' => 'Privacy',
			'auth.signUp.title' => 'Create your account',
			'auth.signUp.body' => 'No password to remember: use Apple or Google and you are in.',
			'auth.signUp.noCardTitle' => 'No card saved',
			'auth.signUp.noCardBody' => 'You pay €1.49 only when you book.',
			'auth.signUp.dataTitle' => 'Name and email only',
			'auth.signUp.dataBody' => 'Your phone is optional, and only the barber sees it.',
			'auth.signUp.roleTitle' => 'Barber or customer',
			'auth.signUp.roleBody' => 'You choose next. For shops it is free.',
			'auth.signUp.alreadyHaveAccount' => 'Already have an account?',
			'auth.signUp.signInLink' => 'Sign in',
			'auth.role.greeting' => ({required Object name}) => 'Hi ${name}',
			'auth.role.title' => 'How do you use BookNow?',
			'auth.role.body' => 'You choose once. You can change it later from your profile.',
			'auth.role.customerTitle' => 'I want to book',
			'auth.role.customerBody' => 'Pick a slot, hold it for €1.49 and pay for the cut in the shop.',
			'auth.role.ownerTitle' => 'I run a barber shop',
			'auth.role.ownerBody' => 'Manage your agenda, price and hours. For shops BookNow is free.',
			'auth.role.pilotNote' => ({required Object shop, required Object address}) => 'The pilot has a single shop: ${shop}, ${address}.',
			'auth.role.selected' => 'Selected',
			'auth.profile.title' => 'Almost there',
			'auth.profile.body' => ({required Object provider}) => 'These details come from your ${provider} account. Change them if you like.',
			'auth.profile.nameLabel' => 'Full name',
			'auth.profile.nameRequired' => 'Please enter your name.',
			'auth.profile.phoneLabel' => 'Phone',
			'auth.profile.phoneOptional' => 'optional',
			'auth.profile.phoneHelper' => 'The barber only needs it if they have to reach you. We don\'t use it for anything else.',
			'auth.profile.save' => 'Save and continue',
			'profile.signedOut' => 'Signed out',
			'profile.remindersOff' => 'Reminders off',
			'profile.notificationsOnBefore' => ({required Object when}) => 'On, ${when} before',
			'profile.ownerHelp' => 'Help',
			'profile.helpLine' => 'Questions, write to us',
			'profile.modeRow' => 'Customers',
			'profile.shopTitle' => 'Your shop',
			'profile.shopLive' => 'Live on BookNow',
			'profile.shopHidden' => 'Not visible to customers yet',
			'profile.seeAsCustomer' => 'See as customer',
			'profile.howYouWork' => 'How you work',
			'profile.yourAccount' => 'Your account',
			'profile.title' => 'Profile',
			'profile.roleOwner' => 'owner',
			'profile.roleCustomer' => 'customer',
			'profile.shopSection' => 'What customers see',
			'profile.shopPhotoPlaceholder' => 'photo',
			'profile.shopNameMissing' => 'Your shop',
			'profile.shopDetailsMissing' => 'Finish setting up your shop',
			'profile.services' => 'Services',
			'profile.servicesCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} service', other: '${n} services', ), 
			'profile.hours' => 'Hours',
			'profile.hoursNone' => 'Not set',
			'profile.team' => 'Team',
			'profile.teamJustYou' => 'Just you',
			'profile.teamCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} person', other: '${n} people', ), 
			'profile.bookingRules' => 'Booking rules',
			'profile.appearanceSection' => 'Appearance',
			'profile.themeSystem' => 'System',
			'profile.themeLight' => 'Light',
			'profile.themeDark' => 'Dark',
			'profile.accountSection' => 'Account',
			'profile.notifications' => 'Notifications',
			'profile.notificationsOn' => 'On',
			'profile.notificationsOff' => 'Off',
			'profile.help' => 'Help and contact',
			'profile.signOut' => 'Sign out',
			'profile.deleteAccount' => 'Delete account',
			'profile.signOutDialog.title' => 'Sign out?',
			'profile.signOutDialog.bodyOwner' => 'Your shop and your agenda stay where they are.',
			'profile.signOutDialog.bodyCustomer' => 'Your bookings stay saved.',
			'profile.signOutDialog.returnWith' => ({required Object provider}) => 'One tap on ${provider} brings you back.',
			'profile.deleteSheet.title' => 'Delete your account?',
			'profile.deleteSheet.body' => 'This can\'t be undone.',
			'profile.deleteSheet.keep' => 'Keep my account',
			'profile.deleteSheet.confirm' => 'Yes, delete',
			'profile.deleteSheet.shopLost' => ({required Object name}) => '${name} and every booking it holds will be deleted.',
			'profile.deleteSheet.shopLostUnnamed' => 'Your shop and every booking it holds will be deleted.',
			'profile.deleteSheet.historyLost' => 'You lose your history and your payment receipts.',
			'profile.personalData' => 'Personal details',
			'profile.editProfile' => 'Edit profile',
			'profile.signedInWith' => ({required Object provider}) => 'Signed in with ${provider}',
			'profile.personal.initialsNote' => 'Shops you visit see your name.',
			'profile.personal.ownerOf' => ({required Object shop}) => 'Owner of ${shop}',
			'profile.personal.nameLabel' => 'Full name',
			'profile.personal.nameRequired' => 'Please enter your name.',
			'profile.personal.phoneLabelCustomer' => 'Phone (optional)',
			'profile.personal.phoneLabelOwner' => 'Phone (personal)',
			'profile.personal.phoneOptional' => 'optional',
			'profile.personal.phonePersonal' => 'personal',
			'profile.personal.phoneHelperCustomer' => 'Only for the shops you book with, if they need to reach you.',
			'profile.personal.phoneHelperOwner' => 'Not the shop\'s number: we only use this one to reach you.',
			'profile.personal.emailLabel' => 'Email',
			'profile.personal.emailLockedHint' => 'Not editable here',
			'profile.personal.emailApple' => 'Managed by Apple. Change it from your Apple ID.',
			'profile.personal.emailGoogle' => 'Managed by Google. Change it from your Google account.',
			'profile.personal.emailProvider' => 'Managed by the service you signed in with.',
			'profile.personal.saved' => 'Details updated',
			'help.screenTitle' => 'Help and contacts',
			'help.faqSection' => 'Frequent questions',
			'help.needMore' => 'Need anything else?',
			'help.faq.feeQuestion' => 'Why do I pay €1,49?',
			'help.faq.feeAnswer' => 'It is the booking fee: it holds your place. You pay for the service itself at the shop, as always.',
			'help.faq.cancelQuestion' => 'How do I cancel a booking?',
			'help.faq.cancelAnswer' => 'Open the booking and tap Cancel. Up to 2 hours before the start the fee is refunded; later the booking is still cancelled, but the fee is kept. After the start time it can no longer be cancelled.',
			'help.faq.refundQuestion' => 'When does the refund arrive?',
			'help.faq.refundAnswer' => 'It leaves as soon as you cancel and returns to the same card, usually within a few working days depending on your bank. If the shop cancels, the fee is always refunded.',
			'help.faq.lateQuestion' => 'What if I am running late?',
			'help.faq.lateAnswer' => 'Let the shop know. The slot stays yours until the owner marks you as a no-show, which they can do from 15 minutes after the start time: the fee is not refunded in that case.',
			'help.callShop' => 'Call the shop',
			'help.callShopSubtitle' => 'For hours, services and appointments',
			'help.writeUs' => 'Write to BookNow',
			'help.writeUsSubtitle' => 'Payments, refunds and the app · within 24 hours',
			'help.terms' => 'Terms',
			'help.privacy' => 'Privacy',
			'help.version' => ({required Object version}) => 'Version ${version}',
			'help.callFailed' => 'Cannot open the phone app.',
			'help.linkFailed' => 'Cannot open the link.',
			'help.topics.payment' => 'Payment',
			'help.topics.booking' => 'Booking',
			'help.topics.account' => 'Account',
			'help.topics.other' => 'Other',
			'help.write.title' => 'Write to BookNow',
			'help.write.replyTo' => ({required Object email}) => 'We reply within 24 hours to ${email}.',
			'help.write.replyGeneric' => 'We reply within 24 hours.',
			'help.write.handoff' => 'We will open your email app with the message ready.',
			'help.write.topicLabel' => 'What is it about?',
			'help.write.messageLabel' => 'Message',
			'help.write.messageHint' => 'Tell us what happened',
			'help.write.attach' => 'We attach your account and the app version',
			'help.write.send' => 'Send',
			'help.write.opened' => 'Message ready in your email app.',
			'help.write.noMailApp' => ({required Object email}) => 'No email app on this phone. Write to ${email}.',
			'help.mail.subject' => ({required Object topic}) => 'BookNow — ${topic}',
			'help.mail.account' => 'Account',
			'help.mail.role' => 'Role',
			'help.mail.appVersion' => 'App version',
			'help.mail.roleOwner' => 'owner',
			'help.mail.roleCustomer' => 'customer',
			'validation.required' => 'This field is required.',
			'validation.requiredNamed' => ({required Object field}) => '${field} is required.',
			'validation.email' => 'Enter a valid email address.',
			'validation.phone' => 'Enter a valid phone number.',
			'validation.tooShort' => ({required Object min}) => 'At least ${min} characters.',
			'validation.tooLong' => ({required Object max}) => 'At most ${max} characters.',
			'shopSetup.team.screenTitle' => 'Team',
			'shopSetup.team.subtitle' => 'Who takes customers here. Customers choose one of them, or whoever is free first.',
			'shopSetup.team.you' => 'You',
			'shopSetup.team.add' => 'Add someone',
			'shopSetup.team.added' => 'Added to the team',
			'shopSetup.team.saved' => 'Changes saved',
			'shopSetup.team.removed' => ({required Object name}) => '${name} is off the team',
			'shopSetup.team.restored' => ({required Object name}) => '${name} is back on the team',
			'shopSetup.team.removedSection' => 'Removed',
			'shopSetup.team.restore' => 'Bring back',
			'shopSetup.team.everyService' => 'Every service',
			'shopSetup.team.servicesCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} service', other: '${n} services', ), 
			'shopSetup.team.shopHours' => 'Shop\'s hours',
			'shopSetup.team.ownHours' => 'Own hours',
			'shopSetup.team.daysOff' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} day off', other: '${n} days off', ), 
			'shopSetup.team.actionsFor' => ({required Object name}) => 'Options for ${name}',
			'shopSetup.team.edit' => 'Edit',
			'shopSetup.team.remove' => 'Remove from the team',
			'shopSetup.team.removeTitle' => ({required Object name}) => 'Remove ${name}?',
			'shopSetup.team.removeBody' => 'Customers can no longer book them or wait for them. Past bookings keep their name, and you can bring them back later.',
			'shopSetup.team.newTitle' => 'New team member',
			'shopSetup.team.editTitle' => 'Team member',
			'shopSetup.team.nameLabel' => 'Name',
			'shopSetup.team.nameHint' => 'Marco',
			'shopSetup.team.nameHelper' => 'Customers see it when they choose who to book with.',
			'shopSetup.team.typeLabel' => 'Who or what',
			'shopSetup.team.typePerson' => 'Person',
			'shopSetup.team.typeResource' => 'Chair or station',
			'shopSetup.team.servicesLabel' => 'Services',
			'shopSetup.team.everyServiceHelper' => 'Including services you add later',
			'shopSetup.team.noService' => 'Choose at least one service.',
			'shopSetup.team.hoursLabel' => 'Hours',
			'shopSetup.team.sameAsShop' => 'Same as the shop',
			'shopSetup.team.ownHoursHelper' => 'Only inside the shop\'s hours. Nobody can book outside them.',
			'shopSetup.team.daysOffLabel' => 'Days off',
			'shopSetup.team.addDayOff' => 'Add a day off',
			'shopSetup.team.removeDayOff' => ({required Object day}) => 'Remove ${day}',
			'shopSetup.team.noDaysOff' => 'None planned',
			'shopSetup.team.save' => 'Add to the team',
			'shopSetup.team.saveChanges' => 'Save changes',
			'shopSetup.checklist.done' => 'Done',
			'shopSetup.checklist.typicalTitle' => 'Start from a typical week?',
			'shopSetup.checklist.typicalBody' => ({required Object hours}) => 'Tuesday to Saturday, ${hours}. You can change any day after.',
			'shopSetup.checklist.typicalCta' => 'Use this week',
			'shopSetup.checklist.title' => 'Let\'s get your shop live',
			'shopSetup.checklist.left' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} step left. Customers can\'t see your shop yet.', other: '${n} steps left. Customers can\'t see your shop yet.', ), 
			'shopSetup.checklist.allDone' => 'All done. One tap and customers can find you.',
			'shopSetup.checklist.continueWith' => ({required Object step}) => 'Next: ${step}',
			'shopSetup.checklist.optional' => 'Optional',
			'shopSetup.checklist.shop' => 'Shop details',
			'shopSetup.checklist.shopHint' => 'Name and phone',
			'shopSetup.checklist.address' => 'Address',
			'shopSetup.checklist.addressHint' => 'Where customers find you',
			'shopSetup.checklist.services' => 'Services and prices',
			'shopSetup.checklist.servicesHint' => 'At least one, with its price',
			'shopSetup.checklist.hours' => 'Opening hours',
			'shopSetup.checklist.hoursHint' => 'When you take customers',
			'shopSetup.checklist.liveTitle' => 'You\'re live',
			'shopSetup.checklist.liveBody' => 'Customers can find your shop now.',
			'shopSetup.checklist.liveCta' => 'Open my shop',
			'shopSetup.stepOf' => ({required Object current, required Object total}) => '${current}/${total}',
			'shopSetup.continue_' => 'Continue',
			'shopSetup.shop.overline' => 'Your shop',
			'shopSetup.shop.title' => 'How do customers find you?',
			'shopSetup.shop.nameLabel' => 'Shop name',
			'shopSetup.shop.nameHelper' => 'Customers see it exactly like this.',
			'shopSetup.shop.phoneLabel' => 'Shop phone',
			'shopSetup.shop.phoneHelper' => 'Customers can call you from the booking.',
			'shopSetup.shop.photoLabel' => 'Photo',
			'shopSetup.shop.photoOptional' => 'optional',
			'shopSetup.shop.photoAdd' => 'Add a photo',
			'shopSetup.shop.photoHint' => 'The inside or the window · you can do it later',
			'shopSetup.shop.photoSource' => 'Shop photo',
			'shopSetup.shop.photoCamera' => 'Take a photo',
			'shopSetup.shop.photoGallery' => 'Choose from the library',
			'shopSetup.shop.photoRemove' => 'Remove photo',
			'shopSetup.shop.photoVisible' => 'Customers can see it',
			'shopSetup.shop.photoCameraNew' => 'Take a new photo',
			'shopSetup.shop.photoSourceBody' => 'It is the first thing customers see. The storefront or the inside, held landscape.',
			'shopSetup.shop.photoTipsTitle' => 'For a good photo',
			'shopSetup.shop.photoTipLight' => 'Natural light, in the daytime',
			'shopSetup.shop.photoTipLandscape' => 'Phone held landscape',
			'shopSetup.shop.photoTipFaces' => 'No customers\' faces without permission',
			'shopSetup.shop.photoFailed' => 'We could not open that photo. Try again.',
			'shopSetup.details.title' => 'Shop details',
			'shopSetup.details.addressLabel' => 'Address',
			'shopSetup.details.addressMissing' => 'No address yet',
			'shopSetup.details.addressMissingHelper' => 'Choose where the shop is',
			'shopSetup.details.addressPinned' => 'pinned on the map',
			'shopSetup.details.addressNotPinned' => 'pin still to confirm',
			'shopSetup.details.liveNote' => 'Changes are visible to customers right away.',
			'shopSetup.details.saved' => 'Shop updated',
			'shopSetup.address.overline' => 'Address',
			'shopSetup.address.title' => 'Where is it?',
			'shopSetup.address.searchHint' => 'Street and number',
			'shopSetup.address.mapPreview' => 'map preview',
			'shopSetup.address.helper' => 'Pick an address and we place the pin for you.',
			'shopSetup.services.overline' => 'Services',
			'shopSetup.services.title' => 'What do customers book?',
			'shopSetup.services.subtitle' => 'Add every service you offer. At least one is needed.',
			'shopSetup.services.newService' => 'New service',
			'shopSetup.services.nameHint' => 'Service name',
			'shopSetup.services.priceHint' => 'Price',
			'shopSetup.services.save' => 'Save',
			'shopSetup.services.edit' => 'Edit',
			'shopSetup.services.delete' => 'Delete',
			'shopSetup.services.editTitle' => 'Edit service',
			'shopSetup.services.actionsFor' => ({required Object name}) => 'Actions for ${name}',
			'shopSetup.services.continueOne' => 'Continue · 1 service',
			'shopSetup.services.minutes' => ({required Object count}) => '${count} min',
			'shopSetup.services.helper' => 'Customers see the prices but pay you in the shop. The duration decides how much agenda space it takes.',
			'shopSetup.services.continueWith' => ({required Object count}) => 'Continue · ${count} services',
			'shopSetup.services.screenTitle' => 'Services',
			'shopSetup.services.manageSubtitle' => 'Customers choose from these when they book. Tap a service to change it.',
			'shopSetup.services.add' => 'Add service',
			'shopSetup.services.emptyTitle' => 'No services yet',
			'shopSetup.services.emptyBody' => 'Add the first service customers can book.',
			'shopSetup.services.nameLabel' => 'Service name',
			'shopSetup.services.durationLabel' => 'Duration',
			'shopSetup.services.priceLabel' => 'Price',
			'shopSetup.services.saveChanges' => 'Save changes',
			'shopSetup.services.previousPrice' => ({required Object price}) => 'Previous price ${price}',
			'shopSetup.services.deleteTitle' => ({required Object name}) => 'Delete ${name}?',
			'shopSetup.services.deleteBody' => 'Bookings already made stay valid. The service can no longer be booked.',
			'shopSetup.services.deleted' => 'Service deleted',
			'shopSetup.services.saved' => 'Service updated',
			'shopSetup.services.added' => 'Service added',
			'shopSetup.hours.overline' => 'Hours',
			'shopSetup.hours.title' => 'When are you open?',
			'shopSetup.hours.closed' => 'Closed',
			'shopSetup.hours.lunchBreak' => 'Lunch break',
			'shopSetup.hours.copyToOpenDays' => 'Copy to all open days',
			'shopSetup.hours.moreDays' => ({required Object days}) => '+ ${days}',
			'shopSetup.hours.screenTitle' => 'Opening hours',
			'shopSetup.hours.weekly' => 'Your week',
			'shopSetup.hours.continuous' => 'open all day',
			'shopSetup.hours.open' => 'Open',
			'shopSetup.hours.slots' => 'Time slots',
			'shopSetup.hours.addSlot' => 'Add slot',
			'shopSetup.hours.removeSlot' => 'Remove slot',
			'shopSetup.hours.copyTo' => 'Copy to other days',
			'shopSetup.hours.copyNone' => 'None',
			'shopSetup.hours.overlap' => 'Two slots overlap.',
			'shopSetup.hours.backwards' => 'The end has to come after the start.',
			'shopSetup.hours.saved' => 'Hours updated',
			'shopSetup.review.title' => 'Ready to open',
			'shopSetup.review.subtitle' => 'Check it one last time. You can change everything later, from Shop.',
			'shopSetup.review.edit' => 'Edit',
			'shopSetup.review.noPhoto' => 'no photo',
			'shopSetup.review.pinConfirmed' => 'pin confirmed',
			'shopSetup.review.servicesFrom' => ({required Object count, required Object price}) => '${count} services · from ${price}',
			'shopSetup.review.openDays' => ({required Object count}) => '${count} open days',
			'shopSetup.review.closedDays' => ({required Object days}) => 'closed ${days}',
			'shopSetup.review.hiddenBefore' => 'Until you publish, your shop is',
			'shopSetup.review.hiddenStrong' => 'not visible',
			'shopSetup.review.hiddenAfter' => 'to customers.',
			'shopSetup.review.publish' => 'Publish the shop',
			'weekdays.short.mon' => 'Mon',
			'weekdays.short.tue' => 'Tue',
			'weekdays.short.wed' => 'Wed',
			'weekdays.short.thu' => 'Thu',
			'weekdays.short.fri' => 'Fri',
			'weekdays.short.sat' => 'Sat',
			'weekdays.short.sun' => 'Sun',
			'weekdays.long.mon' => 'Monday',
			'weekdays.long.tue' => 'Tuesday',
			'weekdays.long.wed' => 'Wednesday',
			'weekdays.long.thu' => 'Thursday',
			'weekdays.long.fri' => 'Friday',
			'weekdays.long.sat' => 'Saturday',
			'weekdays.long.sun' => 'Sunday',
			'notifications.allow' => 'Turn on notifications',
			'notifications.skip' => 'Not now',
			'notifications.owner.title' => 'Know who books, the moment they do',
			'notifications.owner.body' => 'Without notifications you only find out about bookings by opening the agenda.',
			'notifications.owner.pointOne' => 'Every new booking',
			'notifications.owner.pointTwo' => 'Cancellations, so you can refill the slot',
			'notifications.owner.firstTitle' => 'New booking',
			'notifications.owner.firstBody' => 'Marco R. · Haircut · Sat 3 Oct, 10:30',
			'notifications.owner.firstWhen' => 'now',
			'notifications.owner.secondTitle' => 'Slot freed up',
			'notifications.owner.secondBody' => 'Paolo M. cancelled 11:30.',
			'notifications.owner.secondWhen' => '8 min ago',
			'notifications.customer.title' => 'We\'ll remind you before your appointment',
			'notifications.customer.body' => 'Only things about your own bookings. No advertising.',
			'notifications.customer.pointOne' => 'A reminder 2 hours before',
			'notifications.customer.pointTwo' => 'Cancellations and refunds',
			'notifications.customer.firstTitle' => 'In 2 hours',
			'notifications.customer.firstBody' => 'Men\'s cut at Barbieri Navona at 10:30.',
			'notifications.customer.firstWhen' => 'now',
			'notifications.customer.secondTitle' => 'Booking cancelled',
			'notifications.customer.secondBody' => 'Barbieri Navona cancelled Sat 3 Oct. Fee refunded.',
			'notifications.customer.secondWhen' => 'yesterday',
			'notificationSettings.screenTitle' => 'Notifications',
			'notificationSettings.blocked.title' => 'Notifications are off on this phone',
			'notificationSettings.blocked.bodyOwner' => 'New bookings are not reaching you.',
			'notificationSettings.blocked.bodyCustomer' => 'Appointment reminders are not reaching you.',
			'notificationSettings.blocked.action' => 'Open Settings',
			'notificationSettings.lead.oneHour' => '1 hour',
			'notificationSettings.lead.twoHours' => '2 hours',
			'notificationSettings.lead.oneDay' => '1 day',
			'notificationSettings.customer.reminderSection' => 'Reminders',
			'notificationSettings.customer.reminder' => 'Before my appointment',
			'notificationSettings.customer.reminderSubtitle' => 'A reminder so you don\'t miss it',
			'notificationSettings.customer.bookingsSection' => 'Your queue and bookings',
			'notificationSettings.customer.cancellations' => 'Your turn, cancellations, refunds',
			'notificationSettings.customer.cancellationsSubtitle' => 'Always on: they are about your money',
			'notificationSettings.customer.cancellationsLocked' => 'Always on',
			'notificationSettings.owner.agendaSection' => 'Agenda',
			'notificationSettings.owner.newBookings' => 'New bookings',
			'notificationSettings.owner.newBookingsSubtitle' => 'As soon as a customer pays for the slot',
			'notificationSettings.owner.cancellations' => 'Cancellations',
			'notificationSettings.owner.cancellationsSubtitle' => 'The slot is free again',
			'notificationSettings.owner.summarySection' => 'Summary',
			'notificationSettings.owner.dailySummary' => 'Today\'s agenda',
			'notificationSettings.owner.dailySummarySubtitle' => 'How many customers you have today',
			'notificationSettings.owner.summaryTime' => 'Sending time',
			'bookings.rightNow' => 'Right now',
			'bookings.upcoming' => 'Upcoming',
			'bookings.past' => 'Past',
			'bookings.emptyTitle' => 'Nothing scheduled',
			'bookings.emptyBody' => 'The bookings you make show up here, with their current status.',
			'bookings.emptyPastTitle' => 'No history yet',
			'bookings.emptyPastBody' => 'Past appointments appear here.',
			'bookings.inShop' => ({required Object price}) => '${price} in shop',
			'bookings.expiresIn' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Expires in ${n} min', other: 'Expires in ${n} min', ), 
			'bookings.holdLapsed' => 'The slot is no longer held',
			'bookings.payNow' => 'Pay now',
			'bookings.freeUntil' => ({required Object when}) => 'Free cancellation until ${when}',
			'bookings.repeat' => 'Book again',
			'bookings.byYou' => 'by you',
			'bookings.byShop' => 'by the shop',
			'bookings.refunded' => 'refunded',
			'bookings.notRefunded' => 'not refunded',
			'bookings.paid' => 'paid',
			'bookings.paidWithCard' => ({required Object card}) => 'paid · •••• ${card}',
			'bookings.feeNote' => 'The haircut is paid in the shop. Here you only see the status of your spot.',
			'bookings.detailTitle' => 'Your booking',
			'bookings.serviceLine' => ({required Object service, required Object minutes}) => '${service} · ${minutes} minutes',
			'bookings.map' => 'Map',
			'bookings.callShop' => 'Call the shop',
			'bookings.payInShop' => 'to pay in the shop',
			'bookings.bookNowService' => 'BookNow service',
			'bookings.addToCalendar' => 'Add to calendar',
			'bookings.calendarFailed' => 'No calendar app on this device.',
			'bookings.mapFailed' => 'No maps app on this device.',
			'bookings.cancel.action' => 'Cancel booking',
			'bookings.cancel.title' => 'Cancel the haircut?',
			'bookings.cancel.subtitle' => ({required Object when, required Object time, required Object shop}) => '${when} at ${time}, ${shop}.',
			'bookings.cancel.refundTitle' => ({required Object fee}) => '${fee} refund',
			'bookings.cancel.freeTitle' => 'Nothing to refund',
			'bookings.cancel.freeBody' => 'This booking was free to make, so cancelling costs you nothing.',
			'bookings.cancel.refundBody' => 'More than 2 hours to go, so the service fee comes back in 3–5 days.',
			'bookings.cancel.refundBodyCard' => ({required Object card}) => 'More than 2 hours to go, so the service fee comes back to •••• ${card} in 3–5 days.',
			'bookings.cancel.noRefundTitle' => 'The service fee is not refunded',
			'bookings.cancel.noRefundBody' => ({required Object fee}) => 'Less than 2 hours to go, so ${fee} stays with the shop. You don\'t pay for the haircut.',
			'bookings.cancel.slotFreed' => 'The slot is free for other customers straight away.',
			'bookings.cancel.confirm' => 'Yes, cancel',
			'bookings.cancel.keep' => 'Keep the booking',
			'bookings.cancel.done' => 'Booking cancelled.',
			'bookings.cancel.doneRefunded' => ({required Object fee}) => 'Booking cancelled · ${fee} refunded.',
			'bookings.cancel.failed' => 'The booking could not be cancelled. Try again.',
			'account.title' => 'Profile',
			'account.signedInWith' => ({required Object provider}) => 'Signed in with ${provider}',
			'account.editProfile' => 'Edit profile',
			'account.appearanceTitle' => 'Appearance and language',
			'account.themeSystem' => 'System',
			'account.themeLight' => 'Light',
			'account.themeDark' => 'Dark',
			'account.notificationsTitle' => 'Notifications',
			'account.reminderTitle' => 'Cut reminder',
			'account.reminderBody' => '2 hours before',
			'account.shopNewsTitle' => 'Shop news',
			'account.shopNewsBody' => 'Opening hours and closures',
			'account.accountTitle' => 'Account',
			'account.payments' => 'Payments and receipts',
			'account.switchToBarber' => 'Switch to barber',
			'account.help' => 'Help and contact',
			'account.signOut' => 'Sign out',
			_ => null,
		} ?? switch (path) {
			'account.signOutConfirmTitle' => 'Sign out?',
			'account.signOutConfirmBody' => 'You will need to sign in again to see your bookings.',
			'account.deleteAccount' => 'Delete account',
			'account.comingSoon' => 'Available soon.',
			'home.waitShort' => ({required Object n, required Object from, required Object to}) => '${n} · ${from}–${to} min',
			'home.useLocation' => 'Use my location',
			'home.useLocationLine' => 'Show the nearest shops first',
			'home.locationFailed' => 'Couldn\'t get your location. Check it\'s on and allowed for BookNow.',
			'home.guestBlocked' => 'Sign in to see the shops near you.',
			'home.intentNow' => 'Right now',
			'home.intentTomorrow' => 'Tomorrow',
			'home.searchHint' => 'Search shops or services',
			'home.clearCategory' => 'Clear category',
			'home.whereTitle' => 'Where should we look?',
			'home.list' => 'List',
			'home.map' => 'Map',
			'home.headlineNow' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} shop can see you now', other: '${n} shops can see you now', ), 
			'home.headlineToday' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} shop free today', other: '${n} shops free today', ), 
			'home.headlineTomorrow' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} shop to book tomorrow', other: '${n} shops to book tomorrow', ), 
			'home.feedNow' => 'Shortest wait first',
			'home.feedToday' => 'Next free times',
			'home.feedTomorrow' => 'Book for tomorrow',
			'home.categoryNotice' => 'Shops aren\'t sorted by category yet, so this is every shop.',
			'home.emptyNowTitle' => 'No one can see you right now',
			'home.emptyNowBody' => 'Book a time later today instead.',
			'home.emptyNowCta' => 'See today\'s times',
			'home.joinLine' => 'Join the line',
			'home.bookTime' => 'Book a time',
			'home.seeLine' => 'See the line',
			'home.seeTimes' => 'See the times',
			'home.headerTitle' => 'Book a chair or skip the line',
			'home.whatDoYouNeed' => 'What do you need?',
			'home.searchByName' => 'Search by name',
			'home.whereLabel' => 'Where',
			'home.whenLabel' => 'When',
			'home.today' => 'Today',
			'home.allCities' => 'All cities',
			'home.searchCategory' => ({required Object category}) => 'Search ${category}',
			'home.foldSearch' => 'Fold search',
			'home.openSearch' => 'Open full search',
			'home.explore' => 'Explore categories',
			'home.all' => 'All',
			'home.nearYou' => 'Near you',
			'home.shortestWait' => 'Shortest wait right now',
			'home.join' => 'Join',
			'home.book' => 'Book',
			'home.filterOpenNow' => 'Open now',
			'home.filterNearest' => 'Nearest',
			'home.filterShortestQueue' => 'Shortest queue',
			'home.waiting' => ({required Object n, required Object from, required Object to}) => '${n} waiting · ${from}–${to} min',
			'home.noWait' => 'No wait',
			'home.queueClosed' => 'Queue closed',
			'home.nextAt' => ({required Object time}) => 'Next ${time}',
			'home.inQueue' => 'In queue',
			'home.view' => 'View',
			'home.mapNow' => 'Now',
			'home.mapWait' => ({required Object from, required Object to}) => '${from}–${to}\'',
			'home.inLine' => 'in line',
			'home.greeting' => ({required Object name}) => 'Ciao ${name}',
			'home.greetingNoName' => 'Ciao',
			'home.nextBooking' => 'Next booking',
			'home.freeToday' => 'Free today',
			'home.shopsNearby' => 'Shops near you',
			'home.nothingBooked' => 'Nothing booked yet',
			'home.nothingBookedBody' => 'Pick a time below: a deposit holds the spot.',
			'home.noFreeToday' => 'No free times today.',
			'home.noShops' => 'No shops available right now.',
			'home.moreTimes' => 'more times',
			'home.metresAway' => ({required Object metres}) => '${metres} m',
			'home.kilometresAway' => ({required Object km}) => '${km} km',
			'home.servicesCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} service', other: '${n} services', ), 
			'home.fromPrice' => ({required Object price}) => 'from ${price}',
			'home.openNow' => 'Open',
			'home.openUntil' => ({required Object time}) => 'Open until ${time}',
			'home.closedNow' => 'Closed',
			'home.closedUntil' => ({required Object time}) => 'Closed · opens ${time}',
			'agenda.everyone' => 'Everyone',
			'agenda.freeLine' => ({required Object length}) => '${length} · Tap to block',
			'agenda.hours' => ({required Object count}) => '${count} h',
			'agenda.today' => 'Today',
			'agenda.pickDate' => 'Pick a date',
			'agenda.closedShort' => 'Shut',
			'agenda.closedTitle' => 'Closed',
			'agenda.closedBody' => 'No opening hours on this day.',
			'agenda.closureBody' => 'Closed for the day. Nothing can be booked.',
			'agenda.emptyTitle' => 'Nothing booked',
			'agenda.emptyBody' => 'No bookings for this day.',
			'agenda.booked' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} booked', other: '${n} booked', ), 
			'agenda.free' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} free', other: '${n} free', ), 
			'agenda.toCollect' => ({required Object amount}) => '${amount} to collect',
			'agenda.now' => 'now',
			'agenda.freeLabel' => 'Free',
			'agenda.customerFallback' => 'Customer',
			'agenda.minutes' => ({required Object count}) => '${count} min',
			'agenda.cancelledBy' => ({required Object name}) => 'cancelled by ${name}',
			'agenda.until' => ({required Object time, required Object amount}) => 'until ${time} · ${amount} in shop',
			'agenda.blockedLabel' => 'Blocked',
			'agenda.openBooking' => ({required Object name}) => 'Open ${name}\'s booking',
			'agenda.blockFree' => ({required Object time}) => 'Block the free time at ${time}',
			'agenda.openBlock' => ({required Object time}) => 'Open the block at ${time}',
			'agenda.sheet.timeLine' => ({required Object from, required Object to, required Object service, required Object minutes}) => '${from} – ${to} · ${service} · ${minutes} min',
			'agenda.sheet.toCollect' => 'To collect in shop',
			'agenda.sheet.holdPaid' => ({required Object amount}) => '${amount} hold already paid in app',
			'agenda.sheet.call' => ({required Object name}) => 'Call ${name}',
			'agenda.sheet.callGeneric' => 'Call',
			'agenda.sheet.markArrived' => 'Mark as arrived',
			'agenda.sheet.noShow' => 'No-show',
			'agenda.sheet.noShowFrom' => ({required Object time}) => 'No-show · from ${time}',
			'agenda.sheet.cancel' => 'Cancel booking',
			'agenda.sheet.noDialler' => 'No phone app on this device.',
			'agenda.sheet.comingSoon' => 'Available soon.',
			'agenda.block.title' => 'Block time',
			'agenda.block.from' => 'From',
			'agenda.block.to' => 'To',
			'agenda.block.note' => 'Note',
			'agenda.block.noteHint' => 'Break, walk-in client…',
			'agenda.block.save' => 'Block',
			'agenda.block.backwards' => 'The end has to come after the start.',
			'agenda.block.tooLong' => 'A block can\'t run longer than 8 hours.',
			'agenda.block.blockedTitle' => 'Blocked time',
			'agenda.block.remove' => 'Unblock',
			'agenda.block.removeTitle' => 'Unblock this time?',
			'agenda.block.removeBody' => 'Customers will be able to book it again.',
			'agenda.block.blocked' => 'Time blocked.',
			'agenda.block.unblocked' => 'Time unblocked.',
			'flow.doneShort' => 'You\'re booked',
			'flow.whenTitle' => 'When suits you?',
			'flow.morning' => 'Morning',
			'flow.afternoon' => 'Afternoon',
			'flow.lunchBreak' => ({required Object from, required Object to}) => '${from} – ${to} · lunch break',
			'flow.legendTaken' => '— struck through: taken',
			'flow.legendPast' => '— faded: past',
			'flow.continueWith' => ({required Object when, required Object time}) => 'Continue · ${when}, ${time}',
			'flow.closedTitle' => 'Closed',
			'flow.closedBody' => 'The shop is not open on this day. Pick another one.',
			'flow.noTimesTitle' => 'No free times',
			'flow.noTimesBody' => 'Try another day.',
			'flow.confirmTitle' => 'Check and confirm',
			'flow.change' => 'Change',
			'flow.payInShopWithMinutes' => ({required Object minutes}) => '${minutes} min · paid in the shop',
			'flow.bookNowService' => 'BookNow service',
			'flow.payNow' => 'paid now',
			'flow.payAndConfirm' => ({required Object fee}) => 'Pay ${fee} and confirm',
			'flow.payAndConfirmNoFee' => 'Pay and confirm',
			'flow.terms' => 'Free to cancel up to 2 hours before.',
			'flow.freeCancellationUntil' => ({required Object when}) => 'Free cancellation until ${when}.',
			'flow.arriveEarly' => 'Arrive 5 minutes early: the spot is held for 10 minutes.',
			'flow.declinedTitle' => 'Payment failed',
			'flow.declinedBody' => 'The card was declined. You have not been charged.',
			'flow.holdLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Slot held for ${n} more min', other: 'Slot held for ${n} more min', ), 
			'flow.holdLapsed' => 'The slot is no longer held',
			'flow.retry' => 'Try again',
			'flow.giveUp' => 'Leave it',
			'flow.confirmingTitle' => 'Confirming your booking',
			'flow.confirmingBody' => 'The payment went through. This takes a few seconds.',
			'flow.doneTitle' => 'You\'re all set',
			'flow.doneBody' => 'Your spot is booked. We\'ll remind you 2 hours before.',
			'flow.feePaid' => ({required Object fee}) => '${fee} paid',
			'flow.inShop' => ({required Object price}) => '${price} in shop',
			'flow.done' => 'Done',
			'queue.liveNow' => 'Live right now',
			'queue.turnTitleShort' => 'Your turn',
			'queue.splashPlace' => ({required Object n, required Object shop}) => 'You\'re #${n} at ${shop}',
			'queue.splashTurn' => ({required Object shop}) => 'It\'s your turn at ${shop}',
			'queue.live' => 'Live queue',
			'queue.walkIn' => 'Walk-in',
			'queue.stateOpen' => 'Queue open',
			'queue.statePaused' => 'Paused',
			'queue.stateFull' => 'Full for today',
			'queue.stateClosed' => 'Closed for today',
			'queue.stateOutside' => 'Outside opening hours',
			'queue.waitingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'person waiting', other: 'people waiting', ), 
			'queue.estimateNow' => 'If you join now, estimated wait',
			'queue.range' => ({required Object from, required Object to}) => '${from}–${to} min',
			'queue.pausedBody' => 'The barber has paused the queue. People already in line keep their place: try again shortly.',
			'queue.fullBody' => 'Anyone joining now would finish after closing. Try again tomorrow.',
			'queue.closedBody' => 'The queue is closed for today.',
			'queue.outsideBody' => 'The shop is closed right now.',
			'queue.services' => 'Services',
			'queue.pickService' => 'What do you need?',
			'queue.minutes' => ({required Object minutes}) => '${minutes} min',
			'queue.inShop' => ({required Object price}) => '${price} in shop',
			'queue.feeHint' => ({required Object fee}) => 'You pay ${fee} for your place in the queue. The service is paid in the shop.',
			'queue.join' => 'Join',
			'queue.turnIn' => 'Your turn in about',
			'queue.about' => ({required Object range}) => 'about ${range}',
			'queue.refundRule' => 'The fee comes back if you leave while 3 or more people are ahead.',
			'queue.graceRule' => 'We let you know when one person is left ahead of you and when it is your turn: from then you have 10 minutes to arrive.',
			'queue.payAndJoin' => ({required Object fee}) => 'Pay ${fee} and join',
			'queue.placeAfterPayment' => 'Your place is yours as soon as the payment goes through.',
			'queue.joiningTitle' => 'Putting you in the queue',
			'queue.joiningBody' => 'Your payment went through. This takes a few seconds.',
			'queue.inQueue' => 'You\'re in the queue',
			'queue.almost' => 'Almost your turn',
			'queue.position' => ({required Object n}) => '#${n}',
			'queue.inLine' => 'in line',
			'queue.ahead' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '1 person ahead of you', other: '${n} people ahead of you', ), 
			'queue.next' => 'You\'re next',
			'queue.waitAnywhere' => 'We\'ll notify you when you\'re next. You can leave the shop and come back.',
			'queue.leaveRefund' => 'You have at least 3 people ahead: if you leave now, we refund the service fee.',
			'queue.leaveNoRefund' => 'You have fewer than 3 people ahead: if you leave now, the service fee is not refunded.',
			'queue.leave' => 'Leave the queue',
			'queue.turnTitle' => 'It\'s your turn',
			'queue.turnBody' => 'The barber is ready for you. You have 10 minutes to arrive.',
			'queue.turnLeft' => 'to arrive',
			'queue.turnLate' => 'After 10 minutes the barber can mark you as a no-show: the service fee is then not refunded.',
			'queue.servingTitle' => 'You\'re in the chair',
			'queue.servingBody' => 'Your service has started. You pay for it in the shop, as usual.',
			'queue.leaveSheet.title' => 'Leave the queue?',
			'queue.leaveSheet.body' => ({required Object shop}) => 'You lose your place at ${shop}. If you change your mind you\'ll go back to the end of the line.',
			'queue.leaveSheet.refund' => ({required Object fee}) => 'We refund ${fee} within 5–10 business days.',
			'queue.leaveSheet.noRefund' => ({required Object fee}) => 'Your turn is close: if you leave now, ${fee} is not refunded.',
			'queue.leaveSheet.confirm' => 'Yes, leave the queue',
			'queue.leaveSheet.confirmNoRefund' => 'Leave anyway',
			'queue.leaveSheet.stay' => 'Stay in the queue',
			'queue.leftTitle' => 'You left the queue',
			'queue.leftRefunded' => ({required Object fee}) => 'We refund ${fee} within 5–10 business days.',
			'queue.leftKept' => 'The service fee was not refunded.',
			'queue.endedTitle' => 'You\'re no longer in the queue',
			'queue.endedBody' => 'If the barber removed you or closed for today, we refund the service fee.',
			'queue.declinedTitle' => 'Payment failed',
			'queue.declinedBody' => 'Your card was declined. You have not been charged.',
			'queue.retry' => 'Try again',
			'queue.giveUp' => 'Never mind',
			'queue.done' => 'Done',
			'queue.homeTitle' => 'You\'re in the queue',
			'queue.homePaid' => 'Paid',
			'queue.seeQueue' => 'See the queue',
			'queue.owner.walkInFab' => 'Walk-in',
			'queue.owner.nobodyWaiting' => 'Nobody waiting. Enjoy the coffee.',
			'queue.owner.reopen' => 'Reopen',
			'queue.owner.minutesLeft' => ({required Object minutes}) => '${minutes} min left',
			'queue.owner.doneWith' => ({required Object name}) => 'Done with ${name}',
			'queue.owner.calledName' => ({required Object name}) => 'Called ${name}',
			'queue.owner.waitingFor' => ({required Object minutes}) => 'Waiting ${minutes} min',
			'queue.owner.theyreHere' => 'They\'re here, start',
			'queue.owner.noShowIn' => ({required Object time}) => 'No-show in ${time}',
			'queue.owner.chair' => 'Chair',
			'queue.owner.freeNow' => 'Free now',
			'queue.owner.nobodyToCall' => 'Nobody waiting',
			'queue.owner.kindApp' => 'App',
			'queue.owner.kindWalkIn' => 'Walk-in',
			'queue.owner.removeFromLine' => 'Remove from the line',
			'queue.owner.rowNoteApp' => 'Removing someone always refunds their fee.',
			'queue.owner.rowNoteWalkIn' => 'Walk-ins paid nothing in the app.',
			'queue.owner.title' => 'Today\'s queue',
			'queue.owner.summary' => ({required Object waiting, required Object until}) => '${waiting} waiting · the queue ends around ${until}',
			'queue.owner.summaryEmpty' => 'Nobody waiting',
			'queue.owner.pause' => 'Pause',
			'queue.owner.resume' => 'Resume',
			'queue.owner.closeToday' => 'Close for today',
			'queue.owner.inChair' => 'In the chair',
			'queue.owner.called' => 'Called',
			'queue.owner.waiting' => 'Waiting',
			'queue.owner.since' => ({required Object minutes}) => 'for ${minutes} min',
			'queue.owner.calledAt' => ({required Object time}) => 'called at ${time}',
			'queue.owner.queuedAt' => ({required Object time}) => 'in line since ${time}',
			'queue.owner.graceLeft' => ({required Object minutes}) => '${minutes} min left',
			'queue.owner.done' => 'Done',
			'queue.owner.start' => 'Start',
			'queue.owner.noShow' => 'No-show',
			'queue.owner.noShowFrom' => ({required Object time}) => 'No-show · from ${time}',
			'queue.owner.walkInName' => 'Walk-in',
			'queue.owner.remove' => ({required Object name}) => 'Remove ${name} from the queue',
			'queue.owner.callNext' => 'Call next',
			'queue.owner.addWalkIn' => 'Walk-in',
			'queue.owner.emptyTitle' => 'Nobody in the queue',
			'queue.owner.emptyBody' => 'Customers who join from the app show up here. Add people who walk in without it with Walk-in.',
			'queue.owner.removeSheet.title' => ({required Object name}) => 'Remove ${name}?',
			'queue.owner.removeSheet.body' => 'They leave the queue and we refund their service fee.',
			'queue.owner.removeSheet.confirm' => 'Remove from the queue',
			'queue.owner.removeSheet.keep' => 'Cancel',
			'queue.owner.walkInSheet.title' => 'Add a walk-in',
			'queue.owner.walkInSheet.body' => 'For someone who came in without the app. They go to the end of the line, so the wait stays right for everyone.',
			'queue.owner.walkInSheet.service' => 'Service',
			'queue.owner.walkInSheet.name' => 'Name (optional)',
			'queue.owner.walkInSheet.nameHint' => 'e.g. Andrea',
			'queue.owner.walkInSheet.add' => 'Add to the line',
			'queue.owner.walkInSheet.cancel' => 'Cancel',
			'queue.mode.row' => 'How you work',
			'queue.mode.booking' => 'By appointment',
			'queue.mode.queue' => 'Queue',
			'queue.mode.both' => 'Both',
			'queue.mode.title' => 'How you work',
			'queue.mode.lead' => 'Choose how customers come to you. You can change it any time.',
			'queue.mode.bookingBody' => 'Customers pick a day and time in the app. Best if you work from an agenda.',
			'queue.mode.queueBody' => 'Customers see how many people are waiting and join the line from the app. Best if you work without appointments.',
			'queue.mode.blocked' => 'You can\'t switch right now. You can stop taking bookings once you have no future ones, and close the queue once it is empty.',
			'queue.mode.bothBody' => 'Customers choose to book a time or join the line. Booked times keep their place and the line flows around them.',
			'queue.mode.save' => 'Save',
			'queue.mode.saved' => 'Mode updated',
			'categories.barber' => 'Barber',
			'categories.salon' => 'Hair salon',
			'categories.nails' => 'Nails',
			'categories.beauty' => 'Beauty',
			'categories.spa' => 'Spa',
			'categories.lashes' => 'Lashes',
			'categories.tattoo' => 'Tattoo',
			'categories.makeup' => 'Makeup',
			'categories.kids' => 'Kids cuts',
			'categories.more' => 'More',
			'search.recent' => 'Recent',
			'search.allShops' => 'All shops',
			'search.title' => 'Find a shop',
			'search.hint' => 'Name or street',
			'search.noResults' => 'No shops found.',
			'search.categoryNotice' => ({required Object category}) => 'Shops aren\'t sorted by category yet, so this is every shop, not only ${category}.',
			'live.overlineBooked' => 'Booked',
			'live.freeUntil' => ({required Object when}) => 'Free to cancel until ${when}',
			'live.cancelBooking' => 'Cancel booking',
			'live.cancelTitle' => 'Cancel this booking?',
			'live.keepBooking' => 'Keep my booking',
			'live.yesCancel' => 'Yes, cancel',
			'live.refundYes2' => ({required Object fee}) => 'Your ${fee} fee will be refunded.',
			'live.refundFree' => 'It was free to book, so cancelling costs nothing.',
			'live.refundNo2' => ({required Object fee}) => 'It\'s less than 2 hours away, so the ${fee} fee is not refunded.',
			'live.cancelledRefunded' => ({required Object fee}) => 'Booking cancelled. ${fee} refunded.',
			'live.cancelledNoRefund' => 'Booking cancelled.',
			'live.cancelFailed' => 'Couldn\'t cancel. Your booking still stands.',
			'live.overline' => 'In the line',
			'live.headInAt' => ({required Object shop}) => 'Head in now · ${shop}',
			'live.chair' => 'Chair',
			'live.directions' => 'Get directions',
			'live.inChair' => 'In the chair',
			'live.headIn' => 'Head in now. They\'ll hold your place for 10 minutes.',
			'live.leave' => 'Leave the line',
			'live.leaveTitle' => 'Leave the line?',
			'live.refundYes' => 'Your service fee will be refunded.',
			'live.refundNo' => 'With fewer than 3 people ahead, the service fee is not refunded.',
			'live.keep' => 'Keep my place',
			'live.leaveConfirm' => 'Yes, leave',
			'live.leftRefunded' => 'You left the line. Fee refunded.',
			'live.leftNoRefund' => 'You left the line.',
			'live.leaveFailed' => 'Couldn\'t leave the line. You still have your place.',
			'guest.ownerSheetTitle' => 'Sign in to your shop',
			'guest.ownerCustomerAccount' => 'You are signed in, but this account is already a customer account, so it cannot be used for a shop.',
			'guest.title' => 'Skip the wait, keep your place',
			'guest.body' => 'One tap with the account you already have. New or returning, it\'s the same two buttons.',
			'guest.activityTitle' => 'Your visits live here',
			'guest.activityBody' => 'Sign in to follow your place in line and keep your bookings together.',
			'guest.signIn' => 'Sign in',
			'guest.signInTitle' => 'Sign in to BookNow',
			'guest.light' => 'Light',
			'guest.dark' => 'Dark',
			'guest.system' => 'Auto',
			'guest.ownerTitle' => 'Do you run a shop?',
			'guest.ownerBody' => 'Take bookings and run your queue from your phone.',
			'guest.gateBook' => 'Sign in to book this time',
			'guest.gateJoin' => 'Sign in to join the line',
			'guest.gateBody' => ({required Object what}) => '${what}. Your choice is kept, and it takes one tap.',
			'welcome.title' => 'What should the shop call you?',
			'welcome.nameLabel' => 'Your name',
			'welcome.body' => 'Only shops you visit see it. You can change it later.',
			'welcome.cta' => 'Continue',
			'shopScreen.whoLike' => 'With whom?',
			'shopScreen.anyone' => 'Anyone free',
			'shopScreen.withWhom' => ({required Object name}) => 'with ${name}',
			'shopScreen.closedDay' => ({required Object day}) => 'Closed on ${day}. Pick another day.',
			'shopScreen.noTimes' => 'No free times on this day. Pick another day.',
			'shopScreen.joinNow' => ({required Object service}) => '${service} · join now',
			'shopScreen.paying' => 'Paying',
			'shopScreen.tryAgain' => 'Try again',
			'shopScreen.payFee' => ({required Object fee}) => 'Pay ${fee}',
			'shopScreen.placedAt' => ({required Object shop}) => '${shop} · we\'ll tell you when it\'s your turn',
			'shopScreen.previewTitle' => 'Preview',
			'shopScreen.previewBody' => 'This is what customers see.',
			'shopScreen.whatLike' => 'What would you like?',
			'shopScreen.when' => 'When?',
			'shopScreen.sumPick' => 'Pick a time to continue',
			'shopScreen.sumShop' => ({required Object price}) => '${price} in shop',
			'shopScreen.sumShopFee' => ({required Object price, required Object fee}) => '${price} in shop · ${fee} now',
			'shopScreen.continue_' => 'Continue',
			'shopScreen.bookTitle' => ({required Object when}) => 'Book ${when}?',
			'shopScreen.joinTitle' => ({required Object shop}) => 'Join the line at ${shop}?',
			'shopScreen.feeLabel' => 'BookNow fee',
			'shopScreen.feeWhen' => 'Paid now',
			'shopScreen.serviceWhen' => 'Paid to the shop',
			'shopScreen.noFee' => 'Free to book',
			'shopScreen.confirmFree' => 'Confirm booking',
			'shopScreen.heldFor' => ({required Object time}) => 'Held for you for ${time}',
			'shopScreen.declined' => 'That card was declined. You have not been charged.',
			'shopScreen.placed' => 'You\'re in the line',
			'shopScreen.placedBody' => 'We\'ll tell you when it\'s your turn.',
			'today.untilTime' => ({required Object time}) => 'until ${time}',
			'today.bookedTag' => 'Booked',
			'today.queueLine' => ({required Object n, required Object time}) => '${n} waiting · until about ${time}',
			'today.nowLabel' => 'Now',
			'today.nextLabel' => 'Next up',
			'today.comingUp' => 'Coming up',
			'today.details' => 'Details',
			'today.callName' => ({required Object name}) => 'Call ${name}',
			'today.nothingLeftTitle' => 'Nothing else booked today',
			'today.nothingLeftBody' => 'Your free time stays open to customers.',
			'today.markedArrived' => ({required Object name}) => '${name} marked as arrived',
			'today.markedNoShow' => ({required Object name}) => '${name} marked as a no-show',
			'today.noShowTitle' => ({required Object name}) => 'Mark ${name} as a no-show?',
			'today.noShowBody' => 'This can\'t be undone.',
			'today.cancelTitle' => ({required Object name}) => 'Cancel ${name}\'s booking?',
			'today.cancelBody' => 'The customer is told, and the time opens up again.',
			'today.cancelled' => 'Booking cancelled',
			'today.stateTitle' => 'How\'s the queue today?',
			'today.stateOpenTitle' => 'Open',
			'today.stateOpenBody' => 'People can join from the app.',
			'today.statePauseBody' => 'Nobody new can join. People in line stay.',
			'today.stateCloseBody' => ({required Object n}) => 'Nobody new can join. You still serve the ${n} in line, and anyone not served is refunded.',
			'today.pausedBanner' => 'Paused. Nobody new can join.',
			'today.closedBanner' => 'Closed for today. Finish the people in line.',
			'today.wayLine' => 'Line',
			'today.wayBookings' => 'Bookings',
			'today.calendarTitle' => 'Calendar',
			'today.calendarQueueTitle' => 'Your shop runs a queue',
			'today.calendarQueueBody' => 'Customers join the line instead of booking times, so there\'s nothing to plan here. Run the line from Today.',
			'today.calendarQueueCta' => 'Change how you work',
			'chairs.free' => 'Free',
			'chairs.done' => 'Done',
			'chairs.startName' => ({required Object name}) => 'Start ${name}',
			'chairs.overPlan' => ({required Object minutes}) => '${minutes} min over plan',
			'chairs.until' => ({required Object time}) => 'until ${time}',
			'chairs.nextInLine' => 'In line',
			'chairs.nextBooking' => 'Next booking',
			'chairs.turnedAway' => 'Someone turned away',
			'chairs.turnedAwayRecorded' => 'Recorded',
			'statistics.title' => 'Statistics',
			'statistics.today' => 'Today',
			'statistics.sevenDays' => '7 days',
			'statistics.thirtyDays' => '30 days',
			'statistics.custom' => 'Custom',
			'statistics.everyone' => 'Everyone',
			'statistics.allServices' => 'All services',
			'statistics.staffFilter' => 'Staff',
			'statistics.serviceFilter' => 'Service',
			'statistics.rangeTooLong' => ({required Object days}) => 'Choose ${days} days or fewer',
			'statistics.minutes' => ({required Object value}) => '${value} min',
			'statistics.emptyTitle' => 'Nothing to show yet',
			'statistics.emptyBody' => 'Figures appear here once you start using Start and Done on Today.',
			'statistics.kpi.wait' => 'Walk-in wait',
			'statistics.kpi.waitDetail' => ({required Object p90}) => '9 in 10 within ${p90}',
			'statistics.kpi.lost' => 'Lost revenue',
			'statistics.kpi.lostDetail' => ({required Object left, required Object away}) => '${left} left · ${away} turned away',
			'statistics.kpi.onTime' => 'Bookings on time',
			'statistics.kpi.onTimeDetail' => ({required Object delay}) => 'Average delay ${delay}',
			'statistics.kpi.utilization' => 'Chair utilization',
			'statistics.kpi.utilizationDetail' => ({required Object after}) => '${after} after closing',
			'statistics.kpi.overruns' => 'Over plan by 5+ min',
			'statistics.kpi.overrunsDetail' => ({required Object real, required Object plan}) => 'Typically ${real}, menu ${plan}',
			'statistics.kpi.revenue' => 'Estimated revenue',
			'statistics.kpi.revenueDetail' => ({required Object visits}) => '${visits} visits, at menu prices',
			'statistics.kpi.estimates' => 'Wait estimates in range',
			'statistics.kpi.estimatesDetail' => ({required Object miss}) => 'Typically off by ${miss}',
			'statistics.detail.servicesTitle' => 'Services',
			'statistics.detail.waitsTitle' => 'Waits and walk-aways',
			'statistics.detail.bookingsTitle' => 'Bookings and no-shows',
			'statistics.detail.busyTitle' => 'Busy hours',
			'statistics.detail.estimatesTitle' => 'Estimate accuracy',
			'statistics.detail.allServices' => 'All services',
			'statistics.detail.real' => 'Real',
			'statistics.detail.menu' => 'Menu',
			'statistics.detail.overPlan' => 'Over plan by 5+ min',
			'statistics.detail.visits' => 'Visits',
			'statistics.detail.estimatedRevenue' => 'Estimated revenue',
			'statistics.detail.deletedService' => 'Deleted service',
			'statistics.detail.formerStaff' => 'Former staff',
			'statistics.detail.medianOf' => ({required Object real, required Object visits}) => '${real} · ${visits} visits',
			'statistics.detail.walkInWait' => 'Walk-in wait',
			'statistics.detail.average' => 'Average',
			'statistics.detail.p90' => '9 in 10 waited less than',
			'statistics.detail.served' => 'Customers served',
			'statistics.detail.lostCustomers' => 'Customers lost',
			'statistics.detail.walkedAway' => 'Walked away',
			'statistics.detail.turnedAway' => 'Turned away',
			'statistics.detail.neverServed' => 'Still waiting at closing',
			'statistics.detail.lostRevenue' => 'Estimated lost revenue',
			'statistics.detail.total' => 'Total',
			'statistics.detail.lostNote' => 'Based on menu prices, or your median price when nobody found out what they wanted.',
			'statistics.detail.punctuality' => 'Punctuality',
			'statistics.detail.onTime' => 'Started on time',
			'statistics.detail.averageDelay' => 'Average delay',
			'statistics.detail.started' => 'Bookings started',
			'statistics.detail.onTimeNote' => 'On time means within 5 minutes of the booked time.',
			'statistics.detail.noShows' => 'No-shows',
			'statistics.detail.noShowRate' => 'No-show rate',
			'statistics.detail.booked' => 'Booked',
			'statistics.detail.cancelled' => 'Cancelled',
			'statistics.detail.heatmapTitle' => 'When you\'re busiest',
			'statistics.detail.heatmapSummary' => ({required Object day, required Object hour}) => 'Busiest on ${day} at ${hour}',
			'statistics.detail.quiet' => 'Quiet',
			'statistics.detail.busy' => 'Busy',
			'statistics.detail.chairs' => 'Chairs',
			'statistics.detail.utilization' => 'Utilization',
			'statistics.detail.busyTime' => 'Time serving',
			'statistics.detail.availableTime' => 'Time available',
			'statistics.detail.afterClosing' => 'Worked after closing',
			'statistics.detail.estimateAccuracy' => 'The wait we showed',
			'statistics.detail.withinRange' => 'Inside the range shown',
			'statistics.detail.typicalMiss' => 'Typically off by',
			'statistics.detail.longerThanShown' => 'Real waits ran longer by',
			'statistics.detail.shorterThanShown' => 'Real waits ran shorter by',
			'statistics.detail.compared' => 'Waits compared',
			'statistics.detail.estimateNote' => 'Compares the wait shown when someone joined with the wait they really had.',
			'homeWidgets.inLine' => 'In line',
			'homeWidgets.nextVisit' => 'Next visit',
			'homeWidgets.bookAgain' => 'Book again',
			'homeWidgets.findTitle' => 'Find a shop',
			'homeWidgets.findLine' => 'Book a time or join a line',
			'homeWidgets.directions' => 'Directions',
			'homeWidgets.headIn' => 'Head in within 10 min',
			'homeWidgets.ahead' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, zero: 'You\'re next', one: '${n} person ahead', other: '${n} people ahead', ), 
			'homeWidgets.waiting' => 'waiting',
			'homeWidgets.waitingCount' => ({required Object n}) => '${n} waiting',
			'homeWidgets.nobodyWaiting' => 'Nobody waiting',
			'homeWidgets.nextUp' => 'Next up',
			'homeWidgets.calledLine' => 'Called, on their way',
			_ => null,
		} ?? switch (path) {
			'homeWidgets.nextAppointment' => 'Next appointment',
			'homeWidgets.nothingLeft' => 'Nothing else today',
			'homeWidgets.moreToday' => ({required Object n}) => '${n} more today',
			'homeWidgets.openToday' => 'Open today',
			'homeWidgets.staleQueue' => 'Open BookNow to check your place',
			'homeWidgets.staleBooking' => 'Open BookNow to see your next visit',
			'homeWidgets.staleOwner' => 'Open BookNow to see today',
			_ => null,
		};
	}
}
