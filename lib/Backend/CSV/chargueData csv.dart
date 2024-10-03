import 'package:crud_factories/Backend/CSV/importConections.dart';
import 'package:crud_factories/Backend/CSV/importEmpleoyes.dart';
import 'package:crud_factories/Backend/CSV/importFactories.dart';
import 'package:crud_factories/Backend/CSV/importLines.dart';
import 'package:crud_factories/Backend/CSV/importMails.dart';
import 'package:crud_factories/Backend/CSV/importSectors.dart';
import 'package:crud_factories/Backend/data.dart';
import 'package:crud_factories/Objects/Empleoye.dart';

void chargueDataCSV(){

  sectors.clear();
  try {
    sectors.add(csvImportSectors(fileContent,sectors));
  } catch (Exeption) {

  }

  factories.clear();
  try {
    factories.add(csvImportFactories(fileContent, factories));
  } catch (Exeption) {

  }

  empleoyes.clear();
  try{
     empleoyes.add(csvImportEmpleoyes(fileContent, empleoyes));
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

