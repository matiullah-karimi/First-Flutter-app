import 'dart:async';
import 'dart:convert';
import 'package:hello_world/helpers/server_configs.dart';
import 'package:http/http.dart' as http;

class UserFeedback {
  String description;
  String phone;
  String name;

  UserFeedback(this.name, this.phone, this.description);

   Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'description': description
  };

  factory UserFeedback.fromJson(Map<String, dynamic> json) {
    return UserFeedback(
      json["name"],
      json["phone"],
      json["description"]
    );
  }

  static Future<UserFeedback> create(UserFeedback feedback) async {

    var response = await http.post(ServerConfigs.getServerUrl() + "/feedback/create", 
    body: jsonDecode(json.encode(feedback)));

    if (response.statusCode != 200) {
      throw Exception("Error");
    }

    final decoded = json.decode(response.body);

    return new UserFeedback.fromJson(decoded);
  }
}