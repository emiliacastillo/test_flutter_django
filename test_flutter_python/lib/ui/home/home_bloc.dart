import 'package:test_flutter_python/data/repository/repository.dart';

import 'package:test_flutter_python/domain/model.dart';
import 'package:test_flutter_python/domain/result.dart';
import 'package:test_flutter_python/ui/_base/bloc_base.dart';
import 'package:test_flutter_python/ui/_base/bloc_error_handler.dart';
import 'package:test_flutter_python/ui/_base/bloc_loading.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloC with ErrorHandlerBloC, LoadingBloC implements BaseBloC {
  final Repository _repository;

  HomeBloC(this._repository);

/////////////////////////////////////


BehaviorSubject<bool> _deleteTicketController = BehaviorSubject();

  Stream<bool> get deleteTicketStream => _deleteTicketController.stream;

  void deleteTicket(Model model,String serverDeveloperHost) async {
    try {
      isLoading = true;
      var result;
      result = await _repository.deleteTicketSelect(model.id, serverDeveloperHost);      
      if (result is ResultSuccess<bool>)
        sinkAdd(_deleteTicketController, result.value);
      else if (result is ResultError<bool>) onError(result.error);
      isLoading = false;
    } catch (ex) {
      print(ex);
    }
  }


  BehaviorSubject<List<Model>> _listTicketsController = BehaviorSubject();

  Stream<List<Model>> get listTicketsStream => _listTicketsController.stream;

  void getlistTickets(String serverDeveloperHost) async {
    try {
      final result = await _repository.getListTickets(serverDeveloperHost);
      if (result is ResultSuccess<List<Model>>)
        sinkAdd(_listTicketsController, result.value);
    } catch (ex) {
      print(ex);
    }
  }

  BehaviorSubject<Model> _ticketSelectController = BehaviorSubject();

  Stream<Model> get ticketSelectStream => _ticketSelectController.stream;

  void getTicketSelect(int id,String serverDeveloperHost) async {
    try {
      final result = await _repository.getTicketSelect(id, serverDeveloperHost);
      if (result is ResultSuccess<Model>)
        sinkAdd(_listTicketsController, result);
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void dispose() {
    _listTicketsController.close(); //////////////////
    _ticketSelectController.close();
    _deleteTicketController.close();
    disposeErrorHandlerBloC();
    disposeLoadingBloC();
  }
}
