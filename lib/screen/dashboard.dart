import 'package:budgettrack/screen/IncomePage.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Action for the first button
                print('Income');
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context)=>IncomePage()
                    ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
              ),
              child: Text('Add Income'),
            ),
            SizedBox(height: 20), // Add some space between buttons
            ElevatedButton(
              onPressed: () {
                // Action for the second button
                print('Expense');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Set the background color
              ),
              child: Text('Add Expense'),
            ),
            SizedBox(height: 20), // Add some space between buttons
            ElevatedButton(
              onPressed: () {
                // Action for the third button
                print('Statement');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Set the background color
              ),
              child: Text('Statement'),
            ),
          ],
        ),
      ),
    );
  }
}
