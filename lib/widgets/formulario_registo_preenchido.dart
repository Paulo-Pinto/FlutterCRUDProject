// widget formulario
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/registar_model.dart';
import '../screens/list_screen.dart';

class FormularioRegistoPreenchido extends StatefulWidget {
  const FormularioRegistoPreenchido({Key? key}) : super(key: key);

  @override
  _FormularioRegistoPreenchido createState() => _FormularioRegistoPreenchido();
}

class _FormularioRegistoPreenchido extends State<FormularioRegistoPreenchido> {
  final _formKey = GlobalKey<FormState>();

  double peso = 0;
  bool comeu = false;
  double rate = 3.0;
  String obs = "";
  bool obsComplete = false;

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
    final registoAtual = registarM.getActive();

    peso = registoAtual.peso;
    // comeu = registoAtual.comeu;
    // rate = registoAtual.rate;
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
              peso = double.parse(double.parse(value).toStringAsFixed(2));
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
          const SizedBox(height: 40),
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'Como se sente hoje?',
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
                TextSpan(
                  text: '\n1 - Muito mal / 5 - Muito bem',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ])),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 14,
                  fixedSize: const Size(140, 60),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  textStyle: const TextStyle(
                    fontSize: 24,
                  )),
              onPressed: () {
                if (_formKey.currentState!.validate() && obsComplete) {
                  var r = registarM.getRegistoById(registoAtual.id);
                  r.peso = peso;
                  r.comeu = comeu;
                  r.rate = rate.round();
                  r.obs = obs;
                  // recalcular pesos, para atualizar o gráfico
                  registarM.gerarPesos();

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        const Text("O seu registo foi editado com sucesso."),
                    duration: const Duration(seconds: 15),
                    action: SnackBarAction(
                      label: 'Voltar',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ListScreen()),
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ));
                }
              },
              child: const Text('Editar'),
            ),
          ),
        ],
      ),
    );
  }
}

// TODO : organize build method (divide into widgets)
