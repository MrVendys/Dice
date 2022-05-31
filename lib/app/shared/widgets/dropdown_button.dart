import 'package:flutter/material.dart';

class DropDownButton<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final Function(T)? onValueChanged;
  final Color? backgroundColor;
  final Color? borderColor;

  const DropDownButton({
    Key? key,
    required this.value,
    required this.items,
    this.onValueChanged,
    this.backgroundColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(
          12.0,
        ),
        border: Border.all(
          color: borderColor ?? Colors.grey,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          dropdownColor: Colors.white,
          elevation: 1,
          borderRadius: BorderRadius.circular(12.0),
          underline: null,
          value: value,
          items: items,
          onChanged: (T? val) {
            onValueChanged?.call(val ?? value);
          },
        ),
      ),
    );
  }
}
