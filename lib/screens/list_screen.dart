import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proj_comp_movel/screens/dashboard_screen.dart';
import 'package:proj_comp_movel/screens/editar_registo_screen.dart';
import '../models/registar_model.dart';
import 'novo_registo_screen.dart';

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
              if (index < registarM.getLength()) {
                final Registo item = registarM.getIndexFromLast(index);
                //print(item.obs);
                return Dismissible(
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirmação"),
                          content: Text("Deseja mesmo " +
                              ((direction == DismissDirection.endToStart)
                                  ? "apagar"
                                  : "editar") +
                              " este registo?"),
                          actions: <Widget>[
                            TextButton(
                                onPressed: () {
                                  if (item.getAgeInDays() >= 7) {
                                    Navigator.of(context).pop(false);
                                  } else {
                                    Navigator.of(context).pop(true);
                                  }
                                },
                                child: Text(
                                    ((direction == DismissDirection.endToStart)
                                        ? "Apagar"
                                        : "Editar"))),
                            TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text("Cancelar")),
                          ],
                        );
                      },
                    );
                  },
                  key: Key(item.id.toString()),
                  onDismissed: (direction) {
                    if (item.getAgeInDays() < 7) {
                      if (direction == DismissDirection.endToStart) {
                        registarM.removeItem(item);
                        registarM.gerarPesos();
                        // 'Registo de ' + item.formatDate() + ' removido'
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'O registo selecionado foi eliminado com sucesso.')));
                      } else {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('Abrir ecrã de edit...')));
                        registarM.setActive(item);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const EdtiarRegistoScreen()),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Só podem ser alterados registos datados dos últimos 7 dias. Registo foi escondido.')));
                    }
                  },
                  background: Container(
                    // color: Colors.red,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.grey,
                          Colors.grey,
                          // Colors.white,
                          Colors.white,
                          Colors.red,
                          Colors.red,
                        ],
                        // stops: [0.0,0.48, 0.52, 1.0],
                        stops: [0.0, 0.4, 0.5, 0.6, 1.0],
                        end: Alignment.centerRight,
                        begin: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: 20,
                    leading: Icon(
                      Icons.monitor_weight_rounded,
                      size: 50,
                      color: ((item.getAgeInDays() < 7)
                          ? Colors.blue
                          : Colors.grey),
                    ),
                    title: Text(item.toDisplay()),
                  ),
                );
              } else {
                return SizedBox(height: 0);
              }
            }),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                heroTag: "Registar",
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NovoRegistoScreen()),
                  );
                }),
            const SizedBox(height: 10), // space between buttons
            FloatingActionButton(
                heroTag: "Dashboard",
                child: const Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
