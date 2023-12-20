import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Todo_Task.dart';
class AddNewTaskModal extends StatefulWidget {
  const AddNewTaskModal({
    Key? key,
    required this.onAddTap,
  }) : super(key: key);

  final Function(Todo) onAddTap;

  @override
  State<AddNewTaskModal> createState() => _AddNewTaskModalState();
}

class _AddNewTaskModalState extends State<AddNewTaskModal> {
  final TextEditingController _todoTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add New Todo',
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextFormField(
              maxLines: 4,
              controller: _todoTEController,
              decoration: const InputDecoration(
                hintText: 'Enter your todo here',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Enter a value';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Todo todo = Todo(
                      details: _todoTEController.text.trim(),
                      createdDateTime: DateTime.now(),
                      updatedDateTime: DateTime.now(),
                    );
                    widget.onAddTap(todo);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
