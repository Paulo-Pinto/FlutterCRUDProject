import 'package:intl/intl.dart';

class RegistarModel {
  static RegistarModel? _instance;

  final _registos = [
    Registo(58, true, 4, "Vincent Aboubakar", DateTime(2022, 3, 10, 15, 30)),
    Registo(68, false, 1, "Moussa Marega", DateTime.now())
  ];

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

  Registo? firstRegisto(){
    if(_registos.isEmpty) return null;

    Registo oldest = _registos[0];

    for(var r in _registos){
      if(r.data.compareTo(oldest.data) < 0){
        oldest = r;
      }
    }

    return oldest;
  }

  Registo? lastRegisto(){
    if(_registos.isEmpty) return null;

    Registo latest = _registos[0];

    for(var r in _registos){
      if(r.data.compareTo(latest.data) > 0){
        latest = r;
      }
    }

    return latest;
  }

  String getMediaPeso(int dias) {
    var media = 0.0;
    var ctrRegistos = 0;
    for (Registo r in _registos) {
      if (r.getAgeInDays() <= dias) {
        media += r.peso;
        ctrRegistos++;
      }
    }

    return (media / ctrRegistos).toString();
  }

  double getMediaPesoInRange(int diasAtrasInicio, int diasAtrasFim) {
    var media = 0.0;
    var ctrRegistos = 0;
    for (Registo r in _registos) {
      if (diasAtrasInicio < r.getAgeInDays() &&
          r.getAgeInDays() <= diasAtrasFim) {
        media += r.peso;
        ctrRegistos++;
      }
    }

    return (media / ctrRegistos);
  }

  // TODO : testar esta função
  String getVarianciaPesoShort(int dias) {
    // antigo (dias 1 a 7)

    var media1 = getMediaPesoInRange(dias, dias * 2);
    var media2 = getMediaPesoInRange(0, dias);

    if (media1 == 0.0 || media2 == 0.0) {
      return "";
    }

    return (((media1 - media2) / media1) * 100).toString();
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

    media1 = (media1 / ctrRegistos1);
    media2 = (media2 / ctrRegistos2);

    if (ctrRegistos2 == 0 || ctrRegistos1 == 0) {
      return "";
    }

    return (((media1 - media2) / media1) * 100).toString();
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

    if (ctrRegistos2 == 0 || ctrRegistos1 == 0) {
      return "";
    }

    return (((media1 - media2) / media1) * 100).toString();
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

    return (media / ctrRegistos).toString();
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
        (!comeu ? " não " : "") +
        "comeu, e avaliou o seu dia com $rate/5";
  }

  String formatDate() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy - H:mm');
    // final String formatted = formatter.format(data);
    return formatter.format(data);
  }
}
