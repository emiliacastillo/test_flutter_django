import 'package:test_flutter_python/data/repository/repository.dart';
import 'package:test_flutter_python/domain/result.dart';
import 'package:test_flutter_python/ui/_base/bloc_base.dart';
import 'package:test_flutter_python/ui/_base/bloc_error_handler.dart';
import 'package:test_flutter_python/ui/_base/bloc_loading.dart';
import 'package:rxdart/rxdart.dart';

class SelectIpdBloC with LoadingBloC, ErrorHandlerBloC implements BaseBloC {
  final Repository _repository;

  SelectIpdBloC(this._repository);

  
////////////////////////////////////////////////////////////////



  BehaviorSubject<bool> _validserverController = BehaviorSubject();

  Stream<bool> get validserverStream => _validserverController.stream;

  void validserver(String serverDeveloperHost) async {
    try {
      isLoading = true;
      var result = await _repository.validserver(serverDeveloperHost);
      if (result is ResultSuccess<bool>)
        sinkAdd(_validserverController, result.value);
      else if (result is ResultError<bool>) onError(result.error);
      isLoading = false;
    } catch (ex) {
      print(ex);
    }
  }




  @override
  void dispose() {
    _validserverController.close(); /////////////
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
  }
}
