import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final String rating;

  const MovieCard({
    super.key,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146.w,
      height: 220.h,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 8.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 8.h,
              left: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                  vertical: 3.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      rating,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 10.sp,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}