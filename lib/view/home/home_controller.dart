import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/dummy/restaurant_model.dart';

class HomeController extends GetxController {
  Rx<TextEditingController> searchCon = TextEditingController().obs;

  RxList<RestaurantModel> restaurantList = <RestaurantModel>[].obs;
  RxList<FoodCuisineMode> cuisineList = <FoodCuisineMode>[].obs;

  @override
  void onInit() {
    super.onInit();

    restaurantList.value = dummyRestaurantList.map((data) {
      return RestaurantModel(
        imageUrl: data['imageUrl'],
        name: data['name'],
        rating: data['rating'],
        time: data['time'],
        type: data['type'],
        address: data['address'],
      );
    }).toList();

    cuisineList.value = foodCategoryList.map((data) {
      return FoodCuisineMode(
        imageUrl: data['imageUrl'],
        name: data['title'],
      );
    }).toList();
  }

  final List<Map<String, String>> foodCategoryList = [
    {
      "title": "Italian",
      "imageUrl": "https://media.istockphoto.com/id/632439546/photo/pasta-plate.jpg?s=612x612&w=0&k=20&c=zZPaNg_mf7cTVIeJPFVRtsjYClNYkGMcUc5ZBrARwZU=",
    },
    {
      "title": "Indian",
      "imageUrl": "https://media.istockphoto.com/id/1397973112/photo/assortment-of-various-kinds-of-indian-cousine-on-dark-rusty-table.jpg?s=612x612&w=0&k=20&c=R5XnXgP1jWnGM5PF7OUfvLW_NQhAcaGuJlWp6hl0SoQ=",
    },
    {
      "title": "Chinese",
      "imageUrl": "https://images.unsplash.com/photo-1585032226651-759b368d7246?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpbmVzZSUyMGZvb2R8ZW58MHx8MHx8fDA%3D",
    },
    {
      "title": "Mexican",
      "imageUrl": "https://img.freepik.com/free-photo/mexican-kitchen_23-2147640325.jpg",
    },
    {
      "title": "Japanese",
      "imageUrl": "https://images.pexels.com/photos/3620705/pexels-photo-3620705.jpeg?cs=srgb&dl=pexels-viniciusbenedit-3620705.jpg&fm=jpg",
    },
  ];

  final List<Map<String, dynamic>> dummyRestaurantList = [
    {
      "imageUrl": "https://lh3.googleusercontent.com/gps-cs-s/AG0ilSy37y3jgBporrIjJc3Ph92SBIU4Bc9LTwvszhP5vLrkKMMEgsT3qysYZLX41JMhgSzz7QRQFOfo4zG-oAnhGFPSJdkVOknVbv5Yk7v4dZZqCLD9en4ICQuWQtj5Byny8YoKvM0N=s1360-w1360-h1020-rw",
      "name": "Zestful Zenith Diner",
      "rating": 4.8,
      "time": "25-30 min",
      "type": "Italian",
      "address": "1089 Ocean Avenue, New York, USA",
    },
    {
      "imageUrl": "https://media.architecturaldigest.com/photos/66c8923688f5dc5cc31e1e35/16:9/w_2560%2Cc_limit/CH_BAD_ROMAN_NYC_ROUND_1_020323952A.jpg",
      "name": "Spice Harbor",
      "rating": 4.6,
      "time": "20-25 min",
      "type": "Indian",
      "address": "45 Linking Road, Mumbai, India",
    },
    {
      "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSt5fVpoHC7eb3hv5F9n52cNzjj7F4QEplC9g&s",
      "name": "Sakura Essence",
      "rating": 4.7,
      "time": "30-35 min",
      "type": "Japanese",
      "address": "Shibuya Crossing, Tokyo, Japan",
    },
    {
      "imageUrl": "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/85/84/65/surat-baking-company.jpg",
      "name": "Casa Del Sol",
      "rating": 4.4,
      "time": "18-22 min",
      "type": "Mexican",
      "address": "Sunset Street, Los Angeles, USA",
    },
    {
      "imageUrl": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzFwtKlpW3ENn-kiuf9UWp3JGO3Mzg42tv7Q&s",
      "name": "Urban Leaf Café",
      "rating": 4.5,
      "time": "12-18 min",
      "type": "Healthy",
      "address": "Camden Market, London, UK",
    },
  ];
}
