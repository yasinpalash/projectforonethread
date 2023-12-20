import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'Add_New_Task_modal.dart';
import 'Todo_Task.dart';
import 'Update_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ToDos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 2.0,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskModal();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final Todo todo = todoList[index];
          final String formattedDate =
          DateFormat('hh:mm a dd-MM-yy').format(todo.createdDateTime);

          return _buildTaskListTile(context, todo, formattedDate, index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            height: 4,
          );
        },
      ),
    );
  }

  Widget _buildTaskListTile(
      BuildContext context,
      Todo todo,
      String formattedDate,
      int index,
      ) {
    return ListTile(
      tileColor: todo.status == 'Completed' ? Colors.grey : null,
      onTap: () {
        _showTaskActionsDialog(context, todo, index);
      },
      onLongPress: () {
        _toggleTodoStatus(index);
      },
      leading: CircleAvatar(
        child: Text('${index + 1}'),
      ),
      title: Text(todo.details),
      subtitle: Text(formattedDate),
      trailing: Text(todo.status.toUpperCase()),
    );
  }

  void _showAddTaskModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddNewTaskModal(
          onAddTap: (Todo task) {
            _addTodo(task);
          },
        );
      },
    );
  }

  void _showTaskActionsDialog(BuildContext context, Todo todo, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Actions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildActionListTile(
                Icons.edit,
                'Update',
                    () {
                  Navigator.pop(context);
                  _showUpdateTaskModal(todo, index);
                },
              ),
              const Divider(
                height: 0,
              ),
              _buildActionListTile(
                Icons.delete_outline,
                'Delete',
                    () {
                  _deleteTodo(index);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile _buildActionListTile(
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _showUpdateTaskModal(Todo todo, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return UpdateTaskModal(
          todo: todo,
          onTodoUpdate: (String updatedDetailsText) {
            _updateTodo(index, updatedDetailsText);
          },
        );
      },
    );
  }

  void _addTodo(Todo todo) {
    todoList.add(todo);
    setState(() {});
  }

  void _deleteTodo(int index) {
    todoList.removeAt(index);
    setState(() {});
  }

  void _updateTodo(int index, String todoDetails) {
    todoList[index].details = todoDetails;
    setState(() {});
  }

  void _toggleTodoStatus(int index) {
    String currentStatus = todoList[index].status == 'pending' ? 'Completed' : 'pending';
    _updateTodoStatus(index, currentStatus);
  }

  void _updateTodoStatus(int index, String status) {
    todoList[index].status = status;
    setState(() {});
  }
}
