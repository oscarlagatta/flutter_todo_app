import 'package:flutter/material.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  DialogBox({
    super.key,
    this.controller,
    required this.onSve,
    required this.onCancel,
  });

  final controller;

  VoidCallback onSve;
  VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlue[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add New Task'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //save buttons
                MyButton(text: 'Save', onPressed: onSve),
                const SizedBox(
                  width: 8,
                ),
                MyButton(text: 'Cancel', onPressed: onCancel),
                // cancel button
              ],
            )
            // buttons - save and cancel
          ],
        ),
      ),
    );
  }
}
