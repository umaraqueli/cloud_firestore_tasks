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

  void _openModalForm({String? docId}) async {
    if (docId != null) {
      // Buscar o documento com o docId
      DocumentSnapshot document = await firestoreService.getTask(docId);
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

      // Preencher os controladores com os valores existentes
      _titleController.text = data["title"];
      _descriptionController.text = data["description"];
    }

    showModalBottomSheet(
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
                style: TextStyle(fontSize: 24, color: Colors.black),
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
              FilledButton(
                onPressed: () {
                  if (docId == null) {
                    firestoreService.addTask(
                        _titleController.text, _descriptionController.text);
                  } else {
                    firestoreService.updateTask(docId, _titleController.text,
                        _descriptionController.text);
                  }
                  //Limpar os controllers
                  _titleController.clear();
                  _descriptionController.clear();
                  setState(() {});
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _openModalForm();
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: firestoreService.getTasksStream(),
            builder: (context, snapshot) {
              // se existir informacao
              if (snapshot.hasData) {
                List tasksList = snapshot.data!.docs;

                // mostra em formato de lista
                return ListView.builder(
                    itemCount: tasksList.length,
                    itemBuilder: (context, index) {
                      //Pega cada documento individualmente
                      DocumentSnapshot document = tasksList[index];
                      String docId = document.id;

                      //pega a task de cada documento
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String taskTitle = data["title"];
                      String taskDescription = data["description"];

                      return Padding(
                          padding: EdgeInsets.all(16),
                          child: ListTile(
                            tileColor: Colors
                                .grey[200], // Cor de fundo para destacar o item
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Bordas arredondadas do ListTile
                            ),

                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            title: Text(taskTitle),
                            subtitle: Text(taskDescription),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      _openModalForm(docId: docId);
                                    },
                                    icon: Icon(Icons.settings)),
                                IconButton(
                                    onPressed: () {
                                      firestoreService.deleteTask(docId);
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                          ));
                    });
              } else {
                return Center(child: Text("Nenhuma Tarefa encontrada"));
              }
            }));
  }
}
