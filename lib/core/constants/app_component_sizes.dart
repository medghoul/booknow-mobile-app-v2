/// Fixed component dimensions that fall between the spacing steps.
///
/// Anything that maps onto `context.spacing`, `context.radii` or
/// `context.icons` belongs there instead; this file is for the sizes those
/// scales genuinely have no step for.
abstract final class AppComponentSizes {
  // ─── Progress indicator ─────────────────────────────────────────────────────
  static const double progressIndicatorStrokeWidth = 2.5;

  // ─── Buttons ────────────────────────────────────────────────────────────────
  static const double buttonNormalHeight = 52.0;

  /// Outlined controls carry a 1.5px edge in the design — a hairline
  /// is too faint on a white surface.
  static const double outlinedButtonBorderWidth = 1.0;

  /// Text fields match the height of the buttons they sit above.
  static const double fieldHeight = 50.0;

  /// A disabled control keeps its colour and loses its weight.
  static const double disabledOpacity = 0.4;

  /// How far a button shrinks while it is held down.
  ///
  /// Small on purpose: the ripple is still the primary press signal and this
  /// sits under it. On a full-width action 0.97 is a few pixels of inset —
  /// enough to feel the tap land, not enough to look rubbery.
  static const double pressedScale = 0.97;
  static const double buttonSmallHeight = 40.0;
  static const double buttonNormalMinWidth = 160.0;
  static const double buttonSmallMinWidth = 100.0;
  static const double buttonMaxWidth = 400.0;
  static const double buttonProgressIndicatorRatio = 0.45;

  // ─── Sheets ─────────────────────────────────────────────────────────────────
  /// Status chips: roomier than a stock Material chip, and never uppercase —
  /// the word is one of the three signals the status carries.
  static const double statusBadgeHorizontalPadding = 14.0;
  static const double statusBadgeVerticalPadding = 7.0;

  /// The filled circular icon button — the back control on the auth screens.
  /// 44pt is both the design's size and the minimum touch target.
  static const double filledIconButtonSize = 44.0;

  static const double dragHandleWidth = 36.0;
  static const double dragHandleHeight = 4.0;

  // ─── List rows ──────────────────────────────────────────────────────────────
  static const double listRowVerticalPadding = 12.0;
  static const double listRowIconContainerSize = 40.0;
  static const double listRowIconContainerSizeLG = 44.0;
  static const double listRowIconContainerRadius = 10.0;

  // ─── Slot picker ────────────────────────────────────────────────────────────
  /// One slot chip in the availability grid.
  static const double slotChipHeight = 50.0;

  /// One day cell in the horizontal day strip.
  static const double dayCellWidth = 56.0;
  static const double dayCellHeight = 58.0;

  /// The date strip's cells are softened rectangles, not pills.
  static const double dayCellRadius = 12.0;

  /// The map placeholder, which has to reserve the height the real map will
  /// take so the step does not jump when an address is picked.
  static const double mapPreviewHeight = 180.0;

  // ─── Owner agenda ───────────────────────────────────────────────────────────
  /// The time column beside the timeline. Wide enough for `09:00` at the
  /// display weight, and fixed so every row's card starts on the same line —
  /// the whole point of putting the time outside the card is that the eye can
  /// run straight down the column.
  static const double agendaTimeColumnWidth = 50.0;

  /// A timeline row, and the date strip's cards: the same softened rectangle
  /// as the slot picker's day cells.
  static const double agendaRowRadius = 16.0;

  /// A row's height follows the service's duration, so 15, 30 and 45 minutes
  /// read differently without reading a number. These two put the design's
  /// 44px at 15 minutes and 60px at 30 on a line: 15 min → 44, 30 → 60,
  /// 45 → 76, an hour → 92.
  ///
  /// A *minimum*, not a height: the current row carries an extra line and
  /// grows past it, which is also why the design's 45-minute sample measures
  /// 86 rather than the 76 here.
  static const double agendaRowMinHeight = 44.0;
  static const double agendaRowHeightPerMinute = 16.0 / 15.0;

  /// Past the hour the scale stops, so a three-hour block or a free morning
  /// is a row and not a screenful.
  static const double agendaRowScaleCapMinutes = 60.0;

  /// The outline on the row happening now. Two pixels, not a shadow: it has
  /// to be findable at a glance from across the shop.
  static const double agendaCurrentRowBorderWidth = 2.0;

  /// A row that is over. Faded rather than hidden — the owner still reads
  /// down the whole day.
  static const double agendaPastRowOpacity = 0.6;

