import 'package:flutter/material.dart';
import 'package:proj_comp_movel/widgets/formulario_registo.dart';

import 'models/registar_model.dart';

void main() {
  runApp(const RegistarScreen());
}

class RegistarScreen extends StatelessWidget {
  const RegistarScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Registar"),
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            child: FormularioRegisto(),
          )

          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) {
          //         return AlertDialog(
          //           // Retrieve the text that the user has entered by using the
          //           // TextEditingController.
          //           content: Text(myController.text),
          //         );
          //       },
          //     );
          //   },
          //   tooltip: 'submit',
          //   child: const Icon(Icons.check),
          // ),
          ),
    );
  }
}
