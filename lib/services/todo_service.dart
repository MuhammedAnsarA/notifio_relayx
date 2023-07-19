import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notifio_relayx/model/todo_model.dart';

class TodoService {
  final todoCollection = FirebaseFirestore.instance.collection("todoApp");

  // create
  void addNewTask(TodoModel model) {
    todoCollection.add(model.toMap());
  }

  //update
  void updateTask(String? docId, bool? valueUpdate) {
    todoCollection.doc(docId).update({"isDone": valueUpdate});
  }

  //delete
  void deleteTask(String? docId) {
    todoCollection.doc(docId).delete();
  }
}
