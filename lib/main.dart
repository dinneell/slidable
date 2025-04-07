import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoScreen(),
    );
  }
}

class ToDoScreen extends StatefulWidget {
  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  final List<TodoItem> _todos = [];
  final TextEditingController _controller = TextEditingController();

  void _addTodo(String title) {
    setState(() {
      _todos.add(TodoItem(title: title));
    });
    _controller.clear();
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'New Task'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _addTodo(_controller.text),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                return Slidable(
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) => _removeTodo(index),
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: TodoTile(todo: _todos[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem {
  String title;
  bool isDone;
  TodoItem({required this.title, this.isDone = false});
}

class TodoTile extends StatefulWidget {
  final TodoItem todo;
  TodoTile({Key? key, required this.todo}) : super(key: key);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.todo.title,
        style: TextStyle(
          decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Checkbox(
        value: widget.todo.isDone,
        onChanged: (bool? value) {
          setState(() {
            widget.todo.isDone = value ?? false;
          });
        },
      ),
    );
  }
}
//В видео разобран процесс создания простого To-Do приложения на Flutter для iOS и Android в Android Studio, использование пакета Slidable.
//код для To-Do приложения на Flutter с использованием Slidable. Он включает AppBar, список задач, чек-боксы для отметки выполненных задач и возможность удаления через свайп.
//_todos — список задач.
// _controller — контроллер для поля ввода новой задачи.
//TextField + IconButton поле ввода и кнопка добавления