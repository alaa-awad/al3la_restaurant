class MealModule{
 late String uId;
 late String name;
 late String describe;
 late String price;
 late String image;
 String? state;

 MealModule({
   required this.uId,
   required this.name,
   required this.describe,
   required this.image,
   required this.price,
    this.state,
});

MealModule.fromJson(dynamic json){
  uId = json['uId'];
  name = json['name'];
  describe = json['describe'];
  price = json['price'];
  image = json['image'];
  state = json['state'];
}

Map<String,dynamic> toJson(){
  return {
    'uId' : uId,
    'name' : name,
    'describe' : describe,
    'price' : price,
    'image' : image,
    'state' : state,
  };
}

}