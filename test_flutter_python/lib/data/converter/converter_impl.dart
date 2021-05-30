import 'package:test_flutter_python/data/converter/converter.dart';
import 'package:test_flutter_python/domain/model.dart';
 
class ConverterImpl implements ApiConverter {
  @override
  Model modelFromJson(Map<String, dynamic> json) {
    var model = Model();
    try {
      model.id = json['id'];
      model.title = json['title'];      
      return model;
    } catch (ex) {
      print(ex);
      return model;
    }
  }

  @override
  Map<String, dynamic> modelToJson(Model model) => {
        'id': model.id,
        'title': model.title ,
      };

 
}
