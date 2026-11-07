///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsIt extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsIt({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.it,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <it>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	@override dynamic operator[](String key) => _meta.getTranslation(key) ?? super[key];

	late final TranslationsIt _root = this; // ignore: unused_field

	@override 
	TranslationsIt $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsIt(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$common$it common = _Translations$common$it._(_root);
	@override late final _Translations$nav$it nav = _Translations$nav$it._(_root);
	@override late final _Translations$errors$it errors = _Translations$errors$it._(_root);
	@override late final _Translations$bookingStatus$it bookingStatus = _Translations$bookingStatus$it._(_root);
	@override late final _Translations$onboarding$it onboarding = _Translations$onboarding$it._(_root);
	@override late final _Translations$auth$it auth = _Translations$auth$it._(_root);
	@override late final _Translations$profile$it profile = _Translations$profile$it._(_root);
	@override late final _Translations$help$it help = _Translations$help$it._(_root);
	@override late final _Translations$validation$it validation = _Translations$validation$it._(_root);
	@override late final _Translations$shopSetup$it shopSetup = _Translations$shopSetup$it._(_root);
	@override late final _Translations$weekdays$it weekdays = _Translations$weekdays$it._(_root);
	@override late final _Translations$notifications$it notifications = _Translations$notifications$it._(_root);
	@override late final _Translations$notificationSettings$it notificationSettings = _Translations$notificationSettings$it._(_root);
	@override late final _Translations$bookings$it bookings = _Translations$bookings$it._(_root);
	@override late final _Translations$account$it account = _Translations$account$it._(_root);
	@override late final _Translations$home$it home = _Translations$home$it._(_root);
	@override late final _Translations$agenda$it agenda = _Translations$agenda$it._(_root);
	@override late final _Translations$flow$it flow = _Translations$flow$it._(_root);
	@override late final _Translations$queue$it queue = _Translations$queue$it._(_root);
	@override late final _Translations$categories$it categories = _Translations$categories$it._(_root);
	@override late final _Translations$search$it search = _Translations$search$it._(_root);
	@override late final _Translations$live$it live = _Translations$live$it._(_root);
	@override late final _Translations$guest$it guest = _Translations$guest$it._(_root);
	@override late final _Translations$welcome$it welcome = _Translations$welcome$it._(_root);
	@override late final _Translations$shopScreen$it shopScreen = _Translations$shopScreen$it._(_root);
	@override late final _Translations$today$it today = _Translations$today$it._(_root);
	@override late final _Translations$homeWidgets$it homeWidgets = _Translations$homeWidgets$it._(_root);
}

// Path: common
class _Translations$common$it extends Translations$common$en {
	_Translations$common$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get appName => 'BookNow';
	@override String get continue_ => 'Continua';
	@override String get cancel => 'Annulla';
	@override String get close => 'Chiudi';
	@override String get confirm => 'Conferma';
	@override String get save => 'Salva';
	@override String get edit => 'Modifica';
	@override String get delete => 'Elimina';
	@override String get retry => 'Riprova';
	@override String get skip => 'Salta';
	@override String get notNow => 'Non ora';
	@override String get back => 'Indietro';
	@override String get clear => 'Cancella';
	@override String get search => 'Cerca';
	@override String get loading => 'Caricamento…';
	@override String get offline => 'Nessuna connessione';
	@override String serviceLine({required Object name, required Object price, required Object minutes}) => '${name} ${price} · ${minutes} min';
}

// Path: nav
class _Translations$nav$it extends Translations$nav$en {
	_Translations$nav$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get today => 'Oggi';
	@override String get calendar => 'Calendario';
	@override String get shop => 'Negozio';
	@override String get discover => 'Scopri';
	@override String get activity => 'Attività';
	@override String get home => 'Home';
	@override String get bookings => 'Prenotazioni';
	@override String get agenda => 'Agenda';
	@override String get profile => 'Profilo';
}

// Path: errors
class _Translations$errors$it extends Translations$errors$en {
	_Translations$errors$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get generic => 'Qualcosa è andato storto. Riprova.';
	@override String get noConnection => 'Sembra che tu sia offline.';
	@override String get timeout => 'La richiesta ha impiegato troppo tempo.';
	@override String get server => 'Il servizio ha un problema. Riprova tra poco.';
	@override String get unauthorized => 'La sessione è scaduta. Accedi di nuovo.';
	@override String get forbidden => 'Non hai accesso a questa sezione.';
	@override String get notFound => 'Non l\'abbiamo trovato.';
	@override String get tooManyRequests => 'Troppi tentativi. Attendi un momento.';
	@override String get slotTaken => 'Questo slot è appena stato preso. Scegline un altro.';
	@override String get holdExpired => 'Lo slot è stato liberato perché il pagamento ha impiegato troppo tempo.';
	@override String get leadTimeTooShort => 'Questo slot è troppo vicino per essere prenotato.';
	@override String get outsideBookingHorizon => 'Questa data non è ancora prenotabile.';
	@override String get shopClosed => 'Il negozio è chiuso in questo giorno.';
	@override String get cancellationWindowPassed => 'È troppo tardi per annullare ed essere rimborsato.';
	@override String get slotNotBookable => 'Questo orario non è prenotabile.';
	@override String get serviceNotAvailable => 'Questo servizio non è più disponibile.';
	@override String get invalidBlock => 'Questo intervallo non si può bloccare.';
	@override String get shopIncomplete => 'Mancano ancora alcuni dati prima di pubblicare.';
	@override String get providerLimitReached => 'Un negozio può avere fino a 10 persone al lavoro.';
	@override String get providerInUse => 'Ci sono ancora clienti prenotati o in coda con questa persona. Sposta o annulla prima quelle.';
	@override String get defaultProvider => 'Sei tu, quindi non puoi essere rimosso.';
	@override String get providerNotAvailable => 'Questa persona non è disponibile per questo servizio. Scegline un\'altra.';
}

// Path: bookingStatus
class _Translations$bookingStatus$it extends Translations$bookingStatus$en {
	_Translations$bookingStatus$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get pendingPayment => 'In attesa di pagamento';
	@override String get confirmed => 'Confermata';
	@override String get arrived => 'Arrivato';
	@override String get noShow => 'Non presentato';
	@override String get cancelled => 'Annullata';
	@override String get completed => 'Completata';
	@override String get expired => 'Scaduta';
}

// Path: onboarding
class _Translations$onboarding$it extends Translations$onboarding$en {
	_Translations$onboarding$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get skip => 'Salta';
	@override String get next => 'Avanti';
	@override String get start => 'Inizia';
	@override String get haveAccount => 'Ho già un account';
	@override late final _Translations$onboarding$slideOne$it slideOne = _Translations$onboarding$slideOne$it._(_root);
	@override late final _Translations$onboarding$slideTwo$it slideTwo = _Translations$onboarding$slideTwo$it._(_root);
	@override late final _Translations$onboarding$slideThree$it slideThree = _Translations$onboarding$slideThree$it._(_root);
}

// Path: auth
class _Translations$auth$it extends Translations$auth$en {
	_Translations$auth$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get continueWithApple => 'Continua con Apple';
	@override String get continueWithGoogle => 'Continua con Google';
	@override String get signUpWithApple => 'Registrati con Apple';
	@override String get signUpWithGoogle => 'Registrati con Google';
	@override late final _Translations$auth$signIn$it signIn = _Translations$auth$signIn$it._(_root);
	@override late final _Translations$auth$signUp$it signUp = _Translations$auth$signUp$it._(_root);
	@override late final _Translations$auth$role$it role = _Translations$auth$role$it._(_root);
	@override late final _Translations$auth$profile$it profile = _Translations$auth$profile$it._(_root);
}

// Path: profile
class _Translations$profile$it extends Translations$profile$en {
	_Translations$profile$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get signedOut => 'Disconnesso';
	@override String get remindersOff => 'Promemoria disattivati';
	@override String notificationsOnBefore({required Object when}) => 'Attive, ${when} prima';
	@override String get ownerHelp => 'Aiuto';
	@override String get helpLine => 'Domande, scrivici';
	@override String get modeRow => 'Clienti';
	@override String get shopTitle => 'Il tuo negozio';
	@override String get shopLive => 'Online su BookNow';
	@override String get shopHidden => 'Non ancora visibile ai clienti';
	@override String get seeAsCustomer => 'Vedi come cliente';
	@override String get howYouWork => 'Come lavori';
	@override String get yourAccount => 'Il tuo account';
	@override String get title => 'Profilo';
	@override String get roleOwner => 'titolare';
	@override String get roleCustomer => 'cliente';
	@override String get shopSection => 'Cosa vedono i clienti';
	@override String get shopPhotoPlaceholder => 'foto';
	@override String get shopNameMissing => 'Il tuo negozio';
	@override String get shopDetailsMissing => 'Completa i dati del negozio';
	@override String get services => 'Servizi';
	@override String servicesCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} servizio',
		other: '${n} servizi',
	);
	@override String get hours => 'Orari e chiusure';
	@override String get hoursNone => 'Da impostare';
	@override String get team => 'Team';
	@override String get teamJustYou => 'Solo tu';
	@override String teamCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} persona',
		other: '${n} persone',
	);
	@override String get bookingRules => 'Regole di prenotazione';
	@override String get appearanceSection => 'Aspetto e lingua';
	@override String get themeSystem => 'Sistema';
	@override String get themeLight => 'Chiaro';
	@override String get themeDark => 'Scuro';
	@override String get accountSection => 'Account';
	@override String get notifications => 'Notifiche';
	@override String get notificationsOn => 'Attive';
	@override String get notificationsOff => 'Disattivate';
	@override String get help => 'Aiuto e contatti';
	@override String get signOut => 'Esci';
	@override String get deleteAccount => 'Elimina account';
	@override late final _Translations$profile$signOutDialog$it signOutDialog = _Translations$profile$signOutDialog$it._(_root);
	@override late final _Translations$profile$deleteSheet$it deleteSheet = _Translations$profile$deleteSheet$it._(_root);
	@override String get personalData => 'Dati personali';
	@override String get editProfile => 'Modifica profilo';
	@override String signedInWith({required Object provider}) => 'Accesso con ${provider}';
	@override late final _Translations$profile$personal$it personal = _Translations$profile$personal$it._(_root);
}

// Path: help
class _Translations$help$it extends Translations$help$en {
	_Translations$help$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'Aiuto e contatti';
	@override String get faqSection => 'Domande frequenti';
	@override String get needMore => 'Serve altro?';
	@override late final _Translations$help$faq$it faq = _Translations$help$faq$it._(_root);
	@override String get callShop => 'Chiama il negozio';
	@override String get callShopSubtitle => 'Per orari, servizi e appuntamenti';
	@override String get writeUs => 'Scrivi a BookNow';
	@override String get writeUsSubtitle => 'Pagamenti, rimborsi e app · entro 24 ore';
	@override String get terms => 'Termini';
	@override String get privacy => 'Privacy';
	@override String version({required Object version}) => 'Versione ${version}';
	@override String get callFailed => 'Non riesco ad aprire il telefono.';
	@override String get linkFailed => 'Non riesco ad aprire il link.';
	@override late final _Translations$help$topics$it topics = _Translations$help$topics$it._(_root);
	@override late final _Translations$help$write$it write = _Translations$help$write$it._(_root);
	@override late final _Translations$help$mail$it mail = _Translations$help$mail$it._(_root);
}

// Path: validation
class _Translations$validation$it extends Translations$validation$en {
	_Translations$validation$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get required => 'Questo campo è obbligatorio.';
	@override String requiredNamed({required Object field}) => '${field} è obbligatorio.';
	@override String get email => 'Inserisci un indirizzo email valido.';
	@override String get phone => 'Inserisci un numero di telefono valido.';
	@override String tooShort({required Object min}) => 'Almeno ${min} caratteri.';
	@override String tooLong({required Object max}) => 'Massimo ${max} caratteri.';
}

// Path: shopSetup
class _Translations$shopSetup$it extends Translations$shopSetup$en {
	_Translations$shopSetup$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$shopSetup$team$it team = _Translations$shopSetup$team$it._(_root);
	@override late final _Translations$shopSetup$checklist$it checklist = _Translations$shopSetup$checklist$it._(_root);
	@override String stepOf({required Object current, required Object total}) => '${current}/${total}';
	@override String get continue_ => 'Continua';
	@override late final _Translations$shopSetup$shop$it shop = _Translations$shopSetup$shop$it._(_root);
	@override late final _Translations$shopSetup$details$it details = _Translations$shopSetup$details$it._(_root);
	@override late final _Translations$shopSetup$address$it address = _Translations$shopSetup$address$it._(_root);
	@override late final _Translations$shopSetup$services$it services = _Translations$shopSetup$services$it._(_root);
	@override late final _Translations$shopSetup$hours$it hours = _Translations$shopSetup$hours$it._(_root);
	@override late final _Translations$shopSetup$review$it review = _Translations$shopSetup$review$it._(_root);
}

// Path: weekdays
class _Translations$weekdays$it extends Translations$weekdays$en {
	_Translations$weekdays$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override late final _Translations$weekdays$short$it short = _Translations$weekdays$short$it._(_root);
	@override late final _Translations$weekdays$long$it long = _Translations$weekdays$long$it._(_root);
}

// Path: notifications
class _Translations$notifications$it extends Translations$notifications$en {
	_Translations$notifications$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get allow => 'Attiva le notifiche';
	@override String get skip => 'Non ora';
	@override late final _Translations$notifications$owner$it owner = _Translations$notifications$owner$it._(_root);
	@override late final _Translations$notifications$customer$it customer = _Translations$notifications$customer$it._(_root);
}

// Path: notificationSettings
class _Translations$notificationSettings$it extends Translations$notificationSettings$en {
	_Translations$notificationSettings$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'Notifiche';
	@override late final _Translations$notificationSettings$blocked$it blocked = _Translations$notificationSettings$blocked$it._(_root);
	@override late final _Translations$notificationSettings$lead$it lead = _Translations$notificationSettings$lead$it._(_root);
	@override late final _Translations$notificationSettings$customer$it customer = _Translations$notificationSettings$customer$it._(_root);
	@override late final _Translations$notificationSettings$owner$it owner = _Translations$notificationSettings$owner$it._(_root);
}

// Path: bookings
class _Translations$bookings$it extends Translations$bookings$en {
	_Translations$bookings$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get rightNow => 'Adesso';
	@override String get upcoming => 'Prossime';
	@override String get past => 'Passate';
	@override String get emptyTitle => 'Niente in programma';
	@override String get emptyBody => 'Le prenotazioni che fai compaiono qui, con lo stato aggiornato.';
	@override String get emptyPastTitle => 'Nessuno storico';
	@override String get emptyPastBody => 'Qui trovi i tagli già fatti.';
	@override String inShop({required Object price}) => '${price} in negozio';
	@override String expiresIn({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Scade tra ${n} min',
		other: 'Scade tra ${n} min',
	);
	@override String get holdLapsed => 'Posto non più tenuto';
	@override String get payNow => 'Paga ora';
	@override String freeUntil({required Object when}) => 'Annullabile gratis fino a ${when}';
	@override String get repeat => 'Prenota di nuovo';
	@override String get byYou => 'da te';
	@override String get byShop => 'dal negozio';
	@override String get refunded => 'rimborsata';
	@override String get notRefunded => 'non rimborsata';
	@override String get paid => 'pagato';
	@override String paidWithCard({required Object card}) => 'pagato · •••• ${card}';
	@override String get feeNote => 'Il taglio si paga in negozio. Qui vedi solo lo stato del posto.';
	@override String get detailTitle => 'La tua prenotazione';
	@override String serviceLine({required Object service, required Object minutes}) => '${service} · ${minutes} minuti';
	@override String get map => 'Mappa';
	@override String get callShop => 'Chiama il negozio';
	@override String get payInShop => 'da pagare in negozio';
	@override String get bookNowService => 'Servizio BookNow';
	@override String get addToCalendar => 'Aggiungi al calendario';
	@override String get calendarFailed => 'Nessuna app calendario su questo dispositivo.';
	@override String get mapFailed => 'Nessuna app mappe su questo dispositivo.';
	@override late final _Translations$bookings$cancel$it cancel = _Translations$bookings$cancel$it._(_root);
}

// Path: account
class _Translations$account$it extends Translations$account$en {
	_Translations$account$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profilo';
	@override String signedInWith({required Object provider}) => 'Accesso con ${provider}';
	@override String get editProfile => 'Modifica profilo';
	@override String get appearanceTitle => 'Aspetto e lingua';
	@override String get themeSystem => 'Sistema';
	@override String get themeLight => 'Chiaro';
	@override String get themeDark => 'Scuro';
	@override String get notificationsTitle => 'Notifiche';
	@override String get reminderTitle => 'Promemoria del taglio';
	@override String get reminderBody => '2 ore prima';
	@override String get shopNewsTitle => 'Novità del negozio';
	@override String get shopNewsBody => 'Orari e chiusure';
	@override String get accountTitle => 'Account';
	@override String get payments => 'Pagamenti e ricevute';
	@override String get switchToBarber => 'Passa a barbiere';
	@override String get help => 'Aiuto e contatti';
	@override String get signOut => 'Esci';
	@override String get signOutConfirmTitle => 'Vuoi uscire?';
	@override String get signOutConfirmBody => 'Dovrai accedere di nuovo per vedere le tue prenotazioni.';
	@override String get deleteAccount => 'Elimina account';
	@override String get comingSoon => 'Disponibile a breve.';
}

// Path: home
class _Translations$home$it extends Translations$home$en {
	_Translations$home$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String waitShort({required Object n, required Object from, required Object to}) => '${n} · ${from}–${to} min';
	@override String get useLocation => 'Usa la mia posizione';
	@override String get useLocationLine => 'Mostra prima i negozi più vicini';
	@override String get locationFailed => 'Posizione non disponibile. Controlla che sia attiva e consentita per BookNow.';
	@override String get guestBlocked => 'Accedi per vedere i negozi vicino a te.';
	@override String get intentNow => 'Adesso';
	@override String get intentTomorrow => 'Domani';
	@override String get searchHint => 'Cerca negozi o servizi';
	@override String get clearCategory => 'Togli la categoria';
	@override String get whereTitle => 'Dove cerchiamo?';
	@override String get list => 'Lista';
	@override String get map => 'Mappa';
	@override String headlineNow({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} negozio può riceverti ora',
		other: '${n} negozi possono riceverti ora',
	);
	@override String headlineToday({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} negozio libero oggi',
		other: '${n} negozi liberi oggi',
	);
	@override String headlineTomorrow({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} negozio da prenotare domani',
		other: '${n} negozi da prenotare domani',
	);
	@override String get feedNow => 'Prima l\'attesa più breve';
	@override String get feedToday => 'Prossimi orari liberi';
	@override String get feedTomorrow => 'Prenota per domani';
	@override String get categoryNotice => 'I negozi non sono ancora divisi per categoria, quindi li vedi tutti.';
	@override String get emptyNowTitle => 'Nessuno può riceverti adesso';
	@override String get emptyNowBody => 'Prenota un orario più tardi oggi.';
	@override String get emptyNowCta => 'Vedi gli orari di oggi';
	@override String get joinLine => 'Mettiti in coda';
	@override String get bookTime => 'Prenota un orario';
	@override String get seeLine => 'Vedi la coda';
	@override String get seeTimes => 'Vedi gli orari';
	@override String get headerTitle => 'Prenota una poltrona o salta la fila';
	@override String get whatDoYouNeed => 'Di cosa hai bisogno?';
	@override String get searchByName => 'Cerca per nome';
	@override String get whereLabel => 'Dove';
	@override String get whenLabel => 'Quando';
	@override String get today => 'Oggi';
	@override String get allCities => 'Tutte le città';
	@override String searchCategory({required Object category}) => 'Cerca ${category}';
	@override String get foldSearch => 'Chiudi la ricerca';
	@override String get openSearch => 'Apri la ricerca completa';
	@override String get explore => 'Esplora le categorie';
	@override String get all => 'Tutte';
	@override String get nearYou => 'Vicino a te';
	@override String get shortestWait => 'Attesa più breve ora';
	@override String get join => 'Entra';
	@override String get book => 'Prenota';
	@override String get filterOpenNow => 'Aperti ora';
	@override String get filterNearest => 'Più vicini';
	@override String get filterShortestQueue => 'Coda più breve';
	@override String waiting({required Object n, required Object from, required Object to}) => '${n} in attesa · ${from}–${to} min';
	@override String get noWait => 'Nessuna attesa';
	@override String get queueClosed => 'Coda chiusa';
	@override String nextAt({required Object time}) => 'Prossimo ${time}';
	@override String get inQueue => 'In coda';
	@override String get view => 'Vedi';
	@override String get mapNow => 'Ora';
	@override String mapWait({required Object from, required Object to}) => '${from}–${to}\'';
	@override String get inLine => 'in fila';
	@override String greeting({required Object name}) => 'Ciao ${name}';
	@override String get greetingNoName => 'Ciao';
	@override String get nextBooking => 'Prossima prenotazione';
	@override String get freeToday => 'Liberi oggi';
	@override String get shopsNearby => 'Negozi vicino a te';
	@override String get nothingBooked => 'Ancora nessuna prenotazione';
	@override String get nothingBookedBody => 'Scegli un orario qui sotto: blocchi il posto con un acconto.';
	@override String get noFreeToday => 'Nessun orario libero oggi.';
	@override String get noShops => 'Nessun negozio disponibile al momento.';
	@override String get moreTimes => 'altri orari';
	@override String metresAway({required Object metres}) => '${metres} m';
	@override String kilometresAway({required Object km}) => '${km} km';
	@override String servicesCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} servizio',
		other: '${n} servizi',
	);
	@override String fromPrice({required Object price}) => 'da ${price}';
	@override String get openNow => 'Aperto';
	@override String openUntil({required Object time}) => 'Aperto · chiude ${time}';
	@override String get closedNow => 'Chiuso';
	@override String closedUntil({required Object time}) => 'Chiuso · apre alle ${time}';
}

