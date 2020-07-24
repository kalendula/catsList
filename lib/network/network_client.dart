import 'dart:convert';

import 'package:cats_list/cache/cache_store.dart';
import 'package:cats_list/models/breed.dart';
import 'package:cats_list/network/urls.dart';
import 'package:http/http.dart' as http;

class NetworkClient {
  static Future<List<Breed>> fetchBreeds() async {
    try {
      final response =
          await http.get(Urls.BREEDS, headers: Headers.NORMAL_HEADER);

      if (response.statusCode == 200) {
        final List<Breed> fetchedBreedList =
            _fromJson(jsonDecode(response.body));
        await CacheStore.setBreeds(jsonEncode(fetchedBreedList));
        String cachedJson = await CacheStore.getBreeds();
        final List<Breed> cachedBreedList = _fromJson(jsonDecode(cachedJson));
        return cachedBreedList;
      } else {
        throw Exception('Failed to load breeds');
      }
    } catch (e) {
      String cachedJson = await CacheStore.getBreeds();
      final List<Breed> cachedBreedList = _fromJson(jsonDecode(cachedJson));
      return cachedBreedList;
    }
  }

  static Future<String> fetchImageUrl(String breedId) async {
    try {
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
    } catch (e) {
      return "";
    }
  }

  static List<Breed> _fromJson(List<dynamic> jsonData) {
    List<Breed> breedList = [];
    jsonData?.forEach((dynamic breedData) {
      breedList.add(Breed.fromJson(breedData));
    });
    return breedList;
  }
}
