import 'package:flutter/material.dart';

class SearchOfHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchState();
  }
}

class _SearchState extends State<SearchOfHome> {


  TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }


  @override
  void dispose(){
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }


  _onSearchChanged(){
    print(_searchController.text);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        titleSpacing: 5.0 ,
        title: Text("Search"),
      ),
      body: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search)
        ),
      ),
    );
  }
}
