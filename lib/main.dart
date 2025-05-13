import 'package:flutter/material.dart';

// The main function is the entry point of the app
void main() {
  runApp(
    const MainApp(), // Start the app by running the MainApp widget
  );
}

// A simple model class to represent a Todo item
class Todo {
  String? title; // The task description
  bool isDone = false; // Whether the task is marked as completed
}

// The root widget of the app
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

// The state class for MainApp (holds and manages the UI state)
class _MainAppState extends State<MainApp> {
  List<Todo> todos = []; // A list to store all Todo items

  @override
  Widget build(BuildContext context) {
    // Controller to read text input from the TextField
    TextEditingController controller = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      home: Scaffold(
        appBar: AppBar(
          title: Text("Todo App"), // App bar title
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0), // Padding around the body content
          child: Column(
            spacing:
                40, // Space between column elements (not supported on all platforms)
            children: [
              Row(
                spacing: 30, // Space between row elements (also not standard)
                children: [
                  // Text input field
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type here...", // Placeholder text
                        enabledBorder:
                            OutlineInputBorder(), // Border when not focused
                        focusedBorder:
                            OutlineInputBorder(), // Border when focused
                      ),
                    ),
                  ),
                  // Button to add a new Todo item
                  IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.white,
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                    ),
                    onPressed: () {
                      // Create a new Todo with the input text
                      Todo todo = Todo();
                      todo.title = controller.text;

                      // Add the new Todo to the list
                      todos.add(todo);
                      setState(() {}); // Update the UI

                      controller.clear(); // Clear the text field
                    },
                  ),
                ],
              ),
              // Show the list of todos or a message if empty
              todos.isNotEmpty
                  ? notEmpty(controller)
                  : Text("You have no tasks !"),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display the list of todos if not empty
  Expanded notEmpty(TextEditingController controller) {
    return Expanded(
      child: ListView.separated(
        itemCount: todos.length, // Number of Todo items
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title.toString()), // Display task title
            titleTextStyle: TextStyle(
              fontSize: 20,
              // Strike-through if the task is marked as done
              decoration: todos[index].isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            // Checkbox to toggle task completion
            leading: Checkbox(
              value: todos[index].isDone,
              onChanged: (bool? newVal) {
                todos[index].isDone = newVal!;
                setState(() {}); // Update UI
              },
            ),
            // Delete button to remove the task
            trailing: IconButton.filled(
              onPressed: () {
                todos.removeAt(index); // Remove task from list
                setState(() {}); // Update UI
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
          return Divider(); // Add a divider between tasks
        },
      ),
    );
  }
}
