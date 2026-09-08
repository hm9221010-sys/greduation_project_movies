import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../favorites/services/favorite_service.dart';
import '../../data/movie_model.dart';


class MovieCard extends StatefulWidget {
  final MovieModel movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavorite();
  }

  Future<void> checkFavorite() async {
    try {
      final result = await FavoriteService.isFavorite(
        widget.movie.id,
      );

      if (!mounted) return;

      setState(() {
        isFavorite = result;
      });
    } catch (e) {
      debugPrint(
        'Check Favorite Error: $e',
      );
    }
  }

  Future<void> toggleFavorite() async {
    try {
      if (isFavorite) {
        await FavoriteService.removeFavorite(
          widget.movie.id,
        );
      } else {
        await FavoriteService.addFavorite(
          widget.movie,
        );
      }

      if (!mounted) return;

      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      debugPrint(
        'Favorite Error: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146.w,
      height: 220.h,
      margin: EdgeInsets.only(
        right: 12.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          16.r,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.5,
            ),
            blurRadius: 8.r,
            offset: Offset(
              0,
              4.h,
            ),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          16.r,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              widget.movie.posterUrl,
              fit: BoxFit.cover,
            ),

            // Rating
            Positioned(
              top: 8.h,
              left: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(
                    alpha: 0.6,
                  ),
                  borderRadius: BorderRadius.circular(
                    8.r,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.movie.rating,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 10.sp,
                    ),
                  ],
                ),
              ),
            ),

            // Favorite
            Positioned(
              top: 8.h,
              right: 8.w,
              child: GestureDetector(
                onTap: toggleFavorite,
                child: Container(
                  padding: EdgeInsets.all(
                    6.r,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(
                      alpha: 0.6,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: isFavorite
                        ? Colors.red
                        : Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}