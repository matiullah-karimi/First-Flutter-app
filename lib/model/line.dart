import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hello_world/helpers/server_configs.dart';

class Line {
  int id;
  String name;
  String code;
  int districtId;
  DateTime createdAt;
  DateTime updatedAt;

  Line(this.id, this.name, this.code, this.districtId, this.createdAt, this.updatedAt);

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      json["id"],
      json["name"],
      json["code"].toString(),
      json["district_id"],
      DateTime.parse(json["created_at"]),
      DateTime.parse(json["updated_at"])
    );
  }

  static Future<List<Line>> list (int districtId) async {
    final response = await http.get(ServerConfigs.getServerUrl() + "/districts/" + districtId.toString() + "/lines",
     headers: {HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjQzLjExODo4MDAwXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTM3NDIwNDIyLCJleHAiOjE1Mzc2MzY0MjIsIm5iZiI6MTUzNzQyMDQyMiwianRpIjoid3lDVzJ3TVVGN3o2OVlrUCIsInN1YiI6MiwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.-A2vJX_98VKgqWFxFAbW4NgbeyDHs7a5fs-rxdYUDww"});

    if (response.statusCode != 200) {
      throw Exception("Failed to load");
    }

    var decoded = json.decode(response.body);
    List<Line> lines = [];

    for (final line in (decoded as List)) {
       lines.add(new Line.fromJson(line));
    }

    return lines;
  }
}