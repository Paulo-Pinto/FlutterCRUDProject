import 'package:flutter/cupertino.dart';

class CustomTableCell extends StatefulWidget {
  final String media;
  final String variancia;
  final bool rating;

  // constructor
  const CustomTableCell({
    Key? key,
    required this.media,
    required this.variancia,
    required this.rating,
  }) : super(key: key);

  @override
  _CustomTableCell createState() => _CustomTableCell();
}

class _CustomTableCell extends State<CustomTableCell> {
  @override
  Widget build(BuildContext context) {
    if (widget.variancia != "") {
      Color colorVariance;
      if (widget.rating == true) {
        colorVariance = (double.parse(widget.variancia) > 0)
            ? Color(0xFF2BAD34)
            : Color(0xFFB71C1C);
      } else {
        colorVariance = (double.parse(widget.variancia) > 0)
            ? Color(0xFFB71C1C)
            : Color(0xFF2BAD34);
      }

      var sign = (double.parse(widget.variancia) > 0) ? "+" : "";

      return RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: widget.media),
            TextSpan(text: " / "),
            TextSpan(
                text: sign + widget.variancia + "%",
                style: TextStyle(color: colorVariance.withOpacity(0.9))),
          ],
        ),
      );
    } else {
      return RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(text: widget.media),
          ],
        ),
      );
    }
  }
}
