import 'package:flutter/material.dart';

import '../models/registar_model.dart';
import 'custom_table_cell.dart';

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
            // TODO : stylize table
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(3),
            },

            // border: TableBorder.all(color: Color(0xc1a5b0b3)),
            border: TableBorder.symmetric(
              inside: const BorderSide(width: 0.8, color: Color(0xc1a5b0b3)),
            ),
            // border: TableBorde,
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
                      media: registarM.getAverage("peso",7),
                      variancia: registarM.getVarianciaShort("peso",7),
                      rating: false),
                ),
                Center(
                  child: CustomTableCell(
                      media: registarM.getAverage("peso",30),
                      variancia: registarM.getVarianciaShort("peso",30),
                      rating: false),
                ),
              ]),
              TableRow(children: [
                const Center(
                  child: Text('Rating'),
                ),
                Center(
                  child: CustomTableCell(
                      media: registarM.getAverage("rate",7),
                      variancia: registarM.getVarianciaShort("rate",7),
                      rating: true),
                ),
                Center(
                  child: CustomTableCell(
                      media: registarM.getAverage("rate",30),
                      variancia: registarM.getVarianciaShort("rate",30),
                      rating: true),
                ),
              ]),
            ]),
      ),
    );
  }
}
