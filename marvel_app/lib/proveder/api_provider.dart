import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel_app/Model/moveModel.dart';
import 'package:marvel_app/serves/api.dart';


class MovieProvider with ChangeNotifier {
  List<MovieModel> movies = [];
  final Api _api = Api();
  bool loading = false;
  bool error = false;
  

  get busy => null;

  getmoive() async {
    loading = true;
    movies.clear();
    var response = await _api.get("https://mcuapi.herokuapp.com/api/v1/movies");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      for (var item in data) {
        movies.add(MovieModel.fromJson(item));
      }
      loading = false;
      notifyListeners();
    }
    
  }
  seterror(){
    error = true;


  }

  
}