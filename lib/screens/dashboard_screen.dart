import 'package:flutter/material.dart';
import 'package:proj_comp_movel/screens/list_screen.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'novo_registo_screen.dart';
import '../widgets/line_chart.dart';
import '../widgets/table_medias.dart';
import '../widgets/primeiro.dart';
import '../widgets/ultimo.dart';

// TODO : Floating actions buttons com hints na dashboard
// TODO : página individual registo
// TODO : novo registo hint - como se sente hoje (1 - Muito mal, 5 - Muito bem)

void main() {
  Paint.enableDithering = true;
  runApp(const DashboardScreen());
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _DashboardScreen(),
    );
  }
}

class _DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(children: <Widget>[
          const SizedBox(height: 10),
          TableMedias(),
          const SizedBox(height: 30),
          Primeiro(),
          Ultimo(),
          const SizedBox(height: 40),
          RichText(
              text: const TextSpan(
            text: 'Gráfico últimos 15 registos',
            style: TextStyle(
                color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 20),
          GraficoRegistos(),
        ]),
      ),

      // floatingActionButton: SpeedDial(
      //
      // ),

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
              heroTag: "Listar",
              child: const Icon(Icons.list),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListScreen()),
                );
              }),
        ],
      ),
    );
  }
}

class InfoDashboard extends StatelessWidget {
  const InfoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
