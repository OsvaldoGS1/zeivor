import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;

  const StarRating(this.rating, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      IconData starIcon = i <= rating
          ? Icons.star
          : (i - rating < 1 ? Icons.star_half : Icons.star_border);
      Color starColor = i <= rating ? Colors.orange : Colors.grey;

      stars.add(
        Icon(
          starIcon,
          color: starColor,
        ),
      );
    }

    return Row(
      children: stars,
    );
  }
}
