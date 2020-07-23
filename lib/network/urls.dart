class Urls {
  static const String _BASE_URL = "https://api.thecatapi.com/v1";
  static const String BREEDS = "$_BASE_URL/breeds";
  static const String IMAGES = "$_BASE_URL/images/search";
}

class Headers {
  static const NORMAL_HEADER = {
    "x-api-key": "e61d50b3-b967-4643-b749-361062084e8f"
  };
}
