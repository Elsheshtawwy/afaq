import 'package:flutter/material.dart';

Size getSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

bool isLargeScreen(BuildContext context) {
  final size = getSize(context);
  return size.width > 600;
}


