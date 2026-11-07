import 'package:booknow_mobile/core/extensions/context_extension.dart';
import 'package:booknow_mobile/widgets/form/app_text_field.dart';
import 'package:booknow_mobile/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:responsive_layout_kit/responsive_layout_kit.dart';

/// A search input with a clear affordance.
///
/// The clear button appears only once there is something to clear, so the
/// field doesn't carry a dead control in its resting state.
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.clearTooltip,
    this.controller,
    this.autofocus = false,
  });

  final String hint;
  final ValueChanged<String> onChanged;

  /// Accessible name for the clear button.
  final String clearTooltip;

  final TextEditingController? controller;
  final bool autofocus;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();
  late final bool _ownsController = widget.controller == null;

  @override
  void dispose() {
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    widget.onChanged(value);
    setState(() {});
  }

  void _clear() {
    _controller.clear();
    _handleChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      hint: widget.hint,
      autofocus: widget.autofocus,
      onChanged: _handleChanged,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      prefixIcon: Icons.search,
      suffix: _controller.text.isEmpty
          ? null
          : AppIconButton(
              icon: Icons.close,
              size: context.icons.s.w,
              tooltip: widget.clearTooltip,
              onPressed: _clear,
            ),
    );
  }
}
