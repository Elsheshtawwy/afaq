import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Color fillColor;
  final BorderRadius borderRadius;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  

  const CustomTextField({
    super.key,
    required this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.fillColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.validator,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AbsorbPointer(
        absorbing: onTap != null,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            labelText: labelText,
            filled: true,
            fillColor: fillColor,
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide.none,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
