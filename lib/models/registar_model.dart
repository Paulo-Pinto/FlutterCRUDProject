import 'package:intl/intl.dart';

class RegistarModel {
  static RegistarModel? _instance;

  final _registos = [
    Registo(58, true, 4, "Vincent Aboubakar"),
    Registo(68, false, 1, "Moussa Marega")
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
}

class Registo {
  static int lastId = 0;
  int id = lastId + 1;
  double peso = 0;
  bool comeu = false;
  int rate = 1;
  String obs = "";
  DateTime data = DateTime.now();

  Registo(this.peso, this.comeu, this.rate, this.obs){
    lastId++;
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
