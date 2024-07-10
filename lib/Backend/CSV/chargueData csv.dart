import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/data.dart';

void chargueDataCSV(){

  factories.clear();
  try {
    factories.add(csvImportFactories(fileContent, factories));
  } catch (Exeption) {

  }

  mails.clear();
  try {
    mails.add(csvImportMails(fileContent, mails));
  } catch (Exeption) {

  }

  line.clear();
  try {
    line.add(csvImportLines(fileContent, line));
  } catch (Exeption) {

  }

}