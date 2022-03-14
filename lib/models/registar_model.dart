import 'package:intl/intl.dart';

class RegistarModel {
  static RegistarModel? _instance;
  final _registos = [
    Registo(58, true, 4, "Vincent Aboubakar"),
    Registo(68, false, 1, "Moussa Marega")
  ];

  // final registos = [];

  RegistarModel._internal();

  static getInstance() {
    _instance ??= RegistarModel._internal();
    return _instance;
  }

  void insert(operation) => _registos.add(operation);

  List getAll() => _registos;

  Registo getIndex(int index) => _registos[index];

  void removeItem(Registo registo) => _registos.remove(registo);

  int getLength() => _registos.length;
}

class Registo {
  double peso = 0;
  bool comeu = false;
  int rate = 1;
  String obs = "";
  DateTime data = DateTime.now();

  Registo(this.peso, this.comeu, this.rate, this.obs);

  @override
  String toString() {
    return 'Registo{peso: $peso, comeu: $comeu, rate: $rate, obs: ' +
        ((obs == "") ? "Nenhuma" : obs) +
        ', data: ' +
        formatDate() +
        '}';
  }

  String formatDate() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy H:mm');
    // final String formatted = formatter.format(data);
    return formatter.format(data);
  }
}
