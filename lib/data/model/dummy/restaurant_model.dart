import 'package:get/get.dart';

class RestaurantModel {
  final String? imageUrl;
  final String? name;
  final double? rating;
  final String? time;
  final String? type;
  final String? address;
  final RxBool isWishListed;

  RestaurantModel({
    this.imageUrl,
    this.name,
    this.rating,
    this.time,
    this.type,
    this.address,
    RxBool? isWishListed,
  }):isWishListed = false.obs;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    imageUrl: json["imageUrl"],
    name: json["name"],
    rating: json["rating"]?.toDouble(),
    time: json["time"],
    type: json["type"],
    address: json["address"],
    isWishListed: false.obs,
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "name": name,
    "rating": rating, 
    "time": time,
    "type": type,
    "address": address,
  };
}

class FoodCuisineMode {
  final String? imageUrl;
  final String? name;

  FoodCuisineMode({
    this.imageUrl,
    this.name,
  });

  factory FoodCuisineMode.fromJson(Map<String, dynamic> json) => FoodCuisineMode(
    imageUrl: json["imageUrl"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "name": name,
  };
}
