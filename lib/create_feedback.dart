import 'package:flutter/material.dart';
import 'package:hello_world/model/feedback.dart';

class CreateFeedback extends StatefulWidget {
  @override
  _CreateFeedbackState createState() => _CreateFeedbackState();
}

class _CreateFeedbackState extends State<CreateFeedback> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
      ),
      body: Container(
        child: SingleChildScrollView(child: _feedbackForm()),
      ),
    );
  }

  Widget _feedbackForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.deepOrange),
                  labelText: "Name",
                ),
                controller: nameController,
                validator: (value) {
                  if (value.isEmpty || value.length < 3) {
                    return "Please enter your name";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.phone, color: Colors.deepOrange),
                  labelText: "Phone",
                ),
                keyboardType: TextInputType.phone,
                controller: phoneController,
                validator: (value) {
                  if (value.isEmpty || value.length != 10) {
                    return "Please enter correct phone number";
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.description, color: Colors.deepOrange),
                  labelText: "Description",
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: descriptionController,
                validator: (value) {
                  if (value.isEmpty || value.length < 10) {
                    return "Please provide your feedback";
                  }
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 20.0, 8.0, 8.0),
                child: ButtonTheme(
                  child: RaisedButton(
                      child: Text("Submit"),
                      color: Colors.orange,
                      onPressed: _createFeedback),
                )),
          ],
        ),
      ),
    );
  }

  _createFeedback() {
    if (_formKey.currentState.validate()) {
      _showLoadingDialog();
      UserFeedback.create(new UserFeedback(nameController.text,
              phoneController.text, descriptionController.text))
          .then((feedback) {
            Navigator.pop(context);
            Navigator.pop(context);
          })
          .catchError((error) {
            Navigator.pop(context);
          });
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
         children: <Widget>[
           Container(
             padding: EdgeInsets.all(10.0),
             child: Row(
               children: <Widget>[
                 CircularProgressIndicator(),
                 Text("    Submitting your feedback...")
               ]
             ),
           )
         ],
        );
      });
  }
}
