import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../widgets/common/loading_widget.dart';
import 'home/location_selector.dart';
import 'home/search_bar.dart';
import 'home/filter_chips.dart';
import 'home/movie_card.dart';
import 'home/movie_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List movies = [];
  List filteredMovies = [];
  bool isLoading = true;
  String selectedLocation = 'Dhaka';
  String selectedGenre = 'All';
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final movieList = await ApiService.getMovies();
    setState(() {
      movies = movieList;
      filteredMovies = movieList;
      isLoading = false;
    });
  }

  void _filterMovies() {
    setState(() {
      filteredMovies = movies.where((movie) {
        final matchesSearch = searchController.text.isEmpty ||
            movie['title'].toLowerCase().contains(searchController.text.toLowerCase());
        final matchesGenre = selectedGenre == 'All' ||
            (movie['genre'] is List && movie['genre'].contains(selectedGenre));
        return matchesSearch && matchesGenre;
      }).toList();
    });
  }

  Future<void> _logout() async {
    await ApiService.logout();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _showMovieDetails(dynamic movie) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => MovieDetailsSheet(movie: movie),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: const Text('CineStream', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      body: Column(
        children: [
          LocationSelector(
            selectedLocation: selectedLocation,
            onLocationChanged: (location) => setState(() => selectedLocation = location),
          ),
          const SizedBox(height: 8),
          CustomSearchBar(
            controller: searchController,
            onSearch: (_) => _filterMovies(),
          ),
          const SizedBox(height: 8),
          FilterChips(
            selectedGenre: selectedGenre,
            onGenreSelected: (genre) {
              setState(() => selectedGenre = genre);
              _filterMovies();
            },
          ),
          const SizedBox(height: 8),
          Expanded(
            child: isLoading
                ? const LoadingWidget()
                : filteredMovies.isEmpty
                    ? Center(child: Text('No movies found', style: TextStyle(color: Colors.grey[500])))
                    : GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: filteredMovies.length,
                        itemBuilder: (context, index) {
                          return MovieCard(
                            movie: filteredMovies[index],
                            onTap: () => _showMovieDetails(filteredMovies[index]),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}