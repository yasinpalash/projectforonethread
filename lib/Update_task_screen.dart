import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Todo_Task.dart';

class UpdateTaskModal extends StatefulWidget {
  const UpdateTaskModal({
    Key? key,
    required this.todo,
    required this.onTodoUpdate,
  }) : super(key: key);

  final Todo todo;
  final Function(String) onTodoUpdate;

  @override
  State<UpdateTaskModal> createState() => _UpdateTaskModalState();
}

class _UpdateTaskModalState extends State<UpdateTaskModal> {
  late TextEditingController _todoTEController;

  @override
  void initState() {
    super.initState();
    _todoTEController = TextEditingController(text: widget.todo.details);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Update Todo',
                style: Theme.of(context).textTheme.headline6,
              ),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _todoTEController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Enter your todo here',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.onTodoUpdate(_todoTEController.text.trim());
                Get.back();
              },
              child: const Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
