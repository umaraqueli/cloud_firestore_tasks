import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_projetct/services/authentication_service.dart';
import 'package:firebase_projetct/services/firestore_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();

//Criando um Modal
  void _openModalForm() {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 99, 131, 151),
      context: context,
      isScrollControlled:
          true, // Permite que o modal use a altura total disponível
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20), // Borda arrendondada
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom, //Para nao ser  coberto pelo teclado
            left: 16.0,
            right: 16.0,
            top: 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize
                .min, //Faz com que a coluna use o tamanho minimo necessario pelos filhos
            children: [
              Text(
                "Adicionar Tarefas",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(height: 10),
              TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: "Título",
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.text_fields_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
              SizedBox(height: 10),
              TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      filled: true,
                      labelText: 'Descrição',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  firestoreService.addTask(
                      _titleController.text, _descriptionController.text);
                  //Limpar os controllers
                  _titleController.clear();
                  _descriptionController.clear();
                  Navigator.pop(context);
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Minhas Tarefas'),
        ),
        drawer: Drawer(
          child: ListTile(
            title: Text('Deslogar'),
            leading: Icon(Icons.logout),
            onTap: () {
              AuthenticationService().logoutUser();
            },
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getTasksStream(),
            builder: (context, snapshot) {
              // se existir informacaoc
              if (snapshot.hasData) {
                List tasksList = snapshot.data!.docs;
                // mostra em formato de lista
                return ListView.builder(
                    itemCount: tasksList.length,
                    itemBuilder: (context, index) {
                      //pega cada documento individualmente
                      DocumentSnapshot document = tasksList[index];
                      String docId = document.id;

                      //pega a task de cada documento
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String taskTitle = data["title"];
                      String taskDescriptino = data["title"];
                      return ListTile(
                        title: Text(taskTitle),
                      );
                    });
              } else {
                return Center(child: Text("Nenhuma Tarefa encontrada"));
              }
            }));
  }
}
