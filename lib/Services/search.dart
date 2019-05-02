import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Function"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),
      drawer: Drawer(),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = [
    "Anuradhapura",
    "Colombo",
    "Maharagama",
    "Kuruegala",
    "Boralesgamuwa",
    "Bellanvila",
    "Nugegoda",
    "Delkanda",
    "Navinna",
    "Thibirigasyaya",
    "Kirilapone",
    "Kollupitiya",
    "Bambalapitiya",
    "Battaramulla",
    "Thalangama",
    "Kotte",
    "Koswatta"
  ];
  final recentCities = ["Boralesgamuwa", "Bellanvila", "Nugegoda", "Delkanda"];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query= "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some results based on the selection
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when somone searches something
    final suggetionList = query.isEmpty ? recentCities : cities.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
            leading: Icon(Icons.location_city),
            title: Text(suggetionList[index]),
          ),
      itemCount: suggetionList.length,
    );
  }
}
