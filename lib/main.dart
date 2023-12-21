import 'package:camera/camera.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Dashboard_Detail/dashboard_detail.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Delete_user/delete_user.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/New%20design_%20apis/api_expense.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Recievables_Payables/receivables_payables.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/Reminder/reminder_api.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/asset%20new%20design%20api/asset_api.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/asset%20new%20design%20api/property_api.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/asset%20new%20design%20api/stock_apis.dart';
import 'package:cuentaguestor_edit/Api%20Helper/Api_Functions/otp/otp_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Api Helper/Api_Functions/Account/account_api.dart';
import 'Api Helper/Api_Functions/Contact/contact.dart';
import 'Api Helper/Api_Functions/Dashboard_Detail/transaction_detail.dart';
import 'Api Helper/Api_Functions/Expense/expense_api.dart';
import 'Api Helper/Api_Functions/ForgetPasswordApi/forget_password_api.dart';
import 'Api Helper/Api_Functions/Income/income_api.dart';
import 'Api Helper/Api_Functions/Loan/loan_api.dart';
import 'Api Helper/Api_Functions/Login/login.dart';
import 'Api Helper/Api_Functions/New design_ apis/api_income.dart';
import 'Api Helper/Api_Functions/Profile/profile_api.dart';
import 'Api Helper/Api_Functions/SettingsApi/CountryApi/country_api.dart';
import 'Api Helper/Api_Functions/SettingsApi/settings_api.dart';
import 'Api Helper/Api_Functions/Sign up/signup_api.dart';
import 'Api Helper/Api_Functions/TransactionContact/transaction_contact.dart';
import 'Api Helper/Api_Functions/User/user_api.dart';
import 'Api Helper/Api_Functions/UsroleApi/userole_api.dart';
import 'Api Helper/Api_Functions/dashboard/dashboard.dart';
import 'Api Helper/Api_Functions/transacton/transaction_api.dart';
import 'Api Helper/Api_Functions/zakath or interest/zakath_interest_api.dart';
import 'Api Helper/Bloc/Account/account_bloc.dart';
import 'Api Helper/Bloc/Contact/contact_bloc.dart';
import 'Api Helper/Bloc/Country/country_bloc.dart';
import 'Api Helper/Bloc/DashBoard/dash_board_bloc.dart';
import 'Api Helper/Bloc/Dashboard_Zakath_Interest_bloc/zakath_interest_list_bloc.dart';
import 'Api Helper/Bloc/Dashborad_Receivables_payables/payables_receivable_bloc.dart';
import 'Api Helper/Bloc/Delt User/delete_user_bloc.dart';
import 'Api Helper/Bloc/Expense/expense_bloc.dart';
import 'Api Helper/Bloc/Forget_Password/forget_password_bloc.dart';
import 'Api Helper/Bloc/Income/income_bloc.dart';
import 'Api Helper/Bloc/Loan/loan_bloc.dart';
import 'Api Helper/Bloc/Login/login_bloc.dart';
import 'Api Helper/Bloc/NewDesignBloc/expnse/exptransaction_bloc.dart';
import 'Api Helper/Bloc/NewDesignBloc/expnse/new_expense_bloc.dart';
import 'Api Helper/Bloc/NewDesignBloc/incme/Income_transaction/income_transaction_bloc.dart';
import 'Api Helper/Bloc/NewDesignBloc/incme/new_income_bloc.dart';
import 'Api Helper/Bloc/Profile/profile_bloc.dart';
import 'Api Helper/Bloc/Settings/settings_bloc.dart';
import 'Api Helper/Bloc/Signup/signup_bloc.dart';
import 'Api Helper/Bloc/Transaction/transaction_bloc.dart';
import 'Api Helper/Bloc/Transaction_contact/transaction_contact_bloc.dart';
import 'Api Helper/Bloc/User/user_bloc.dart';
import 'Api Helper/Bloc/Userole/userole_bloc.dart';
import 'Api Helper/Bloc/asset new design bloc/asset_bloc.dart';
import 'Api Helper/Bloc/asset new design bloc/dlt bloc/portfolio_delete_bloc.dart';
import 'Api Helper/Bloc/asset new design bloc/property/property_bloc.dart';
import 'Api Helper/Bloc/asset new design bloc/stock/stock_bloc.dart';
import 'Api Helper/Bloc/dash_detail/dash_detail_bloc.dart';
import 'Api Helper/Bloc/defaultContryList/default_country_list_bloc.dart';
import 'Api Helper/Bloc/otp/otp_bloc.dart';
import 'Api Helper/Bloc/portfolio_transaction_bloc/portfolio_transaction_bloc.dart';
import 'Api Helper/Bloc/reminder/reminder_bloc.dart';
import 'Api Helper/Bloc/transaction_list/transaction_list_bloc.dart';
import 'Pagination code folder/api/Bloc/pagination_contact_bloc.dart';
import 'Pagination code folder/api/api.dart';
import 'Utilities/CommenClass/camera_screen.dart';
import 'View/screens/SplashScreen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  SignupApi signupApi = SignupApi();
  ApiIncome apiIncome = ApiIncome();

  ApiExpense apiExpense = ApiExpense();
  LoginApi loginApi = LoginApi();
  SettingsApi settingsApi = SettingsApi();
  UseroleApi useroleApi = UseroleApi();
  CountryApi countryApi = CountryApi();
  AccountApi accountApi = AccountApi();
  ProfileApi profileApi = ProfileApi();
  ForgetPasswordApi forgetPasswordApi =   ForgetPasswordApi();
  PaginationContactApi paginationContactApi = PaginationContactApi();



  IncomeApi incomeApi = IncomeApi();
  UserApi userApi = UserApi();
  ExpenseApi expenseApi = ExpenseApi();
  LoanApi loanApi = LoanApi();
  DashBoardApi dashBoardApi = DashBoardApi();
  TransactionApi transactionApi = TransactionApi();
  ContactApi contactApi = ContactApi();

  TransactionContactApi transactionContactApi = TransactionContactApi();
  AssetApi assetApi = AssetApi();
  ReminderApi reminderApi = ReminderApi();

  OtpApi otpApi = OtpApi();
  DashBoardDetailApi dashBoardDetailApi = DashBoardDetailApi();
  TransactionListApi transactionListApi = TransactionListApi();
  StockAssetApi stockAssetApi = StockAssetApi();
  PropertyAssetApi propertyAssetApi = PropertyAssetApi();
  DeleteUserApi deleteUserApi =  DeleteUserApi ();
  ZakathInterestApi zakathInterestApi =ZakathInterestApi();
  RecievablePayableApi recievablePayableApi = RecievablePayableApi();



  // NewTransferListApi newTransferListApi=NewTransferListApi();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(loginApi),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(settingsApi),
        ),
        BlocProvider<UseroleBloc>(
          create: (context) => UseroleBloc(useroleApi),
        ),
        BlocProvider<DefaultCountryListBloc>(
          create: (context) => DefaultCountryListBloc(countryApi),
        ),
        BlocProvider<CountryBloc>(
          create: (context) => CountryBloc(countryApi),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(accountApi),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(profileApi),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userApi),
        ),
        BlocProvider<IncomeBloc>(
          create: (context) => IncomeBloc(incomeApi),
        ),
        BlocProvider<ExpenseBloc>(
          create: (context) => ExpenseBloc(expenseApi),
        ),
        BlocProvider<LoanBloc>(
          create: (context) => LoanBloc(loanApi),
        ),
        BlocProvider<DashBoardBloc>(
          create: (context) => DashBoardBloc(dashBoardApi),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(transactionApi),
        ),
        BlocProvider<ContactBloc>(
          create: (context) => ContactBloc(contactApi),
        ),
        BlocProvider<TransactionContactBloc>(
          create: (context) => TransactionContactBloc(transactionContactApi),
        ),

        BlocProvider<AssetBloc>(
          create: (context) => AssetBloc(assetApi),
        ),
        BlocProvider<ReminderBloc>(
          create: (context) => ReminderBloc(reminderApi),
        ),

        BlocProvider<SignupBloc>(
          create: (context) => SignupBloc(signupApi),
        ),
        BlocProvider<OtpBloc>(
          create: (context) => OtpBloc(otpApi),
        ),
        BlocProvider<Dash_detailBloc>(
          create: (context) => Dash_detailBloc(dashBoardDetailApi),
        ), BlocProvider<Transaction_listBloc>(
          create: (context) => Transaction_listBloc(transactionListApi),
        ),
        BlocProvider<NewExpenseBloc>(
          create: (context) => NewExpenseBloc(apiExpense),
        ),
        BlocProvider<NewIncomeBloc>(
          create: (context) => NewIncomeBloc(apiIncome),
        )
        ,
        BlocProvider<ExptransactionBloc>(
          create: (context) => ExptransactionBloc(apiExpense),
        ),
        BlocProvider<IncomeTransactionBloc>(
          create: (context) => IncomeTransactionBloc(apiIncome),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => ForgetPasswordBloc(forgetPasswordApi
          ),
        ),
        BlocProvider<StockBloc>(
          create: (context) => StockBloc(stockAssetApi
          ),
        ),
        BlocProvider<PropertyBloc>(
          create: (context) => PropertyBloc(propertyAssetApi
          ),
        ),
        BlocProvider<PortfolioTransactionBloc>(
          create: (context) => PortfolioTransactionBloc(assetApi
          ),
        ),
        BlocProvider<DeleteUserBloc>(
          create: (context) => DeleteUserBloc( deleteUserApi),
        ),
        BlocProvider<PortfolioDeleteBloc>(
          create: (context) => PortfolioDeleteBloc( assetApi),
        ),
        BlocProvider<ZakathInterestListBloc>(
          create: (context) => ZakathInterestListBloc( zakathInterestApi),
        ),
        BlocProvider<PayablesReceivableBloc>(
          create: (context) => PayablesReceivableBloc( recievablePayableApi),
        ), BlocProvider<PaginationContactBloc>(
          create: (context) => PaginationContactBloc( paginationContactApi),
        ),



        // BlocProvider<NewTransferBlocBloc>(
        //   create: (context) => NewTransferBlocBloc(newTransferListApi),
        // ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zinco',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // home: CustomPicker(),
        //  home: TransactionPageUi(),
        //  home: IndexWorking(),
        home: SplashScreen(),
      ),
    );
  }
}
