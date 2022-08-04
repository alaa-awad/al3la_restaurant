class UserModel {
  late String id;
  late String name;
  String? image;
  late String email;
  late String type;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    this.image,
  });

  UserModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    type = json["type"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'email': email,
      'type': type,
    };
  }
}
