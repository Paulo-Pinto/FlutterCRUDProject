import 'package:flutter/cupertino.dart';

import '../models/registar_model.dart';

class Primeiro extends StatelessWidget {
  // constructor
  const Primeiro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
    registarM.gerarRegistos();
    final first = registarM.firstRegisto();

    if (first != null) {
      return RichText(
          text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
            TextSpan(text: 'Primeiro Registo: a '),
            TextSpan(
                text: first.formatDate(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' pesou '),
            TextSpan(
                text: first.getPesoString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ]));
    }

    return RichText(text: const TextSpan());
  }
}
