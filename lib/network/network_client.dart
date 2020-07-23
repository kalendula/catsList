import 'dart:convert';

import 'package:cats_list/models/breed.dart';
import 'package:cats_list/network/urls.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  static Future<List<Breed>> fetchBreeds() async {
    final response = await http.get(Urls.BREEDS,
        headers: {"x-api-key": "e61d50b3-b967-4643-b749-361062084e8f"});

    if (response.statusCode == 200) {
      final List<Breed> fetchedBreedList = [];
      List<dynamic> responseData = jsonDecode(response.body);
      responseData?.forEach((dynamic breedData) {
        fetchedBreedList.add(Breed.fromJson(breedData));
      });
      return fetchedBreedList;
    } else {
      throw Exception('Failed to load breeds');
    }
  }
}
