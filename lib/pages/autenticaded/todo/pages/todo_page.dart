import 'package:flutter/material.dart';
import 'package:todo/pages/autenticaded/todo/widgets/todo_list_item.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final TextEditingController todoController = TextEditingController();
  List<String> todos = [];

  void addTodo(String text) {
    setState(() {
      String text = todoController.text;
      todos.add(text);
      todoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Você possui ${todos.length} tarefas pendentes',
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    todos.clear();
                  });
                },
                style: OutlinedButton.styleFrom(
                  primary: Colors.orange,
                  fixedSize: Size(65, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    width: 0.4,
                    color: Colors.orangeAccent,
                  ),
                ),
                child: const Icon(
                  Icons.clear_all,
                  size: 30,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Flexible(
            child: Scrollbar(
              child: ListView.builder(
                itemCount: todos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return TodoListItem(
                    tittle: todos[index],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: todoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tarefa',
                    hintText: 'Informe a tarefa',
                  ),
                  onSubmitted: addTodo,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  addTodo(todoController.text);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  fixedSize: Size(62, 62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

/*ListView.builder(
                  itemCount: 40,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Card(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.album),
                              title: Text('The Enchanted Nightingale'),
                              subtitle: Text(
                                  'Music by Julie Gable. Lyrics by Sidney Stein.'),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text('BUY TICKETS'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  child: const Text('LISTEN'),
                                  onPressed: () {/* ... */},
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ), */
