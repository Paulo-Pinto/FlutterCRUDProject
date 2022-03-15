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

  double peso = 0;
  bool comeu = false;
  double rate = 1.0;
  String obs = "";
  bool obsComplete = false;

  @override
  Widget build(BuildContext context) {
    final registoM = RegistarModel.getInstance();

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
                    action: SnackBarAction(
                      label: 'Fechar',
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
                if (_formKey.currentState!.validate() && obsComplete) {
                  var r = Registo(peso, comeu, rate.round(), obs);
                  print(r);
                  registoM.insert(r);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        const Text("O seu registo foi adicionado com sucesso."),
                    duration: const Duration(seconds: 15),
                    action: SnackBarAction(
                      label: 'Aceder',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        // TODO : Criar página única para registo
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => RegistoScreen(registo)),
                        // );
                      },
                    ),
                  ));
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

// TODO : organize build method (divide into widgets)
