// widget formulario
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/registar_model.dart';
import '../screens/list_screen.dart';

class FormularioRegistoPreenchidoNaoEditavel extends StatefulWidget {
  const FormularioRegistoPreenchidoNaoEditavel({Key? key}) : super(key: key);

  @override
  _FormularioRegistoPreenchidoNaoEditavel createState() =>
      _FormularioRegistoPreenchidoNaoEditavel();
}

class _FormularioRegistoPreenchidoNaoEditavel
    extends State<FormularioRegistoPreenchidoNaoEditavel> {
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
            enabled: false,
            initialValue: peso.toString(),
            decoration: const InputDecoration(
              icon: Icon(Icons.monitor_weight_rounded, size: 40),
              border: UnderlineInputBorder(),
              hintText: 'Quanto pesou hoje?',
              labelText: 'Peso',
            ),
          ),
          TextFormField(
            enabled: false,
            initialValue: (obs.isEmpty) ? "" : obs,
            maxLines: 3,
            maxLength: 200,
            decoration: const InputDecoration(
              icon: Icon(Icons.reviews, size: 40),
              border: OutlineInputBorder(),
              labelText: 'Observações (opcional)',
            ),
          ),
          CheckboxListTile(
            title: Text("Alimentou-se nas últimas 3 horas?"),
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            value: comeu,
            onChanged: (bool? value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 40),
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(children: <TextSpan>[
                TextSpan(
                  text: 'Como se sentiu:',
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
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