// Path: agenda
class _Translations$agenda$it extends Translations$agenda$en {
	_Translations$agenda$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get everyone => 'Tutti';
	@override String freeLine({required Object length}) => '${length} · Tocca per bloccare';
	@override String hours({required Object count}) => '${count} h';
	@override String get today => 'Oggi';
	@override String get pickDate => 'Scegli una data';
	@override String get closedShort => 'chiuso';
	@override String get closedTitle => 'Chiuso';
	@override String get closedBody => 'Nessun orario di apertura in questo giorno.';
	@override String get closureBody => 'Chiusura straordinaria. Nessuna prenotazione possibile.';
	@override String get emptyTitle => 'Giornata libera';
	@override String get emptyBody => 'Nessuna prenotazione per questo giorno.';
	@override String booked({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} prenotazione',
		other: '${n} prenotazioni',
	);
	@override String free({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} orario libero',
		other: '${n} orari liberi',
	);
	@override String toCollect({required Object amount}) => '${amount} da incassare';
	@override String get now => 'ora';
	@override String get freeLabel => 'Libero';
	@override String get customerFallback => 'Cliente';
	@override String minutes({required Object count}) => '${count} min';
	@override String cancelledBy({required Object name}) => 'annullata da ${name}';
	@override String until({required Object time, required Object amount}) => 'fino alle ${time} · ${amount} in negozio';
	@override String get blockedLabel => 'Bloccato';
	@override String openBooking({required Object name}) => 'Apri la prenotazione di ${name}';
	@override String blockFree({required Object time}) => 'Blocca l\'orario libero delle ${time}';
	@override String openBlock({required Object time}) => 'Apri il blocco delle ${time}';
	@override late final _Translations$agenda$sheet$it sheet = _Translations$agenda$sheet$it._(_root);
	@override late final _Translations$agenda$block$it block = _Translations$agenda$block$it._(_root);
}

