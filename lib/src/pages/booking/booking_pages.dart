import 'package:flutter/material.dart';
import 'package:move_app/src/core/constants/app_colors.dart';
import 'package:move_app/src/core/data/model.dart';
import 'package:move_app/src/pages/booking/custom_app_bar.dart';
import 'package:move_app/src/pages/booking/movie_time_view.dart';
import 'package:move_app/src/pages/booking/screen_painter.dart';

import 'bottom_size_animation.dart';
import 'movie_date.dart';
import 'opacity_animation.dart';
import 'seat_section.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage>
    with TickerProviderStateMixin {
  late ButtonSizeAnimationController controller;
  final movie = movies.first;
  @override
  void initState() {
    controller = ButtonSizeAnimationController(
        buttonController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 750)),
        contentController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 750)));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      await controller.buttonController.forward();
      await controller.buttonController.reverse();
      await controller.contentController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundlColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        child: OpacityAnimation(
          listenable: controller.initialOpacityAnimation,
          child: const CustomAppBar(),
        ),
        preferredSize: const Size.fromHeight(kToolbarHeight),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
              width: size.width,
              child: Column(
                children: [
                  OpacityAnimation(
                      child: _CinemaLayout(),
                      listenable: controller.initialOpacityAnimation),
                  OpacityAnimation(
                      child: _BottomPage(
                        movie: movie,
                      ),
                      listenable: controller.endOpacityAnimation)
                ],
              ))
        ],
      ),
    );
  }
}

class _BottomPage extends StatelessWidget {
  const _BottomPage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height * 0.42;
    return Container(
      width: size.width,
      height: height,
      decoration: const BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 22,
          ),
          const Text('Select Date and Time',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 30,
          ),
          MovieDates(
            movie: movie,
          ),
          MovieTimes(movie: movie),
          Expanded(
              child: Padding(
            padding:
                const EdgeInsets.only(right: 25, left: 25, top: 30, bottom: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Total Price',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('\$43.55',
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                      child: Text(
                    'Book Ticket',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class _CinemaLayout extends StatelessWidget {
  _CinemaLayout({Key? key}) : super(key: key);
  final movie = movies.first;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding:
          const EdgeInsets.only(top: kToolbarHeight * 1.6, right: 25, left: 25),
      child: Column(children: [
        SizedBox(
          height: size.height * 0.06,
          width: size.width,
          child: CustomPaint(
            painter: ScreeenPainter(),
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        SizedBox(
          width: size.width,
          child: MovieCinema(cinema: movie.location),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        const MovieSeatlabels(),
        SizedBox(
          height: size.height * 0.02,
        ),
      ]),
    );
  }
}

class MovieSeatlabels extends StatelessWidget {
  const MovieSeatlabels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: seatLabels
            .map((e) => SeatStatusLabel(color: e.color, label: e.name))
            .toList(),
      ),
    );
  }
}

class SeatStatusLabel extends StatelessWidget {
  const SeatStatusLabel({Key? key, required this.color, required this.label})
      : super(key: key);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }
}
