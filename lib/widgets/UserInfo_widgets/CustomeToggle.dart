  import 'package:flutter/material.dart';
  import 'package:toggle_switch/toggle_switch.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart';

  class CustomToggle extends StatelessWidget {
    final int initialIndex;
    final List<String> labels;
    final List<IconData> icons;
    final List<List<Color>> activeBgColors;
    final void Function(int?)? onToggle;

    const CustomToggle({
      Key? key,
      required this.initialIndex,
      required this.labels,
      required this.icons,
      required this.activeBgColors,
      required this.onToggle,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return ToggleSwitch(
        animationDuration: 500,
        minWidth: 100.0,
        initialLabelIndex: initialIndex,
        cornerRadius: 20.0,
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey.shade300,
        inactiveFgColor: Colors.black,
        totalSwitches: labels.length,
        labels: labels,
        icons: icons,
        activeBgColors: activeBgColors,
        onToggle: onToggle,
      );
    }
  }
