/// Money is held in cents and only ever becomes a decimal for display.
///
/// Parsing and formatting live together so the two can't drift: a price typed
/// as "25,00" has to come back out as "€25,00".
abstract final class Money {
  /// Accepts both separators — an Italian keyboard gives a comma, a numeric
  /// one often gives a dot, and the owner should not have to care.
  static int parseToCents(String input) {
    final normalised = input.trim().replaceAll(',', '.');
    final euros = double.tryParse(normalised) ?? 0;
    return (euros * 100).round();
  }

  /// What a customer reads: whole euros go without the cents, so "€28" beside
  /// a fee of "€1,49".
  static String shortCents(int cents) =>
      cents % 100 == 0 ? '€${cents ~/ 100}' : formatCents(cents);

  static String formatCents(int cents) {
    final euros = (cents / 100).toStringAsFixed(2).replaceAll('.', ',');
    return '€$euros';
  }
}
