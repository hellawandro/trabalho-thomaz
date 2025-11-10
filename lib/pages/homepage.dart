import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference tarefas = FirebaseFirestore.instance.collection(
    FirebaseAuth.instance.currentUser!.uid // as tarefas são guardadas com o ID do usuário
  );

  Future<void> adicionarTarefa() async {
    TextEditingController tarefaController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Nova Tarefa"),
          content: SizedBox(
            width: 400,
            child: TextFormField(
              controller: tarefaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Adicionar'),
              // É onde as tarefas são criadas
              onPressed: () {
                final String nome = tarefaController.text;
                if (nome.isNotEmpty) {
                  tarefas.add({"nome": nome, "feito": false});
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 57, 102, 180),
        centerTitle: true,
        title: const Text(
          "Tarefas",
          style: TextStyle(color: Color.fromARGB(255, 245, 244, 243)),
          
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Adicionar tarefa",
        onPressed: () { adicionarTarefa(); },
        child: Text("+"),
      ),

      // Usa um StreamBuilder para ler o firebase e construir a página em si
      // tarefas.snapshots().data!.docs é uma array de todos os documentos que tem dentro da coleção tarefas
      body: StreamBuilder(
        stream: tarefas.snapshots(), // O stream que será ouvido
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            // Se houver dados, constrói uma ListView
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                bool? feito = streamSnapshot.data!.docs[index]["feito"];
                return CheckboxListTile(
                  tristate: false,
                  title: Text(documentSnapshot["nome"]),
                  value: feito,
                  onChanged: (bool? value) {
                    // se a tecla delete estiver pressionada, vai deletar a tarefa
                    bool deletarDocumento = HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.delete);
                    setState(() {
                      tarefas.doc(streamSnapshot.data!.docs[index].id).update(
                        {"feito": value}
                      );
                      feito = value;
                      if (deletarDocumento) {
                        tarefas.doc(streamSnapshot.data!.docs[index].id).delete();
                      }
                    });
                  },
                );
              },
            );
          }
          // Caso não tenha dados, o body retorna um símbolo giratório
          return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}
