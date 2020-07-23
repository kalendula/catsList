import 'dart:convert';
import 'dart:io';

import 'package:cats_list/models/breed.dart';
import 'package:cats_list/network/urls.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  static Future<List<Breed>> fetchBreeds() async {
    final response =
        await http.get(Urls.BREEDS, headers: Headers.NORMAL_HEADER);

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

  static Future<String> fetchImageUrl(String breedId) async {
    final response = await http.get("${Urls.IMAGES}?breed_id=$breedId",
        headers: Headers.NORMAL_HEADER);

    if (response.statusCode == 200) {
      String fileUrl = "";
      List<dynamic> responseData = jsonDecode(response.body);
      fileUrl = responseData[0]["url"];
      if (fileUrl == "") throw Exception('Failed to load image');
      return fileUrl;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
