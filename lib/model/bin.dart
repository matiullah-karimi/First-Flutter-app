import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:hello_world/helpers/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/helpers/server_configs.dart';

class Bin {
  int id;
  String code;
  int latitude;
  int longitude;
  int roadId;
  DateTime createdAt;
  DateTime updatedAt;

  Bin(this.id, this.code, this.latitude, this.longitude, this.roadId, this.createdAt, this.updatedAt);

  factory Bin.fromJson(Map<String, dynamic> json) {
    return Bin(
      json["id"],
      json["code"],
      json["latitude"],
      json["longitude"],
      json["roadId"],
      DateTime.parse(json["created_at"]),
      DateTime.parse(json["updated_at"])
    );
  }

  static Future<List<Bin>> list (int roadId) async {
    final token = await SessionManager.getToken();
    final response = await http.get(ServerConfigs.getServerUrl() + "/roads/" + roadId.toString() + "/bins",
     headers: {HttpHeaders.authorizationHeader: "Bearer " + token});

    if (response.statusCode != 200) {
      throw Exception("Failed to load");
    }

    var decoded = json.decode(response.body);
    List<Bin> bins = [];

    for (final bin in (decoded as List)) {
       bins.add(new Bin.fromJson(bin));
    }

    return bins;
  }
}