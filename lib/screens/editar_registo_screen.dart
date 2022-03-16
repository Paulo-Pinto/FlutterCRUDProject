import 'package:flutter/material.dart';
import 'package:proj_comp_movel/screens/list_screen.dart';
import 'package:proj_comp_movel/widgets/formulario_registo_preenchido.dart';

import '../models/registar_model.dart';
import '../widgets/formulario_registo.dart';
import 'dashboard_screen.dart';
import 'novo_registo_screen.dart';

class EdtiarRegistoScreen extends StatelessWidget {
  const EdtiarRegistoScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();

    // print(registarM.getActive());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _EditarRegistoScreen(),
    );
  }
}

class _EditarRegistoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
    final registoAtual = registarM.getActive();

    return Scaffold(
      appBar: AppBar(
        title: Text("Registo de ${registoAtual.formatDate()}"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: FormularioRegistoPreenchido(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "Listar",
              child: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
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
    );
  }
}
