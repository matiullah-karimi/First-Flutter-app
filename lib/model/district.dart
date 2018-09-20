class District {
  int id;
  String name;
  String code;
  int zoneId;
  DateTime createdAt;
  DateTime updatedAt;

  District(this.id, this.name, this.code, this.zoneId, this.createdAt, this.updatedAt);

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      json["id"],
      json["name"],
      json["code"].toString(),
      json["zone_id"],
      DateTime.parse(json["created_at"]),
      DateTime.parse(json["updated_at"])
    );
  }
}