import 'package:cats_list/models/breed.dart';
import 'package:cats_list/screens/breeds_details.dart/details_view.dart';
import 'package:cats_list/screens/breeds_list/breeds_bloc.dart';
import 'package:cats_list/screens/breeds_list/breeds_events.dart';
import 'package:flutter/material.dart';

class BreedScreenView extends StatefulWidget {
  BreedScreenView({Key key}) : super(key: key);

  @override
  _BreedScreenViewState createState() => _BreedScreenViewState();
}

class _BreedScreenViewState extends State<BreedScreenView> {
  final _bloc = BreedBloc();

  @override
  void initState() {
    _bloc.breedEventSink.add(FetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cats List"),
        ),
        body: breedsBuilder());
  }

  Widget breedsBuilder() {
    return StreamBuilder(
      stream: _bloc.breed,
      builder: (BuildContext context, AsyncSnapshot<List<Breed>> snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        }
        return breedsList(snapshot.data);
      },
    );
  }

  Widget breedsList(List<Breed> breeds) {
    return ListView.separated(
      itemCount: breeds.length,
      itemBuilder: (context, index) {
        Breed breed = breeds[index];
        return ListTile(
          title: Text('${breed.name}'),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BreedsDetailScreen(
                      breed: breed,
                    )));
          },
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
    );
  }
}
