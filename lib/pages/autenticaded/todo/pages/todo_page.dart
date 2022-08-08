import 'package:flutter/material.dart';
import 'package:todo/pages/autenticaded/todo/widgets/todo_list_item.dart';
import 'package:todo/repositories/todo_repository.dart';
import '../../../../models/todo.dart';
import 'package:flutter/services.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoState();
}

class _TodoState extends State<TodoPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];
  late bool? _isButtonAddDisabled = true;
  late bool? _isButtonRemoveAllDisabled = true;

  late int? indexTask = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      todoRepository.getTodoList().then((value) {
        todos = value;
        verificaLista();
      });
    });
  }

  void addTodo(String text) {
    if (text.isNotEmpty) {
      setState(() {
        String text = todoController.text;
        Todo newTodo = Todo(title: text, dateTime: DateTime.now());
        todos.add(newTodo);
        todoController.clear();
        _isButtonAddDisabled = true;
        verificaLista();
        HapticFeedback.heavyImpact();
        FocusManager.instance.primaryFocus?.unfocus();
        todoRepository.saveTodoList(todos);
      });
    }
  }

  void verificaLista() {
    setState(() {
      _isButtonRemoveAllDisabled = todos.isEmpty;
    });
  }

  void getTodoLists() {}

  void desfazerExcluir(Todo todo) {
    setState(() {
      verificaLista();
      todos.insert(indexTask!, todo);
      todoRepository.saveTodoList(todos);
    });
  }

  void desfazerTodos(List<Todo> todoAux) {
    setState(() {
      todos.addAll(todoAux);
      todoRepository.saveTodoList(todos);
      verificaLista();
    });
  }

  void onChanged(String text) {
    setState(() {
      String text = todoController.text;
      _isButtonAddDisabled = (text.isEmpty);
    });
  }

  void limparTodos() {
    setState(() {
      List<Todo> todoAux = [];

      todoAux.addAll(todos);

      todos.clear();
      todoRepository.saveTodoList(todos);

      Navigator.of(context).pop();

      HapticFeedback.heavyImpact();

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Tarefas removidas com sucesso!'),
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: Colors.orange,
            onPressed: () {
              desfazerTodos(todoAux);
            },
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    });
    verificaLista();
  }

  void onDelete(Todo todo) {
    setState(() {
      indexTask = todos.indexOf(todo);
      todos.remove(todo);
      todoRepository.saveTodoList(todos);
      HapticFeedback.heavyImpact();
      verificaLista();

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tarefa ${todo.title} deletada com sucesso'),
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: Colors.orange,
            onPressed: () {
              desfazerExcluir(todo);
            },
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    });
  }

  void showDeleteAllConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content: const Text('Tem certeza que deseja limpar todas as tarefas?'),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () => Navigator.pop(context, 'Cancelar'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                width: 0.4,
                color: Color.fromARGB(136, 255, 153, 0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.cancel),
                SizedBox(width: 5),
                Text('Cancelar'),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: () => limparTodos(),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.red.withOpacity(0.5),
              side: const BorderSide(
                width: 0,
                color: Colors.red,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Ok',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!_isButtonRemoveAllDisabled!)
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                ),
                Expanded(
                  child: Text(
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    'Você possui ${todos.length} tarefas pendentes',
                  ),
                ),
                OutlinedButton(
                  onPressed: !_isButtonRemoveAllDisabled!
                      ? () => showDeleteAllConfirmationDialog()
                      : null,
                  style: OutlinedButton.styleFrom(
                    primary: Colors.orange,
                    fixedSize: const Size(65, 65),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                      width: 0.4,
                      color: !_isButtonRemoveAllDisabled!
                          ? Colors.orangeAccent
                          : Colors.grey,
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
              child: Column(
                children: [
                  if (!_isButtonRemoveAllDisabled!)
                    ListView.builder(
                      itemCount: todos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return TodoListItem(
                          todo: todos[index],
                          onDelete: onDelete,
                        );
                      },
                    ),
                ],
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
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tarefa',
                    hintText: 'Ex.: Correr na práia',
                  ),
                  onSubmitted: addTodo,
                  onChanged: onChanged,
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: !_isButtonAddDisabled!
                    ? () => addTodo(todoController.text)
                    : null,
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  fixedSize: const Size(65, 65),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Icon(
                  Icons.add_task_outlined,
                  size: 25,
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
