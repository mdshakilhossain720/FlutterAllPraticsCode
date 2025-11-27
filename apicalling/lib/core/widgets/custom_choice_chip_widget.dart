import 'package:apicalling/core/constants/app_colors.dart';
import 'package:apicalling/core/utils/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomChoiceChipWidget extends StatelessWidget {
  const CustomChoiceChipWidget({
    super.key,

    required this.isSelected,
    this.onSelected,
    required this.tag,
  });

  final bool isSelected;
  final Function(bool)? onSelected;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      shape: const StadiumBorder(side: BorderSide.none),
      side: BorderSide(color: Colors.transparent),
      label: Text(
        tag,
        style: context.textTheme.bodyMedium!.copyWith(
          color: isSelected ? Colors.white : AppColors.gray,
        ),
      ),
      selected: isSelected,
      onSelected: (val) {
        onSelected?.call(val);
      },
      selectedColor: AppColors.primaryColor,
      backgroundColor: AppColors.bodyTextColor,
    );
  }
}
