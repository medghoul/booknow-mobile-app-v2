/// The days of the week, keyed as the API writes them.
///
/// Monday first, because that is how an Italian week reads and how the hours
/// editor is laid out in the design.
enum Weekday {
  monday('mon'),
  tuesday('tue'),
  wednesday('wed'),
  thursday('thu'),
  friday('fri'),
  saturday('sat'),
  sunday('sun');

  const Weekday(this.wireName);

  final String wireName;

  /// `DateTime.monday` is 1 and this enum starts at 0, so the two have to be
  /// mapped rather than indexed directly.
  static Weekday fromDateTime(DateTime date) =>
      Weekday.values[date.weekday - 1];

  static Weekday? fromWire(String value) {
    for (final day in Weekday.values) {
      if (day.wireName == value) return day;
    }
    return null;
  }
}
