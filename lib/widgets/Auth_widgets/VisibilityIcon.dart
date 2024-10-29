  import 'package:flutter/material.dart';

  class VisibilityIcon extends StatelessWidget {
    final bool obscureText;
    final VoidCallback onPressed;

    const VisibilityIcon({
      Key? key,
      required this.obscureText,
      required this.onPressed,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return IconButton(
        icon: Icon(
          obscureText ? Icons.visibility : Icons.visibility_off,
          color: Colors.blue.shade600,
        ),
        onPressed: onPressed,
      );
    }
  }