import 'dart:convert';
import 'dart:developer';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Loan/DeleteLoanModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Loan/DetailLoanModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Loan/EditLoanModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/ModelClasses/Loan/ListLoanModelClass.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Repository/api_client.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../ModelClasses/Loan/LoanCreateModelClass.dart';
import '../../ModelClasses/Loan/LoanViewModelClass.dart';

class LoanApi{
  ApiClient apiClient = ApiClient();
  LoanCreateModelClass loanCreateModelClass = LoanCreateModelClass();
  ListLoanModelClass listLoanModelClass = ListLoanModelClass();
  DetailLoanModelClass detailLoanModelClass = DetailLoanModelClass();
  EditLoanModelClass editLoanModelClass = EditLoanModelClass();
  DeleteLoanModelClass deleteLoanModelClass = DeleteLoanModelClass();
  LoanViewModelClass loanViewModelClass = LoanViewModelClass();
  Future<LoanCreateModelClass> CreateLoanFunction(
      {required String organization,
        required String loanName,
        required String loanType,
        required String day,
        required String amount,
        required String interest,
        required String paymentCycle,
        required String duration,
        required String interestAmount,
        required String processingFee,
        required String totalAmount,
        required bool isManual,
        required bool isExisting,
        required String account,
        required String date,
        required List reminderList,
      }) async {
    final String path = "loans/create-loans/";



    final body = {
      "date":date,
      "organization":organization,
      "loan_name":loanName,
      "loan_type":loanType,
      "amount":amount,
      "interest":interest,
      "day":day,
      "payment_cycle":paymentCycle,
      "duration": duration,
      "interest_amount":interestAmount,
      "processing_fee":processingFee,
      "total_amount":totalAmount,
      "is_manual": isManual,
      "is_existing":isExisting,
      "account":account,
      "reminder": reminderList
    };


    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);


    log("_________________ create loan  in api  $body");
    return LoanCreateModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<ListLoanModelClass> ListLoanFunction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final organizationId =   prefs.getString("organisation");
    final String path = "loans/list-loans/";

    final country_id = prefs.getString("country_id");
    final body = {
      "organization":organizationId,
      "country_id":country_id
    };

    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);


    log("_________________ list loan  in api  $body");
    return ListLoanModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  Future<DetailLoanModelClass> DetailLoanFunction(
      {required String id,
        required String organisation}) async {
    final String path = "loans/details-loans/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "id": id,
      "country_id": country_id,
      "organization": organisation
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("_________________detail loan  in api  $body");
    return DetailLoanModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
  Future<EditLoanModelClass> EditLoanFunction(
      {required String organization,
        required String loanName,
        required String date,
        required String day,
        required String loanType,
        required String amount,
        required String interest,
        required String paymentCycle,
        required String duration,
        required String interestAmount,
        required String processingFee,
        required String totalAmount,
        required bool isManual,
        required bool isExisting,
        required String account,
        required String id,
        required List reminderList,
      }) async {
    final String path = "loans/update-loans/";
    final body = {
      "organization":organization,
      "loan_name":loanName,
      "loan_type":loanType,
      "date":date,
      "day":day,
      "amount":amount,
      "interest":interest,
      "payment_cycle":paymentCycle,
      "duration": duration,
      "interest_amount":interestAmount,
      "processing_fee":processingFee,
      "total_amount":totalAmount,
      "is_manual": isManual,
      "is_existing":isExisting,
      "account":account,
      "reminder":reminderList,
      "id": id
    };
    Response response = await apiClient.invokeAPI(path: path, method: "POST", body: body);
    log("_________________edit loan  in api  $body");
    log("_________________edit loan  in api  .....................................................");
    return EditLoanModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<DeleteLoanModelClass> DeleteLoanFunction(
      {required String id,
        required String organisation}) async {
    final String path = "loans/delete-loans/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    final body = {
      "id": id,
      "country_id": country_id,
      "organization": organisation
    };
    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("_________________delete loan  in api  $body");
    return DeleteLoanModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  Future<LoanViewModelClass> loanViewFunction(
      {required String id,
        required String organisation}) async {
    final String path = "loans/view-loans/";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final country_id = prefs.getString("country_id");
    print(path);
    final body = {
      "country_id": country_id,
      "id": id,
      "organization": organisation
    };
    print(body);

    Response response = await apiClient.invokeAPI(
        path: path, method: "POST", body: body);
    log("_________________view loan  in api  $body");
    return LoanViewModelClass.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


}