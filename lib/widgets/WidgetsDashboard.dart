import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/registar_model.dart';
import 'custom_table_cell.dart';

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

class TableMedias extends StatelessWidget {
  // constructor
  const TableMedias({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registarM = RegistarModel.getInstance();
    registarM.gerarRegistos();

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
            border: TableBorder.all(color: Color(0xc1a5b0b3)),
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
                  child: CustomTableCell(
                      media: registarM.getMediaPeso(7),
                      variancia: registarM.getVarianciaPeso(7),
                      rating: false),
                ),
                Center(
                  child: CustomTableCell(
                      media: registarM.getMediaPeso(30),
                      variancia: registarM.getVarianciaPeso(30),
                      rating: false),
                ),
              ]),
              TableRow(children: [
                const Center(
                  child: Text('Rating'),
                ),
                Center(
                  child: CustomTableCell(
                      media: registarM.getMediaRate(7),
                      variancia: registarM.getVarianciaRate(7),
                      rating: true),
                ),
                Center(
                  child: CustomTableCell(
                      media: registarM.getMediaRate(30),
                      variancia: registarM.getVarianciaRate(30),
                      rating: true),
                ),
              ]),
            ]),
      ),
    );
  }
}


