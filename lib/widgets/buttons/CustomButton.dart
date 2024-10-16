import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? labelColor;
  final double? labelSize;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final bool isLoading;
  final double horizontalPadding;
  final double verticalPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double elevation;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.buttonColor = const Color(0xFF0961F5),
    this.labelColor = Colors.white,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
    this.isLoading = false,
    this.borderRadius = 12,
    this.labelFontSize = 20,
    this.horizontalPadding = 40,
    this.verticalPadding = 8,
    this.labelSize,
    this.labelFontWeight,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.padding,
    this.elevation = 2.0, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? Theme.of(context).primaryColor,
          foregroundColor: labelColor,
          padding: contentPadding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          textStyle: textStyle ?? TextStyle(
            fontSize: labelFontSize,
            fontWeight: labelFontWeight,
          ),
          elevation: elevation, 
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.white24,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 8),
                  ],
                  Text(label),
                  if (suffixIcon != null) ...[
                    const SizedBox(width: 8),
                    suffixIcon!,
                  ],
                ],
              ),
      ),
    );
  }
}
