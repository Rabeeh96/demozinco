import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/Loan/loan_api.dart';
import '../../ModelClasses/Loan/DeleteLoanModelClass.dart';
import '../../ModelClasses/Loan/DetailLoanModelClass.dart';
import '../../ModelClasses/Loan/EditLoanModelClass.dart';
import '../../ModelClasses/Loan/ListLoanModelClass.dart';
import '../../ModelClasses/Loan/LoanCreateModelClass.dart';
import '../../ModelClasses/Loan/LoanViewModelClass.dart';

part 'loan_event.dart';
part 'loan_state.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
 late LoanCreateModelClass loanCreateModelClass ;
 late ListLoanModelClass listLoanModelClass ;
 late DetailLoanModelClass detailLoanModelClass ;
 late EditLoanModelClass editLoanModelClass;
 late DeleteLoanModelClass deleteLoanModelClass ;
 late LoanViewModelClass loanViewModelClass ;

 LoanApi loanApi;
  LoanBloc(this.loanApi) : super(LoanInitial()) {
    on<CreateLoanEvent>((event, emit) async {
      emit(LoanCreateLoading());
      try{
        loanCreateModelClass =await loanApi.CreateLoanFunction(
              date: event.date,
            day: event.day,
            organization: event.organization, loanName: event.loanName,
            loanType: event.loanType, amount: event.amount, interest: event.interest,
            paymentCycle: event.paymentCycle, duration: event.duration, interestAmount: event.interestAmount,
            processingFee: event.processingFee, totalAmount: event.totalAmount, isManual: event.isManual,
            isExisting: event.isExisting, account: event.account, reminderList: event.reminderList);

        emit(LoanCreateLoaded());
      }catch(e){
        emit(LoanCreateError());

      }

    });
    on<ListLoanEvent>((event, emit) async {
      emit(LoanListLoading());
      try{
        listLoanModelClass = await loanApi.ListLoanFunction();

        emit(LoanListLoaded());
      }catch(e){
        emit(LoanListError());

      }

    });

    on<DetailsLoanEvent>((event, emit) async {
      emit(DetailLoanLoading());
      try{
        detailLoanModelClass = await loanApi.DetailLoanFunction(id: event.id, organisation: event.organization);

        emit(DetailLoanLoaded());
      }catch(e){
        emit(DetailLoanError());

      }

    });
    on<EditLoanEvent>((event, emit) async {
      emit(EditLoanLoading());
      try{
        editLoanModelClass = await loanApi.EditLoanFunction( date: event.date,organization: event.organization, loanName: event.loanName,
            day: event.day,
            loanType: event.loanType, amount: event.amount, interest: event.interest, paymentCycle: event.paymentCycle,
            duration: event.duration, interestAmount: event.interestAmount, processingFee: event.processingFee,
            totalAmount: event.totalAmount, isManual: event.isManual, isExisting: event.isExisting,
            account: event.account, id: event.id, reminderList: event.reminderList);

        emit(EditLoanLoaded());
      }catch(e){
        emit(EditLoanError());

      }

    });



    on<DeleteLoanEvent>((event, emit) async {
      emit(DeleteLoanLoading());
      try{
        deleteLoanModelClass = await loanApi.DeleteLoanFunction(id: event.id, organisation: event.organization);

        emit(DeleteLoanLoaded());
      }catch(e){
        emit(DeleteLoanError());

      }

    });

    on<LoanViewEvent>((event, emit) async {
      emit(ViewLoanLoading());
      try{
        loanViewModelClass = await loanApi.loanViewFunction(id: event.id, organisation: event.organization);

        emit(ViewLoanLoaded());
      }catch(e){
        emit(ViewLoanError());

      }

    });


  }
}
