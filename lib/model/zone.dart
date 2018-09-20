import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hello_world/model/district.dart';
import 'package:http/http.dart' as http;
import 'package:hello_world/helpers/server_configs.dart';

class Zone {
  int id;
  String name;
  String code;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  List<District> districts;

  String url = ServerConfigs.getServerUrl();

  Zone(this.id, this.name, this.code, this.userId, this.createdAt, this.updatedAt, this.districts);

  factory Zone.fromJson(Map<String, dynamic> json){
    List<District> tmpDistricts = [];

    for (final d in (json["districts"] as List)) {
      tmpDistricts.add(new District.fromJson(d)); 
    }

    return Zone (json["id"],
      json["name"],
      json["code"].toString(),
      json["user_id"],
      DateTime.parse(json["created_at"]),
      DateTime.parse(json["updated_at"]),
      tmpDistricts
    );
  }
    

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'code': code,
    'user_id': userId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'districts': districts
  };

  static Future<Zone> fetchZone () async {
    final response = await http.get(ServerConfigs.getServerUrl() + "/zone",
     headers: {HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC8xOTIuMTY4LjQzLjExODo4MDAwXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNTM3NDIwNDIyLCJleHAiOjE1Mzc2MzY0MjIsIm5iZiI6MTUzNzQyMDQyMiwianRpIjoid3lDVzJ3TVVGN3o2OVlrUCIsInN1YiI6MiwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.-A2vJX_98VKgqWFxFAbW4NgbeyDHs7a5fs-rxdYUDww"});

    if (response.statusCode != 200) {
      throw Exception("Failed to load");
    }

    Zone zone = new Zone.fromJson(json.decode(response.body));
    return zone;
  }
}