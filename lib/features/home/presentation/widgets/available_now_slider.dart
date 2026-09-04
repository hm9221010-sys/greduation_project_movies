import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AvailableNowSlider extends StatelessWidget {
  final List<String> imageUrls;
  final ValueChanged<int> onPageChanged;

  const AvailableNowSlider({
    super.key,
    required this.imageUrls,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 355,
      child: CarouselSlider.builder(
        itemCount: imageUrls.length,
        options: CarouselOptions(
          height: 351,
          enlargeCenterPage: true,
          viewportFraction: 0.62,
          enlargeFactor: 0.21,
          onPageChanged: (index, reason) => onPageChanged(index),
        ),
        itemBuilder: (context, index, realIndex) {
          return _MovieCarouselItem(imageUrl: imageUrls[index]);
        },
      ),
    );
  }
}

class _MovieCarouselItem extends StatelessWidget {
  final String imageUrl;

  const _MovieCarouselItem({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 234,
      height: 351,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
            const Positioned(
              top: 10,
              left: 10,
              child: _RatingBadge(rating: '7.7'),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final String rating;

  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            rating,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 3),
          const Icon(Icons.star, color: Colors.amber, size: 12),
        ],
      ),
    );
  }
}

















