import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? btnColor;
  final Color? txtColor;
  final double? txtSize;
  final double? fontSize;
  final FontWeight? fontWeight;

  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool inProgress;
  final double btnHorizontalPadding;
  final double btnVerticalPadding;
  final Widget? prefix;
  final Widget? suffix;

  const MainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.btnColor,
    this.txtColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
    this.inProgress = false,
    this.borderRadius = 8,
    this.fontSize = 20,
    this.btnHorizontalPadding = 40,
    this.btnVerticalPadding = 8,
    this.txtSize,
    this.fontWeight,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: btnHorizontalPadding, vertical: btnVerticalPadding),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
              btnColor ?? Theme.of(context).primaryColor),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: padding!,
          child: inProgress
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
                    if (prefix != null) ...[
                      prefix!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        color: txtColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                      ),
                    ),
                    if (suffix != null) ...[
                      const SizedBox(width: 8),
                      suffix!,
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
