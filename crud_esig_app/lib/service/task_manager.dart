import 'package:crud_esig/helpers/constantes.dart';
import 'package:crud_esig/models/task.dart';
import 'package:dio/dio.dart';

class TaskManager {

  Future<List<Task>> list(filter) async {
   try{
      var url = '$HOST_API$TASK$filter';

      Response response = await Dio().get(url);

      var data = response.data['data'];

      if (data != null){
            Iterable decode = data;
            List<Task> result = decode.map((e) => Task.fromJson(e)).toList();
            return result;
      }

      return [];
   }catch(e){
     print(e);
   }
  }

   Future<List<Task>> save(String taskText, filter) async {
   try{
      var url = HOST_API+TASK;

      Response response = await Dio().post(url,data:{ "description":taskText,
      "done":false,"filter":filter});

      var data = response.data['data'];

      if (data != null){
            Iterable decode = data;
            List<Task> result = decode.map((e) => Task.fromJson(e)).toList();
            return result;
      }

      return [];
   }catch(e){
     print(e);
   }
  }

  Future<List<Task>> delete(id,filter) async {
   try{
      var url = '$HOST_API$TASK$id';

      await Dio().delete(url);

      var data = await list(filter);

      return data;
   }catch(e){
     print(e);
   }
  }

   Future<List<Task>> update(Task task,filter) async {
   try{
      var url = '$HOST_API$TASK${task.id}';

      await Dio().put(url,data:{"description":task.description,"done":task.done,"filter":"all"});

      var data = await list(filter);

      return data;
   }catch(e){
     print(e);
   }
  }

    Future<List<Task>> deleteTaskDone(filter) async {
   try{
      var url = '$HOST_API$TASK_DONE';

      await Dio().delete(url);

      var data = await list(filter);

      return data;
   }catch(e){
     print(e);
   }
  }
}