class CategoryModel{

 late String uId;
 late String name;
 late String image;

 CategoryModel({
   required this.uId,
   required this.name,
   required this.image,
});

 CategoryModel.fromJson(dynamic json){
   uId= json['uId'];
   name= json['name'];
   image = json['image'];
 }

 Map<String,dynamic> toJson(){
   return {
     'uId' : uId,
     'name' : name,
     "image" :image,
   };
 }
}