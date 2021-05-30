import 'package:test_flutter_python/data/repository/repository.dart';
import 'package:test_flutter_python/domain/model.dart';
import 'package:test_flutter_python/domain/result.dart';
import 'package:test_flutter_python/ui/_base/bloc_base.dart';
import 'package:test_flutter_python/ui/_base/bloc_error_handler.dart';
import 'package:test_flutter_python/ui/_base/bloc_loading.dart';
import 'package:rxdart/rxdart.dart';

class NewRecordBloC with LoadingBloC, ErrorHandlerBloC implements BaseBloC {
  final Repository _repository;

  NewRecordBloC(this._repository);

  
////////////////////////////////////////////////////////////////



  BehaviorSubject<bool> _saveTicketController = BehaviorSubject();

  Stream<bool> get saveTicketStream => _saveTicketController.stream;

  void saveTicket(Model model,String serverDeveloperHost) async {
    try {
      isLoading = true;
      var result;
      if(model.id!=null)
        result = await _repository.updateTicketSelect(model,serverDeveloperHost);
      else
         result = await _repository.setTicketSelect(model,serverDeveloperHost);
      if (result is ResultSuccess<bool>)
        sinkAdd(_saveTicketController, result.value);
      else if (result is ResultError<bool>) onError(result.error);
      isLoading = false;
    } catch (ex) {
      print(ex);
    }
  }

BehaviorSubject<bool> _deleteTicketController = BehaviorSubject();

  Stream<bool> get deleteTicketStream => _deleteTicketController.stream;

  void deleteTicket(Model model,String serverDeveloperHost) async {
    try {
      isLoading = true;
      var result;
      result = await _repository.deleteTicketSelect(model.id,serverDeveloperHost);      
      if (result is ResultSuccess<bool>)
        sinkAdd(_deleteTicketController, result.value);
      else if (result is ResultError<bool>) onError(result.error);
      isLoading = false;
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void dispose() {
    _saveTicketController.close(); /////////////
    _deleteTicketController.close(); /////////////
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
  }
}
