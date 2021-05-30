import 'package:test_flutter_python/domain/model.dart';

abstract class ApiConverter {
 
  //////////////////////

  Map<String, dynamic> modelToJson(Model model);

  Model modelFromJson(Map<String, dynamic> json);
}
