//http import
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/movie.dart';

class HttpHelper {
  final String urlBase = "https://api.themoviedb.org/3/movie/";
  final String urlUpcoming = "/upcoming";
  final String urlKey = "?api_key=3cae426b920b29ed2fb1c0749f258325";

  Future<List?> getUpcoming() async {
    final String urlFinal = urlBase + urlUpcoming + urlKey;

    http.Response result = await http.get(Uri.parse(urlFinal));

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse["results"];

      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      print(result.body);
      return null;
    }
  }
}
