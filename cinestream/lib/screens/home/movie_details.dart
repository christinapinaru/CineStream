import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants.dart';
import '../../widgets/booking/booking_dialog.dart';

class MovieDetailsSheet extends StatelessWidget {
  final dynamic movie;

  const MovieDetailsSheet({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 50,
            height: 5,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          // Poster
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              movie['posterUrl'] ?? '',
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      movie['rating']?.toString() ?? '0.0',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.access_time, color: Colors.grey, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${movie['duration'] ?? 120} min',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.calendar_today, color: Colors.grey, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      movie['releaseYear']?.toString() ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Genre chips
                if (movie['genre'] != null && movie['genre'] is List)
                  Wrap(
                    spacing: 8,
                    children: (movie['genre'] as List).map((genre) {
                      return Chip(
                        label: Text(genre, style: const TextStyle(fontSize: 12)),
                        backgroundColor: AppConstants.primaryColor.withOpacity(0.2),
                        labelStyle: TextStyle(color: AppConstants.primaryColor),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 16),
                Text(
                  'Synopsis',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movie['description'] ?? 'No description available',
                  style: TextStyle(color: Colors.grey[400], height: 1.5),
                ),
                const SizedBox(height: 20),
                // Director
                if (movie['director'] != null)
                  Text(
                    'Director: ${movie['director']}',
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                const SizedBox(height: 24),
                // Book button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (context) => BookingDialog(movie: movie),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Book Tickets',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}