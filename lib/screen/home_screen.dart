import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilem/screen/detail_screen.dart';
import 'package:pilem/services/api_service.dart';

import '../models/movie.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();

  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  @override
  void initState(){
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final List<Map<String, dynamic>> allMoviesData = await _apiService.getAllMovies();
    final List<Map<String, dynamic>> trendingMoviesData = await _apiService.getTrendingMovies();
    final List<Map<String, dynamic>> popularMoviesData = await _apiService.getPopularMovies();

    setState(() {
      _allMovies = allMoviesData.map((e) => Movie.fromJson(e)).toList();
      _trendingMovies = trendingMoviesData.map((e) => Movie.fromJson(e)).toList();
      _popularMovies = popularMoviesData.map((e) => Movie.fromJson(e)).toList();
    });
  }

  Widget _buildMoviesList (String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final Movie movie = movies[index];
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailScreen(movie: movie),),),
                  child: Column(
                    children: [
                      
                      Image.network('https://tmdb.org/t/p/w500${movie.posterPath}',
                      height: 150,
                      width: 100,
                      fit: BoxFit.cover,
                      ),
                      SizedBox(height: 5),
                      Text(movie.title.length > 14 ?
                      '${movie.title.substring(0,10)}...' : movie.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              },),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilem'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildMoviesList('All Movies', _allMovies),
            _buildMoviesList('Trending Movies', _trendingMovies),
            _buildMoviesList('Popular Movies', _popularMovies),
          ],
        ),
      ),
    );
  }
}