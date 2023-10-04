import 'package:flutter/material.dart';

class MyDropdownButton extends StatelessWidget {
  final List<String> items;
  final ValueNotifier<String> selectedItem;
  const MyDropdownButton(
      {super.key, required this.items, required this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedItem,
      builder: (BuildContext context, String value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: value,
            onChanged: (newValue) {
              selectedItem.value = newValue!;
            },
            dropdownColor: const Color.fromARGB(255, 109, 109, 109),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
