import 'package:flutter/material.dart';
import 'package:fund_watchlist/theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? initialValue;
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final bool showToggleVisibility;
  final bool isPasswordVisible;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? onToggleVisibility;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.prefixIcon,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    this.showToggleVisibility = false,
    this.isPasswordVisible = false,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText && !isPasswordVisible,
      style: const TextStyle(fontSize: 15),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColor.primary), 
        ),
        contentPadding: const EdgeInsets.all(10.0),
        labelText: label,
        labelStyle: const TextStyle(fontSize: 15),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(width: 25, height: 25, child: Icon(prefixIcon)),
        ),
        suffixIcon: showToggleVisibility
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onToggleVisibility,
              )
            : null,
      ),
    );
  }
}
