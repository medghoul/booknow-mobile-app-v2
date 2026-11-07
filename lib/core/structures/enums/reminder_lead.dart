/// How long before an appointment the reminder goes out.
///
/// A closed set rather than a free number: the three the design offers are the
/// ones that mean something — leave now, plan your afternoon, plan your day —
/// and a picker that offers 37 minutes invites a choice nobody wants to make.
enum ReminderLead {
  oneHour('1h'),
  twoHours('2h'),
  oneDay('1d');

  const ReminderLead(this.wireName);

  /// What the API calls it: `reminder.offset`, one of `1h`, `2h`, `1d`.
  ///
  /// The duration, not a count of minutes. The server turns it into a time by
  /// subtracting it from the appointment, and the three it accepts are an
  /// enum of its own — so sending `120` would be a number it has no field for.
  final String wireName;

  /// The server's value, or the default when it is one this build does not
  /// know — a fourth offset added by a newer API must not empty the screen.
  static ReminderLead fromWire(Object? value) => ReminderLead.values.firstWhere(
    (lead) => lead.wireName == value,
    orElse: () => ReminderLead.twoHours,
  );
}
