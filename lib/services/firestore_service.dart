import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //Pegando as referencias de uma coleção ("Tabela do banco")
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection("tasks");

  Future addTask(String title, String description) {
    return tasks.add({
      "title": title,
      "description": description,
    });
  }

  Stream<QuerySnapshot> getTasksStream() {
    final tasksStream = tasks.snapshots();
    return tasksStream;
  }
}
