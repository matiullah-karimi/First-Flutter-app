import 'dart:async';
import 'dart:convert';
import 'package:hello_world/helpers/server_configs.dart';
import 'package:http/http.dart' as http;

class LandingPage {
  int id;
  String info;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  LandingPage(this.id, this.info, this.image, this.createdAt, this.updatedAt);

  factory LandingPage.fromJson(Map<String, dynamic> json) {
    return LandingPage(
      json["id"],
      json["info"],
      json["image"],
      DateTime.parse(json["created_at"]),
      DateTime.parse(json["updated_at"])
    );
  }

  static Future<List<LandingPage>> list () async {
    final response = await http.get(ServerConfigs.getServerUrl() + "/landing-pages");

    if (response.statusCode != 200) {
      throw Exception("Failed to load");
    }

    var decoded = json.decode(response.body);
    List<LandingPage> pages = [];

    for (final page in (decoded as List)) {
      pages.add(new LandingPage.fromJson(page));
    }
    
    return pages;
  }
}