import 'package:flutter/material.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

class Todo {
  String? title;
  bool isDone = false;
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo App"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            spacing: 40,
            children: [
              Row(
                spacing: 30,
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type here...",
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      // color: Colors.white,
                    ),
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    onPressed: () {
                      Todo todo = Todo();
                      todo.title = controller.text;

                      todos.add(todo);
                      setState(() {});

                      controller.clear();
                    },
                  ),
                ],
              ),
              todos.isNotEmpty
                  ? notEmpty(controller)
                  : Text("You have no tasks !"),
            ],
          ),
        ),
      ),
    );
  }

  Expanded notEmpty(TextEditingController controller) {
    return Expanded(
      child: ListView.separated(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title.toString()),
            titleTextStyle: TextStyle(
              fontSize: 20,
              decoration: todos[index].isDone == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            leading: Checkbox(
                value: todos[index].isDone,
                onChanged: (bool? newVal) {
                  todos[index].isDone = newVal!;
                  setState(() {});
                }),
            trailing: IconButton.filled(
              onPressed: () {
                todos.removeAt(index);
                setState(() {});
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.redAccent),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
