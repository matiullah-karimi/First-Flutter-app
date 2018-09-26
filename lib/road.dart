import 'package:flutter/material.dart';
import 'package:hello_world/bin.dart';
import 'package:hello_world/model/line.dart';
import 'package:hello_world/model/road.dart';

class RoadList extends StatefulWidget {
  RoadList({Key key, this.line});
  final Line line;

  @override
  _RoadState createState() => _RoadState();
}

class _RoadState extends State<RoadList> {
  Widget _linesListView() {
    return FutureBuilder<List<Road>>(
        future: Road.list(widget.line.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView(
                children: snapshot.data.map((Road road) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.add_circle),
                  title: Text(road.from + " - " + road.to),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return new BinList(road: road );
                      }
                    ));
                  },
                ),
              );
            }).toList());
          } else if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: Text(widget.line.name)),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _linesListView(),
      ),
    );
  }
}
