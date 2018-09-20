import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
    final response = await http.get(ServerConfigs.getServerUrl() + "/roads/" + roadId.toString() + "/bins",
     headers: {HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjQzLjExODo4MDAwXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTM3NDIwNDIyLCJleHAiOjE1Mzc2MzY0MjIsIm5iZiI6MTUzNzQyMDQyMiwianRpIjoid3lDVzJ3TVVGN3o2OVlrUCIsInN1YiI6MiwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.-A2vJX_98VKgqWFxFAbW4NgbeyDHs7a5fs-rxdYUDww"});

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