// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String noItem(Object item) {
    return 'Keine $item.';
  }

  @override
  String itemInvalid(Object item) {
    return '$item ist ungültig.';
  }

  @override
  String shureDelete(Object item) {
    return 'Bist du dir sicher $item zu löschen?';
  }

  @override
  String get finishConfigurationAndWaitForMobile => 'Schließe Konfiguration ab und warte auf mobil';

  @override
  String get openSynchronizationOnMobile => 'Öffne Synchronisation auf mobil';

  @override
  String get mobileNotConnectedYet => 'Mobil noch nicht verbunden ...';

  @override
  String get mobileConnected => 'Mobil verbunden. Bereit zu synchronisieren!';

  @override
  String get deleteMissingEntries => 'Lösche fehlende Einträge?';

  @override
  String get mobileConnectedReadyToSynchronize => 'Mobil verbunden. Synchronisieren?';

  @override
  String get synchronizing => 'Synchronisiere ...';

  @override
  String get waitingForDesktop => 'Warte auf Desktop ...';

  @override
  String get synchronizationComplete => 'Synchronisation abgeschlossen!';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get add => 'Hinzufügen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get no => 'Nein';

  @override
  String get yes => 'Ja';

  @override
  String get okay => 'Okay';

  @override
  String get close => 'Schließen';

  @override
  String get delete => 'Löschen';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Einstellungen';

  @override
  String get category => 'Kategorie';

  @override
  String get categories => 'Kategorien';

  @override
  String get topic => 'Thema';

  @override
  String get topics => 'Themen';

  @override
  String get transaction => 'Transaktion';

  @override
  String get transactions => 'Transaktionen';

  @override
  String get repeated => 'Wiederholt';

  @override
  String get setup => 'Einrichtung';

  @override
  String get finish => 'Abschließen';

  @override
  String get name => 'Name';

  @override
  String get description => 'Beschreibung';

  @override
  String get active => 'Aktiv';

  @override
  String get inactive => 'Inaktiv';

  @override
  String get positive => 'Positiv';

  @override
  String get negative => 'Negativ';

  @override
  String get start => 'Start';

  @override
  String get end => 'Ende';

  @override
  String get date => 'Datum';

  @override
  String get interval => 'Intervall';

  @override
  String get count => 'Anzahl';

  @override
  String get unit => 'Einheit';

  @override
  String get compensation => 'Kompensation';

  @override
  String get compensations => 'Kompensationen';

  @override
  String get label => 'Bezeichnung';

  @override
  String get labels => 'Bezeichnungen';

  @override
  String get none => 'Nichts';

  @override
  String get manage => 'Verwalte';

  @override
  String get value => 'Wert';

  @override
  String get upcomingPayment => 'Anfallende Zahlung';

  @override
  String get next => 'Nächste';

  @override
  String get option => 'Option';

  @override
  String get from => 'Von';

  @override
  String get to => 'Bis';

  @override
  String get overview => 'Übersicht';

  @override
  String get expense => 'Ausgabe';

  @override
  String get income => 'Einnahme';

  @override
  String get total => 'Gesamt';

  @override
  String get user => 'Nutzer';

  @override
  String get summary => 'Zusammenfassung';

  @override
  String get loading => 'Lade ...';

  @override
  String get in_ => 'In';

  @override
  String get day => 'Tag';

  @override
  String get days => 'Tagen';

  @override
  String get desktop => 'Desktop';

  @override
  String get mobile => 'Mobil';

  @override
  String get synchronization => 'Synchronisation';
}
