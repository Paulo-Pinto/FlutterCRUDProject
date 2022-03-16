import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class RegistarModel {
  static RegistarModel? _instance;

  final _registos = [
    // Registo(58, true, 4, "Vincent Aboubakar", DateTime(2022, 3, 10, 15, 30)),
    // Registo(68, false, 1, "Moussa Marega", DateTime.now())
  ];
  final _pesosMap = {};
  final _pesosList = [];
  late Registo _active;

  bool gerados = false;

  void gerarRegistos() {
    // gera apenas uma vez
    if (gerados == true) return;

    var random = Random();
    var pesoInicial = 70.0;
    var month = 2;
    var day = 15;
    for (var i = 15; i < 45; i++) {
      pesoInicial += random.nextInt(4) - 2;

      day = i;
      if (i >= 28) {
        month = 3;
        day = i - 27;
      }
      var r = Registo(pesoInicial, random.nextBool(), random.nextInt(2) + 3,
          String.fromCharCode(i), DateTime(2022, month = month, day, 15, 30));
      _registos.add(r);
    }

    gerarPesos();
    gerados = true;
  }

  RegistarModel._internal();

  static getInstance() {
    _instance ??= RegistarModel._internal();
    return _instance;
  }

  void insert(Registo registo) => _registos.add(registo);

  List getAll() => _registos;

  List? getAllReversed() => _registos.reversed.toList();

  Registo getIndex(int index) => _registos[index];

  Registo getIndexFromLast(int index) => _registos[getLength() - 1 - index];

  void removeItem(Registo registo) => _registos.remove(registo);

  int getLength() => _registos.length;

  // List<FlSpot> getPesos() => _pesos.forEach((k, v) => FlSpot(k, v)).toList();
  List<FlSpot> getPesos() => _pesosList.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();

  // _registos.map((x) => FlSpot(double.parse("${DateFormat('MM').format(x.data)}${DateFormat('dd').format(x.data)}"), x.peso)).toList();

  double getMinPeso() =>
      _pesosList.reduce((curr, next) => curr < next ? curr : next);

  double getMaxPeso() =>
      _pesosList.reduce((curr, next) => curr > next ? curr : next);

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

  String getAverage(String choice, int dias) {
    var media = 0.0;
    var ctrRegistos = 0;
    for (Registo r in _registos) {
      if (r.getAgeInDays() > 0 && r.getAgeInDays() <= dias) {
        if (choice == "rate") {
          media += r.rate;
        } else {
          media += r.peso;
        }
        ctrRegistos++;
      }
    }

    return (media / ctrRegistos).toStringAsFixed(2);
  }

  double getMediaInRange(String choice, int inicio, int fim) {
    var media = 0.0;
    var ctrRegistos = 0;
    for (Registo r in _registos) {
      if (inicio < r.getAgeInDays() && r.getAgeInDays() <= fim) {
        if (choice == "rate") {
          media += r.rate;
        } else {
          media += r.peso;
        }
        ctrRegistos++;
      }
    }

    return (media / ctrRegistos);
  }

  String getVarianciaShort(String choice, int dias) {
    var media1 = getMediaInRange(choice, dias, dias * 2);
    var media2 = getMediaInRange(choice, 0, dias);

    // se não houver registos, sai
    if (media1.isNaN || media2.isNaN) {
      // print("Há um Nan $dias $choice");
      return "";
    }

    if (choice == "peso") {
      return (-((media1 - media2) / media1) * 100).toStringAsFixed(2);
    }

    return (-((media1 - media2) / media1) * 100).toStringAsFixed(2);
  }

  void setActive(Registo r) => _active = r;

  Registo getActive() => _active;

  Registo? getRegistoById(int id) {
    for (Registo r in _registos) {
      if (r.id == id) return r;
    }
    return null;
  }

  void gerarPesos() {
    var pos = 1;
    for (Registo r in _registos) {
      _pesosMap[pos++] = r.peso;
      if (_pesosList.length == 15) _pesosList.removeAt(0);
      _pesosList.add(r.peso);
    }
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

  // TODO : impedir que registos no futuro sejam criados
  Registo(this.peso, this.comeu, this.rate, this.obs, this.data) {
    if (obs.length < 100) obs = "";
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
        " - Pesou $peso kg, avaliou o seu dia com $rate/5, " + (!comeu ? "não " : "") + "comeu";
  }

  String formatDate() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy - H:mm');
    return formatter.format(data);
  }
}
