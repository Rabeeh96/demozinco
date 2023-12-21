
import 'package:http/http.dart';

import '../../Api Helper/ModelClasses/contact/ListContactModelClass.dart';
import '../../Api Helper/Repository/api_client.dart';



class PaginationContactApi {
  ApiClient apiClient = ApiClient();
  ListContactModelClass listContactModelClass = ListContactModelClass();



  Future<Response> contacttListFunction(
      {required String organisation,
        required int page_number,
        required int page_size,
        required String search}) async {
    final String path = "contacts/list-contact/";
    final body = {
      "organization": organisation,
      "page_number": page_number,
      "page_size": page_size,
      "search": search
    };

    Response response =
    await apiClient.invokeAPI(path: path, method: "POST", body: body);
    return response;
  }



}
