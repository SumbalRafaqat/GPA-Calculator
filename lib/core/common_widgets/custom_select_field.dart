import 'package:flutter/material.dart';
import 'package:gpa_calculator/core/constants/app_dimensions.dart';
import 'package:gpa_calculator/core/theme/app_colors.dart';
import 'package:gpa_calculator/core/theme/app_text_styles.dart';


/// Dropdown-style select field matching the Figma "Department" / "Semester"
/// picker:
///  - Persistent small caption above the field ("— Department —").
///  - Collapsed: grey-bordered pill, value/hint + chevron-down.
///  - Expanded: options list unfolds ABOVE the field in a light-grey rounded
///    panel (radio circles, selected row bold blue), field border turns
///    blue, chevron flips up.
class CustomSelectField<T> extends StatefulWidget {
  final String label;
  final String hint;
  final T? value;
  final List<T> options;
  final String Function(T) labelBuilder;
  final ValueChanged<T> onSelected;

  const CustomSelectField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.options,
    required this.labelBuilder,
    required this.onSelected,
  });

  @override
  State<CustomSelectField<T>> createState() => _CustomSelectFieldState<T>();
}

class _CustomSelectFieldState<T> extends State<CustomSelectField<T>> {
  bool _expanded = false;

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final hasValue = widget.value != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _captionRow(),
        const SizedBox(height: 4),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 180),
          crossFadeState: _expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: _optionsPanel(),
          secondChild: const SizedBox.shrink(),
        ),
        GestureDetector(
          onTap: _toggle,
          child: Container(
            height: AppDimensions.fieldHeight,
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
              border: Border.all(
                color: _expanded ? AppColors.primary : AppColors.cardBorder,
                width: _expanded ? AppDimensions.borderWidthSelected : AppDimensions.borderWidth,
              ),
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    hasValue ? widget.labelBuilder(widget.value as T) : widget.hint,
                    style: hasValue
                        ? AppTextStyles.bodyBold.copyWith(color: AppColors.primary)
                        : AppTextStyles.fieldHint,
                  ),
                ),
                Icon(
                  _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _captionRow() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.cardBorder)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(widget.label, style: AppTextStyles.captionSmall.copyWith(color: AppColors.primary)),
        ),
        Expanded(child: Container(height: 1, color: AppColors.cardBorder)),
      ],
    );
  }

  Widget _optionsPanel() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceS),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spaceM, vertical: AppDimensions.spaceXS),
      decoration: BoxDecoration(
        color: const Color(0xFFDCDCDC),
        borderRadius: BorderRadius.circular(AppDimensions.radiusCard),
      ),
      child: Column(
        children: widget.options.map((opt) {
          final selected = opt == widget.value;
          return InkWell(
            onTap: () {
              widget.onSelected(opt);
              setState(() => _expanded = false);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.labelBuilder(opt),
                    style: selected
                        ? AppTextStyles.bodyBold.copyWith(color: AppColors.primary, fontSize: 15)
                        : AppTextStyles.body.copyWith(fontSize: 15),
                  ),
                  Icon(
                    selected ? Icons.radio_button_checked : Icons.radio_button_off,
                    color: selected ? AppColors.primary : AppColors.textHint,
                    size: AppDimensions.iconM,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}