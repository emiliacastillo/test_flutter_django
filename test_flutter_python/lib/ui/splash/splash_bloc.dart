import 'package:test_flutter_python/data/repository/repository.dart';
import 'package:test_flutter_python/ui/_base/bloc_base.dart';
import 'package:test_flutter_python/ui/_base/bloc_error_handler.dart';
import 'package:test_flutter_python/ui/_base/bloc_loading.dart';

class SplashBloC with LoadingBloC, ErrorHandlerBloC implements BaseBloC {
  final Repository _repository;

  SplashBloC(this._repository);
  @override
  void dispose() {
    disposeLoadingBloC();
    disposeErrorHandlerBloC();
  }
}
