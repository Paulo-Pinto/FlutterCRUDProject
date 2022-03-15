import 'package:flutter/material.dart';
import 'package:proj_comp_movel/screens/list_screen.dart';

import '../registar.dart';
import '../widgets/WidgetsDashboard.dart';

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
            // Variancia(),
            // MediaRating(),
            Primeiro(),
            Ultimo(),
            // GraficoRegistos(),
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
