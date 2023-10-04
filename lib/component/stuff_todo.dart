import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class StuffTodo extends StatelessWidget {
  final num taskIndex;
  final num? taskLength;
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext) deleteFunction;

  const StuffTodo(
      {Key? key,
      required this.taskIndex,
      required this.taskLength,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 25,
          bottom: taskIndex == taskLength! ? 70 : 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              style: BorderStyle.solid,
              color: Colors.transparent,
            ),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 72, 82),
                Color.fromARGB(255, 0, 72, 82),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Slidable(
            endActionPane: ActionPane(
              extentRatio: 0.25,
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: deleteFunction,
                  icon: Icons.delete,
                  backgroundColor: Colors.red.shade300,
                  borderRadius: BorderRadius.circular(12),
                )
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: taskCompleted
                    ? const Color.fromARGB(255, 15, 15, 15)
                    : const Color.fromARGB(255, 29, 29, 29),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    taskName,
                    style: TextStyle(
                        color: taskCompleted
                            ? const Color.fromARGB(255, 88, 88, 88)
                            : Colors.white,
                        fontSize: 20,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        value: taskCompleted,
                        onChanged: onChanged,
                        activeColor: Colors.white,
                        checkColor: Colors.black,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 0, 72, 82)),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
