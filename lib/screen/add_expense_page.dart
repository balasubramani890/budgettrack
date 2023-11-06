import 'dart:math';

import 'package:budgettrack/controller/transaction_controller.dart';
import 'package:budgettrack/model/transaction_model.dart';
import 'package:budgettrack/service/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'logout_button_page.dart';


class AddExpensePage extends StatefulWidget {
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  // TextEditingController _dateController = TextEditingController();
  TransactionController transactionController = TransactionController();
  TransactionService transactionService = TransactionService();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();

  String selectedValue = 'Cash'; // Default selected value

  List<String> options = ['Cash', 'Bank'];

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.day, // Set initial mode to display only the date
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        transactionController.tDateController.text = DateFormat('dd-MM-yyyy').format(pickedDate); // Format the date as needed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense'),
        actions: [
            LogoutButtonPage()
        ],
      ),
      body:
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: transactionController.tDateController,
                  decoration: InputDecoration(
                    labelText: 'Transaction Date',
                    suffixIcon: InkWell(
                      onTap: () => _selectDate(context),
                      child: Icon(Icons.calendar_today),
                    ),
                  ),
                  readOnly: true, // Prevent manual editing of the text field
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select the Date';
                    }
                    return null;
                  },
                ),

                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),

                TextFormField(
                  controller: transactionController.tDescription,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Description';
                    }
                    return null;
                  },
                ),

                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),

                TextFormField(
                  controller: transactionController.tAmount,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Amount';
                    }
                    return null;
                  },
                ),

                /* const Padding(
                    padding: EdgeInsets.all(10.0)
                ),*/

                //	Income or Expense mention this column
                /* TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Transaction Type',


                  ),
                  keyboardType: TextInputType.number,

                  *//* controller: loginController.mobileController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },*//*
                ),*/


                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),

                //	if category is income --> salary, interest, etc..
                //	if category is expense --> food, dress, etc..
                TextFormField(
                  controller: transactionController.tCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                ),

                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),

                //	payment method is cash, card, upi etc..
                TextFormField(
                  controller: transactionController.tPaymentMethod,
                  decoration: const InputDecoration(
                    labelText: 'Payment Method',
                  ),
                  /*
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },*/
                ),

                const Padding(
                    padding: EdgeInsets.all(10.0)
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: ElevatedButton(
                          child: Text('Save'),

                          onPressed: () async {
                            print("Income Save Clicked");
                            if (_formKey.currentState!.validate()) {
                              print("Validation successfully");
                              final transactionData = TransactionModel(
                                transactionDate: transactionController.tDateController.text,
                                transactionType: "EXPENSE",
                                description: transactionController.tDescription.text,
                                amount: double.parse(transactionController.tAmount.text),
                                category: transactionController.tCategory.text,
                                paymentMethod: transactionController.tPaymentMethod.text,
                                receiptUrl: "",
                              );

                              final result = await transactionService.saveExpense(transactionData);
                              print('Transaction Page Result got $result');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Expense Saved Successfully')
                              ));
                            }
                            else
                            {
                              print("Validation Failed");
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Income Saved Successfully')
                              ));
                            }
                          }),
                    ),
                    /*   ElevatedButton(
                          child: Text('CLEAR'),
                          onPressed: (){
                            clearData();
                          }
                      ),*/
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


