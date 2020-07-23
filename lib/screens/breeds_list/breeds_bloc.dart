import "dart:async";

import 'package:cats_list/models/breed.dart';
import 'package:cats_list/network/network_client.dart';
import 'package:cats_list/screens/breeds_list/breeds_events.dart';

class BreedBloc {
  List<Breed> _breeds = [];

  final _breedStateController = StreamController<List<Breed>>();
  StreamSink<List<Breed>> get _inBreed => _breedStateController.sink;

  Stream<List<Breed>> get breed => _breedStateController.stream;

  final _breedEventController = StreamController<BreedEvent>();

  Sink<BreedEvent> get breedEventSink => _breedEventController.sink;

  BreedBloc() {
    _breedEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(BreedEvent event) async {
    if (event is FetchEvent) {
      _breeds = await NetworkClient.fetchBreeds();
    } else
      throw UnimplementedError;

    _inBreed.add(_breeds);
  }

  void dispose() {
    _breedStateController.close();
    _breedEventController.close();
  }
}
