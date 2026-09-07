import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/data/movie_model.dart';

class SearchResultCard extends StatelessWidget {
  final MovieModel movie;

  const SearchResultCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              movie.posterUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[800],
                  child: Center(
                    child: Icon(
                      Icons.movie,
                      color: Colors.white54,
                      size: 40.sp,
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 8.h,
            left: 8.w,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    movie.rating,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
