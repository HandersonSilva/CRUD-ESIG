import 'package:crud_esig/component/taskFormDialog.dart';
import 'package:crud_esig/service/task_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'models/task.dart';//para ios

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
        MaterialApp(
        title: 'CRUD ESIG',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  var items = List<Task>();

  HomePage(){
    items = [];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();
  var taskManager = TaskManager();
  String filter = 'all'; 

  _HomePageState(){
    grantedPermissions();
    load();
  }

  void save() async {
    if (newTaskCtrl.text.isEmpty){
      return;
    }

    var data = await taskManager.save(newTaskCtrl.text,filter);
    newTaskCtrl.clear();

    if (data != null){
      setState(() {
        widget.items = data;
      });
    }
  }
 
  void remove(int index) async {
    var data = await taskManager.delete(index,filter);
    if (data != null){
      setState(() {
        widget.items = data;
      });
    }
  }

    void removeTaskDone() async {
    var data = await taskManager.deleteTaskDone(filter);
    if (data != null){
      setState(() {
        widget.items = data;
      });
    }
  }

  Future load() async {
    var data = await taskManager.list(filter);
    if (data != null){
      setState(() {
        widget.items = data;
      });
    }
  }

  update(Task task) async{
    var data = await taskManager.update(task,filter);
    if (data != null){
      setState(() {
        widget.items = data;
      });
    }
  }

  Future<void> grantedPermissions() async {
    final storage = await Permission.storage.status;
    if (storage.isUndetermined) {
      await Permission.storage.request();
    }
    showInfo();
  }

  Future<void> showInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final result = prefs.getBool('alert_info');
    if (result == null) {
      Future.delayed(Duration.zero, () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Informações"),
                content: Container(
                  width: double.infinity,
                  child: Container(
                    height: 150,
                    child: Column(
                      children: [
                        const Text(
                            '1 - Utilize o botão (mais) para salvar uma tarefa.'),
                        const Text(
                            '2 - Para alterar uma tarefa, mantenha ela pressionada por alguns segundos.'),
                            const Text(
                            '3 - Para excluir uma tarefa, arraste ela para qualquer lado.'),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () async {
                       prefs.setBool('alert_info', true);
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"),
                  ),
                ],
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(labelText: "Nova Tarefa",labelStyle: TextStyle(color: Colors.white)),
          ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                  borderSide: filter == 'all' ?  BorderSide(
                    color: Colors.blueGrey, //Color of the border
                  ) : null,
                  onPressed: () {
                   filter = 'all';
                   load();
                  },
                  child:
                  Text('Todos',
                      style: TextStyle(
                            fontSize: 12
                          )
                  ),
                ),
                OutlineButton(
                  borderSide: filter == 'unrealized' ?  BorderSide(
                    color: Colors.blueGrey, //Color of the border
                  ) : null,
                  onPressed: () {
                   filter = 'unrealized';
                   load();
                  },
                  child:
                  Text('A fazer',
                      style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(25, 118, 210, 1)
                          )
                  ),
                ),
                OutlineButton(
                  borderSide: filter == 'done' ?  BorderSide(
                    color: Colors.blueGrey, //Color of the border
                  ) : null,
                  onPressed: () {
                     filter = 'done';
                     load();
                  },
                  child:
                  Text('Feito',
                      style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(40, 167, 69, 1)
                          )
                  ),
                ),
                OutlineButton(
                  onPressed: () {
                   removeTaskDone();
                  },
                  child:
                  Text('Excluir concluídas',
                    style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(244, 67, 54, 1)
                          ),
                  ),
                ),
              ],
            ),
           const Divider(
                  color: Color.fromRGBO(25, 118, 210, 1),
                  height: 4,
                  thickness: 4,
                  indent: 4,
                  endIndent: 0,
                ),
          Expanded(
                child: ListView.builder(
                itemCount: widget.items.length, 
                itemBuilder: (context, index){
                  final task = widget.items[index];
                  return Dismissible( 
                    key:Key(task.description), 
                    background: Container( color: Colors.red.withOpacity(0.2),
                    child:Padding(padding: EdgeInsets.all(20),
                    child:  Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text("Excluir"),
                        ],
                      ),
                    ),
                    ),
                    ),
                    onDismissed: (direction){
                      remove(task.id);
                    },
                    child: Column(
                      children: [
                        GestureDetector(
                           onLongPress: task.done ? null: () => {
                              showDialog(
                              context: context,
                              child: TaskFormDialog(
                                task,(e)=>{
                                  if (e){
                                    load()
                                  }
                                }
                              ))
                           },
                              child: CheckboxListTile(
                              title:Text(task.description, 
                              style: TextStyle(
                                  decoration: task.done ? TextDecoration.lineThrough : TextDecoration.none,
                                ),
                              ),
                              value: task.done,
                              onChanged: task.done ? null : (value){
                                  task.done = value;
                                  update(task);
                              },),
                        ),
                        const Divider(
                          color: Color.fromRGBO(184, 186, 187, 1),
                          height: 2,
                          thickness: 2,
                          indent: 2,
                          endIndent: 0,
                        ),
                      ],
                    )
                  );
              }),
            ),
          ],
        ),
      ),//widget acessar variavel class pai
      floatingActionButton: FloatingActionButton(
      onPressed: save,
      child: Icon(Icons.add, color: Color.fromRGBO(255, 255, 255, 1)),
      backgroundColor: Colors.lightBlue)
    );
  }
}

