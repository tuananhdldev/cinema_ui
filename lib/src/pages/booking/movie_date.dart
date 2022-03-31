import 'package:flutter/material.dart';
import 'package:move_app/src/core/data/model.dart';

import '../../core/constants/app_colors.dart';

class MovieDates extends StatefulWidget {
  const MovieDates({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  State<MovieDates> createState() => _MovieDatesState();
}

class _MovieDatesState extends State<MovieDates> {
  final pageController =
      PageController(viewportFraction: 0.165, initialPage: 5);
  double? page = 0;
  void _listenScroll() {
    setState(() {
      page = pageController.page;
    });
  }

  @override
  void initState() {
    pageController.addListener(_listenScroll);

    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(_listenScroll);
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movieDates = List.generate(
      31,
      (index) => MovieDate('Mar', index + 1, widget.movie.dates.times),
    );
    return SizedBox(
      height: 83,
      child: PageView.builder(
        controller: pageController,
        itemCount: movieDates.length,
        onPageChanged: (page) {
          pageController.animateToPage(page,
              duration: const Duration(milliseconds: 400),
              curve: Curves.bounceOut);
        },
        itemBuilder: (context, index) {
          double opacity = 1;
          if (pageController.position.haveDimensions) {
            opacity = index.toDouble() - pageController.page!;
            opacity = opacity.clamp(0, 2);
            if (opacity > 1) {
              opacity = 0;
            }
          }

          return MovieDateOval(
              date: movieDates[index],
              isSelected: index == page,
              opacity: opacity);
        },
      ),
    );
  }
}

class MovieDateOval extends StatelessWidget {
  const MovieDateOval(
      {Key? key,
      required this.date,
      required this.isSelected,
      required this.opacity})
      : super(key: key);
  final MovieDate date;
  final bool isSelected;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    final color = isSelected ? AppColors.primaryColor : Colors.black12;
    final colorNumber = isSelected ? Colors.white : Colors.transparent;
    final colorText = isSelected ? Colors.black : Colors.grey;
    final colorMonth = isSelected ? Colors.white : Colors.grey;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              date.month,
              style: TextStyle(
                fontSize: 12,
                color: colorMonth,
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: colorNumber),
              child: Center(
                child: Text(
                  date.dayOfMonth.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    color: colorText,
                    fontWeight: FontWeight.bold,
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
