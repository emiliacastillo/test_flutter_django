import 'package:rxdart/rxdart.dart';


class LoadingBloC {
  BehaviorSubject<bool> _loadingController = BehaviorSubject();

  Stream<bool> get isLoadingStream => _loadingController.stream;

  bool get isLoading => _loadingController.value;

  set isLoading(bool loading) {
    _loadingController.sink.add(loading);
  }

  void disposeLoadingBloC() {
    _loadingController.close();
  }
}
