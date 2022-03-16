import 'package:flutter/material.dart';
import 'package:proj_comp_movel/screens/list_screen.dart';

import 'registar_screen.dart';
import '../widgets/line_chart.dart';
import '../widgets/table_medias.dart';
import '../widgets/primeiro.dart';
import '../widgets/ultimo.dart';

void main() {
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
            TableMedias(),
            const SizedBox(height: 20), // space between buttons
            Primeiro(),
            Ultimo(),
            const SizedBox(height: 40), // space between buttons
            RichText(
                text: const TextSpan(
              text: 'Gráfico últimos 15 pesos',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 10), // space between buttons
            GraficoRegistos(),
          ]),
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
                heroTag: "Registar",
                child: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistarScreen()),
                  );
                }),
          ],
        ));
  }
}

class InfoDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
