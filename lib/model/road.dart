import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hello_world/helpers/server_configs.dart';

class Road {
  int id;
  String from;
  String to;
  int lineId;
  DateTime createdAt;
  DateTime updatedAt;

  Road(this.id, this.from, this.to, this.lineId, this.createdAt, this.updatedAt);

  factory Road.fromJson(Map<String, dynamic> json) {
    return Road(
      json["id"],
      json["from"],
      json["to"].toString(),
      json["line_id"],
      DateTime.parse(json["created_at"]),
      DateTime.parse(json["updated_at"])
    );
  }

  static Future<List<Road>> list (int lineId) async {
    final response = await http.get(ServerConfigs.getServerUrl() + "/lines/" + lineId.toString() + "/roads",
     headers: {HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjQzLjExODo4MDAwXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTM3NDIwNDIyLCJleHAiOjE1Mzc2MzY0MjIsIm5iZiI6MTUzNzQyMDQyMiwianRpIjoid3lDVzJ3TVVGN3o2OVlrUCIsInN1YiI6MiwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.-A2vJX_98VKgqWFxFAbW4NgbeyDHs7a5fs-rxdYUDww"});

    if (response.statusCode != 200) {
      throw Exception("Failed to load");
    }

    var decoded = json.decode(response.body);
    List<Road> lines = [];

    for (final line in (decoded as List)) {
       lines.add(new Road.fromJson(line));
    }

    return lines;
  }
}