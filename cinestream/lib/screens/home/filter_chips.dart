import 'package:flutter/material.dart';
import '../../constants.dart';

class FilterChips extends StatelessWidget {
  final String selectedGenre;
  final Function(String) onGenreSelected;

  const FilterChips({
    super.key,
    required this.selectedGenre,
    required this.onGenreSelected,
  });

  static const List<String> genres = [  // এখানে static const যোগ করুন
    'All', 'Action', 'Comedy', 'Drama', 'Horror',
    'Romance', 'Sci-Fi', 'Thriller', 'Adventure'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: genres.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final genre = genres[index];
          return FilterChip(
            label: Text(genre),
            selected: selectedGenre == genre,
            onSelected: (selected) {
              onGenreSelected(selected ? genre : 'All');
            },
            selectedColor: AppConstants.primaryColor,
            backgroundColor: Colors.grey[800],
            labelStyle: TextStyle(
              color: selectedGenre == genre ? Colors.white : Colors.grey[300],
              fontWeight: selectedGenre == genre ? FontWeight.bold : FontWeight.normal,
            ),
          );
        },
      ),
    );
  }
}