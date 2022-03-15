import 'package:flutter/cupertino.dart';

import '../models/registar_model.dart';

class Ultimo extends StatelessWidget {
  // constructor
  const Ultimo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
    registarM.gerarRegistos();
    final last = registarM.lastRegisto();

    if (last != null) {
      return RichText(
          text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(text: '\nÚltimo Registo: a '),
                TextSpan(
                    text: last.formatDate(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' pesou '),
                TextSpan(
                    text: last.getPesoString(),
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ]));
    }

    return RichText(text: const TextSpan());
  }
}