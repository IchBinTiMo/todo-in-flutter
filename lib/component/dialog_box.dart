import 'package:flutter/material.dart';
import 'package:eztodo/component/my_button.dart';
import 'package:eztodo/component/my_dropdownbutton.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final ValueNotifier<String> selectedItem;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const DialogBox(
      {super.key,
      required this.controller,
      required this.selectedItem,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 36, 36, 36),
        content: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 109, 109, 109)),
                  ),
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  hintText: "Add a new task",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 109, 109, 109)),
                ),
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyDropdownButton(
                      items: const ["Daily", "Weekly", "Others"],
                      selectedItem: selectedItem),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(text: "Save", onPressed: onSave),
                    const SizedBox(width: 10),
                    MyButton(text: "Cancel", onPressed: onCancel),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
