
import 'package:crud_factories/Backend/Feature/Connection/ExecuteQuery/IexecuteQuery.dart'
    show Iexecutequery;

abstract class ITransactionalExecuteQuery implements Iexecutequery {
  Future<void> transaction(
      Future<void> Function(Iexecutequery executor) action,
      );
}