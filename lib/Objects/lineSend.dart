import 'package:desktop_app/Objects/Factory.dart';

class lineSend {

  String date;
  Factory factory;
  String observations;
  String state;

  lineSend({
    required this.date,
    required this.factory,
    required this.observations,
    required this.state
});

  @override
  String toString() {
    return 'lineSend{date: $date, factory: $factory, observations: $observations, state: $state}';
  }
}
