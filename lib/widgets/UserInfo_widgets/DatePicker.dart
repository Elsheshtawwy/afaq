import 'package:afaq/widgets/TextField/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;

  const DatePickerWidget(
      {super.key, required this.labelText, required this.controller});
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.controller.text.isNotEmpty
          ? DateTime.parse(widget.controller.text)
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        widget.controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: widget.controller,
              labelText: widget.labelText,
              prefixIcon:
                  Icon(Icons.calendar_today, color: Colors.blue.shade600),
            ),
          ),
        ),
      ],
    );
  }
}
