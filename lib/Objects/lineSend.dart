import 'package:crud_factories/Objects/Factory.dart';

class lineSend {

  String date;
  String factory;
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
