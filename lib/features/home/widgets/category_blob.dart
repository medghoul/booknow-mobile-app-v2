import 'package:booknow_mobile/localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// What a customer can look for.
///
/// Local to the app for now: the API has no category on a shop yet, so picking
/// one names the search rather than narrowing it. See `ShopSearchPage`.
enum ShopCategory {
  barber('barber'),
  salon('salon'),
  nails('nails'),
  beauty('beauty'),
  spa('spa'),
  lashes('lashes'),
  tattoo('tattoo'),
  makeup('makeup'),
  kids('kids'),
  more('more');

  const ShopCategory(this.asset);

  final String asset;

  String get assetPath => 'assets/categories/$asset.svg';

  String label(Translations t) => switch (this) {
    ShopCategory.barber => t.categories.barber,
    ShopCategory.salon => t.categories.salon,
    ShopCategory.nails => t.categories.nails,
    ShopCategory.beauty => t.categories.beauty,
    ShopCategory.spa => t.categories.spa,
    ShopCategory.lashes => t.categories.lashes,
    ShopCategory.tattoo => t.categories.tattoo,
    ShopCategory.makeup => t.categories.makeup,
    ShopCategory.kids => t.categories.kids,
    ShopCategory.more => t.categories.more,
  };
}

/// The five organic shapes, as CSS `border-radius` percentages: horizontal
/// top-left, top-right, bottom-right, bottom-left, then the same four vertical.
const List<List<double>> _shapes = [
  [62, 38, 54, 46, 48, 58, 42, 52],
  [44, 56, 40, 60, 58, 44, 56, 42],
  [56, 44, 62, 38, 42, 52, 48, 58],
  [40, 60, 48, 52, 54, 40, 60, 46],
  [58, 42, 44, 56, 46, 62, 38, 54],
];

/// The irregular corners for one category at a given size. Never a perfect
/// circle, and the shapes repeat in category order so neighbours differ.
BorderRadius blobRadius(ShopCategory category, double width, double height) =>
    blobRadiusAt(category.index, width, height);

/// The same corners by place in a row.
BorderRadius blobRadiusAt(int index, double width, double height) {
  final s = _shapes[index % _shapes.length];
  Radius corner(int i) =>
      Radius.elliptical(width * s[i] / 100, height * s[i + 4] / 100);

  return BorderRadius.only(
    topLeft: corner(0),
    topRight: corner(1),
    bottomRight: corner(2),
    bottomLeft: corner(3),
  );
}

/// A category's clay picture inside its organic blob.
///
/// Only the picture: labels and tap handling belong to whatever holds it, since
/// the three places this appears label it differently.
class CategoryBlob extends StatelessWidget {
  const CategoryBlob({
    super.key,
    required this.category,
    required this.width,
    required this.height,
    required this.pictureSize,
    required this.color,
    this.shadows,
  });

  final ShopCategory category;
  final double width;
  final double height;
  final double pictureSize;
  final Color color;

  /// The drop shadow on the band, or the ring of a selected blob.
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: blobRadius(category, width, height),
        boxShadow: shadows,
      ),
      child: CategoryPicture(category: category, size: pictureSize),
    );
  }
}

/// The clay picture on its own, decorative to a screen reader: whatever holds
/// it carries the name.
class CategoryPicture extends StatelessWidget {
  const CategoryPicture({
    super.key,
    required this.category,
    required this.size,
  });

  final ShopCategory category;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      category.assetPath,
      width: size,
      height: size,
      excludeFromSemantics: true,
    );
  }
}
