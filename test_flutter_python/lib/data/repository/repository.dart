
import 'package:test_flutter_python/domain/model.dart';

import 'package:test_flutter_python/domain/result.dart';


abstract class Repository {
 
/////////////////////////////////////////////


  Future<Result<Model>> getTicketSelect(int id,String serverDeveloperHost);


  Future<Result<List<Model>>> getListTickets(String serverDeveloperHost);


  Future<Result<bool>> setTicketSelect(Model model,String serverDeveloperHost);
 

  Future<Result<bool>> updateTicketSelect(Model model,String serverDeveloperHost);
  

  Future<Result<bool>> deleteTicketSelect(int id,String serverDeveloperHost);
  
  Future<Result<bool>> validserver(String serverDeveloperHost);
  
}
