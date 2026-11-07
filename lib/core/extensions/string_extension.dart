extension StringExtension on String {
  String toCapitalized() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Initials for an avatar placeholder: "Marco Rossi" → "MR".
  String toInitials({int max = 2}) {
    final parts = trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '';
    return parts.take(max).map((p) => p[0].toUpperCase()).join();
  }
}
