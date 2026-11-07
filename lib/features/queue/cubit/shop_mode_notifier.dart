import 'package:booknow_mobile/core/structures/enums/queue_enums.dart';
import 'package:flutter/foundation.dart';

/// The owner's shop mode, shared by the "Come lavori" setting and the first
/// owner tab.
///
/// The tabs keep their state while the owner moves between them, so without
/// this a switch to the queue would only show on the next launch. Null until
/// the shop has been read once.
class ShopModeNotifier extends ValueNotifier<ShopMode?> {
  ShopModeNotifier() : super(null);
}
