// widget formulario
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/registar_model.dart';
import '../screens/list_screen.dart';

class FormularioRegistoPreenchidoNaoEditavel extends StatefulWidget {
  const FormularioRegistoPreenchidoNaoEditavel({Key? key}) : super(key: key);

  @override
  _FormularioRegistoPreenchidoNaoEditavel createState() => _FormularioRegistoPreenchidoNaoEditavel();
}

class _FormularioRegistoPreenchidoNaoEditavel extends State<FormularioRegistoPreenchidoNaoEditavel> {
  final _formKey = GlobalKey<FormState>();

  double peso = 0;
  bool comeu = false;
  double rate = 1.0;
  String obs = "";
  bool obsComplete = false;

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
    final registoAtual = registarM.getActive();

    peso = registoAtual.peso;
    comeu = registoAtual.comeu;
    rate = registoAtual.rate;
    obs = registoAtual.obs;

    return Form(
      key: _formKey,
      child: Wrap(
        alignment: WrapAlignment.center,
        runSpacing: 20,
        children: <Widget>[
          TextFormField(
            initialValue: peso.toString(),
            decoration: const InputDecoration(
              icon: Icon(Icons.monitor_weight_rounded, size: 40),
              border: UnderlineInputBorder(),
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
            initialValue: (obs.isEmpty) ? "" : obs,
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
            title: Text("Alimentou-se nas últimas 3 horas?"),
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
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
            inactiveColor: const Color(0xB8B8B8FF),
            activeColor: Colors.blue,
            label: rate.round().toString(),
            onChanged: (double value) {
              setState(() {
                rate = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
