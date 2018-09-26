import 'package:flutter/material.dart';
import 'package:hello_world/create_feedback.dart';
import 'package:hello_world/helpers/session_manager.dart';
import 'package:hello_world/landing_pages.dart';
import 'package:hello_world/zone.dart';
import 'login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tanzif',
      theme: new ThemeData(
        primarySwatch: Colors.orange
      ),
      home: MyHomePage(title: 'Tanzif'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _createInspection() async {
    bool isLogin = await SessionManager.isLogin();

    if (isLogin) {
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (BuildContext context) {
        return new ZoneList();
      }));
      return;
    }

    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Login();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new LandingPages(),
            ButtonTheme(
                minWidth: double.infinity,
                child: new RaisedButton(
                    onPressed: _createInspection,
                    child: new Text("Create Inspection"))),
            ButtonTheme(
                minWidth: double.infinity,
                child: new RaisedButton(
                  onPressed: _incrementCounter,
                  child: new Text("Report Misconduct"),
                )),
            ButtonTheme(
                minWidth: double.infinity,
                child: new RaisedButton(
                  onPressed: _openFeedback,
                  child: new Text("Feedback"),
                )),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _openFeedback() {
     Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new CreateFeedback();
    }));
  }
}
