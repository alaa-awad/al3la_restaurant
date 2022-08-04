class WorkerModel {
  late String id;
  late String name;
  late String password;
  late String type;

  WorkerModel({
    required this.id,
    required this.name,
    required this.password,
    required this.type,
  });

  WorkerModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    password = json["password"];
    type = json["type"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'password': password,
      'type': type,
    };
  }
}
