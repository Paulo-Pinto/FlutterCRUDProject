import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/registar_model.dart';

class Primeiro extends StatelessWidget {
  // constructor
  const Primeiro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
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

class Ultimo extends StatelessWidget {
  // constructor
  const Ultimo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
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

class TableMedias extends StatelessWidget {
  // constructor
  const TableMedias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();

    return Container(
      padding: EdgeInsets.all(2.0),
      child: Container(
        // constraints: const BoxConstraints(
        //   minWidth: 200,
        //   maxWidth: 400,
        // ),
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Table(
            // TODO : remove border + stylize table
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },
            border: TableBorder.all(color: Colors.grey),
            children: [
              const TableRow(children: [
                Center(
                  child: Text(''),
                ),
                Center(
                  child: Text('7 dias'),
                ),
                Center(
                  child: Text('30 dias'),
                ),
              ]),
              TableRow(children: [
                const Center(
                  child: Text(
                    'Peso',
                  ),
                ),
                Center(
                  child: Text(registarM.getMediaPeso(7) +
                      " " +
                      registarM.getVarianciaPeso(7)),
                ),
                Center(
                  child: Text(registarM.getMediaPeso(30) +
                      " " +
                      registarM.getVarianciaPeso(30)),
                ),
              ]),
              TableRow(children: [
                const Center(
                  child: Text('Rating'),
                ),
                Center(
                  child: Text(registarM.getMediaRate(7) +
                      " " +
                      registarM.getVarianciaRate(7)),
                ),
                Center(
                  child: Text(registarM.getMediaRate(30) +
                      " " +
                      registarM.getVarianciaRate(30)),
                ),
              ]),
            ]),
      ),
    );
  }
}