  /// One date-strip card. Narrower than [dayCellWidth]: this one carries a
  /// third line, the day's booking count.
  static const double agendaStripCardWidth = 52.0;

  // ─── Empty / error states ───────────────────────────────────────────────────
  static const double emptyStateIconContainerSize = 120.0;
  static const double emptyStateIconContainerRadius = 28.0;

  // ─── Settings rows and cards ────────────────────────────────────────────────

  /// The leading thumbnail on the shop row — a photo, or the dashed
  /// placeholder when the shop has none yet.
  static const double settingsThumbSize = 52.0;
  static const double settingsThumbBorderWidth = 1.5;

  /// The round avatar in the profile header, which doubles as the way into
  /// personal data.
  static const double profileAvatarSize = 56.0;

  /// The same disc on the personal-data screen, where it is the subject
  /// rather than a corner of the header.
  static const double profileAvatarLargeSize = 88.0;

  /// The pencil badge on the header avatar, which is the owner's only visible
  /// way in.
  static const double profileAvatarBadgeSize = 20.0;

  // ─── Segmented control ──────────────────────────────────────────────────────
  /// One segment's minimum height. Below the platform touch target the
  /// control still works with a mouse and stops working with a thumb.
  static const double segmentMinHeight = 44.0;

  /// The count badge riding next to a segment's label. A circle at one digit,
  /// a pill from two — hence a minimum width rather than a square.
  static const double segmentBadgeSize = 20.0;

  // ─── Choice chips ───────────────────────────────────────────────────────────
  /// A chip the user picks from a short set — a support topic, a filter.
  /// 44pt because it is a control, not a label.
  static const double chipMinHeight = 44.0;

  /// An unselected chip is outlined as well as filled: on the recessed
  /// surface, fill alone leaves it invisible.
  static const double chipBorderWidth = 1.5;

  // ─── Notification rows ──────────────────────────────────────────────────────
  /// A notification row carries two lines and a switch, so it is taller than
  /// a settings row.
  static const double notificationRowMinHeight = 62.0;

  // ─── Switch ─────────────────────────────────────────────────────────────────
  /// The track and thumb, straight from the design. Material's own switch is
  /// a different anatomy — its off-thumb shrinks — so [AppSwitch] draws these
  /// rather than theming around it.
  static const double switchTrackWidth = 50.0;
  static const double switchTrackHeight = 30.0;
  static const double switchThumbSize = 24.0;
  static const double switchTrackPadding = 3.0;
  static const double switchBorderWidth = 1.5;

  /// The off thumb is the muted ink rather than a colour of its own, dimmed
  /// so the track reads as empty at a glance.
  static const double switchOffThumbOpacity = 0.55;

  // ─── Bottom navigation ──────────────────────────────────────────────────────
  /// One tab's minimum height, from the design. Comfortably past the 44pt
  /// touch target both platforms ask for, and it is a *minimum* so a label
  /// that wraps at a large system text size grows the bar instead of
  /// overflowing it.
  static const double bottomNavItemMinHeight = 52.0;

  // ─── Hairlines ──────────────────────────────────────────────────────────────
  /// A one-pixel rule: under the bottom bar, between settings rows.
  ///
  /// Not on a scale and should not be — it is one device pixel's worth of
  /// line, and scaling it with the layout turns a hairline into a border.
  static const double hairline = 1.0;

  // ─── Customer home and booking ──────────────────────────────────────────────
  /// A free-time card: wide enough for a time, a shop name and a price.
  static const double slotCardWidth = 148.0;

  /// A shop card, wide enough for a washed photo above three lines.
  static const double shopCardWidth = 256.0;
  static const double shopCardPhotoHeight = 136.0;

  /// The carousel's position dots, and the stretched one for the current page.
  static const double carouselDotSize = 7.0;
  static const double carouselDotActiveWidth = 20.0;

  /// A time in the booking flow's grid, four to a row.
  static const double slotTileMinHeight = 50.0;
  static const double slotTileRadius = 18.0;
  static const double slotTileBorderWidth = 1.5;

  /// A day in the flow's date strip.
  static const double flowDayWidth = 54.0;
  static const double flowDayRadius = 20.0;

  /// The three-step progress bar above the flow.
  static const double stepBarHeight = 4.0;
  static const double stepBarWidth = 18.0;

  /// A past booking faded behind the sheet that is asking about it.
  static const double pastSlotOpacity = 0.45;

  // ─── Identity provider buttons ──────────────────────────────────────────────
  static const double providerButtonHeight = 52.0;
  static const double providerButtonBorderWidth = 1.0;
}
