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
  final double size;
  final Color color;

  const RatingStarsBuilderWidget(
      {Key? key, required this.rating, required this.color, required this.size})
      : super(key: key);

  IconData _starIcon(int index) {
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
    final List<Icon> starList = List.generate(5, (index) {
      return Icon(
        _starIcon(index + 1),
        color: color,
        size: size,
      );
    });
    return Row(children: starList);
  }
}
