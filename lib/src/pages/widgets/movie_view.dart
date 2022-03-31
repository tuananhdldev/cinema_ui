import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:move_app/src/core/animations/opacity_tween.dart';
import 'package:move_app/src/core/constants/app_colors.dart';
import 'package:move_app/src/core/data/model.dart';
import 'package:move_app/src/pages/details_page.dart';
import 'dart:math';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MoviesView extends StatefulWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  State<MoviesView> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  final _pageController = PageController(viewportFraction: 0.68);
  double? page = 0;

  void _listenScroll() {
    setState(() {
      page = _pageController.page;
    });
  }

  @override
  void initState() {
    _pageController.addListener(_listenScroll);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listenScroll);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double opacity = 1;
    return Column(
      children: [
        Expanded(
            flex: 9,
            child: PageView.builder(
                pageSnapping: true,
                clipBehavior: Clip.none,
                controller: _pageController,
                itemCount: movies.length,
                onPageChanged: (page) => _pageController.animateToPage(page,
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceOut),
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  double valueTranslate = 0;
                  double value = 0;

                  if (_pageController.position.haveDimensions) {
                    valueTranslate = index.toDouble() - page!;
                    value = (valueTranslate * 0.03).clamp(-1, 1);
                    opacity = (1 - valueTranslate.abs()).clamp(0.3, 1);
                  }
                  return Transform.translate(
                      offset: Offset(0, 50 * valueTranslate.abs()),
                      child: Transform.rotate(
                          angle: pi * value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                    reverseTransitionDuration:
                                        const Duration(milliseconds: 1000),
                                    pageBuilder: (context, animation, __) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: DetailPage(movie: movie),
                                      );
                                    }));
                              },
                              child: Opacity(
                                  opacity: opacity,
                                  child: Hero(
                                      tag: movie.picture,
                                      child: MovieCard(movie: movie))),
                            ),
                          )));
                })),
        Expanded(
            flex: 1,
            child: SmoothPageIndicator(
                effect: const ExpandingDotsEffect(),
                controller: _pageController,
                count: movies.length)),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage('assets/images/' + movie.picture),
                fit: BoxFit.fill)),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator(
      {Key? key,
      required this.itemCount,
      required this.indexSelected,
      required this.opacity})
      : super(key: key);
  final int itemCount;
  final int indexSelected;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(itemCount, (index) {
            bool isSelected = index == indexSelected;
            return Padding(
              padding: const EdgeInsets.all(3.0),
              child: AnimatedOpacity(
                duration: const Duration(seconds: 1),
                opacity: lerpDouble(0, 1, opacity)!,
                child: Container(
                  width: isSelected ? 12 * 2.5 : 12,
                  height: 12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.grey.shade600),
                ),
              ),
            );
          }),
        ));
  }
}
