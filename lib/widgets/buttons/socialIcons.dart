  import 'package:flutter/material.dart';

  Widget buildSocialButtons(
    List<String> assetPaths, List<Function> onTapCallbacks) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(assetPaths.length, (index) {
      return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => onTapCallbacks[index](),
        child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border.all(color: const Color(0xFFEFF0F6)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 2,
          ),
          ],
        ),
        child: ClipOval(
          child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            assetPaths[index],
            fit: BoxFit.cover,
          ),
          ),
        ),
        ),
      ),
      );
    }),
    );
  }