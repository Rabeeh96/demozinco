import 'package:cuentaguestor_edit/View/screens/NewLoanDesign/create_loan.dart';
import 'package:cuentaguestor_edit/View/screens/expenses/expense_new_design/btmsheetclass.dart';
import 'package:cuentaguestor_edit/View/screens/income/Income_new_design/income_btmsheet.dart';
import 'package:cuentaguestor_edit/View/screens/income/Income_new_design/income_list_overview.dart';
import 'package:cuentaguestor_edit/View/screens/new_transfer_section/add_transfer.dart';
import 'package:flutter/material.dart';

import '../Utilities/CommenClass/menu_title_widget.dart';
import '../Utilities/global/text_style.dart';
import '../Utilities/global/variables.dart';
import 'screens/NewLoanDesign/new_loan_list.dart';
import 'screens/contacts/new_section/contact_list_page.dart';
import 'screens/contacts/new_section/crate_contact.dart';
import 'screens/expenses/expense_new_design/expense_list_overview.dart';
import 'screens/new_transfer_section/transfer_list.dart';

class ScreenMenu extends StatelessWidget {
   ScreenMenu({Key? key}) : super(key: key);
  CommonBottomSheetClass commonBottomSheetClass = CommonBottomSheetClass();
   IncomeBottomSheetClass incomeBottomSheetClass = IncomeBottomSheetClass();
  @override
  Widget build(BuildContext context) {
    final mHeight = MediaQuery.of(context).size.height;
    final mWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 11,

        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Menu',

              style: customisedStyle(context, Color(0xff13213A), FontWeight.w600, 22.0),
            ),
            Container(
              alignment: Alignment.center,
              height: mHeight*.05,
              width: mWidth*.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                  ,color: Color(0xffF3F7FC)
              ),
              child:  Text(
                default_country_name+"-"+countryShortCode,
                style: customisedStyle(context, Color(0xff0073D8), FontWeight.w500, 14.0),)
            )
          ],
        ),

      ),
      body: Container(
        padding: EdgeInsets.only(left: mWidth*.04,right:mWidth*.04, ),
        child: Column(
          children: [
            SizedBox(height: mHeight*.014,),

            MenuItemsWidget(
              mHeight: mHeight,
              mWidth: mWidth,
              context: context,
              image: 'assets/menu/personalcard.svg',
              menuItemName: 'Contacts',
              menuTitleOnTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListContactPage()));
              },
              menuAddButtonOnTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContactCreateNew(
                      openingBalance: "0.00",
                      type: 'Create', imagePath: '',
                    )));

              },
            ),
            SizedBox(
              height: 8,
            ),
            MenuItemsWidget(
              mHeight: mHeight,
              mWidth: mWidth,
              context: context,
              image: 'assets/menu/wallet-add-1.svg',
              menuItemName: 'Expenses',
              menuTitleOnTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListExpenseScreen()));
              },
              menuAddButtonOnTap: () {


                commonBottomSheetClass.ExpenseAddBottomSheet( context: context, type: 'Create', addOrEdit: 'Add',id: "");
              },
            ),
            SizedBox(
              height: 8,
            ),
            MenuItemsWidget(
              mHeight: mHeight,
              mWidth: mWidth,
              context: context,
              image: 'assets/menu/wallet-add.svg',
              menuItemName: 'Income',
              menuTitleOnTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListIncomeScreen()));
              },
              menuAddButtonOnTap: () {
                incomeBottomSheetClass.incomeAddBottomSheet( context: context, type: 'Create', addOrEdit: 'Add',id: "");
              },
            ),
            SizedBox(
              height: 8,
            ),
            MenuItemsWidget(
              mHeight: mHeight,
              mWidth: mWidth,
              context: context,
              image: 'assets/menu/archive.svg',
              menuItemName: 'Loans',
              menuTitleOnTap: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewLoanList()));
              },
              menuAddButtonOnTap: ()async {



                final result = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddLoanPage(
                      isEdit: false,
                      id: "",
                    )));


              },
            ),
            SizedBox(
              height: 8,
            ),
            MenuItemsWidget(
              mHeight: mHeight,
              mWidth: mWidth,
              context: context,
              image: 'assets/menu/Group 1109.svg',
              menuItemName: 'Transfers',
              menuTitleOnTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransactionList()));
              },
              menuAddButtonOnTap: () {

                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransferTransaction(
                  toAmount: "0.0",
                  transactionType: "",
                  to_country_Name: "",to_country_id: "",from_country_Name: "",from_country_id: "",
                  type: "Create",balance: "0.00",fromAmount: "0.00",to_account_id: "",to_accountName: "",description: "",from_account_id: "",
                  from_accountName: "",id: "",date: "",isZakah: false,
                )));


              },
            ),


          ],
        ),
      ),
    );
  }
}
