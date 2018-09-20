import 'package:flutter/material.dart';
import 'package:hello_world/create_inspection.dart';
import 'package:hello_world/model/road.dart';
import 'package:hello_world/model/bin.dart';

class BinList extends StatefulWidget {
  BinList({Key key, this.road});
  final Road road;

  @override
  _BinState createState() => _BinState();
}

class _BinState extends State<BinList> {
  Widget _linesListView() {
    return FutureBuilder<List<Bin>>(
        future: Bin.list(widget.road.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView(
                children: snapshot.data.map((Bin bin) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.add_circle),
                  title: Text(bin.code),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return new InspectionForm();
                      }
                    ));
                  },
                ),
              );
            }).toList());
          } else if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text(widget.road.from + " - " + widget.road.to)),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _linesListView(),
      ),
    );
  }
}
