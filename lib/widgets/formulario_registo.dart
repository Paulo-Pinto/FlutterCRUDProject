// widget formulario
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/registar_model.dart';

class FormularioRegisto extends StatefulWidget {
  const FormularioRegisto({Key? key}) : super(key: key);

  @override
  _FormularioRegisto createState() => _FormularioRegisto();
}

class _FormularioRegisto extends State<FormularioRegisto> {
  final _formKey = GlobalKey<FormState>();

  // final myController = TextEditingController();
  double peso = 0;
  bool comeu = false;
  double rate = 1.0;
  String obs = "";
  bool obsComplete = false;

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final m = RegistarModel.getInstance();
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 20,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.monitor_weight_rounded, size: 40),
              border: UnderlineInputBorder(),
              // border: OutlineInputBorder(),
              hintText: 'Quanto pesou hoje?',
              labelText: 'Peso',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira o peso';
              }
              value = value.replaceAll(",", ".");
              if (double.tryParse(value) == null) {
                return 'Insira um número';
              }
              peso = double.parse(value);
              return null;
            },
          ),
          TextFormField(
            maxLines: 3,
            maxLength: 200,
            decoration: const InputDecoration(
              icon: Icon(Icons.reviews, size: 40),
              border: OutlineInputBorder(),
              labelText: 'Observações (opcional)',
            ),
            validator: (value) {
              if (value != null) {
                var obsLen = value.length;
                // observation is empty
                if (obsLen == 0) {
                  obsComplete = true;
                  obs = "";
                  return null;
                }
                // observation is not empty, and is not in 100 < x < 200
                if (obsLen < 100 || obsLen > 200) {
                  obsComplete = false;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Escreva entre 100 e 200 caracteres (escreveu $obsLen)"),
                    duration: const Duration(seconds: 1),
                    backgroundColor: Colors.black54,
                    action: SnackBarAction(
                      label: 'Dismiss',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ));
                } else {
                  // observation is okay, save it
                  obsComplete = true;
                  obs = value;
                  return null;
                }
              }
              obs = "";
              return null;
            },
          ),
          CheckboxListTile(
            title: Text("Comeu hoje?"),
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            // fillColor: MaterialStateProperty.all<Color>(Colors.blue),
            value: comeu,
            onChanged: (bool? value) {
              setState(() {
                comeu = value!;
              });
            },
          ),
          Slider(
            value: rate,
            min: 1,
            max: 5,
            divisions: 4,
            inactiveColor: const Color(0xABC6D9BE),
            activeColor: Colors.blue,
            label: rate.round().toString(),
            onChanged: (double value) {
              setState(() {
                rate = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var r = Registo(peso, comeu, rate.round(), obs);
                  print(r);
                  if (obsComplete) {
                    print("entered");
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Registo adicionado com sucesso!")),
                    );
                  }
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
// TODO : save registos