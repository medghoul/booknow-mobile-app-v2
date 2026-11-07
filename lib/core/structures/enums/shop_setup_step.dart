/// The owner's shop wizard, one topic per step.
///
/// The order is the order of the design's board, and `index` is what decides
/// where an interrupted wizard resumes — see `ShopSetupProgress`.
enum ShopSetupStep {
  /// Name, phone, optional photo.
  shop,

  /// Address, chosen from autocomplete so it is always geocoded.
  address,

  /// At least one service: name, duration, price.
  services,

  /// Weekly opening hours, and optional closures.
  hours,

  /// Read-only check, then publish.
  review;

  bool get isFirst => index == 0;

  bool get isLast => index == ShopSetupStep.values.length - 1;

  ShopSetupStep? get next => isLast ? null : ShopSetupStep.values[index + 1];

  ShopSetupStep? get previous =>
      isFirst ? null : ShopSetupStep.values[index - 1];

  /// 1-based, for the "2/4" counter.
  int get number => index + 1;

  /// The review is not a step the owner fills in — it is the check at the end,
  /// which is why the design's progress bar reads 4 and not 5, and why the
  /// review screen shows no bar at all.
  bool get isCounted => this != ShopSetupStep.review;

  static int get count =>
      ShopSetupStep.values.where((step) => step.isCounted).length;

  static List<ShopSetupStep> get counted =>
      ShopSetupStep.values.where((step) => step.isCounted).toList();
}
