/// Animation durations and delays, in milliseconds.
///
/// No `duration:` or `delay:` integer is written at a call site — reach for a
/// token here so motion stays consistent across the app.
abstract final class AppAnimations {
  // Durations (milliseconds)
  static const int durationXS = 300;
  static const int durationSM = 400;
  static const int durationMD = 500;
  static const int durationLG = 600;
  static const int durationXL = 800;
  static const int durationXXL = 1000;

  // Delays (milliseconds)

  static const int delayXS = 60;
  static const int delaySM = 120;
  static const int delayMD = 300;
  static const int delayLG = 600;
}
