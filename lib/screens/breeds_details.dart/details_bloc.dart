import "dart:async";
import 'package:cats_list/network/network_client.dart';
import 'package:cats_list/screens/breeds_details.dart/details_events.dart';

class DetailsBloc {
  String _image = "";

  final _imageStateController = StreamController<String>();
  StreamSink<String> get _imageSink => _imageStateController.sink;

  Stream<String> get image => _imageStateController.stream;

  final _detailsEventController = StreamController<DetailsEvent>();

  Sink<DetailsEvent> get detailsEventSink => _detailsEventController.sink;

  DetailsBloc() {
    _detailsEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(DetailsEvent event) async {
    if (event is ImageFetchEvent) {
      _image = await NetworkClient.fetchImageUrl(event.breedId);
    } else
      throw UnimplementedError;

    _imageSink.add(_image);
  }

  void dispose() {
    _imageStateController.close();
    _detailsEventController.close();
  }
}