// Path: flow
class _Translations$flow$it extends Translations$flow$en {
	_Translations$flow$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get doneShort => 'Prenotazione fatta';
	@override String get whenTitle => 'Quando ti va bene?';
	@override String get morning => 'Mattina';
	@override String get afternoon => 'Pomeriggio';
	@override String lunchBreak({required Object from, required Object to}) => '${from} – ${to} · pausa pranzo';
	@override String get legendTaken => '— barrato: occupato';
	@override String get legendPast => '— sbiadito: passato';
	@override String continueWith({required Object when, required Object time}) => 'Continua · ${when}, ${time}';
	@override String get closedTitle => 'Chiuso';
	@override String get closedBody => 'Il negozio non apre in questo giorno. Scegline un altro.';
	@override String get noTimesTitle => 'Nessun orario libero';
	@override String get noTimesBody => 'Prova un altro giorno.';
	@override String get confirmTitle => 'Controlla e conferma';
	@override String get change => 'Cambia';
	@override String payInShopWithMinutes({required Object minutes}) => '${minutes} min · paghi in negozio';
	@override String get bookNowService => 'Servizio BookNow';
	@override String get payNow => 'lo paghi adesso';
	@override String payAndConfirm({required Object fee}) => 'Paga ${fee} e conferma';
	@override String get payAndConfirmNoFee => 'Paga e conferma';
	@override String get terms => 'Confermando accetti i Termini. Il taglio si paga in negozio.';
	@override String freeCancellationUntil({required Object when}) => 'Annullabile gratis fino a ${when}.';
	@override String get arriveEarly => 'Arriva 5 minuti prima: il posto è tenuto per 10 minuti.';
	@override String get declinedTitle => 'Pagamento non riuscito';
	@override String get declinedBody => 'La carta è stata rifiutata. Non ti abbiamo addebitato nulla.';
	@override String holdLeft({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Slot tenuto ancora ${n} min',
		other: 'Slot tenuto ancora ${n} min',
	);
	@override String get holdLapsed => 'Lo slot non è più tenuto';
	@override String get retry => 'Riprova';
	@override String get giveUp => 'Lascia perdere';
	@override String get confirmingTitle => 'Stiamo confermando';
	@override String get confirmingBody => 'Il pagamento è andato a buon fine. Ci vuole qualche secondo.';
	@override String get doneTitle => 'È tutto a posto';
	@override String get doneBody => 'Il tuo posto è prenotato. Ti mandiamo un promemoria 2 ore prima.';
	@override String feePaid({required Object fee}) => '${fee} pagati';
	@override String inShop({required Object price}) => '${price} in negozio';
	@override String get done => 'Fatto';
}

// Path: queue
class _Translations$queue$it extends Translations$queue$en {
	_Translations$queue$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get liveNow => 'In diretta adesso';
	@override String get turnTitleShort => 'Tocca a te';
	@override String splashPlace({required Object n, required Object shop}) => 'Sei il n. ${n} da ${shop}';
	@override String splashTurn({required Object shop}) => 'Tocca a te da ${shop}';
	@override String get live => 'Coda dal vivo';
	@override String get walkIn => 'Senza appuntamento';
	@override String get stateOpen => 'Coda aperta';
	@override String get statePaused => 'In pausa';
	@override String get stateFull => 'Completa per oggi';
	@override String get stateClosed => 'Chiusa per oggi';
	@override String get stateOutside => 'Fuori orario';
	@override String waitingCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'persona in attesa',
		other: 'persone in attesa',
	);
	@override String get estimateNow => 'Se entri ora, attesa stimata';
	@override String range({required Object from, required Object to}) => '${from}–${to} min';
	@override String get pausedBody => 'Il barbiere ha messo in pausa la coda. Chi è già in fila mantiene il posto: riprova tra poco.';
	@override String get fullBody => 'Chi entra ora finirebbe dopo la chiusura. Riprova domani.';
	@override String get closedBody => 'La coda è chiusa per oggi.';
	@override String get outsideBody => 'Il negozio è chiuso in questo momento.';
	@override String get services => 'Servizi';
	@override String get pickService => 'Cosa ti serve?';
	@override String minutes({required Object minutes}) => '${minutes} min';
	@override String inShop({required Object price}) => '${price} in negozio';
	@override String feeHint({required Object fee}) => 'Paghi ${fee} per il posto in coda. Il servizio lo paghi in negozio.';
	@override String get join => 'Mettiti in coda';
	@override String get turnIn => 'Tocca a te tra';
	@override String about({required Object range}) => 'circa ${range}';
	@override String get refundRule => 'Se lasci la coda con almeno 3 persone davanti, ti rimborsiamo il costo del servizio.';
	@override String get graceRule => 'Ti avvisiamo quando manca una persona e quando tocca a te: da quel momento hai 10 minuti per arrivare.';
	@override String payAndJoin({required Object fee}) => 'Paga ${fee} e mettiti in coda';
	@override String get placeAfterPayment => 'Il posto è tuo appena il pagamento va a buon fine.';
	@override String get joiningTitle => 'Ti stiamo mettendo in coda';
	@override String get joiningBody => 'Il pagamento è andato a buon fine. Ci vuole qualche secondo.';
	@override String get inQueue => 'Sei in coda';
	@override String get almost => 'Quasi il tuo turno';
	@override String position({required Object n}) => '${n}°';
	@override String get inLine => 'in coda';
	@override String ahead({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '1 persona prima di te',
		other: '${n} persone prima di te',
	);
	@override String get next => 'Sei il prossimo';
	@override String get waitAnywhere => 'Puoi aspettare dove vuoi: ti avvisiamo quando manca una persona.';
	@override String get leaveRefund => 'Hai almeno 3 persone davanti: se lasci ora, ti rimborsiamo il costo del servizio.';
	@override String get leaveNoRefund => 'Hai meno di 3 persone davanti: se lasci ora, il costo del servizio non ti viene rimborsato.';
	@override String get leave => 'Lascia la coda';
	@override String get turnTitle => 'È il tuo turno';
	@override String get turnBody => 'Il barbiere ti sta aspettando. Hai 10 minuti per arrivare.';
	@override String get turnLeft => 'per arrivare';
	@override String get turnLate => 'Dopo 10 minuti il barbiere può segnarti come non presentato: in quel caso il costo del servizio non viene rimborsato.';
	@override String get servingTitle => 'Sei in poltrona';
	@override String get servingBody => 'Il servizio è iniziato. Lo paghi in negozio, come sempre.';
	@override late final _Translations$queue$leaveSheet$it leaveSheet = _Translations$queue$leaveSheet$it._(_root);
	@override String get leftTitle => 'Hai lasciato la coda';
	@override String leftRefunded({required Object fee}) => 'Ti rimborsiamo ${fee} entro 5–10 giorni lavorativi.';
	@override String get leftKept => 'Il costo del servizio non è stato rimborsato.';
	@override String get endedTitle => 'Non sei più in coda';
	@override String get endedBody => 'Se il barbiere ti ha tolto dalla coda o ha chiuso per oggi, ti rimborsiamo il costo del servizio.';
	@override String get declinedTitle => 'Pagamento non riuscito';
	@override String get declinedBody => 'La carta è stata rifiutata. Non ti abbiamo addebitato nulla.';
	@override String get retry => 'Riprova';
	@override String get giveUp => 'Lascia perdere';
	@override String get done => 'Fatto';
	@override String get homeTitle => 'Sei in coda';
	@override String get homePaid => 'Pagato';
	@override String get seeQueue => 'Vedi la coda';
	@override late final _Translations$queue$owner$it owner = _Translations$queue$owner$it._(_root);
	@override late final _Translations$queue$mode$it mode = _Translations$queue$mode$it._(_root);
}

// Path: categories
class _Translations$categories$it extends Translations$categories$en {
	_Translations$categories$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get barber => 'Barbiere';
	@override String get salon => 'Parrucchiere';
	@override String get nails => 'Unghie';
	@override String get beauty => 'Bellezza';
	@override String get spa => 'Spa';
	@override String get lashes => 'Ciglia';
	@override String get tattoo => 'Tatuaggi';
	@override String get makeup => 'Trucco';
	@override String get kids => 'Taglio bimbi';
	@override String get more => 'Altro';
}

// Path: search
class _Translations$search$it extends Translations$search$en {
	_Translations$search$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get recent => 'Recenti';
	@override String get allShops => 'Tutti i negozi';
	@override String get title => 'Cerca';
	@override String get hint => 'Cerca per nome';
	@override String get noResults => 'Nessun negozio trovato.';
	@override String categoryNotice({required Object category}) => 'I negozi non sono ancora divisi per categoria, quindi vedi tutti i negozi, non solo ${category}.';
}

// Path: live
class _Translations$live$it extends Translations$live$en {
	_Translations$live$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get overlineBooked => 'Prenotato';
	@override String freeUntil({required Object when}) => 'Annulli gratis fino a ${when}';
	@override String get cancelBooking => 'Annulla prenotazione';
	@override String get cancelTitle => 'Annullare questa prenotazione?';
	@override String get keepBooking => 'Tieni la prenotazione';
	@override String get yesCancel => 'Sì, annulla';
	@override String refundYes2({required Object fee}) => 'La commissione di ${fee} ti viene rimborsata.';
	@override String refundNo2({required Object fee}) => 'Mancano meno di 2 ore, quindi la commissione di ${fee} non è rimborsata.';
	@override String cancelledRefunded({required Object fee}) => 'Prenotazione annullata. ${fee} rimborsati.';
	@override String get cancelledNoRefund => 'Prenotazione annullata.';
	@override String get cancelFailed => 'Annullamento non riuscito. La prenotazione resta valida.';
	@override String get overline => 'In coda';
	@override String headInAt({required Object shop}) => 'Vai ora · ${shop}';
	@override String get chair => 'Poltrona';
	@override String get directions => 'Indicazioni';
	@override String get inChair => 'Sei in poltrona';
	@override String get headIn => 'Entra adesso. Ti tengono il posto per 10 minuti.';
	@override String get leave => 'Lascia la coda';
	@override String get leaveTitle => 'Lasciare la coda?';
	@override String get refundYes => 'Ti rimborsiamo il costo del servizio.';
	@override String get refundNo => 'Con meno di 3 persone davanti, il costo del servizio non viene rimborsato.';
	@override String get keep => 'Tieni il posto';
	@override String get leaveConfirm => 'Sì, lascia';
	@override String get leftRefunded => 'Hai lasciato la coda. Costo rimborsato.';
	@override String get leftNoRefund => 'Hai lasciato la coda.';
	@override String get leaveFailed => 'Non siamo riusciti a toglierti dalla coda. Hai ancora il tuo posto.';
}

// Path: guest
class _Translations$guest$it extends Translations$guest$en {
	_Translations$guest$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get ownerSheetTitle => 'Accedi al tuo negozio';
	@override String get ownerCustomerAccount => 'Hai effettuato l\'accesso, ma questo account è già un account cliente, quindi non può essere usato per un negozio.';
	@override String get title => 'Salta l\'attesa, tieni il posto';
	@override String get body => 'Un tocco con l\'account che hai già. Nuovo o no, sono gli stessi due pulsanti.';
	@override String get activityTitle => 'Le tue visite stanno qui';
	@override String get activityBody => 'Accedi per seguire il tuo posto in coda e tenere insieme le prenotazioni.';
	@override String get signIn => 'Accedi';
	@override String get signInTitle => 'Accedi a BookNow';
	@override String get light => 'Chiaro';
	@override String get dark => 'Scuro';
	@override String get system => 'Auto';
	@override String get ownerTitle => 'Hai un negozio?';
	@override String get ownerBody => 'Accedi, o configuralo in pochi minuti.';
	@override String get gateBook => 'Accedi per prenotare questo orario';
	@override String get gateJoin => 'Accedi per metterti in coda';
	@override String gateBody({required Object what}) => '${what}. La tua scelta resta, basta un tocco.';
}

// Path: welcome
class _Translations$welcome$it extends Translations$welcome$en {
	_Translations$welcome$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Come deve chiamarti il negozio?';
	@override String get nameLabel => 'Il tuo nome';
	@override String get body => 'Lo vedono solo i negozi dove vai. Puoi cambiarlo dopo.';
	@override String get cta => 'Continua';
}

// Path: shopScreen
class _Translations$shopScreen$it extends Translations$shopScreen$en {
	_Translations$shopScreen$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String closedDay({required Object day}) => 'Chiuso ${day}. Scegli un altro giorno.';
	@override String get noTimes => 'Nessun orario libero in questo giorno. Scegline un altro.';
	@override String joinNow({required Object service}) => '${service} · entra ora';
	@override String get paying => 'Pagamento in corso';
	@override String get tryAgain => 'Riprova';
	@override String payFee({required Object fee}) => 'Paga ${fee}';
	@override String placedAt({required Object shop}) => '${shop} · ti avvisiamo quando tocca a te';
	@override String get previewTitle => 'Anteprima';
	@override String get previewBody => 'Questo è ciò che vedono i clienti.';
	@override String get whatLike => 'Cosa desideri?';
	@override String get when => 'Quando?';
	@override String get sumPick => 'Scegli un orario per continuare';
	@override String sumShop({required Object price}) => '${price} in negozio';
	@override String sumShopFee({required Object price, required Object fee}) => '${price} in negozio · ${fee} ora';
	@override String get continue_ => 'Continua';
	@override String bookTitle({required Object when}) => 'Prenotare ${when}?';
	@override String joinTitle({required Object shop}) => 'Metterti in coda da ${shop}?';
	@override String get feeLabel => 'Costo BookNow';
	@override String get feeWhen => 'Lo paghi ora';
	@override String get serviceWhen => 'Lo paghi al negozio';
	@override String get noFee => 'Prenotazione gratuita';
	@override String get confirmFree => 'Conferma la prenotazione';
	@override String heldFor({required Object time}) => 'Tenuto per te per ${time}';
	@override String get declined => 'La carta è stata rifiutata. Non ti abbiamo addebitato nulla.';
	@override String get placed => 'Sei in coda';
	@override String get placedBody => 'Ti avvisiamo quando tocca a te.';
}

// Path: today
class _Translations$today$it extends Translations$today$en {
	_Translations$today$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String untilTime({required Object time}) => 'fino alle ${time}';
	@override String get bookedTag => 'Prenotato';
	@override String queueLine({required Object n, required Object time}) => '${n} in attesa · fino alle ${time} circa';
	@override String get nowLabel => 'Adesso';
	@override String get nextLabel => 'Prossimo';
	@override String get comingUp => 'In arrivo';
	@override String get details => 'Dettagli';
	@override String callName({required Object name}) => 'Chiama ${name}';
	@override String get nothingLeftTitle => 'Nient\'altro prenotato oggi';
	@override String get nothingLeftBody => 'Il tempo libero resta aperto ai clienti.';
	@override String markedArrived({required Object name}) => '${name} segnato come arrivato';
	@override String markedNoShow({required Object name}) => '${name} segnato come assente';
	@override String noShowTitle({required Object name}) => 'Segnare ${name} come assente?';
	@override String get noShowBody => 'Non si può annullare.';
	@override String cancelTitle({required Object name}) => 'Annullare la prenotazione di ${name}?';
	@override String get cancelBody => 'Il cliente viene avvisato e l\'orario torna libero.';
	@override String get cancelled => 'Prenotazione annullata';
	@override String get stateTitle => 'Com\'è la coda oggi?';
	@override String get stateOpenTitle => 'Aperta';
	@override String get stateOpenBody => 'Ci si può mettere in coda dall\'app.';
	@override String get statePauseBody => 'Nessun nuovo ingresso. Chi è in coda resta.';
	@override String stateCloseBody({required Object n}) => 'Nessun nuovo ingresso. Servi ancora i ${n} in coda, e chi non viene servito è rimborsato.';
	@override String get pausedBanner => 'In pausa. Nessun nuovo ingresso.';
	@override String get closedBanner => 'Chiusa per oggi. Finisci con chi è in coda.';
	@override String get wayLine => 'Coda';
	@override String get wayBookings => 'Prenotazioni';
	@override String get calendarTitle => 'Calendario';
	@override String get calendarQueueTitle => 'Il tuo negozio lavora con la coda';
	@override String get calendarQueueBody => 'I clienti si mettono in coda invece di prenotare un orario, quindi qui non c\'è nulla da pianificare. Gestisci la coda da Oggi.';
	@override String get calendarQueueCta => 'Cambia come lavori';
}

// Path: homeWidgets
class _Translations$homeWidgets$it extends Translations$homeWidgets$en {
	_Translations$homeWidgets$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get inLine => 'In coda';
	@override String get nextVisit => 'Prossima visita';
	@override String get bookAgain => 'Prenota di nuovo';
	@override String get findTitle => 'Trova un negozio';
	@override String get findLine => 'Prenota un orario o mettiti in coda';
	@override String get directions => 'Indicazioni';
	@override String get headIn => 'Entra entro 10 min';
	@override String ahead({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		zero: 'Sei il prossimo',
		one: '${n} persona davanti',
		other: '${n} persone davanti',
	);
	@override String get waiting => 'in attesa';
	@override String waitingCount({required Object n}) => '${n} in attesa';
	@override String get nobodyWaiting => 'Nessuno in attesa';
	@override String get nextUp => 'Prossimo';
	@override String get calledLine => 'Chiamato, sta arrivando';
	@override String get nextAppointment => 'Prossimo appuntamento';
	@override String get nothingLeft => 'Nient\'altro oggi';
	@override String moreToday({required Object n}) => 'altri ${n} oggi';
	@override String get openToday => 'Apri oggi';
	@override String get staleQueue => 'Apri BookNow per controllare il tuo posto';
	@override String get staleBooking => 'Apri BookNow per la prossima visita';
	@override String get staleOwner => 'Apri BookNow per vedere oggi';
}

// Path: onboarding.slideOne
class _Translations$onboarding$slideOne$it extends Translations$onboarding$slideOne$en {
	_Translations$onboarding$slideOne$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prenota il taglio in 30 secondi';
	@override String get body => 'Scegli il giorno e l\'ora liberi del tuo barbiere. Niente telefonate, niente attese in negozio.';
}

// Path: onboarding.slideTwo
class _Translations$onboarding$slideTwo$it extends Translations$onboarding$slideTwo$en {
	_Translations$onboarding$slideTwo$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Il taglio lo paghi in negozio';
	@override String get body => 'In app paghi solo €1,49 per bloccare lo slot. Il taglio lo paghi al barbiere, anche in contanti.';
	@override String get serviceLabel => 'Taglio';
	@override String get serviceNote => 'in negozio, al barbiere';
	@override String get feeLabel => 'Servizio BookNow';
	@override String get feeNote => 'ora, in app';
	@override String get plus => 'più';
	@override String get serviceAmount => '€18,00';
	@override String get feeAmount => '€1,49';
}

// Path: onboarding.slideThree
class _Translations$onboarding$slideThree$it extends Translations$onboarding$slideThree$en {
	_Translations$onboarding$slideThree$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Hai un barber shop?';
	@override String get body => 'Gestisci l\'agenda gratis dal telefono. Ogni prenotazione ti arriva con una notifica.';
	@override String get agendaToday => 'Oggi · agenda';
	@override String get agendaFree => 'libero';
	@override String get agendaPush => 'Nuova prenotazione: Marco, sab 3 ott ore 10:30';
	@override String get agendaBookedTime => '10:30';
	@override String get agendaBookedName => 'Marco R.';
	@override String get agendaFreeTime => '11:00';
}

// Path: auth.signIn
class _Translations$auth$signIn$it extends Translations$auth$signIn$en {
	_Translations$auth$signIn$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bentornato';
	@override String get body => 'Accedi in un tocco. Usiamo il tuo account solo per nome ed email.';
	@override String get firstTime => 'prima volta?';
	@override String get createAccount => 'Crea un account';
	@override String get terms => 'Continuando accetti i Termini e la Privacy.';
	@override String get termsLink => 'Termini';
	@override String get privacyLink => 'Privacy';
}

// Path: auth.signUp
class _Translations$auth$signUp$it extends Translations$auth$signUp$en {
	_Translations$auth$signUp$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Crea il tuo account';
	@override String get body => 'Nessuna password da ricordare: usa Apple o Google e sei dentro.';
	@override String get noCardTitle => 'Nessuna carta salvata';
	@override String get noCardBody => 'Paghi €1,49 solo quando prenoti.';
	@override String get dataTitle => 'Solo nome ed email';
	@override String get dataBody => 'Il telefono è facoltativo, lo vede solo il barbiere.';
	@override String get roleTitle => 'Barbiere o cliente';
	@override String get roleBody => 'Scegli tu al passo dopo. Per i negozi è gratis.';
	@override String get alreadyHaveAccount => 'Hai già un account?';
	@override String get signInLink => 'Accedi';
}

// Path: auth.role
class _Translations$auth$role$it extends Translations$auth$role$en {
	_Translations$auth$role$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String greeting({required Object name}) => 'Ciao ${name}';
	@override String get title => 'Come usi BookNow?';
	@override String get body => 'Lo scegli una volta sola. Puoi cambiarlo dal profilo.';
	@override String get customerTitle => 'Voglio prenotare';
	@override String get customerBody => 'Scegli lo slot, blocchi il posto con €1,49 e paghi il taglio in negozio.';
	@override String get ownerTitle => 'Ho un barber shop';
	@override String get ownerBody => 'Gestisci agenda, prezzo e orari. Per i negozi BookNow è gratis.';
	@override String pilotNote({required Object shop, required Object address}) => 'Nel pilota c\'è un solo negozio: ${shop}, ${address}.';
	@override String get selected => 'Selezionato';
}

// Path: auth.profile
class _Translations$auth$profile$it extends Translations$auth$profile$en {
	_Translations$auth$profile$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ci siamo quasi';
	@override String body({required Object provider}) => 'Questi dati arrivano dal tuo account ${provider}. Correggili se vuoi.';
	@override String get nameLabel => 'Nome e cognome';
	@override String get nameRequired => 'Inserisci il tuo nome.';
	@override String get phoneLabel => 'Telefono';
	@override String get phoneOptional => 'facoltativo';
	@override String get phoneHelper => 'Serve solo al barbiere se deve avvisarti. Non lo usiamo per altro.';
	@override String get save => 'Salva e continua';
}

// Path: profile.signOutDialog
class _Translations$profile$signOutDialog$it extends Translations$profile$signOutDialog$en {
	_Translations$profile$signOutDialog$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Uscire dall\'account?';
	@override String get bodyOwner => 'Il tuo negozio e la tua agenda restano dove sono.';
	@override String get bodyCustomer => 'Le tue prenotazioni restano salvate.';
	@override String returnWith({required Object provider}) => 'Rientri con un tocco su ${provider}.';
}

// Path: profile.deleteSheet
class _Translations$profile$deleteSheet$it extends Translations$profile$deleteSheet$en {
	_Translations$profile$deleteSheet$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Eliminare l\'account?';
	@override String get body => 'L\'operazione è definitiva: non si può annullare.';
	@override String get keep => 'Tieni il mio account';
	@override String get confirm => 'Sì, elimina';
	@override String shopLost({required Object name}) => 'Il negozio ${name} e tutte le sue prenotazioni verranno eliminati.';
	@override String get shopLostUnnamed => 'Il tuo negozio e tutte le sue prenotazioni verranno eliminati.';
	@override String get historyLost => 'Perdi lo storico e le ricevute dei pagamenti.';
}

// Path: profile.personal
class _Translations$profile$personal$it extends Translations$profile$personal$en {
	_Translations$profile$personal$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get initialsNote => 'Le iniziali vengono dal tuo nome';
	@override String ownerOf({required Object shop}) => 'Titolare di ${shop}';
	@override String get nameLabel => 'Nome e cognome';
	@override String get nameRequired => 'Inserisci il tuo nome.';
	@override String get phoneLabelCustomer => 'Telefono (facoltativo)';
	@override String get phoneLabelOwner => 'Telefono (personale)';
	@override String get phoneOptional => 'facoltativo';
	@override String get phonePersonal => 'personale';
	@override String get phoneHelperCustomer => 'Lo vede solo il barbiere, se deve avvisarti.';
	@override String get phoneHelperOwner => 'Non è il numero del negozio: lo usiamo solo per contattarti.';
	@override String get emailLabel => 'Email';
	@override String get emailLockedHint => 'Non modificabile qui';
	@override String get emailApple => 'Gestita da Apple. Per cambiarla modifica il tuo ID Apple.';
	@override String get emailGoogle => 'Gestita da Google. Per cambiarla modifica il tuo account Google.';
	@override String get emailProvider => 'Gestita dal servizio con cui hai fatto l\'accesso.';
	@override String get saved => 'Dati aggiornati';
}

// Path: help.faq
class _Translations$help$faq$it extends Translations$help$faq$en {
	_Translations$help$faq$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get feeQuestion => 'Perché pago €1,49?';
	@override String get feeAnswer => 'È il costo del servizio di prenotazione: blocca il tuo posto. Il servizio lo paghi in negozio, come sempre.';
	@override String get cancelQuestion => 'Come annullo una prenotazione?';
	@override String get cancelAnswer => 'Apri la prenotazione e tocca Annulla. Fino a 2 ore prima dell\'inizio la commissione viene rimborsata; più tardi la prenotazione si annulla comunque, ma la commissione resta. Dopo l\'orario di inizio non si annulla più.';
	@override String get refundQuestion => 'Quando arriva il rimborso?';
	@override String get refundAnswer => 'Parte appena annulli e torna sulla stessa carta, di solito in pochi giorni lavorativi secondo i tempi della tua banca. Se è il negozio ad annullare, la commissione è sempre rimborsata.';
	@override String get lateQuestion => 'Arrivo in ritardo, cosa succede?';
	@override String get lateAnswer => 'Avvisa il negozio. Il posto resta tuo finché il titolare non ti segna come assente, cosa che può fare da 15 minuti dopo l\'orario di inizio: in quel caso la commissione non viene rimborsata.';
}

// Path: help.topics
class _Translations$help$topics$it extends Translations$help$topics$en {
	_Translations$help$topics$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get payment => 'Pagamento';
	@override String get booking => 'Prenotazione';
	@override String get account => 'Account';
	@override String get other => 'Altro';
}

// Path: help.write
class _Translations$help$write$it extends Translations$help$write$en {
	_Translations$help$write$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Scrivi a BookNow';
	@override String replyTo({required Object email}) => 'Rispondiamo entro 24 ore a ${email}.';
	@override String get replyGeneric => 'Rispondiamo entro 24 ore.';
	@override String get handoff => 'Apriamo la tua app email con il messaggio già pronto.';
	@override String get topicLabel => 'Di cosa si tratta?';
	@override String get messageLabel => 'Messaggio';
	@override String get messageHint => 'Raccontaci cosa è successo';
	@override String get attach => 'Alleghiamo il tuo account e la versione dell\'app';
	@override String get send => 'Invia';
	@override String get opened => 'Messaggio pronto nella tua app email.';
	@override String noMailApp({required Object email}) => 'Nessuna app email sul telefono. Scrivi a ${email}.';
}

// Path: help.mail
class _Translations$help$mail$it extends Translations$help$mail$en {
	_Translations$help$mail$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String subject({required Object topic}) => 'BookNow — ${topic}';
	@override String get account => 'Account';
	@override String get role => 'Ruolo';
	@override String get appVersion => 'Versione app';
	@override String get roleOwner => 'titolare';
	@override String get roleCustomer => 'cliente';
}

// Path: shopSetup.team
class _Translations$shopSetup$team$it extends Translations$shopSetup$team$en {
	_Translations$shopSetup$team$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get screenTitle => 'Team';
	@override String get subtitle => 'Chi riceve i clienti qui. I clienti scelgono una persona, o chi si libera prima.';
	@override String get you => 'Tu';
	@override String get add => 'Aggiungi una persona';
	@override String get added => 'Aggiunto al team';
	@override String get saved => 'Modifiche salvate';
	@override String removed({required Object name}) => '${name} non è più nel team';
	@override String restored({required Object name}) => '${name} è di nuovo nel team';
	@override String get removedSection => 'Rimossi';
	@override String get restore => 'Riporta nel team';
	@override String get everyService => 'Tutti i servizi';
	@override String servicesCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} servizio',
		other: '${n} servizi',
	);
	@override String get shopHours => 'Orari del negozio';
	@override String get ownHours => 'Orari propri';
	@override String daysOff({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: '${n} giorno libero',
		other: '${n} giorni liberi',
	);
	@override String actionsFor({required Object name}) => 'Opzioni per ${name}';
	@override String get edit => 'Modifica';
	@override String get remove => 'Rimuovi dal team';
	@override String removeTitle({required Object name}) => 'Rimuovere ${name}?';
	@override String get removeBody => 'I clienti non potranno più prenotare con questa persona né aspettarla in coda. Le prenotazioni passate mantengono il nome, e potrai riportarla nel team.';
	@override String get newTitle => 'Nuova persona nel team';
	@override String get editTitle => 'Persona del team';
	@override String get nameLabel => 'Nome';
	@override String get nameHint => 'Marco';
	@override String get nameHelper => 'I clienti lo vedono quando scelgono con chi prenotare.';
	@override String get typeLabel => 'Chi o cosa';
	@override String get typePerson => 'Persona';
	@override String get typeResource => 'Poltrona o postazione';
	@override String get servicesLabel => 'Servizi';
	@override String get everyServiceHelper => 'Anche quelli che aggiungerai';
	@override String get noService => 'Scegli almeno un servizio.';
	@override String get hoursLabel => 'Orari';
	@override String get sameAsShop => 'Come il negozio';
	@override String get ownHoursHelper => 'Solo dentro gli orari del negozio. Fuori nessuno può prenotare.';
	@override String get daysOffLabel => 'Giorni liberi';
	@override String get addDayOff => 'Aggiungi un giorno libero';
	@override String removeDayOff({required Object day}) => 'Rimuovi ${day}';
	@override String get noDaysOff => 'Nessuno in programma';
	@override String get save => 'Aggiungi al team';
	@override String get saveChanges => 'Salva modifiche';
}

// Path: shopSetup.checklist
class _Translations$shopSetup$checklist$it extends Translations$shopSetup$checklist$en {
	_Translations$shopSetup$checklist$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get done => 'Fatto';
	@override String get typicalTitle => 'Partire da una settimana tipica?';
	@override String typicalBody({required Object hours}) => 'Da martedì a sabato, ${hours}. Puoi cambiare ogni giorno dopo.';
	@override String get typicalCta => 'Usa questa settimana';
	@override String get title => 'Mettiamo online il tuo negozio';
	@override String left({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n,
		one: 'Manca ${n} passaggio. I clienti non vedono ancora il negozio.',
		other: 'Mancano ${n} passaggi. I clienti non vedono ancora il negozio.',
	);
	@override String get allDone => 'Tutto pronto. Un tocco e i clienti ti trovano.';
	@override String continueWith({required Object step}) => 'Prossimo: ${step}';
	@override String get optional => 'Facoltativo';
	@override String get shop => 'Dati del negozio';
	@override String get shopHint => 'Nome e telefono';
	@override String get address => 'Indirizzo';
	@override String get addressHint => 'Dove ti trovano i clienti';
	@override String get services => 'Servizi e prezzi';
	@override String get servicesHint => 'Almeno uno, con il prezzo';
	@override String get hours => 'Orari di apertura';
	@override String get hoursHint => 'Quando ricevi i clienti';
	@override String get liveTitle => 'Sei online';
	@override String get liveBody => 'Ora i clienti possono trovare il tuo negozio.';
	@override String get liveCta => 'Apri il mio negozio';
}

// Path: shopSetup.shop
class _Translations$shopSetup$shop$it extends Translations$shopSetup$shop$en {
	_Translations$shopSetup$shop$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get overline => 'Il tuo negozio';
	@override String get title => 'Come ti trovano i clienti?';
	@override String get nameLabel => 'Nome del negozio';
	@override String get nameHelper => 'Lo vedono i clienti, scritto così.';
	@override String get phoneLabel => 'Telefono del negozio';
	@override String get phoneHelper => 'I clienti possono chiamarti dalla prenotazione.';
	@override String get photoLabel => 'Foto';
	@override String get photoOptional => 'facoltativa';
	@override String get photoAdd => 'Aggiungi una foto';
	@override String get photoHint => 'L\'interno o la vetrina · puoi farlo dopo';
	@override String get photoSource => 'Foto del negozio';
	@override String get photoCamera => 'Scatta una foto';
	@override String get photoGallery => 'Scegli dalla galleria';
	@override String get photoRemove => 'Rimuovi foto';
	@override String get photoVisible => 'Visibile ai clienti';
	@override String get photoCameraNew => 'Scatta una nuova foto';
	@override String get photoSourceBody => 'È la prima cosa che vedono i clienti. Meglio la vetrina o l\'interno, in orizzontale.';
	@override String get photoTipsTitle => 'Per una buona foto';
	@override String get photoTipLight => 'Luce naturale, di giorno';
	@override String get photoTipLandscape => 'Telefono in orizzontale';
	@override String get photoTipFaces => 'Niente volti di clienti senza permesso';
	@override String get photoFailed => 'Non siamo riusciti ad aprire la foto. Riprova.';
}

// Path: shopSetup.details
class _Translations$shopSetup$details$it extends Translations$shopSetup$details$en {
	_Translations$shopSetup$details$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dati del negozio';
	@override String get addressLabel => 'Indirizzo';
	@override String get addressMissing => 'Indirizzo da scegliere';
	@override String get addressMissingHelper => 'Scegli dove si trova il negozio';
	@override String get addressPinned => 'pin sulla mappa';
	@override String get addressNotPinned => 'pin da confermare';
	@override String get liveNote => 'Le modifiche sono subito visibili ai clienti.';
	@override String get saved => 'Negozio aggiornato';
}

// Path: shopSetup.address
class _Translations$shopSetup$address$it extends Translations$shopSetup$address$en {
	_Translations$shopSetup$address$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get overline => 'Indirizzo';
	@override String get title => 'Dove si trova?';
	@override String get searchHint => 'Via e numero';
	@override String get mapPreview => 'anteprima mappa';
	@override String get helper => 'Scegli un indirizzo e posizioniamo il pin da soli.';
}

// Path: shopSetup.services
class _Translations$shopSetup$services$it extends Translations$shopSetup$services$en {
	_Translations$shopSetup$services$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get overline => 'Servizi';
	@override String get title => 'Cosa prenotano i clienti?';
	@override String get subtitle => 'Aggiungi tutti i servizi che offri. Ne serve almeno uno.';
	@override String get newService => 'Nuovo servizio';
	@override String get nameHint => 'Nome del servizio';
	@override String get priceHint => 'Prezzo';
	@override String get save => 'Salva';
	@override String get edit => 'Modifica';
	@override String get delete => 'Elimina';
	@override String get editTitle => 'Modifica servizio';
	@override String actionsFor({required Object name}) => 'Azioni per ${name}';
	@override String get continueOne => 'Continua · 1 servizio';
	@override String minutes({required Object count}) => '${count} min';
	@override String get helper => 'I prezzi li vedono i clienti, ma li pagano a te in negozio. La durata decide quanto spazio occupa in agenda.';
	@override String continueWith({required Object count}) => 'Continua · ${count} servizi';
	@override String get screenTitle => 'Servizi';
	@override String get manageSubtitle => 'I clienti scelgono tra questi quando prenotano. Tocca un servizio per modificarlo.';
	@override String get add => 'Aggiungi servizio';
	@override String get emptyTitle => 'Ancora nessun servizio';
	@override String get emptyBody => 'Aggiungi il primo servizio che i clienti possono prenotare.';
	@override String get nameLabel => 'Nome del servizio';
	@override String get durationLabel => 'Durata';
	@override String get priceLabel => 'Prezzo';
	@override String get saveChanges => 'Salva modifiche';
	@override String previousPrice({required Object price}) => 'Prezzo precedente ${price}';
	@override String deleteTitle({required Object name}) => 'Eliminare ${name}?';
	@override String get deleteBody => 'Le prenotazioni già fatte restano valide. Il servizio non sarà più prenotabile.';
	@override String get deleted => 'Servizio eliminato';
	@override String get saved => 'Servizio aggiornato';
	@override String get added => 'Servizio aggiunto';
}

// Path: shopSetup.hours
class _Translations$shopSetup$hours$it extends Translations$shopSetup$hours$en {
	_Translations$shopSetup$hours$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get overline => 'Orari';
	@override String get title => 'Quando sei aperto?';
	@override String get closed => 'Chiuso';
	@override String get lunchBreak => 'Pausa pranzo';
	@override String get copyToOpenDays => 'Copia su tutti i giorni aperti';
	@override String moreDays({required Object days}) => '+ ${days}';
	@override String get screenTitle => 'Orari e chiusure';
	@override String get weekly => 'La tua settimana';
	@override String get continuous => 'orario continuato';
	@override String get open => 'Aperto';
	@override String get slots => 'Fasce orarie';
	@override String get addSlot => 'Aggiungi fascia';
	@override String get removeSlot => 'Rimuovi fascia';
	@override String get copyTo => 'Copia su altri giorni';
	@override String get copyNone => 'Nessuno';
	@override String get overlap => 'Due fasce si sovrappongono.';
	@override String get backwards => 'La fine deve venire dopo l\'inizio.';
	@override String get saved => 'Orari aggiornati';
}

// Path: shopSetup.review
class _Translations$shopSetup$review$it extends Translations$shopSetup$review$en {
	_Translations$shopSetup$review$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tutto pronto per aprire';
	@override String get subtitle => 'Controlla un\'ultima volta. Puoi cambiare tutto anche dopo, da Negozio.';
	@override String get edit => 'Modifica';
	@override String get noPhoto => 'senza foto';
	@override String get pinConfirmed => 'pin confermato';
	@override String servicesFrom({required Object count, required Object price}) => '${count} servizi · da ${price}';
	@override String openDays({required Object count}) => '${count} giorni aperti';
	@override String closedDays({required Object days}) => 'chiuso ${days}';
	@override String get hiddenBefore => 'Finché non pubblichi, il negozio';
	@override String get hiddenStrong => 'non è visibile';
	@override String get hiddenAfter => 'ai clienti.';
	@override String get publish => 'Pubblica il negozio';
}

// Path: weekdays.short
class _Translations$weekdays$short$it extends Translations$weekdays$short$en {
	_Translations$weekdays$short$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Lun';
	@override String get tue => 'Mar';
	@override String get wed => 'Mer';
	@override String get thu => 'Gio';
	@override String get fri => 'Ven';
	@override String get sat => 'Sab';
	@override String get sun => 'Dom';
}

// Path: weekdays.long
class _Translations$weekdays$long$it extends Translations$weekdays$long$en {
	_Translations$weekdays$long$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get mon => 'Lunedì';
	@override String get tue => 'Martedì';
	@override String get wed => 'Mercoledì';
	@override String get thu => 'Giovedì';
	@override String get fri => 'Venerdì';
	@override String get sat => 'Sabato';
	@override String get sun => 'Domenica';
}

// Path: notifications.owner
class _Translations$notifications$owner$it extends Translations$notifications$owner$en {
	_Translations$notifications$owner$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sappi subito chi prenota';
	@override String get body => 'Senza notifiche scopri le prenotazioni solo aprendo l\'agenda.';
	@override String get pointOne => 'Ogni nuova prenotazione';
	@override String get pointTwo => 'Annullamenti, così riempi lo slot';
	@override String get firstTitle => 'Nuova prenotazione';
	@override String get firstBody => 'Marco R. · Taglio uomo · sab 3 ott, 10:30';
	@override String get firstWhen => 'ora';
	@override String get secondTitle => 'Slot liberato';
	@override String get secondBody => 'Paolo M. ha annullato le 11:30.';
	@override String get secondWhen => '8 min fa';
}

// Path: notifications.customer
class _Translations$notifications$customer$it extends Translations$notifications$customer$en {
	_Translations$notifications$customer$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ti avvisiamo prima dell\'appuntamento';
	@override String get body => 'Solo cose che riguardano le tue prenotazioni. Niente pubblicità.';
	@override String get pointOne => 'Promemoria 2 ore prima';
	@override String get pointTwo => 'Annullamenti e rimborsi';
	@override String get firstTitle => 'Tra 2 ore';
	@override String get firstBody => 'Taglio uomo da Barbieri Navona alle 10:30.';
	@override String get firstWhen => 'ora';
	@override String get secondTitle => 'Prenotazione annullata';
	@override String get secondBody => 'Barbieri Navona ha annullato sab 3 ott. Costo rimborsato.';
	@override String get secondWhen => 'ieri';
}

// Path: notificationSettings.blocked
class _Translations$notificationSettings$blocked$it extends Translations$notificationSettings$blocked$en {
	_Translations$notificationSettings$blocked$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Notifiche disattivate sul telefono';
	@override String get bodyOwner => 'Non ti arrivano le nuove prenotazioni.';
	@override String get bodyCustomer => 'Non ti arrivano i promemoria degli appuntamenti.';
	@override String get action => 'Apri Impostazioni';
}

// Path: notificationSettings.lead
class _Translations$notificationSettings$lead$it extends Translations$notificationSettings$lead$en {
	_Translations$notificationSettings$lead$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get oneHour => '1 ora';
	@override String get twoHours => '2 ore';
	@override String get oneDay => '1 giorno';
}

// Path: notificationSettings.customer
class _Translations$notificationSettings$customer$it extends Translations$notificationSettings$customer$en {
	_Translations$notificationSettings$customer$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get reminderSection => 'Promemoria';
	@override String get reminder => 'Prima dell\'appuntamento';
	@override String get reminderSubtitle => 'Ti avvisiamo quando è ora di andare';
	@override String get bookingsSection => 'Prenotazioni';
	@override String get cancellations => 'Annullamenti e rimborsi';
	@override String get cancellationsSubtitle => 'Sempre attive: riguardano i tuoi soldi';
	@override String get cancellationsLocked => 'Attive';
}

// Path: notificationSettings.owner
class _Translations$notificationSettings$owner$it extends Translations$notificationSettings$owner$en {
	_Translations$notificationSettings$owner$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get agendaSection => 'Agenda';
	@override String get newBookings => 'Nuove prenotazioni';
	@override String get newBookingsSubtitle => 'Appena un cliente paga il posto';
	@override String get cancellations => 'Annullamenti';
	@override String get cancellationsSubtitle => 'Lo slot torna libero';
	@override String get summarySection => 'Riepilogo';
	@override String get dailySummary => 'Agenda del giorno';
	@override String get dailySummarySubtitle => 'Quanti clienti hai oggi';
	@override String get summaryTime => 'Orario di invio';
}

// Path: bookings.cancel
class _Translations$bookings$cancel$it extends Translations$bookings$cancel$en {
	_Translations$bookings$cancel$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get action => 'Annulla prenotazione';
	@override String get title => 'Annullare il taglio?';
	@override String subtitle({required Object when, required Object time, required Object shop}) => '${when} alle ${time}, ${shop}.';
	@override String refundTitle({required Object fee}) => 'Rimborso di ${fee}';
	@override String get refundBody => 'Mancano più di 2 ore, quindi il servizio ti viene restituito in 3–5 giorni.';
	@override String refundBodyCard({required Object card}) => 'Mancano più di 2 ore, quindi il servizio ti viene restituito su •••• ${card} in 3–5 giorni.';
	@override String get noRefundTitle => 'Il servizio non viene rimborsato';
	@override String noRefundBody({required Object fee}) => 'Mancano meno di 2 ore, quindi ${fee} resta al negozio. Il taglio non lo paghi.';
	@override String get slotFreed => 'Lo slot torna subito libero per altri clienti.';
	@override String get confirm => 'Sì, annulla';
	@override String get keep => 'Mantieni la prenotazione';
	@override String get done => 'Prenotazione annullata.';
	@override String doneRefunded({required Object fee}) => 'Prenotazione annullata · ${fee} rimborsati.';
	@override String get failed => 'Non è stato possibile annullare. Riprova.';
}

// Path: agenda.sheet
class _Translations$agenda$sheet$it extends Translations$agenda$sheet$en {
	_Translations$agenda$sheet$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String timeLine({required Object from, required Object to, required Object service, required Object minutes}) => '${from} – ${to} · ${service} · ${minutes} min';
	@override String get toCollect => 'Da incassare in negozio';
	@override String holdPaid({required Object amount}) => '${amount} di acconto già pagato nell\'app';
	@override String call({required Object name}) => 'Chiama ${name}';
	@override String get callGeneric => 'Chiama';
	@override String get markArrived => 'Segna come arrivato';
	@override String get noShow => 'Non presentato';
	@override String noShowFrom({required Object time}) => 'Non presentato · dalle ${time}';
	@override String get cancel => 'Annulla prenotazione';
	@override String get noDialler => 'Nessuna app telefono su questo dispositivo.';
	@override String get comingSoon => 'Disponibile a breve.';
}

// Path: agenda.block
class _Translations$agenda$block$it extends Translations$agenda$block$en {
	_Translations$agenda$block$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Blocca orario';
	@override String get from => 'Dalle';
	@override String get to => 'Alle';
	@override String get note => 'Nota';
	@override String get noteHint => 'Pausa, cliente senza prenotazione…';
	@override String get save => 'Blocca';
	@override String get backwards => 'La fine deve venire dopo l\'inizio.';
	@override String get tooLong => 'Un blocco non può superare le 8 ore.';
	@override String get blockedTitle => 'Orario bloccato';
	@override String get remove => 'Sblocca orario';
	@override String get removeTitle => 'Sbloccare questo orario?';
	@override String get removeBody => 'Torna prenotabile dai clienti.';
	@override String get blocked => 'Orario bloccato.';
	@override String get unblocked => 'Orario sbloccato.';
}

// Path: queue.leaveSheet
class _Translations$queue$leaveSheet$it extends Translations$queue$leaveSheet$en {
	_Translations$queue$leaveSheet$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lasciare la coda?';
	@override String body({required Object shop}) => 'Perdi il tuo posto da ${shop}. Se cambi idea dovrai rimetterti in fondo alla coda.';
	@override String refund({required Object fee}) => 'Ti rimborsiamo ${fee} entro 5–10 giorni lavorativi.';
	@override String noRefund({required Object fee}) => 'Manca poco al tuo turno: se lasci ora, ${fee} non ti viene rimborsato.';
	@override String get confirm => 'Sì, lascia la coda';
	@override String get confirmNoRefund => 'Lascia comunque';
	@override String get stay => 'Resta in coda';
}

// Path: queue.owner
class _Translations$queue$owner$it extends Translations$queue$owner$en {
	_Translations$queue$owner$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get walkInFab => 'Senza app';
	@override String get nobodyWaiting => 'Nessuno in attesa. Goditi il caffè.';
	@override String get reopen => 'Riapri';
	@override String minutesLeft({required Object minutes}) => '${minutes} min rimasti';
	@override String doneWith({required Object name}) => 'Fine con ${name}';
	@override String calledName({required Object name}) => 'Chiamato ${name}';
	@override String waitingFor({required Object minutes}) => 'Attesa ${minutes} min';
	@override String get theyreHere => 'È arrivato, inizia';
	@override String noShowIn({required Object time}) => 'Assente tra ${time}';
	@override String get chair => 'Poltrona';
	@override String get freeNow => 'Libero ora';
	@override String get nobodyToCall => 'Nessuno in attesa';
	@override String get kindApp => 'App';
	@override String get kindWalkIn => 'Senza app';
	@override String get removeFromLine => 'Togli dalla coda';
	@override String get rowNoteApp => 'Togliere qualcuno rimborsa sempre la sua commissione.';
	@override String get rowNoteWalkIn => 'Chi entra senza app non ha pagato nulla.';
	@override String get title => 'Coda di oggi';
	@override String summary({required Object waiting, required Object until}) => '${waiting} in attesa · la coda finisce verso le ${until}';
	@override String get summaryEmpty => 'Nessuno in attesa';
	@override String get pause => 'Pausa';
	@override String get resume => 'Riprendi';
	@override String get closeToday => 'Chiudi per oggi';
	@override String get inChair => 'In poltrona';
	@override String get called => 'Chiamata';
	@override String get waiting => 'In attesa';
	@override String since({required Object minutes}) => 'da ${minutes} min';
	@override String calledAt({required Object time}) => 'chiamata alle ${time}';
	@override String queuedAt({required Object time}) => 'in coda dalle ${time}';
	@override String graceLeft({required Object minutes}) => 'ha ancora ${minutes} min';
	@override String get done => 'Fatto';
	@override String get start => 'Inizia';
	@override String get noShow => 'Non presentato';
	@override String noShowFrom({required Object time}) => 'Non presentato · dalle ${time}';
	@override String get walkInName => 'Walk-in';
	@override String remove({required Object name}) => 'Rimuovi ${name} dalla coda';
	@override String get callNext => 'Chiama il prossimo';
	@override String get addWalkIn => 'Walk-in';
	@override String get emptyTitle => 'Nessuno in coda';
	@override String get emptyBody => 'Quando un cliente si mette in coda dall\'app lo vedi qui. Chi entra senza app lo aggiungi con Walk-in.';
	@override late final _Translations$queue$owner$removeSheet$it removeSheet = _Translations$queue$owner$removeSheet$it._(_root);
	@override late final _Translations$queue$owner$walkInSheet$it walkInSheet = _Translations$queue$owner$walkInSheet$it._(_root);
}

// Path: queue.mode
class _Translations$queue$mode$it extends Translations$queue$mode$en {
	_Translations$queue$mode$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get row => 'Come lavori';
	@override String get booking => 'Su appuntamento';
	@override String get queue => 'Coda';
	@override String get both => 'Entrambi';
	@override String get title => 'Come lavori';
	@override String get lead => 'Scegli come i clienti arrivano da te. Puoi cambiare quando vuoi.';
	@override String get bookingBody => 'I clienti scelgono giorno e ora dall\'app. Adatto se lavori su agenda.';
	@override String get queueBody => 'I clienti vedono quante persone aspettano e si mettono in fila dall\'app. Adatto se lavori senza appuntamento.';
	@override String get blocked => 'Non puoi cambiare adesso. Puoi smettere di prendere prenotazioni quando non ne hai più di future, e chiudere la coda quando è vuota.';
	@override String get bothBody => 'I clienti scelgono se prenotare un orario o mettersi in coda. Gli orari prenotati restano fissi e la coda si adatta.';
	@override String get save => 'Salva';
	@override String get saved => 'Modalità aggiornata';
}

// Path: queue.owner.removeSheet
class _Translations$queue$owner$removeSheet$it extends Translations$queue$owner$removeSheet$en {
	_Translations$queue$owner$removeSheet$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String title({required Object name}) => 'Rimuovere ${name}?';
	@override String get body => 'Esce dalla coda e gli rimborsiamo il costo del servizio.';
	@override String get confirm => 'Rimuovi dalla coda';
	@override String get keep => 'Annulla';
}

// Path: queue.owner.walkInSheet
class _Translations$queue$owner$walkInSheet$it extends Translations$queue$owner$walkInSheet$en {
	_Translations$queue$owner$walkInSheet$it._(TranslationsIt root) : this._root = root, super.internal(root);

