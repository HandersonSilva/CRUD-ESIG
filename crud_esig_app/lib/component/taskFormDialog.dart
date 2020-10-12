import 'package:crud_esig/models/task.dart';
import 'package:crud_esig/service/task_manager.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TaskFormDialog extends StatefulWidget {
  final Task task;
  Function onUpdateSuccess;
  var taskManager = TaskManager();

  TaskFormDialog(this.task, this.onUpdateSuccess);

  @override
  _TaskFormDialogState createState() => _TaskFormDialogState();

  update(Task task) async{
    var data = await taskManager.update(task,'all');
    return data != null;
  }
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 2.0),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Alterar tarefa',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
            ),
            TextFormField(
              initialValue: widget.task.description,
              maxLines: 8,
              decoration: const InputDecoration(
                hintText: 'Nova tarefa',
              ),
              validator: (text) {
                if (text.isEmpty) return 'Informe a descrição';
                return null;
              },
              onChanged: (value) => widget.task.description = value,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Voltar'),
                ),
                FlatButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                     var status = await widget.update(widget.task);
                
                      widget.onUpdateSuccess(status);

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(
                    'Atualizar',
                    style: TextStyle(color: Color.fromRGBO(40, 167, 69, 1)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
