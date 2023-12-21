import 'dart:convert';

import 'package:http/http.dart';


import '../../../ModelClasses/Settings/Country/CreateCountryModelClass.dart';
import '../../../ModelClasses/Settings/Country/DefaultCountryModelClass.dart';
import '../../../ModelClasses/Settings/Country/DeleteCountryModelClass.dart';
import '../../../ModelClasses/Settings/Country/DetailCountryModelClass.dart';
import '../../../ModelClasses/Settings/Country/EditCountryModelClass.dart';
import '../../../ModelClasses/Settings/Country/ListCountryModelClass.dart';
import '../../../ModelClasses/Settings/Country/SetAsDefaultCountryModelClass.dart';
import '../../../Repository/api_client.dart';

class CountryApi{

  ApiClient apiClient = ApiClient();
  DefaultCountryModelClass defaultCountryModelClass = DefaultCountryModelClass();
  ListCountryModelClass listCountryModelClass = ListCountryModelClass();
  DetailCountryModelClass detailCountryModelClass = DetailCountryModelClass();
  EditCountryModelClass editCountryModelClass= EditCountryModelClass();
  DeleteCountryModelClass deleteCountryModelClass = DeleteCountryModelClass();
  CreateCountryModelClass createCountryModelClass = CreateCountryModelClass();
  SetAsDefaultCountryModelClass setAsDefaultCountryModelClass = SetAsDefaultCountryModelClass();


  Future<DefaultCountryModelClass> defaultCountryList({required String Search}) async {
    final body = {
      "search": Search,
    };
    final String path = "country/list-default-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST_", body: body);


    return DefaultCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<CreateCountryModelClass> createCountryList({required String organisation, required String country}) async {
    final body = {
      "organization": organisation,
      "country": country
    };
    final String path = "country/create-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return CreateCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ListCountryModelClass> listCountryList({required String organisation,required String search}) async {
    final body = {
      "organization": organisation,
      "search":search

    };
    final String path = "country/list-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return ListCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DetailCountryModelClass> detailCountryList({required String organisation,required String id}) async {
    final body = {
      "organization": organisation,
      "id":id

    };
    final String path = "country/details-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DetailCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<EditCountryModelClass> editCountryList({required String organisation,required String country, required String id}) async {
    final body = {
      "organization": organisation,
      "country":country,
      "id":id

    };
    final String path = "country/update-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return EditCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<DeleteCountryModelClass> deleteCountryList({required String organisation, required String id}) async {
    final body = {
      "id":id,
      "organization": organisation
    };
    final String path = "country/delete-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return DeleteCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<SetAsDefaultCountryModelClass> setAsDefaultCountryFunction({required bool isDefault, required String id}) async {
    final body = {
      "id":id,
      "is_default":isDefault
    };
    final String path = "country/default-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    return SetAsDefaultCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DefaultCountryModelClass> defaultCountry({required String Search}) async {
    final body = {
      "search": Search,
    };
    final String path = "country/list-default-country/";
    Response response = await apiClient.invokeAPI(
        path: path, method: "LOGIN", body: body);


    return DefaultCountryModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }







}