import 'package:flutter/material.dart';
import 'package:hello_world/line.dart';
import 'package:hello_world/model/district.dart';
import 'package:hello_world/model/zone.dart';

class ZoneList extends StatefulWidget {
  @override
  _ZoneState createState() => _ZoneState();
}

class _ZoneState extends State<ZoneList> {
  String title = "Zone";
  Widget _zonesListView() {
    return FutureBuilder<Zone>(
        future: Zone.fetchZone(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            title = snapshot.data.name;
            return new ListView(
                children: snapshot.data.districts.map((District district) {
              return Card(
                child: ListTile(
                  leading: Icon(Icons.add_circle),
                  title: Text(district.name),
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return LineList(district: district);
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
      appBar: new AppBar(title: Text(title)),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: _zonesListView(),
      ),
    );
  }
}
