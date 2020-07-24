import 'package:cached_network_image/cached_network_image.dart';
import 'package:cats_list/models/breed.dart';
import 'package:flutter/material.dart';

import 'details_bloc.dart';
import 'details_events.dart';

class BreedsDetailScreen extends StatelessWidget {
  final Breed breed;
  final _bloc = DetailsBloc();
  //BreedsDetailScreen({Key key, @required this.breed}) : super(key: key);
  BreedsDetailScreen({Key key, @required this.breed}) {
    _bloc.detailsEventSink.add(ImageFetchEvent(breedId: breed.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(breed.name),
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10), child: imageBuilder()),
              textElement("Name: ${breed.name}"),
              Divider(
                color: Colors.black,
              ),
              textElement("Description: ${breed.description}"),
              Divider(
                color: Colors.black,
              ),
              textElement("Life length: ${breed.lifeSpan} years"),
              Divider(
                color: Colors.black,
              ),
              textElement("Origin country: ${breed.origin}"),
              Divider(
                color: Colors.black,
              ),
              textElement("Temperament: ${breed.temperament}"),
              Divider(
                color: Colors.black,
              ),
            ])));
  }

  Widget imageBuilder() {
    return StreamBuilder(
      stream: _bloc.image,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
            padding: EdgeInsets.only(top: 10),
            child: GestureDetector(
                onTap: () => _showMyDialog(context, snapshot.data),
                child: CachedNetworkImage(
                  imageUrl: snapshot.data,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: 100,
                  height: 100,
                )));
      },
    );
  }

  Widget textElement(String text) {
    return Padding(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontSize: 20,
          ),
        ));
  }

  Future<void> _showMyDialog(BuildContext context, String imageUrl) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${breed.name} photo'),
          content: SingleChildScrollView(
              child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Dismiss',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
