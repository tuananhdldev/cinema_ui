import 'package:flutter/material.dart';
import 'package:move_app/src/core/constants/app_colors.dart';
import 'package:move_app/src/core/data/model.dart';

class MovieTimes extends StatefulWidget {
  const MovieTimes({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  State<MovieTimes> createState() => _MovieTimesState();
}

class _MovieTimesState extends State<MovieTimes> {
  final pageController = PageController(viewportFraction: 0.19, initialPage: 3);
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
    return SizedBox(
      height: 70,
      child: PageView.builder(
        itemBuilder: ((context, index) => MovieTimeCard(
            time: widget.movie.dates.times[index], isSelected: page == index)),
        controller: pageController,
        itemCount: widget.movie.dates.times.length,
        onPageChanged: (page) => pageController.animateToPage(page,
            duration: const Duration(seconds: 1), curve: Curves.bounceOut),
      ),
    );
  }
}

class MovieTimeCard extends StatelessWidget {
  const MovieTimeCard({Key? key, required this.time, required this.isSelected})
      : super(key: key);
  final String time;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final colorText = isSelected ? AppColors.primaryColor : Colors.grey;
    final colorBorder =
        isSelected ? AppColors.primaryColor : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(color: colorBorder),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child:
                Text(time, style: TextStyle(color: colorText, fontSize: 13))),
      ),
    );
  }
}
