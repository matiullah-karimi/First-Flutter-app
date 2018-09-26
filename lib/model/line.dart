import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hello_world/helpers/session_manager.dart';
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
    final token = await SessionManager.getToken();
    final response = await http.get(ServerConfigs.getServerUrl() + "/districts/" + districtId.toString() + "/lines",
     headers: {HttpHeaders.authorizationHeader: "Bearer " + token});

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