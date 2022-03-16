import 'package:flutter/material.dart';
import 'package:proj_comp_movel/screens/dashboard_screen.dart';
import 'package:proj_comp_movel/screens/list_screen.dart';
import 'package:proj_comp_movel/widgets/formulario_registo.dart';

void main() {
  runApp(const RegistarScreen());
}

class RegistarScreen extends StatelessWidget {
  const RegistarScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _RegistarScreen(),
    );
  }
}

class _RegistarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Registar"),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: FormularioRegisto(),
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
                child: const Icon(Icons.keyboard_return),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                }),
          ],
        ));
  }
}
