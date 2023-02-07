import 'package:flutter/material.dart';
import 'package:online_store/theme/app_colors.dart';
import 'package:online_store/ui/widgets/elements/ecommerce_logo_widget.dart';

class IconWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color? iconColor;
  final IconData icon;
  final double size;
  final double? radius;

  final void Function()? onPressed;

  const IconWidget({
    Key? key,
    required this.backgroundColor,
    required this.icon,
    required this.size,
    this.onPressed,
    this.radius,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 0),
        color: backgroundColor,
      ),
      width: size,
      height: size,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size / 2,
          color: iconColor ?? Colors.white,
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
    final List<Padding> starList = List.generate(5, (index) {
      return Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Icon(
          _starIcon(index + 1),
          color: color,
          size: size,
        ),
      );
    });
    return Row(children: starList);
  }
}

class AppElevatedButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Widget title;
  final double? width;
  final double? height;
  final double? radius;
  final void Function()? onPressed;

  const AppElevatedButtonWidget(
      {Key? key,
      required this.backgroundColor,
      required this.title,
      this.width,
      this.height,
      this.radius,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(

          backgroundColor: backgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 0))),
      child: SizedBox(
        height: height,
        width: width,
        child: title,
      ),
    );
  }
}

class LoadWidget extends StatelessWidget {
  const LoadWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: AppColors.dark,
            ),
            width: 70,
            height: 70,
            child: const EcommerceLogoWidget(logoSize: 60),
          ),
          const CircularProgressIndicator(
            color: AppColors.orange,
            // backgroundColor: AppColors.dark,
            strokeWidth: 6,
          ),
        ],
      ),
    );
  }
}
