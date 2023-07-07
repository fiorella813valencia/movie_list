import 'package:flutter/material.dart';
import 'package:terminator_practice/util/http_helper.dart';

import '../models/movie.dart';
import '../util/db_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late List? movies;
  late int moviesCount;

  late HttpHelper helper;

  Future initialize() async {
    movies = [];
    movies = await helper.getUpcoming();

    setState(() {
      moviesCount = movies!.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Movies'),
      ),
      body: ListView.builder(
        itemCount: movies!.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieRow(movies?[index]);
        },
      ),
    );
  }
}

class MovieRow extends StatefulWidget {
  final Movie movie;
  MovieRow(this.movie);


  @override
  _MovieListState createState() => _MovieRowState(movie);
}

class _MovieRowState extends State<MovieRow> {
  final Movie movie;
  _MovieRow(this.movie);
  bool favorite;
  DbHelper dbHelper;

  @override
  void initState() {
    favorite=false;
    dbHelper=DbHelper();
    isFavorite(movie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        trailing: IconButton(
          icon:Icon(Icons.favorite),
          color: favorite? Colors.red:Colors.grey,
          onPressed: () {
            setState(() {
              favorite=!favorite;
            });
          },
        ),
      ),
    );
  }

  Future isFavorite(Movie movie)async{
    await dbHelper.openDb();
    favorite =await dbHelper.isFavorite(movie);
    setState(()){
      movie.isFavorite=favorite;
    }
  }
}

