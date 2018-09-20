import 'package:flutter/material.dart';

class InspectionForm extends StatefulWidget {
  @override
  _InspectionFormState createState() => _InspectionFormState();
}

class _InspectionFormState extends State<InspectionForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Inspection")),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButton(
              onChanged: (d) {
                print(d);
              },
              items: <DropdownMenuItem>[
                DropdownMenuItem(
                  child: Text("Hello"),
                ),
                DropdownMenuItem(
                  child: Text("Hello"),
                ),
                DropdownMenuItem(
                  child: Text("Hello"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}