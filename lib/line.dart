import 'package:flutter/material.dart';
import 'package:hello_world/model/district.dart';
import 'package:hello_world/model/line.dart';
import 'package:hello_world/road.dart';

class LineList extends StatefulWidget {
  LineList({Key key, this.district});
  final District district;

  @override
  _LineState createState() => _LineState();
}

class _LineState extends State<LineList> {
  Widget _linesListView() {
    return FutureBuilder<List<Line>>(
        future: Line.list(widget.district.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new ListView(
                children: snapshot.data.map((Line line) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.add_circle),
                  title: Text(line.name),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return new RoadList(line: line);
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
      appBar: new AppBar(title: Text(widget.district.name)),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _linesListView(),
      ),
    );
  }
}