	final TranslationsIt _root; // ignore: unused_field

	// Translations
	@override String get title => 'Aggiungi un walk-in';
	@override String get body => 'Per chi è entrato senza l\'app. Va in fondo alla coda, così l\'attesa resta giusta per tutti.';
	@override String get service => 'Servizio';
	@override String get name => 'Nome (facoltativo)';
	@override String get nameHint => 'Es. Andrea';
	@override String get add => 'Aggiungi alla coda';
	@override String get cancel => 'Annulla';
}

/// The flat map containing all translations for locale <it>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsIt {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.appName' => 'BookNow',
			'common.continue_' => 'Continua',
			'common.cancel' => 'Annulla',
			'common.close' => 'Chiudi',
			'common.confirm' => 'Conferma',
			'common.save' => 'Salva',
			'common.edit' => 'Modifica',
			'common.delete' => 'Elimina',
			'common.retry' => 'Riprova',
			'common.skip' => 'Salta',
			'common.notNow' => 'Non ora',
			'common.back' => 'Indietro',
			'common.clear' => 'Cancella',
			'common.search' => 'Cerca',
			'common.loading' => 'Caricamento…',
			'common.offline' => 'Nessuna connessione',
			'common.serviceLine' => ({required Object name, required Object price, required Object minutes}) => '${name} ${price} · ${minutes} min',
			'nav.today' => 'Oggi',
			'nav.calendar' => 'Calendario',
			'nav.shop' => 'Negozio',
			'nav.discover' => 'Scopri',
			'nav.activity' => 'Attività',
			'nav.home' => 'Home',
			'nav.bookings' => 'Prenotazioni',
			'nav.agenda' => 'Agenda',
			'nav.profile' => 'Profilo',
			'errors.generic' => 'Qualcosa è andato storto. Riprova.',
			'errors.noConnection' => 'Sembra che tu sia offline.',
			'errors.timeout' => 'La richiesta ha impiegato troppo tempo.',
			'errors.server' => 'Il servizio ha un problema. Riprova tra poco.',
			'errors.unauthorized' => 'La sessione è scaduta. Accedi di nuovo.',
			'errors.forbidden' => 'Non hai accesso a questa sezione.',
			'errors.notFound' => 'Non l\'abbiamo trovato.',
			'errors.tooManyRequests' => 'Troppi tentativi. Attendi un momento.',
			'errors.slotTaken' => 'Questo slot è appena stato preso. Scegline un altro.',
			'errors.holdExpired' => 'Lo slot è stato liberato perché il pagamento ha impiegato troppo tempo.',
			'errors.leadTimeTooShort' => 'Questo slot è troppo vicino per essere prenotato.',
			'errors.outsideBookingHorizon' => 'Questa data non è ancora prenotabile.',
			'errors.shopClosed' => 'Il negozio è chiuso in questo giorno.',
			'errors.cancellationWindowPassed' => 'È troppo tardi per annullare ed essere rimborsato.',
			'errors.slotNotBookable' => 'Questo orario non è prenotabile.',
			'errors.serviceNotAvailable' => 'Questo servizio non è più disponibile.',
			'errors.invalidBlock' => 'Questo intervallo non si può bloccare.',
			'errors.shopIncomplete' => 'Mancano ancora alcuni dati prima di pubblicare.',
			'errors.providerLimitReached' => 'Un negozio può avere fino a 10 persone al lavoro.',
			'errors.providerInUse' => 'Ci sono ancora clienti prenotati o in coda con questa persona. Sposta o annulla prima quelle.',
			'errors.defaultProvider' => 'Sei tu, quindi non puoi essere rimosso.',
			'errors.providerNotAvailable' => 'Questa persona non è disponibile per questo servizio. Scegline un\'altra.',
			'bookingStatus.pendingPayment' => 'In attesa di pagamento',
			'bookingStatus.confirmed' => 'Confermata',
			'bookingStatus.arrived' => 'Arrivato',
			'bookingStatus.noShow' => 'Non presentato',
			'bookingStatus.cancelled' => 'Annullata',
			'bookingStatus.completed' => 'Completata',
			'bookingStatus.expired' => 'Scaduta',
			'onboarding.skip' => 'Salta',
			'onboarding.next' => 'Avanti',
			'onboarding.start' => 'Inizia',
			'onboarding.haveAccount' => 'Ho già un account',
			'onboarding.slideOne.title' => 'Prenota il taglio in 30 secondi',
			'onboarding.slideOne.body' => 'Scegli il giorno e l\'ora liberi del tuo barbiere. Niente telefonate, niente attese in negozio.',
			'onboarding.slideTwo.title' => 'Il taglio lo paghi in negozio',
			'onboarding.slideTwo.body' => 'In app paghi solo €1,49 per bloccare lo slot. Il taglio lo paghi al barbiere, anche in contanti.',
			'onboarding.slideTwo.serviceLabel' => 'Taglio',
			'onboarding.slideTwo.serviceNote' => 'in negozio, al barbiere',
			'onboarding.slideTwo.feeLabel' => 'Servizio BookNow',
			'onboarding.slideTwo.feeNote' => 'ora, in app',
			'onboarding.slideTwo.plus' => 'più',
			'onboarding.slideTwo.serviceAmount' => '€18,00',
			'onboarding.slideTwo.feeAmount' => '€1,49',
			'onboarding.slideThree.title' => 'Hai un barber shop?',
			'onboarding.slideThree.body' => 'Gestisci l\'agenda gratis dal telefono. Ogni prenotazione ti arriva con una notifica.',
			'onboarding.slideThree.agendaToday' => 'Oggi · agenda',
			'onboarding.slideThree.agendaFree' => 'libero',
			'onboarding.slideThree.agendaPush' => 'Nuova prenotazione: Marco, sab 3 ott ore 10:30',
			'onboarding.slideThree.agendaBookedTime' => '10:30',
			'onboarding.slideThree.agendaBookedName' => 'Marco R.',
			'onboarding.slideThree.agendaFreeTime' => '11:00',
			'auth.continueWithApple' => 'Continua con Apple',
			'auth.continueWithGoogle' => 'Continua con Google',
			'auth.signUpWithApple' => 'Registrati con Apple',
			'auth.signUpWithGoogle' => 'Registrati con Google',
			'auth.signIn.title' => 'Bentornato',
			'auth.signIn.body' => 'Accedi in un tocco. Usiamo il tuo account solo per nome ed email.',
			'auth.signIn.firstTime' => 'prima volta?',
			'auth.signIn.createAccount' => 'Crea un account',
			'auth.signIn.terms' => 'Continuando accetti i Termini e la Privacy.',
			'auth.signIn.termsLink' => 'Termini',
			'auth.signIn.privacyLink' => 'Privacy',
			'auth.signUp.title' => 'Crea il tuo account',
			'auth.signUp.body' => 'Nessuna password da ricordare: usa Apple o Google e sei dentro.',
			'auth.signUp.noCardTitle' => 'Nessuna carta salvata',
			'auth.signUp.noCardBody' => 'Paghi €1,49 solo quando prenoti.',
			'auth.signUp.dataTitle' => 'Solo nome ed email',
			'auth.signUp.dataBody' => 'Il telefono è facoltativo, lo vede solo il barbiere.',
			'auth.signUp.roleTitle' => 'Barbiere o cliente',
			'auth.signUp.roleBody' => 'Scegli tu al passo dopo. Per i negozi è gratis.',
			'auth.signUp.alreadyHaveAccount' => 'Hai già un account?',
			'auth.signUp.signInLink' => 'Accedi',
			'auth.role.greeting' => ({required Object name}) => 'Ciao ${name}',
			'auth.role.title' => 'Come usi BookNow?',
			'auth.role.body' => 'Lo scegli una volta sola. Puoi cambiarlo dal profilo.',
			'auth.role.customerTitle' => 'Voglio prenotare',
			'auth.role.customerBody' => 'Scegli lo slot, blocchi il posto con €1,49 e paghi il taglio in negozio.',
			'auth.role.ownerTitle' => 'Ho un barber shop',
			'auth.role.ownerBody' => 'Gestisci agenda, prezzo e orari. Per i negozi BookNow è gratis.',
			'auth.role.pilotNote' => ({required Object shop, required Object address}) => 'Nel pilota c\'è un solo negozio: ${shop}, ${address}.',
			'auth.role.selected' => 'Selezionato',
			'auth.profile.title' => 'Ci siamo quasi',
			'auth.profile.body' => ({required Object provider}) => 'Questi dati arrivano dal tuo account ${provider}. Correggili se vuoi.',
			'auth.profile.nameLabel' => 'Nome e cognome',
			'auth.profile.nameRequired' => 'Inserisci il tuo nome.',
			'auth.profile.phoneLabel' => 'Telefono',
			'auth.profile.phoneOptional' => 'facoltativo',
			'auth.profile.phoneHelper' => 'Serve solo al barbiere se deve avvisarti. Non lo usiamo per altro.',
			'auth.profile.save' => 'Salva e continua',
			'profile.signedOut' => 'Disconnesso',
			'profile.remindersOff' => 'Promemoria disattivati',
			'profile.notificationsOnBefore' => ({required Object when}) => 'Attive, ${when} prima',
			'profile.ownerHelp' => 'Aiuto',
			'profile.helpLine' => 'Domande, scrivici',
			'profile.modeRow' => 'Clienti',
			'profile.shopTitle' => 'Il tuo negozio',
			'profile.shopLive' => 'Online su BookNow',
			'profile.shopHidden' => 'Non ancora visibile ai clienti',
			'profile.seeAsCustomer' => 'Vedi come cliente',
			'profile.howYouWork' => 'Come lavori',
			'profile.yourAccount' => 'Il tuo account',
			'profile.title' => 'Profilo',
			'profile.roleOwner' => 'titolare',
			'profile.roleCustomer' => 'cliente',
			'profile.shopSection' => 'Cosa vedono i clienti',
			'profile.shopPhotoPlaceholder' => 'foto',
			'profile.shopNameMissing' => 'Il tuo negozio',
			'profile.shopDetailsMissing' => 'Completa i dati del negozio',
			'profile.services' => 'Servizi',
			'profile.servicesCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} servizio', other: '${n} servizi', ), 
			'profile.hours' => 'Orari e chiusure',
			'profile.hoursNone' => 'Da impostare',
			'profile.team' => 'Team',
			'profile.teamJustYou' => 'Solo tu',
			'profile.teamCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} persona', other: '${n} persone', ), 
			'profile.bookingRules' => 'Regole di prenotazione',
			'profile.appearanceSection' => 'Aspetto e lingua',
			'profile.themeSystem' => 'Sistema',
			'profile.themeLight' => 'Chiaro',
			'profile.themeDark' => 'Scuro',
			'profile.accountSection' => 'Account',
			'profile.notifications' => 'Notifiche',
			'profile.notificationsOn' => 'Attive',
			'profile.notificationsOff' => 'Disattivate',
			'profile.help' => 'Aiuto e contatti',
			'profile.signOut' => 'Esci',
			'profile.deleteAccount' => 'Elimina account',
			'profile.signOutDialog.title' => 'Uscire dall\'account?',
			'profile.signOutDialog.bodyOwner' => 'Il tuo negozio e la tua agenda restano dove sono.',
			'profile.signOutDialog.bodyCustomer' => 'Le tue prenotazioni restano salvate.',
			'profile.signOutDialog.returnWith' => ({required Object provider}) => 'Rientri con un tocco su ${provider}.',
			'profile.deleteSheet.title' => 'Eliminare l\'account?',
			'profile.deleteSheet.body' => 'L\'operazione è definitiva: non si può annullare.',
			'profile.deleteSheet.keep' => 'Tieni il mio account',
			'profile.deleteSheet.confirm' => 'Sì, elimina',
			'profile.deleteSheet.shopLost' => ({required Object name}) => 'Il negozio ${name} e tutte le sue prenotazioni verranno eliminati.',
			'profile.deleteSheet.shopLostUnnamed' => 'Il tuo negozio e tutte le sue prenotazioni verranno eliminati.',
			'profile.deleteSheet.historyLost' => 'Perdi lo storico e le ricevute dei pagamenti.',
			'profile.personalData' => 'Dati personali',
			'profile.editProfile' => 'Modifica profilo',
			'profile.signedInWith' => ({required Object provider}) => 'Accesso con ${provider}',
			'profile.personal.initialsNote' => 'Le iniziali vengono dal tuo nome',
			'profile.personal.ownerOf' => ({required Object shop}) => 'Titolare di ${shop}',
			'profile.personal.nameLabel' => 'Nome e cognome',
			'profile.personal.nameRequired' => 'Inserisci il tuo nome.',
			'profile.personal.phoneLabelCustomer' => 'Telefono (facoltativo)',
			'profile.personal.phoneLabelOwner' => 'Telefono (personale)',
			'profile.personal.phoneOptional' => 'facoltativo',
			'profile.personal.phonePersonal' => 'personale',
			'profile.personal.phoneHelperCustomer' => 'Lo vede solo il barbiere, se deve avvisarti.',
			'profile.personal.phoneHelperOwner' => 'Non è il numero del negozio: lo usiamo solo per contattarti.',
			'profile.personal.emailLabel' => 'Email',
			'profile.personal.emailLockedHint' => 'Non modificabile qui',
			'profile.personal.emailApple' => 'Gestita da Apple. Per cambiarla modifica il tuo ID Apple.',
			'profile.personal.emailGoogle' => 'Gestita da Google. Per cambiarla modifica il tuo account Google.',
			'profile.personal.emailProvider' => 'Gestita dal servizio con cui hai fatto l\'accesso.',
			'profile.personal.saved' => 'Dati aggiornati',
			'help.screenTitle' => 'Aiuto e contatti',
			'help.faqSection' => 'Domande frequenti',
			'help.needMore' => 'Serve altro?',
			'help.faq.feeQuestion' => 'Perché pago €1,49?',
			'help.faq.feeAnswer' => 'È il costo del servizio di prenotazione: blocca il tuo posto. Il servizio lo paghi in negozio, come sempre.',
			'help.faq.cancelQuestion' => 'Come annullo una prenotazione?',
			'help.faq.cancelAnswer' => 'Apri la prenotazione e tocca Annulla. Fino a 2 ore prima dell\'inizio la commissione viene rimborsata; più tardi la prenotazione si annulla comunque, ma la commissione resta. Dopo l\'orario di inizio non si annulla più.',
			'help.faq.refundQuestion' => 'Quando arriva il rimborso?',
			'help.faq.refundAnswer' => 'Parte appena annulli e torna sulla stessa carta, di solito in pochi giorni lavorativi secondo i tempi della tua banca. Se è il negozio ad annullare, la commissione è sempre rimborsata.',
			'help.faq.lateQuestion' => 'Arrivo in ritardo, cosa succede?',
			'help.faq.lateAnswer' => 'Avvisa il negozio. Il posto resta tuo finché il titolare non ti segna come assente, cosa che può fare da 15 minuti dopo l\'orario di inizio: in quel caso la commissione non viene rimborsata.',
			'help.callShop' => 'Chiama il negozio',
			'help.callShopSubtitle' => 'Per orari, servizi e appuntamenti',
			'help.writeUs' => 'Scrivi a BookNow',
			'help.writeUsSubtitle' => 'Pagamenti, rimborsi e app · entro 24 ore',
			'help.terms' => 'Termini',
			'help.privacy' => 'Privacy',
			'help.version' => ({required Object version}) => 'Versione ${version}',
			'help.callFailed' => 'Non riesco ad aprire il telefono.',
			'help.linkFailed' => 'Non riesco ad aprire il link.',
			'help.topics.payment' => 'Pagamento',
			'help.topics.booking' => 'Prenotazione',
			'help.topics.account' => 'Account',
			'help.topics.other' => 'Altro',
			'help.write.title' => 'Scrivi a BookNow',
			'help.write.replyTo' => ({required Object email}) => 'Rispondiamo entro 24 ore a ${email}.',
			'help.write.replyGeneric' => 'Rispondiamo entro 24 ore.',
			'help.write.handoff' => 'Apriamo la tua app email con il messaggio già pronto.',
			'help.write.topicLabel' => 'Di cosa si tratta?',
			'help.write.messageLabel' => 'Messaggio',
			'help.write.messageHint' => 'Raccontaci cosa è successo',
			'help.write.attach' => 'Alleghiamo il tuo account e la versione dell\'app',
			'help.write.send' => 'Invia',
			'help.write.opened' => 'Messaggio pronto nella tua app email.',
			'help.write.noMailApp' => ({required Object email}) => 'Nessuna app email sul telefono. Scrivi a ${email}.',
			'help.mail.subject' => ({required Object topic}) => 'BookNow — ${topic}',
			'help.mail.account' => 'Account',
			'help.mail.role' => 'Ruolo',
			'help.mail.appVersion' => 'Versione app',
			'help.mail.roleOwner' => 'titolare',
			'help.mail.roleCustomer' => 'cliente',
			'validation.required' => 'Questo campo è obbligatorio.',
			'validation.requiredNamed' => ({required Object field}) => '${field} è obbligatorio.',
			'validation.email' => 'Inserisci un indirizzo email valido.',
			'validation.phone' => 'Inserisci un numero di telefono valido.',
			'validation.tooShort' => ({required Object min}) => 'Almeno ${min} caratteri.',
			'validation.tooLong' => ({required Object max}) => 'Massimo ${max} caratteri.',
			'shopSetup.team.screenTitle' => 'Team',
			'shopSetup.team.subtitle' => 'Chi riceve i clienti qui. I clienti scelgono una persona, o chi si libera prima.',
			'shopSetup.team.you' => 'Tu',
			'shopSetup.team.add' => 'Aggiungi una persona',
			'shopSetup.team.added' => 'Aggiunto al team',
			'shopSetup.team.saved' => 'Modifiche salvate',
			'shopSetup.team.removed' => ({required Object name}) => '${name} non è più nel team',
			'shopSetup.team.restored' => ({required Object name}) => '${name} è di nuovo nel team',
			'shopSetup.team.removedSection' => 'Rimossi',
			'shopSetup.team.restore' => 'Riporta nel team',
			'shopSetup.team.everyService' => 'Tutti i servizi',
			'shopSetup.team.servicesCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} servizio', other: '${n} servizi', ), 
			'shopSetup.team.shopHours' => 'Orari del negozio',
			'shopSetup.team.ownHours' => 'Orari propri',
			'shopSetup.team.daysOff' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} giorno libero', other: '${n} giorni liberi', ), 
			'shopSetup.team.actionsFor' => ({required Object name}) => 'Opzioni per ${name}',
			'shopSetup.team.edit' => 'Modifica',
			'shopSetup.team.remove' => 'Rimuovi dal team',
			'shopSetup.team.removeTitle' => ({required Object name}) => 'Rimuovere ${name}?',
			'shopSetup.team.removeBody' => 'I clienti non potranno più prenotare con questa persona né aspettarla in coda. Le prenotazioni passate mantengono il nome, e potrai riportarla nel team.',
			'shopSetup.team.newTitle' => 'Nuova persona nel team',
			'shopSetup.team.editTitle' => 'Persona del team',
			'shopSetup.team.nameLabel' => 'Nome',
			'shopSetup.team.nameHint' => 'Marco',
			'shopSetup.team.nameHelper' => 'I clienti lo vedono quando scelgono con chi prenotare.',
			'shopSetup.team.typeLabel' => 'Chi o cosa',
			'shopSetup.team.typePerson' => 'Persona',
			'shopSetup.team.typeResource' => 'Poltrona o postazione',
			'shopSetup.team.servicesLabel' => 'Servizi',
			'shopSetup.team.everyServiceHelper' => 'Anche quelli che aggiungerai',
			'shopSetup.team.noService' => 'Scegli almeno un servizio.',
			'shopSetup.team.hoursLabel' => 'Orari',
			'shopSetup.team.sameAsShop' => 'Come il negozio',
			'shopSetup.team.ownHoursHelper' => 'Solo dentro gli orari del negozio. Fuori nessuno può prenotare.',
			'shopSetup.team.daysOffLabel' => 'Giorni liberi',
			'shopSetup.team.addDayOff' => 'Aggiungi un giorno libero',
			'shopSetup.team.removeDayOff' => ({required Object day}) => 'Rimuovi ${day}',
			'shopSetup.team.noDaysOff' => 'Nessuno in programma',
			'shopSetup.team.save' => 'Aggiungi al team',
			'shopSetup.team.saveChanges' => 'Salva modifiche',
			'shopSetup.checklist.done' => 'Fatto',
			'shopSetup.checklist.typicalTitle' => 'Partire da una settimana tipica?',
			'shopSetup.checklist.typicalBody' => ({required Object hours}) => 'Da martedì a sabato, ${hours}. Puoi cambiare ogni giorno dopo.',
			'shopSetup.checklist.typicalCta' => 'Usa questa settimana',
			'shopSetup.checklist.title' => 'Mettiamo online il tuo negozio',
			'shopSetup.checklist.left' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Manca ${n} passaggio. I clienti non vedono ancora il negozio.', other: 'Mancano ${n} passaggi. I clienti non vedono ancora il negozio.', ), 
			'shopSetup.checklist.allDone' => 'Tutto pronto. Un tocco e i clienti ti trovano.',
			'shopSetup.checklist.continueWith' => ({required Object step}) => 'Prossimo: ${step}',
			'shopSetup.checklist.optional' => 'Facoltativo',
			'shopSetup.checklist.shop' => 'Dati del negozio',
			'shopSetup.checklist.shopHint' => 'Nome e telefono',
			'shopSetup.checklist.address' => 'Indirizzo',
			'shopSetup.checklist.addressHint' => 'Dove ti trovano i clienti',
			'shopSetup.checklist.services' => 'Servizi e prezzi',
			'shopSetup.checklist.servicesHint' => 'Almeno uno, con il prezzo',
			'shopSetup.checklist.hours' => 'Orari di apertura',
			'shopSetup.checklist.hoursHint' => 'Quando ricevi i clienti',
			'shopSetup.checklist.liveTitle' => 'Sei online',
			'shopSetup.checklist.liveBody' => 'Ora i clienti possono trovare il tuo negozio.',
			'shopSetup.checklist.liveCta' => 'Apri il mio negozio',
			'shopSetup.stepOf' => ({required Object current, required Object total}) => '${current}/${total}',
			'shopSetup.continue_' => 'Continua',
			'shopSetup.shop.overline' => 'Il tuo negozio',
			'shopSetup.shop.title' => 'Come ti trovano i clienti?',
			'shopSetup.shop.nameLabel' => 'Nome del negozio',
			'shopSetup.shop.nameHelper' => 'Lo vedono i clienti, scritto così.',
			'shopSetup.shop.phoneLabel' => 'Telefono del negozio',
			'shopSetup.shop.phoneHelper' => 'I clienti possono chiamarti dalla prenotazione.',
			'shopSetup.shop.photoLabel' => 'Foto',
			'shopSetup.shop.photoOptional' => 'facoltativa',
			'shopSetup.shop.photoAdd' => 'Aggiungi una foto',
			'shopSetup.shop.photoHint' => 'L\'interno o la vetrina · puoi farlo dopo',
			'shopSetup.shop.photoSource' => 'Foto del negozio',
			'shopSetup.shop.photoCamera' => 'Scatta una foto',
			'shopSetup.shop.photoGallery' => 'Scegli dalla galleria',
			'shopSetup.shop.photoRemove' => 'Rimuovi foto',
			'shopSetup.shop.photoVisible' => 'Visibile ai clienti',
			'shopSetup.shop.photoCameraNew' => 'Scatta una nuova foto',
			'shopSetup.shop.photoSourceBody' => 'È la prima cosa che vedono i clienti. Meglio la vetrina o l\'interno, in orizzontale.',
			'shopSetup.shop.photoTipsTitle' => 'Per una buona foto',
			'shopSetup.shop.photoTipLight' => 'Luce naturale, di giorno',
			'shopSetup.shop.photoTipLandscape' => 'Telefono in orizzontale',
			'shopSetup.shop.photoTipFaces' => 'Niente volti di clienti senza permesso',
			'shopSetup.shop.photoFailed' => 'Non siamo riusciti ad aprire la foto. Riprova.',
			'shopSetup.details.title' => 'Dati del negozio',
			'shopSetup.details.addressLabel' => 'Indirizzo',
			'shopSetup.details.addressMissing' => 'Indirizzo da scegliere',
			'shopSetup.details.addressMissingHelper' => 'Scegli dove si trova il negozio',
			'shopSetup.details.addressPinned' => 'pin sulla mappa',
			'shopSetup.details.addressNotPinned' => 'pin da confermare',
			'shopSetup.details.liveNote' => 'Le modifiche sono subito visibili ai clienti.',
			'shopSetup.details.saved' => 'Negozio aggiornato',
			'shopSetup.address.overline' => 'Indirizzo',
			'shopSetup.address.title' => 'Dove si trova?',
			'shopSetup.address.searchHint' => 'Via e numero',
			'shopSetup.address.mapPreview' => 'anteprima mappa',
			'shopSetup.address.helper' => 'Scegli un indirizzo e posizioniamo il pin da soli.',
			'shopSetup.services.overline' => 'Servizi',
			'shopSetup.services.title' => 'Cosa prenotano i clienti?',
			'shopSetup.services.subtitle' => 'Aggiungi tutti i servizi che offri. Ne serve almeno uno.',
			'shopSetup.services.newService' => 'Nuovo servizio',
			'shopSetup.services.nameHint' => 'Nome del servizio',
			'shopSetup.services.priceHint' => 'Prezzo',
			'shopSetup.services.save' => 'Salva',
			'shopSetup.services.edit' => 'Modifica',
			'shopSetup.services.delete' => 'Elimina',
			'shopSetup.services.editTitle' => 'Modifica servizio',
			'shopSetup.services.actionsFor' => ({required Object name}) => 'Azioni per ${name}',
			'shopSetup.services.continueOne' => 'Continua · 1 servizio',
			'shopSetup.services.minutes' => ({required Object count}) => '${count} min',
			'shopSetup.services.helper' => 'I prezzi li vedono i clienti, ma li pagano a te in negozio. La durata decide quanto spazio occupa in agenda.',
			'shopSetup.services.continueWith' => ({required Object count}) => 'Continua · ${count} servizi',
			'shopSetup.services.screenTitle' => 'Servizi',
			'shopSetup.services.manageSubtitle' => 'I clienti scelgono tra questi quando prenotano. Tocca un servizio per modificarlo.',
			'shopSetup.services.add' => 'Aggiungi servizio',
			'shopSetup.services.emptyTitle' => 'Ancora nessun servizio',
			'shopSetup.services.emptyBody' => 'Aggiungi il primo servizio che i clienti possono prenotare.',
			'shopSetup.services.nameLabel' => 'Nome del servizio',
			'shopSetup.services.durationLabel' => 'Durata',
			'shopSetup.services.priceLabel' => 'Prezzo',
			'shopSetup.services.saveChanges' => 'Salva modifiche',
			'shopSetup.services.previousPrice' => ({required Object price}) => 'Prezzo precedente ${price}',
			'shopSetup.services.deleteTitle' => ({required Object name}) => 'Eliminare ${name}?',
			'shopSetup.services.deleteBody' => 'Le prenotazioni già fatte restano valide. Il servizio non sarà più prenotabile.',
			'shopSetup.services.deleted' => 'Servizio eliminato',
			'shopSetup.services.saved' => 'Servizio aggiornato',
			'shopSetup.services.added' => 'Servizio aggiunto',
			'shopSetup.hours.overline' => 'Orari',
			'shopSetup.hours.title' => 'Quando sei aperto?',
			'shopSetup.hours.closed' => 'Chiuso',
			'shopSetup.hours.lunchBreak' => 'Pausa pranzo',
			'shopSetup.hours.copyToOpenDays' => 'Copia su tutti i giorni aperti',
			'shopSetup.hours.moreDays' => ({required Object days}) => '+ ${days}',
			'shopSetup.hours.screenTitle' => 'Orari e chiusure',
			'shopSetup.hours.weekly' => 'La tua settimana',
			'shopSetup.hours.continuous' => 'orario continuato',
			'shopSetup.hours.open' => 'Aperto',
			'shopSetup.hours.slots' => 'Fasce orarie',
			'shopSetup.hours.addSlot' => 'Aggiungi fascia',
			'shopSetup.hours.removeSlot' => 'Rimuovi fascia',
			'shopSetup.hours.copyTo' => 'Copia su altri giorni',
			'shopSetup.hours.copyNone' => 'Nessuno',
			'shopSetup.hours.overlap' => 'Due fasce si sovrappongono.',
			'shopSetup.hours.backwards' => 'La fine deve venire dopo l\'inizio.',
			'shopSetup.hours.saved' => 'Orari aggiornati',
			'shopSetup.review.title' => 'Tutto pronto per aprire',
			'shopSetup.review.subtitle' => 'Controlla un\'ultima volta. Puoi cambiare tutto anche dopo, da Negozio.',
			'shopSetup.review.edit' => 'Modifica',
			'shopSetup.review.noPhoto' => 'senza foto',
			'shopSetup.review.pinConfirmed' => 'pin confermato',
			'shopSetup.review.servicesFrom' => ({required Object count, required Object price}) => '${count} servizi · da ${price}',
			'shopSetup.review.openDays' => ({required Object count}) => '${count} giorni aperti',
			'shopSetup.review.closedDays' => ({required Object days}) => 'chiuso ${days}',
			'shopSetup.review.hiddenBefore' => 'Finché non pubblichi, il negozio',
			'shopSetup.review.hiddenStrong' => 'non è visibile',
			'shopSetup.review.hiddenAfter' => 'ai clienti.',
			'shopSetup.review.publish' => 'Pubblica il negozio',
			'weekdays.short.mon' => 'Lun',
			'weekdays.short.tue' => 'Mar',
			'weekdays.short.wed' => 'Mer',
			'weekdays.short.thu' => 'Gio',
			'weekdays.short.fri' => 'Ven',
			'weekdays.short.sat' => 'Sab',
			'weekdays.short.sun' => 'Dom',
			'weekdays.long.mon' => 'Lunedì',
			'weekdays.long.tue' => 'Martedì',
			'weekdays.long.wed' => 'Mercoledì',
			'weekdays.long.thu' => 'Giovedì',
			'weekdays.long.fri' => 'Venerdì',
			'weekdays.long.sat' => 'Sabato',
			'weekdays.long.sun' => 'Domenica',
			'notifications.allow' => 'Attiva le notifiche',
			'notifications.skip' => 'Non ora',
			'notifications.owner.title' => 'Sappi subito chi prenota',
			'notifications.owner.body' => 'Senza notifiche scopri le prenotazioni solo aprendo l\'agenda.',
			'notifications.owner.pointOne' => 'Ogni nuova prenotazione',
			'notifications.owner.pointTwo' => 'Annullamenti, così riempi lo slot',
			'notifications.owner.firstTitle' => 'Nuova prenotazione',
			'notifications.owner.firstBody' => 'Marco R. · Taglio uomo · sab 3 ott, 10:30',
			'notifications.owner.firstWhen' => 'ora',
			'notifications.owner.secondTitle' => 'Slot liberato',
			'notifications.owner.secondBody' => 'Paolo M. ha annullato le 11:30.',
			'notifications.owner.secondWhen' => '8 min fa',
			'notifications.customer.title' => 'Ti avvisiamo prima dell\'appuntamento',
			'notifications.customer.body' => 'Solo cose che riguardano le tue prenotazioni. Niente pubblicità.',
			'notifications.customer.pointOne' => 'Promemoria 2 ore prima',
			'notifications.customer.pointTwo' => 'Annullamenti e rimborsi',
			'notifications.customer.firstTitle' => 'Tra 2 ore',
			'notifications.customer.firstBody' => 'Taglio uomo da Barbieri Navona alle 10:30.',
			'notifications.customer.firstWhen' => 'ora',
			'notifications.customer.secondTitle' => 'Prenotazione annullata',
			'notifications.customer.secondBody' => 'Barbieri Navona ha annullato sab 3 ott. Costo rimborsato.',
			'notifications.customer.secondWhen' => 'ieri',
			'notificationSettings.screenTitle' => 'Notifiche',
			'notificationSettings.blocked.title' => 'Notifiche disattivate sul telefono',
			'notificationSettings.blocked.bodyOwner' => 'Non ti arrivano le nuove prenotazioni.',
			'notificationSettings.blocked.bodyCustomer' => 'Non ti arrivano i promemoria degli appuntamenti.',
			'notificationSettings.blocked.action' => 'Apri Impostazioni',
			'notificationSettings.lead.oneHour' => '1 ora',
			'notificationSettings.lead.twoHours' => '2 ore',
			'notificationSettings.lead.oneDay' => '1 giorno',
			'notificationSettings.customer.reminderSection' => 'Promemoria',
			'notificationSettings.customer.reminder' => 'Prima dell\'appuntamento',
			'notificationSettings.customer.reminderSubtitle' => 'Ti avvisiamo quando è ora di andare',
			'notificationSettings.customer.bookingsSection' => 'Prenotazioni',
			'notificationSettings.customer.cancellations' => 'Annullamenti e rimborsi',
			'notificationSettings.customer.cancellationsSubtitle' => 'Sempre attive: riguardano i tuoi soldi',
			'notificationSettings.customer.cancellationsLocked' => 'Attive',
			'notificationSettings.owner.agendaSection' => 'Agenda',
			'notificationSettings.owner.newBookings' => 'Nuove prenotazioni',
			'notificationSettings.owner.newBookingsSubtitle' => 'Appena un cliente paga il posto',
			'notificationSettings.owner.cancellations' => 'Annullamenti',
			'notificationSettings.owner.cancellationsSubtitle' => 'Lo slot torna libero',
			'notificationSettings.owner.summarySection' => 'Riepilogo',
			'notificationSettings.owner.dailySummary' => 'Agenda del giorno',
			'notificationSettings.owner.dailySummarySubtitle' => 'Quanti clienti hai oggi',
			'notificationSettings.owner.summaryTime' => 'Orario di invio',
			'bookings.rightNow' => 'Adesso',
			'bookings.upcoming' => 'Prossime',
			'bookings.past' => 'Passate',
			'bookings.emptyTitle' => 'Niente in programma',
			'bookings.emptyBody' => 'Le prenotazioni che fai compaiono qui, con lo stato aggiornato.',
			'bookings.emptyPastTitle' => 'Nessuno storico',
			'bookings.emptyPastBody' => 'Qui trovi i tagli già fatti.',
			'bookings.inShop' => ({required Object price}) => '${price} in negozio',
			'bookings.expiresIn' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Scade tra ${n} min', other: 'Scade tra ${n} min', ), 
			'bookings.holdLapsed' => 'Posto non più tenuto',
			'bookings.payNow' => 'Paga ora',
			'bookings.freeUntil' => ({required Object when}) => 'Annullabile gratis fino a ${when}',
			'bookings.repeat' => 'Prenota di nuovo',
			'bookings.byYou' => 'da te',
			'bookings.byShop' => 'dal negozio',
			'bookings.refunded' => 'rimborsata',
			'bookings.notRefunded' => 'non rimborsata',
			'bookings.paid' => 'pagato',
			'bookings.paidWithCard' => ({required Object card}) => 'pagato · •••• ${card}',
			'bookings.feeNote' => 'Il taglio si paga in negozio. Qui vedi solo lo stato del posto.',
			'bookings.detailTitle' => 'La tua prenotazione',
			'bookings.serviceLine' => ({required Object service, required Object minutes}) => '${service} · ${minutes} minuti',
			'bookings.map' => 'Mappa',
			'bookings.callShop' => 'Chiama il negozio',
			'bookings.payInShop' => 'da pagare in negozio',
			'bookings.bookNowService' => 'Servizio BookNow',
			'bookings.addToCalendar' => 'Aggiungi al calendario',
			'bookings.calendarFailed' => 'Nessuna app calendario su questo dispositivo.',
			'bookings.mapFailed' => 'Nessuna app mappe su questo dispositivo.',
			'bookings.cancel.action' => 'Annulla prenotazione',
			'bookings.cancel.title' => 'Annullare il taglio?',
			'bookings.cancel.subtitle' => ({required Object when, required Object time, required Object shop}) => '${when} alle ${time}, ${shop}.',
			'bookings.cancel.refundTitle' => ({required Object fee}) => 'Rimborso di ${fee}',
			'bookings.cancel.refundBody' => 'Mancano più di 2 ore, quindi il servizio ti viene restituito in 3–5 giorni.',
			'bookings.cancel.refundBodyCard' => ({required Object card}) => 'Mancano più di 2 ore, quindi il servizio ti viene restituito su •••• ${card} in 3–5 giorni.',
			'bookings.cancel.noRefundTitle' => 'Il servizio non viene rimborsato',
			'bookings.cancel.noRefundBody' => ({required Object fee}) => 'Mancano meno di 2 ore, quindi ${fee} resta al negozio. Il taglio non lo paghi.',
			'bookings.cancel.slotFreed' => 'Lo slot torna subito libero per altri clienti.',
			'bookings.cancel.confirm' => 'Sì, annulla',
			'bookings.cancel.keep' => 'Mantieni la prenotazione',
			'bookings.cancel.done' => 'Prenotazione annullata.',
			'bookings.cancel.doneRefunded' => ({required Object fee}) => 'Prenotazione annullata · ${fee} rimborsati.',
			'bookings.cancel.failed' => 'Non è stato possibile annullare. Riprova.',
			'account.title' => 'Profilo',
			'account.signedInWith' => ({required Object provider}) => 'Accesso con ${provider}',
			'account.editProfile' => 'Modifica profilo',
			'account.appearanceTitle' => 'Aspetto e lingua',
			'account.themeSystem' => 'Sistema',
			'account.themeLight' => 'Chiaro',
			'account.themeDark' => 'Scuro',
			'account.notificationsTitle' => 'Notifiche',
			'account.reminderTitle' => 'Promemoria del taglio',
			'account.reminderBody' => '2 ore prima',
			'account.shopNewsTitle' => 'Novità del negozio',
			'account.shopNewsBody' => 'Orari e chiusure',
			'account.accountTitle' => 'Account',
			'account.payments' => 'Pagamenti e ricevute',
			'account.switchToBarber' => 'Passa a barbiere',
			'account.help' => 'Aiuto e contatti',
			'account.signOut' => 'Esci',
			'account.signOutConfirmTitle' => 'Vuoi uscire?',
			'account.signOutConfirmBody' => 'Dovrai accedere di nuovo per vedere le tue prenotazioni.',
			'account.deleteAccount' => 'Elimina account',
			'account.comingSoon' => 'Disponibile a breve.',
			_ => null,
		} ?? switch (path) {
			'home.waitShort' => ({required Object n, required Object from, required Object to}) => '${n} · ${from}–${to} min',
			'home.useLocation' => 'Usa la mia posizione',
			'home.useLocationLine' => 'Mostra prima i negozi più vicini',
			'home.locationFailed' => 'Posizione non disponibile. Controlla che sia attiva e consentita per BookNow.',
			'home.guestBlocked' => 'Accedi per vedere i negozi vicino a te.',
			'home.intentNow' => 'Adesso',
			'home.intentTomorrow' => 'Domani',
			'home.searchHint' => 'Cerca negozi o servizi',
			'home.clearCategory' => 'Togli la categoria',
			'home.whereTitle' => 'Dove cerchiamo?',
			'home.list' => 'Lista',
			'home.map' => 'Mappa',
			'home.headlineNow' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} negozio può riceverti ora', other: '${n} negozi possono riceverti ora', ), 
			'home.headlineToday' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} negozio libero oggi', other: '${n} negozi liberi oggi', ), 
			'home.headlineTomorrow' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} negozio da prenotare domani', other: '${n} negozi da prenotare domani', ), 
			'home.feedNow' => 'Prima l\'attesa più breve',
			'home.feedToday' => 'Prossimi orari liberi',
			'home.feedTomorrow' => 'Prenota per domani',
			'home.categoryNotice' => 'I negozi non sono ancora divisi per categoria, quindi li vedi tutti.',
			'home.emptyNowTitle' => 'Nessuno può riceverti adesso',
			'home.emptyNowBody' => 'Prenota un orario più tardi oggi.',
			'home.emptyNowCta' => 'Vedi gli orari di oggi',
			'home.joinLine' => 'Mettiti in coda',
			'home.bookTime' => 'Prenota un orario',
			'home.seeLine' => 'Vedi la coda',
			'home.seeTimes' => 'Vedi gli orari',
			'home.headerTitle' => 'Prenota una poltrona o salta la fila',
			'home.whatDoYouNeed' => 'Di cosa hai bisogno?',
			'home.searchByName' => 'Cerca per nome',
			'home.whereLabel' => 'Dove',
			'home.whenLabel' => 'Quando',
			'home.today' => 'Oggi',
			'home.allCities' => 'Tutte le città',
			'home.searchCategory' => ({required Object category}) => 'Cerca ${category}',
			'home.foldSearch' => 'Chiudi la ricerca',
			'home.openSearch' => 'Apri la ricerca completa',
			'home.explore' => 'Esplora le categorie',
			'home.all' => 'Tutte',
			'home.nearYou' => 'Vicino a te',
			'home.shortestWait' => 'Attesa più breve ora',
			'home.join' => 'Entra',
			'home.book' => 'Prenota',
			'home.filterOpenNow' => 'Aperti ora',
			'home.filterNearest' => 'Più vicini',
			'home.filterShortestQueue' => 'Coda più breve',
			'home.waiting' => ({required Object n, required Object from, required Object to}) => '${n} in attesa · ${from}–${to} min',
			'home.noWait' => 'Nessuna attesa',
			'home.queueClosed' => 'Coda chiusa',
			'home.nextAt' => ({required Object time}) => 'Prossimo ${time}',
			'home.inQueue' => 'In coda',
			'home.view' => 'Vedi',
			'home.mapNow' => 'Ora',
			'home.mapWait' => ({required Object from, required Object to}) => '${from}–${to}\'',
			'home.inLine' => 'in fila',
			'home.greeting' => ({required Object name}) => 'Ciao ${name}',
			'home.greetingNoName' => 'Ciao',
			'home.nextBooking' => 'Prossima prenotazione',
			'home.freeToday' => 'Liberi oggi',
			'home.shopsNearby' => 'Negozi vicino a te',
			'home.nothingBooked' => 'Ancora nessuna prenotazione',
			'home.nothingBookedBody' => 'Scegli un orario qui sotto: blocchi il posto con un acconto.',
			'home.noFreeToday' => 'Nessun orario libero oggi.',
			'home.noShops' => 'Nessun negozio disponibile al momento.',
			'home.moreTimes' => 'altri orari',
			'home.metresAway' => ({required Object metres}) => '${metres} m',
			'home.kilometresAway' => ({required Object km}) => '${km} km',
			'home.servicesCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} servizio', other: '${n} servizi', ), 
			'home.fromPrice' => ({required Object price}) => 'da ${price}',
			'home.openNow' => 'Aperto',
			'home.openUntil' => ({required Object time}) => 'Aperto · chiude ${time}',
			'home.closedNow' => 'Chiuso',
			'home.closedUntil' => ({required Object time}) => 'Chiuso · apre alle ${time}',
			'agenda.everyone' => 'Tutti',
			'agenda.freeLine' => ({required Object length}) => '${length} · Tocca per bloccare',
			'agenda.hours' => ({required Object count}) => '${count} h',
			'agenda.today' => 'Oggi',
			'agenda.pickDate' => 'Scegli una data',
			'agenda.closedShort' => 'chiuso',
			'agenda.closedTitle' => 'Chiuso',
			'agenda.closedBody' => 'Nessun orario di apertura in questo giorno.',
			'agenda.closureBody' => 'Chiusura straordinaria. Nessuna prenotazione possibile.',
			'agenda.emptyTitle' => 'Giornata libera',
			'agenda.emptyBody' => 'Nessuna prenotazione per questo giorno.',
			'agenda.booked' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} prenotazione', other: '${n} prenotazioni', ), 
			'agenda.free' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '${n} orario libero', other: '${n} orari liberi', ), 
			'agenda.toCollect' => ({required Object amount}) => '${amount} da incassare',
			'agenda.now' => 'ora',
			'agenda.freeLabel' => 'Libero',
			'agenda.customerFallback' => 'Cliente',
			'agenda.minutes' => ({required Object count}) => '${count} min',
			'agenda.cancelledBy' => ({required Object name}) => 'annullata da ${name}',
			'agenda.until' => ({required Object time, required Object amount}) => 'fino alle ${time} · ${amount} in negozio',
			'agenda.blockedLabel' => 'Bloccato',
			'agenda.openBooking' => ({required Object name}) => 'Apri la prenotazione di ${name}',
			'agenda.blockFree' => ({required Object time}) => 'Blocca l\'orario libero delle ${time}',
			'agenda.openBlock' => ({required Object time}) => 'Apri il blocco delle ${time}',
			'agenda.sheet.timeLine' => ({required Object from, required Object to, required Object service, required Object minutes}) => '${from} – ${to} · ${service} · ${minutes} min',
			'agenda.sheet.toCollect' => 'Da incassare in negozio',
			'agenda.sheet.holdPaid' => ({required Object amount}) => '${amount} di acconto già pagato nell\'app',
			'agenda.sheet.call' => ({required Object name}) => 'Chiama ${name}',
			'agenda.sheet.callGeneric' => 'Chiama',
			'agenda.sheet.markArrived' => 'Segna come arrivato',
			'agenda.sheet.noShow' => 'Non presentato',
			'agenda.sheet.noShowFrom' => ({required Object time}) => 'Non presentato · dalle ${time}',
			'agenda.sheet.cancel' => 'Annulla prenotazione',
			'agenda.sheet.noDialler' => 'Nessuna app telefono su questo dispositivo.',
			'agenda.sheet.comingSoon' => 'Disponibile a breve.',
			'agenda.block.title' => 'Blocca orario',
			'agenda.block.from' => 'Dalle',
			'agenda.block.to' => 'Alle',
			'agenda.block.note' => 'Nota',
			'agenda.block.noteHint' => 'Pausa, cliente senza prenotazione…',
			'agenda.block.save' => 'Blocca',
			'agenda.block.backwards' => 'La fine deve venire dopo l\'inizio.',
			'agenda.block.tooLong' => 'Un blocco non può superare le 8 ore.',
			'agenda.block.blockedTitle' => 'Orario bloccato',
			'agenda.block.remove' => 'Sblocca orario',
			'agenda.block.removeTitle' => 'Sbloccare questo orario?',
			'agenda.block.removeBody' => 'Torna prenotabile dai clienti.',
			'agenda.block.blocked' => 'Orario bloccato.',
			'agenda.block.unblocked' => 'Orario sbloccato.',
			'flow.doneShort' => 'Prenotazione fatta',
			'flow.whenTitle' => 'Quando ti va bene?',
			'flow.morning' => 'Mattina',
			'flow.afternoon' => 'Pomeriggio',
			'flow.lunchBreak' => ({required Object from, required Object to}) => '${from} – ${to} · pausa pranzo',
			'flow.legendTaken' => '— barrato: occupato',
			'flow.legendPast' => '— sbiadito: passato',
			'flow.continueWith' => ({required Object when, required Object time}) => 'Continua · ${when}, ${time}',
			'flow.closedTitle' => 'Chiuso',
			'flow.closedBody' => 'Il negozio non apre in questo giorno. Scegline un altro.',
			'flow.noTimesTitle' => 'Nessun orario libero',
			'flow.noTimesBody' => 'Prova un altro giorno.',
			'flow.confirmTitle' => 'Controlla e conferma',
			'flow.change' => 'Cambia',
			'flow.payInShopWithMinutes' => ({required Object minutes}) => '${minutes} min · paghi in negozio',
			'flow.bookNowService' => 'Servizio BookNow',
			'flow.payNow' => 'lo paghi adesso',
			'flow.payAndConfirm' => ({required Object fee}) => 'Paga ${fee} e conferma',
			'flow.payAndConfirmNoFee' => 'Paga e conferma',
			'flow.terms' => 'Confermando accetti i Termini. Il taglio si paga in negozio.',
			'flow.freeCancellationUntil' => ({required Object when}) => 'Annullabile gratis fino a ${when}.',
			'flow.arriveEarly' => 'Arriva 5 minuti prima: il posto è tenuto per 10 minuti.',
			'flow.declinedTitle' => 'Pagamento non riuscito',
			'flow.declinedBody' => 'La carta è stata rifiutata. Non ti abbiamo addebitato nulla.',
			'flow.holdLeft' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'Slot tenuto ancora ${n} min', other: 'Slot tenuto ancora ${n} min', ), 
			'flow.holdLapsed' => 'Lo slot non è più tenuto',
			'flow.retry' => 'Riprova',
			'flow.giveUp' => 'Lascia perdere',
			'flow.confirmingTitle' => 'Stiamo confermando',
			'flow.confirmingBody' => 'Il pagamento è andato a buon fine. Ci vuole qualche secondo.',
			'flow.doneTitle' => 'È tutto a posto',
			'flow.doneBody' => 'Il tuo posto è prenotato. Ti mandiamo un promemoria 2 ore prima.',
			'flow.feePaid' => ({required Object fee}) => '${fee} pagati',
			'flow.inShop' => ({required Object price}) => '${price} in negozio',
			'flow.done' => 'Fatto',
			'queue.liveNow' => 'In diretta adesso',
			'queue.turnTitleShort' => 'Tocca a te',
			'queue.splashPlace' => ({required Object n, required Object shop}) => 'Sei il n. ${n} da ${shop}',
			'queue.splashTurn' => ({required Object shop}) => 'Tocca a te da ${shop}',
			'queue.live' => 'Coda dal vivo',
			'queue.walkIn' => 'Senza appuntamento',
			'queue.stateOpen' => 'Coda aperta',
			'queue.statePaused' => 'In pausa',
			'queue.stateFull' => 'Completa per oggi',
			'queue.stateClosed' => 'Chiusa per oggi',
			'queue.stateOutside' => 'Fuori orario',
			'queue.waitingCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: 'persona in attesa', other: 'persone in attesa', ), 
			'queue.estimateNow' => 'Se entri ora, attesa stimata',
			'queue.range' => ({required Object from, required Object to}) => '${from}–${to} min',
			'queue.pausedBody' => 'Il barbiere ha messo in pausa la coda. Chi è già in fila mantiene il posto: riprova tra poco.',
			'queue.fullBody' => 'Chi entra ora finirebbe dopo la chiusura. Riprova domani.',
			'queue.closedBody' => 'La coda è chiusa per oggi.',
			'queue.outsideBody' => 'Il negozio è chiuso in questo momento.',
			'queue.services' => 'Servizi',
			'queue.pickService' => 'Cosa ti serve?',
			'queue.minutes' => ({required Object minutes}) => '${minutes} min',
			'queue.inShop' => ({required Object price}) => '${price} in negozio',
			'queue.feeHint' => ({required Object fee}) => 'Paghi ${fee} per il posto in coda. Il servizio lo paghi in negozio.',
			'queue.join' => 'Mettiti in coda',
			'queue.turnIn' => 'Tocca a te tra',
			'queue.about' => ({required Object range}) => 'circa ${range}',
			'queue.refundRule' => 'Se lasci la coda con almeno 3 persone davanti, ti rimborsiamo il costo del servizio.',
			'queue.graceRule' => 'Ti avvisiamo quando manca una persona e quando tocca a te: da quel momento hai 10 minuti per arrivare.',
			'queue.payAndJoin' => ({required Object fee}) => 'Paga ${fee} e mettiti in coda',
			'queue.placeAfterPayment' => 'Il posto è tuo appena il pagamento va a buon fine.',
			'queue.joiningTitle' => 'Ti stiamo mettendo in coda',
			'queue.joiningBody' => 'Il pagamento è andato a buon fine. Ci vuole qualche secondo.',
			'queue.inQueue' => 'Sei in coda',
			'queue.almost' => 'Quasi il tuo turno',
			'queue.position' => ({required Object n}) => '${n}°',
			'queue.inLine' => 'in coda',
			'queue.ahead' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, one: '1 persona prima di te', other: '${n} persone prima di te', ), 
			'queue.next' => 'Sei il prossimo',
			'queue.waitAnywhere' => 'Puoi aspettare dove vuoi: ti avvisiamo quando manca una persona.',
			'queue.leaveRefund' => 'Hai almeno 3 persone davanti: se lasci ora, ti rimborsiamo il costo del servizio.',
			'queue.leaveNoRefund' => 'Hai meno di 3 persone davanti: se lasci ora, il costo del servizio non ti viene rimborsato.',
			'queue.leave' => 'Lascia la coda',
			'queue.turnTitle' => 'È il tuo turno',
			'queue.turnBody' => 'Il barbiere ti sta aspettando. Hai 10 minuti per arrivare.',
			'queue.turnLeft' => 'per arrivare',
			'queue.turnLate' => 'Dopo 10 minuti il barbiere può segnarti come non presentato: in quel caso il costo del servizio non viene rimborsato.',
			'queue.servingTitle' => 'Sei in poltrona',
			'queue.servingBody' => 'Il servizio è iniziato. Lo paghi in negozio, come sempre.',
			'queue.leaveSheet.title' => 'Lasciare la coda?',
			'queue.leaveSheet.body' => ({required Object shop}) => 'Perdi il tuo posto da ${shop}. Se cambi idea dovrai rimetterti in fondo alla coda.',
			'queue.leaveSheet.refund' => ({required Object fee}) => 'Ti rimborsiamo ${fee} entro 5–10 giorni lavorativi.',
			'queue.leaveSheet.noRefund' => ({required Object fee}) => 'Manca poco al tuo turno: se lasci ora, ${fee} non ti viene rimborsato.',
			'queue.leaveSheet.confirm' => 'Sì, lascia la coda',
			'queue.leaveSheet.confirmNoRefund' => 'Lascia comunque',
			'queue.leaveSheet.stay' => 'Resta in coda',
			'queue.leftTitle' => 'Hai lasciato la coda',
			'queue.leftRefunded' => ({required Object fee}) => 'Ti rimborsiamo ${fee} entro 5–10 giorni lavorativi.',
			'queue.leftKept' => 'Il costo del servizio non è stato rimborsato.',
			'queue.endedTitle' => 'Non sei più in coda',
			'queue.endedBody' => 'Se il barbiere ti ha tolto dalla coda o ha chiuso per oggi, ti rimborsiamo il costo del servizio.',
			'queue.declinedTitle' => 'Pagamento non riuscito',
			'queue.declinedBody' => 'La carta è stata rifiutata. Non ti abbiamo addebitato nulla.',
			'queue.retry' => 'Riprova',
			'queue.giveUp' => 'Lascia perdere',
			'queue.done' => 'Fatto',
			'queue.homeTitle' => 'Sei in coda',
			'queue.homePaid' => 'Pagato',
			'queue.seeQueue' => 'Vedi la coda',
			'queue.owner.walkInFab' => 'Senza app',
			'queue.owner.nobodyWaiting' => 'Nessuno in attesa. Goditi il caffè.',
			'queue.owner.reopen' => 'Riapri',
			'queue.owner.minutesLeft' => ({required Object minutes}) => '${minutes} min rimasti',
			'queue.owner.doneWith' => ({required Object name}) => 'Fine con ${name}',
			'queue.owner.calledName' => ({required Object name}) => 'Chiamato ${name}',
			'queue.owner.waitingFor' => ({required Object minutes}) => 'Attesa ${minutes} min',
			'queue.owner.theyreHere' => 'È arrivato, inizia',
			'queue.owner.noShowIn' => ({required Object time}) => 'Assente tra ${time}',
			'queue.owner.chair' => 'Poltrona',
			'queue.owner.freeNow' => 'Libero ora',
			'queue.owner.nobodyToCall' => 'Nessuno in attesa',
			'queue.owner.kindApp' => 'App',
			'queue.owner.kindWalkIn' => 'Senza app',
			'queue.owner.removeFromLine' => 'Togli dalla coda',
			'queue.owner.rowNoteApp' => 'Togliere qualcuno rimborsa sempre la sua commissione.',
			'queue.owner.rowNoteWalkIn' => 'Chi entra senza app non ha pagato nulla.',
			'queue.owner.title' => 'Coda di oggi',
			'queue.owner.summary' => ({required Object waiting, required Object until}) => '${waiting} in attesa · la coda finisce verso le ${until}',
			'queue.owner.summaryEmpty' => 'Nessuno in attesa',
			'queue.owner.pause' => 'Pausa',
			'queue.owner.resume' => 'Riprendi',
			'queue.owner.closeToday' => 'Chiudi per oggi',
			'queue.owner.inChair' => 'In poltrona',
			'queue.owner.called' => 'Chiamata',
			'queue.owner.waiting' => 'In attesa',
			'queue.owner.since' => ({required Object minutes}) => 'da ${minutes} min',
			'queue.owner.calledAt' => ({required Object time}) => 'chiamata alle ${time}',
			'queue.owner.queuedAt' => ({required Object time}) => 'in coda dalle ${time}',
			'queue.owner.graceLeft' => ({required Object minutes}) => 'ha ancora ${minutes} min',
			'queue.owner.done' => 'Fatto',
			'queue.owner.start' => 'Inizia',
			'queue.owner.noShow' => 'Non presentato',
			'queue.owner.noShowFrom' => ({required Object time}) => 'Non presentato · dalle ${time}',
			'queue.owner.walkInName' => 'Walk-in',
			'queue.owner.remove' => ({required Object name}) => 'Rimuovi ${name} dalla coda',
			'queue.owner.callNext' => 'Chiama il prossimo',
			'queue.owner.addWalkIn' => 'Walk-in',
			'queue.owner.emptyTitle' => 'Nessuno in coda',
			'queue.owner.emptyBody' => 'Quando un cliente si mette in coda dall\'app lo vedi qui. Chi entra senza app lo aggiungi con Walk-in.',
			'queue.owner.removeSheet.title' => ({required Object name}) => 'Rimuovere ${name}?',
			'queue.owner.removeSheet.body' => 'Esce dalla coda e gli rimborsiamo il costo del servizio.',
			'queue.owner.removeSheet.confirm' => 'Rimuovi dalla coda',
			'queue.owner.removeSheet.keep' => 'Annulla',
			'queue.owner.walkInSheet.title' => 'Aggiungi un walk-in',
			'queue.owner.walkInSheet.body' => 'Per chi è entrato senza l\'app. Va in fondo alla coda, così l\'attesa resta giusta per tutti.',
			'queue.owner.walkInSheet.service' => 'Servizio',
			'queue.owner.walkInSheet.name' => 'Nome (facoltativo)',
			'queue.owner.walkInSheet.nameHint' => 'Es. Andrea',
			'queue.owner.walkInSheet.add' => 'Aggiungi alla coda',
			'queue.owner.walkInSheet.cancel' => 'Annulla',
			'queue.mode.row' => 'Come lavori',
			'queue.mode.booking' => 'Su appuntamento',
			'queue.mode.queue' => 'Coda',
			'queue.mode.both' => 'Entrambi',
			'queue.mode.title' => 'Come lavori',
			'queue.mode.lead' => 'Scegli come i clienti arrivano da te. Puoi cambiare quando vuoi.',
			'queue.mode.bookingBody' => 'I clienti scelgono giorno e ora dall\'app. Adatto se lavori su agenda.',
			'queue.mode.queueBody' => 'I clienti vedono quante persone aspettano e si mettono in fila dall\'app. Adatto se lavori senza appuntamento.',
			'queue.mode.blocked' => 'Non puoi cambiare adesso. Puoi smettere di prendere prenotazioni quando non ne hai più di future, e chiudere la coda quando è vuota.',
			'queue.mode.bothBody' => 'I clienti scelgono se prenotare un orario o mettersi in coda. Gli orari prenotati restano fissi e la coda si adatta.',
			'queue.mode.save' => 'Salva',
			'queue.mode.saved' => 'Modalità aggiornata',
			'categories.barber' => 'Barbiere',
			'categories.salon' => 'Parrucchiere',
			'categories.nails' => 'Unghie',
			'categories.beauty' => 'Bellezza',
			'categories.spa' => 'Spa',
			'categories.lashes' => 'Ciglia',
			'categories.tattoo' => 'Tatuaggi',
			'categories.makeup' => 'Trucco',
			'categories.kids' => 'Taglio bimbi',
			'categories.more' => 'Altro',
			'search.recent' => 'Recenti',
			'search.allShops' => 'Tutti i negozi',
			'search.title' => 'Cerca',
			'search.hint' => 'Cerca per nome',
			'search.noResults' => 'Nessun negozio trovato.',
			'search.categoryNotice' => ({required Object category}) => 'I negozi non sono ancora divisi per categoria, quindi vedi tutti i negozi, non solo ${category}.',
			'live.overlineBooked' => 'Prenotato',
			'live.freeUntil' => ({required Object when}) => 'Annulli gratis fino a ${when}',
			'live.cancelBooking' => 'Annulla prenotazione',
			'live.cancelTitle' => 'Annullare questa prenotazione?',
			'live.keepBooking' => 'Tieni la prenotazione',
			'live.yesCancel' => 'Sì, annulla',
			'live.refundYes2' => ({required Object fee}) => 'La commissione di ${fee} ti viene rimborsata.',
			'live.refundNo2' => ({required Object fee}) => 'Mancano meno di 2 ore, quindi la commissione di ${fee} non è rimborsata.',
			'live.cancelledRefunded' => ({required Object fee}) => 'Prenotazione annullata. ${fee} rimborsati.',
			'live.cancelledNoRefund' => 'Prenotazione annullata.',
			'live.cancelFailed' => 'Annullamento non riuscito. La prenotazione resta valida.',
			'live.overline' => 'In coda',
			'live.headInAt' => ({required Object shop}) => 'Vai ora · ${shop}',
			'live.chair' => 'Poltrona',
			'live.directions' => 'Indicazioni',
			'live.inChair' => 'Sei in poltrona',
			'live.headIn' => 'Entra adesso. Ti tengono il posto per 10 minuti.',
			'live.leave' => 'Lascia la coda',
			'live.leaveTitle' => 'Lasciare la coda?',
			'live.refundYes' => 'Ti rimborsiamo il costo del servizio.',
			'live.refundNo' => 'Con meno di 3 persone davanti, il costo del servizio non viene rimborsato.',
			'live.keep' => 'Tieni il posto',
			'live.leaveConfirm' => 'Sì, lascia',
			'live.leftRefunded' => 'Hai lasciato la coda. Costo rimborsato.',
			'live.leftNoRefund' => 'Hai lasciato la coda.',
			'live.leaveFailed' => 'Non siamo riusciti a toglierti dalla coda. Hai ancora il tuo posto.',
			'guest.ownerSheetTitle' => 'Accedi al tuo negozio',
			'guest.ownerCustomerAccount' => 'Hai effettuato l\'accesso, ma questo account è già un account cliente, quindi non può essere usato per un negozio.',
			'guest.title' => 'Salta l\'attesa, tieni il posto',
			'guest.body' => 'Un tocco con l\'account che hai già. Nuovo o no, sono gli stessi due pulsanti.',
			'guest.activityTitle' => 'Le tue visite stanno qui',
			'guest.activityBody' => 'Accedi per seguire il tuo posto in coda e tenere insieme le prenotazioni.',
			'guest.signIn' => 'Accedi',
			'guest.signInTitle' => 'Accedi a BookNow',
			'guest.light' => 'Chiaro',
			'guest.dark' => 'Scuro',
			'guest.system' => 'Auto',
			'guest.ownerTitle' => 'Hai un negozio?',
			'guest.ownerBody' => 'Accedi, o configuralo in pochi minuti.',
			'guest.gateBook' => 'Accedi per prenotare questo orario',
			'guest.gateJoin' => 'Accedi per metterti in coda',
			'guest.gateBody' => ({required Object what}) => '${what}. La tua scelta resta, basta un tocco.',
			'welcome.title' => 'Come deve chiamarti il negozio?',
			'welcome.nameLabel' => 'Il tuo nome',
			'welcome.body' => 'Lo vedono solo i negozi dove vai. Puoi cambiarlo dopo.',
			'welcome.cta' => 'Continua',
			'shopScreen.closedDay' => ({required Object day}) => 'Chiuso ${day}. Scegli un altro giorno.',
			'shopScreen.noTimes' => 'Nessun orario libero in questo giorno. Scegline un altro.',
			'shopScreen.joinNow' => ({required Object service}) => '${service} · entra ora',
			'shopScreen.paying' => 'Pagamento in corso',
			'shopScreen.tryAgain' => 'Riprova',
			'shopScreen.payFee' => ({required Object fee}) => 'Paga ${fee}',
			'shopScreen.placedAt' => ({required Object shop}) => '${shop} · ti avvisiamo quando tocca a te',
			'shopScreen.previewTitle' => 'Anteprima',
			'shopScreen.previewBody' => 'Questo è ciò che vedono i clienti.',
			'shopScreen.whatLike' => 'Cosa desideri?',
			'shopScreen.when' => 'Quando?',
			'shopScreen.sumPick' => 'Scegli un orario per continuare',
			'shopScreen.sumShop' => ({required Object price}) => '${price} in negozio',
			'shopScreen.sumShopFee' => ({required Object price, required Object fee}) => '${price} in negozio · ${fee} ora',
			'shopScreen.continue_' => 'Continua',
			'shopScreen.bookTitle' => ({required Object when}) => 'Prenotare ${when}?',
			'shopScreen.joinTitle' => ({required Object shop}) => 'Metterti in coda da ${shop}?',
			'shopScreen.feeLabel' => 'Costo BookNow',
			'shopScreen.feeWhen' => 'Lo paghi ora',
			'shopScreen.serviceWhen' => 'Lo paghi al negozio',
			'shopScreen.noFee' => 'Prenotazione gratuita',
			'shopScreen.confirmFree' => 'Conferma la prenotazione',
			'shopScreen.heldFor' => ({required Object time}) => 'Tenuto per te per ${time}',
			'shopScreen.declined' => 'La carta è stata rifiutata. Non ti abbiamo addebitato nulla.',
			'shopScreen.placed' => 'Sei in coda',
			'shopScreen.placedBody' => 'Ti avvisiamo quando tocca a te.',
			'today.untilTime' => ({required Object time}) => 'fino alle ${time}',
			'today.bookedTag' => 'Prenotato',
			'today.queueLine' => ({required Object n, required Object time}) => '${n} in attesa · fino alle ${time} circa',
			'today.nowLabel' => 'Adesso',
			'today.nextLabel' => 'Prossimo',
			'today.comingUp' => 'In arrivo',
			'today.details' => 'Dettagli',
			'today.callName' => ({required Object name}) => 'Chiama ${name}',
			'today.nothingLeftTitle' => 'Nient\'altro prenotato oggi',
			'today.nothingLeftBody' => 'Il tempo libero resta aperto ai clienti.',
			'today.markedArrived' => ({required Object name}) => '${name} segnato come arrivato',
			'today.markedNoShow' => ({required Object name}) => '${name} segnato come assente',
			'today.noShowTitle' => ({required Object name}) => 'Segnare ${name} come assente?',
			'today.noShowBody' => 'Non si può annullare.',
			'today.cancelTitle' => ({required Object name}) => 'Annullare la prenotazione di ${name}?',
			'today.cancelBody' => 'Il cliente viene avvisato e l\'orario torna libero.',
			'today.cancelled' => 'Prenotazione annullata',
			'today.stateTitle' => 'Com\'è la coda oggi?',
			'today.stateOpenTitle' => 'Aperta',
			'today.stateOpenBody' => 'Ci si può mettere in coda dall\'app.',
			'today.statePauseBody' => 'Nessun nuovo ingresso. Chi è in coda resta.',
			'today.stateCloseBody' => ({required Object n}) => 'Nessun nuovo ingresso. Servi ancora i ${n} in coda, e chi non viene servito è rimborsato.',
			'today.pausedBanner' => 'In pausa. Nessun nuovo ingresso.',
			'today.closedBanner' => 'Chiusa per oggi. Finisci con chi è in coda.',
			'today.wayLine' => 'Coda',
			'today.wayBookings' => 'Prenotazioni',
			'today.calendarTitle' => 'Calendario',
			'today.calendarQueueTitle' => 'Il tuo negozio lavora con la coda',
			'today.calendarQueueBody' => 'I clienti si mettono in coda invece di prenotare un orario, quindi qui non c\'è nulla da pianificare. Gestisci la coda da Oggi.',
			'today.calendarQueueCta' => 'Cambia come lavori',
			'homeWidgets.inLine' => 'In coda',
			'homeWidgets.nextVisit' => 'Prossima visita',
			'homeWidgets.bookAgain' => 'Prenota di nuovo',
			'homeWidgets.findTitle' => 'Trova un negozio',
			'homeWidgets.findLine' => 'Prenota un orario o mettiti in coda',
			'homeWidgets.directions' => 'Indicazioni',
			'homeWidgets.headIn' => 'Entra entro 10 min',
			'homeWidgets.ahead' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('it'))(n, zero: 'Sei il prossimo', one: '${n} persona davanti', other: '${n} persone davanti', ), 
			'homeWidgets.waiting' => 'in attesa',
			'homeWidgets.waitingCount' => ({required Object n}) => '${n} in attesa',
			'homeWidgets.nobodyWaiting' => 'Nessuno in attesa',
			'homeWidgets.nextUp' => 'Prossimo',
			'homeWidgets.calledLine' => 'Chiamato, sta arrivando',
			'homeWidgets.nextAppointment' => 'Prossimo appuntamento',
			'homeWidgets.nothingLeft' => 'Nient\'altro oggi',
			'homeWidgets.moreToday' => ({required Object n}) => 'altri ${n} oggi',
			'homeWidgets.openToday' => 'Apri oggi',
			'homeWidgets.staleQueue' => 'Apri BookNow per controllare il tuo posto',
			'homeWidgets.staleBooking' => 'Apri BookNow per la prossima visita',
			'homeWidgets.staleOwner' => 'Apri BookNow per vedere oggi',
			_ => null,
		};
	}
}
