import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../models/todo.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({Key? key, required this.todo, required this.onDelete})
      : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              flex: 1,
              onPressed: (index) {
                print('Arquivando ' + index.toString());
              },
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: "Arquivar",
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            SlidableAction(
              onPressed: (index) => onDelete(todo),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: "Excluir",
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.task_alt, size: 23),
                title: Text(todo.title),
                subtitle: Text(
                  DateFormat("EE, dd/MM/yyyy HH:mm").format(todo.dateTime),
                ),
                onTap: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
