import 'package:flutter/cupertino.dart';

abstract class DetailsEvent {}

class ImageFetchEvent extends DetailsEvent {
  String breedId;

  ImageFetchEvent({@required this.breedId});
}
