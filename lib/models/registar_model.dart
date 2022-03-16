import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class RegistarModel {
  static RegistarModel? _instance;

  final _registos = [
    // Registo(58, true, 4, "Vincent Aboubakar", DateTime(2022, 3, 10, 15, 30)),
    // Registo(68, false, 1, "Moussa Marega", DateTime.now())
  ];
  final _pesos = {};
  final _pesosL = [];

  bool gerados = false;

  void gerarRegistos() {
    // gera apenas uma vez
    if (gerados == true) return;

    var random = Random();
    var pesoInicial = 70.0;
    var month = 2;
    var day = 15;
    for (var i = 15; i < 45; i++) {
      pesoInicial += random.nextInt(10) - 5;

      day = i;
      if (i >= 28) {
        month = 3;
        day = i - 27;
      }
      var r = Registo(pesoInicial, random.nextBool(), random.nextInt(4) + 1,
          String.fromCharCode(i), DateTime(2022, month = month, day, 15, 30));
      _registos.add(r);
    }
    // TODO : remove map _pesos
    var pos = 1;
    for (Registo r in _registos) {
      _pesos[pos++] = r.peso;
      if (_pesosL.length == 15) _pesosL.removeAt(0);
      _pesosL.add(r.peso);
    }
    gerados = true;
  }

  RegistarModel._internal();

  static getInstance() {
    _instance ??= RegistarModel._internal();
    return _instance;
  }

  void insert(Registo registo) => _registos.add(registo);

  List getAll() => _registos;

  Registo getIndex(int index) => _registos[index];

  void removeItem(Registo registo) => _registos.remove(registo);

  int getLength() => _registos.length;

  // List<FlSpot> getPesos() => _pesos.forEach((k, v) => FlSpot(k, v)).toList();
  List<FlSpot> getPesos() => _pesosL.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();

  // _registos.map((x) => FlSpot(double.parse("${DateFormat('MM').format(x.data)}${DateFormat('dd').format(x.data)}"), x.peso)).toList();

  double getMinPeso() {
    var l = [];
    _pesos.forEach((k, v) => l.add(v));
    return l.reduce((curr, next) => curr < next ? curr : next);
  }

  double getMaxPeso() {
    var l = [];
    _pesos.forEach((k, v) => l.add(v));
    return l.reduce((curr, next) => curr > next ? curr : next);
  }

  // double getMaxPeso() =>
  //     _pesos.reduce((curr, next) => curr > next ? curr : next);

  Registo? firstRegisto() {
    if (_registos.isEmpty) return null;

    Registo oldest = _registos[0];

    for (var r in _registos) {
      if (r.data.compareTo(oldest.data) < 0) {
        oldest = r;
      }
    }

    return oldest;
  }

  Registo? lastRegisto() {
    if (_registos.isEmpty) return null;

    Registo latest = _registos[0];

    for (var r in _registos) {
      if (r.data.compareTo(latest.data) > 0) {
        latest = r;
      }
    }

    return latest;
  }

  String getMediaPeso(int dias) {
    var media = 0.0;
    var ctrRegistos = 0;
    for (Registo r in _registos) {
      if (r.getAgeInDays() > 0 && r.getAgeInDays() <= dias) {
        media += r.peso;
        ctrRegistos++;
      }
    }

    print("$dias media $media for $ctrRegistos = " +
        (media / ctrRegistos).toStringAsFixed(2));
    return (media / ctrRegistos).toStringAsFixed(2);
  }

  double getMediaPesoInRange(int diasAtrasInicio, int diasAtrasFim) {
    var media = 0.0;
    var ctrRegistos = 0;
    for (Registo r in _registos) {
      if (diasAtrasInicio <= r.getAgeInDays() &&
          r.getAgeInDays() <= diasAtrasFim) {
        media += r.peso;
        ctrRegistos++;
      }
    }
    print(
        "in range $diasAtrasInicio to $diasAtrasFim media $media for $ctrRegistos");
    return (media / ctrRegistos);
  }

  // TODO : fix this
  String getVarianciaPesoShort(int dias) {
    // antigo (dias 1 a 7)

    var media1 = getMediaPesoInRange(dias, dias * 2);
    var media2 = getMediaPesoInRange(0, dias);

    if (media1 == 0.0 || media2 == 0.0) {
      return "";
    }

    return (((media1 - media2) / media1) * 100).toStringAsFixed(2);
  }

  String getVarianciaPeso(int dias) {
    // antigo (dias 1 a 7)
    var media1 = 0.0;
    var ctrRegistos1 = 0;

    for (Registo r in _registos) {
      // dias < x < 2dias
      if (dias < r.getAgeInDays() && r.getAgeInDays() <= dias * 2) {
        media1 += r.peso;
        ctrRegistos1++;
      }
    }

    // recente (dias 8 a 15)
    var media2 = 0.0;
    var ctrRegistos2 = 0;

    for (Registo r in _registos) {
      // x < dias
      if (r.getAgeInDays() <= dias) {
        media2 += r.peso;
        ctrRegistos2++;
      }
    }

    media1 = double.parse((media1 / ctrRegistos1).toStringAsFixed(2));
    media2 = double.parse((media2 / ctrRegistos2).toStringAsFixed(2));

    if (ctrRegistos2 == 0 || ctrRegistos1 == 0) {
      return "";
    }

    print(
        "VARIANCE \n $dias media ($media1 in $ctrRegistos1), ($media2 in $ctrRegistos2) = " +
            (((media1 - media2) / media1) * 100).toStringAsFixed(2));

    return (((media1 - media2) / media1) * 100).toStringAsFixed(2);
  }

  String getVarianciaRate(int dias) {
    // antigo (dias 1 a 7)
    var media1 = 0.0;
    var ctrRegistos1 = 0;

    for (Registo r in _registos) {
      // dias < x < 2dias
      if (dias < r.getAgeInDays() && r.getAgeInDays() <= dias * 2) {
        media1 += r.rate;
        ctrRegistos1++;
      }
    }

    // recente (dias 8 a 15)
    var media2 = 0.0;
    var ctrRegistos2 = 0;

    for (Registo r in _registos) {
      // x < dias
      if (r.getAgeInDays() <= dias) {
        media2 += r.rate;
        ctrRegistos2++;
      }
    }

    media1 = (media1 / ctrRegistos1);
    media2 = (media2 / ctrRegistos2);
    // após 1 mês de dados, começar a mostrar variancia após 30 dias
    if (ctrRegistos2 == 0 || ctrRegistos1 == 0) {
      return "";
    }

    return (((media1 - media2) / media1) * 100).toStringAsFixed(2);
  }

  String getMediaRate(int dias) {
    var media = 0.0;
    var ctrRegistos = 0;
    for (Registo r in _registos) {
      if (r.getAgeInDays() <= dias) {
        media += r.rate;
        ctrRegistos++;
      }
    }

    return (media / ctrRegistos).toStringAsFixed(2);
  }
}

class Registo {
  static int lastId = 0;
  int id = lastId + 1;
  double peso = 0;
  bool comeu = false;
  int rate = 1;
  String obs = "";
  DateTime data = DateTime.now();

  Registo(this.peso, this.comeu, this.rate, this.obs, this.data) {
    lastId++;
  }

  String getPesoString() => peso.toString() + " kg";

  int getAgeInDays() {
    var dataOg = DateTime(data.year, data.month, data.day);
    var d = DateTime.now();
    d = DateTime(d.year, d.month, d.day);
    return (d.difference(dataOg).inHours / 24).round();
  }

  @override
  String toString() {
    return 'Registo $id {peso: $peso, comeu: $comeu, rate: $rate, obs: ' +
        ((obs == "") ? "Nenhuma" : obs) +
        ', data: ' +
        formatDate() +
        '}';
  }

  String toDisplay() {
    return formatDate() +
        " - Pesou ${peso} kg, " +
        (!comeu ? "não " : "") +
        "comeu, e avaliou o seu dia com $rate/5";
  }

  String formatDate() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy - H:mm');
    // final String formatted = formatter.format(data);
    return formatter.format(data);
  }
}
