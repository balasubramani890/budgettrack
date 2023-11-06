import 'package:budgettrack/screen/add_expense_page.dart';
import 'package:budgettrack/screen/logout_button_page.dart';
import 'package:flutter/material.dart';
import 'add_income_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double buttonWidth = 200.0; // Set a fixed width for the buttons
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          LogoutButtonPage()
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  // Action for the first button
                  print('Income');
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>AddIncomePage()
                      ));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
                ),
                child: Text('Add Income'),
              ),
            ),
            SizedBox(height: 20), // Add some space between buttons
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  // Action for the second button
                  print('Expense');
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>AddExpensePage()
                      ));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Set the background color
                ),
                child: Text('Add Expense'),
              ),
            ),
            SizedBox(height: 20), // Add some space between buttons
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  // Action for the third button
                  print('Statement');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Set the background color
                ),
                child: Text('Statement'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
