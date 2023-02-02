import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final double size;
  final void Function()? onPressed;

  const IconWidget({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.size,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 4),
        color: backgroundColor,
      ),
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size / 2,
          color: Colors.white,
        ),
      ),
    );
  }
}

class RatingStarsBuilderWidget extends StatelessWidget {
  final double rating;

  const RatingStarsBuilderWidget({Key? key, required this.rating})
      : super(key: key);

  IconData starIcon(int index) {
    if (rating > index) {
      return Icons.star;
    } else if (rating < index && rating > index - 1) {
      return Icons.star_half;
    } else {
      return Icons.star_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(starIcon(1)),
        Icon(starIcon(2)),
        Icon(starIcon(3)),
        Icon(starIcon(4)),
        Icon(starIcon(5)),
      ],
    );
  }
}
