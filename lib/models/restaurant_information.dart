class RestaurantInformationModel{
  late String name;
  String? location;
  num? numberPhone;
  String? facebookAccount;
  String? instagramAccount;

  RestaurantInformationModel({
    required this.name,
    this.location,
    this.facebookAccount,
    this.numberPhone,
    this.instagramAccount,
  });

  RestaurantInformationModel.fromJson(dynamic json){
    name = json['name'];
    location = json['location'];
    numberPhone = json['numberPhone'];
    facebookAccount = json['facebookAccount'];
    instagramAccount = json['instagramAccount'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'location' : location,
      'numberPhone' : numberPhone,
      'facebookAccount' : facebookAccount,
      'instagramAccount' : instagramAccount,
    };
  }

}