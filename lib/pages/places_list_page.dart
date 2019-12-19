import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';

import './add_place_page.dart';

class PlacesListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<Place> greatPlaces = Provider.of<GreatPlacesProvider>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlacePage.routeName);
            },
          )
        ],
      ),
      body: Consumer<GreatPlacesProvider>(
        child: const Center(
          child: Text('Got no places yet, start adding some!'),
        ),
        builder: (ctx, greatPlaces, child) => greatPlaces.items.length <= 0
            ? child
            : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                      backgroundImage: FileImage(greatPlaces.items[i].image)),
                  title: Text(greatPlaces.items[i].title),
                  onTap: () {
                    // Go to detail page
                  },
                ),
              ),
      ),
    );
  }
}
