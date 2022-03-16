import 'package:flutter/material.dart';
import '../models/registar_model.dart';
import 'registar_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Lista Registos"),
        ),
        body: ListView.builder(
            itemCount: registarM.getLength(),
            // TODO : Ordenar por data
            itemBuilder: (context, index) {
              final Registo item = registarM.getIndex(index);

              return Dismissible(
                confirmDismiss: (DismissDirection direction) async {
                  return await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirmação"),
                        content:
                            const Text("Deseja mesmo apagar este registo?"),
                        actions: <Widget>[
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("Apagar")),
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("Cancelar")),
                        ],
                      );
                    },
                  );
                },
                key: Key(item.id.toString()),
                onDismissed: (direction) {
                  if (item.getAgeInDays() < 7) {
                    print(item);
                    registarM.removeItem(item);
                    // 'Registo de ' + item.formatDate() + ' removido'
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'O registo selecionado foi eliminado com sucesso.')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Só podem ser eliminados registos datados dos últimos 7 dias.')));
                  }
                },
                // TODO : add editar
                background: Container(color: Colors.red),
                child: ListTile(
                  minVerticalPadding: 20,
                  leading: const Icon(Icons.monitor_weight_rounded, size: 50),
                  title: Text(item.toDisplay()),
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.keyboard_return),
            onPressed: () {
              Navigator.push(
                context,
                // TODO : make this dynamic, return to the screen that accessed it
                MaterialPageRoute(builder: (context) => RegistarScreen()),
              );
            }),
      ),
    );
  }
}
