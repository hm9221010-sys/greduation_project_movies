import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:greduation_movies_fluter/features/home/data/movie_model.dart';
import 'package:greduation_movies_fluter/features/home/presentation/widgets/movie_card.dart';
import 'package:greduation_movies_fluter/utils/app_color.dart';
import '../../../../features/favorites/services/history_service.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: HistoryService.getHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              style: const TextStyle(
                color: AppColors.whiteColor,
              ),
            ),
          );
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/images/iconProfile.png',
            ),
          );
        }

        final movies = docs.map(
              (document) {
            final data = document.data();

            return MovieModel(
              id: data['id'] ?? 0,
              title: data['title'] ?? '',
              posterUrl: data['posterUrl'] ?? '',
              rating: data['rating']?.toString() ?? '0.0',
              releaseDate: DateTime.tryParse(
                data['releaseDate']?.toString() ?? '',
              ) ??
                  DateTime.now(),
              dateAdded: DateTime.tryParse(
                data['dateAdded']?.toString() ?? '',
              ) ??
                  DateTime.now(),
              genres: data['genres'] != null
                  ? List<String>.from(
                data['genres'],
              )
                  : [],
            );
          },
        ).toList();

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: movies.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            childAspectRatio: 0.66,
          ),
          itemBuilder: (context, index) {
            return MovieCard(
              movie: movies[index],
            );
          },
        );
      },
    );
  }
}