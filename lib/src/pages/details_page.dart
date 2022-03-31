import 'package:flutter/material.dart';
import 'package:move_app/src/core/constants/app_colors.dart';
import 'package:move_app/src/core/data/model.dart';

import 'booking/booking_pages.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryBackgroundlColor,
        elevation: 0,
        title: const Text(
          'Movie Details',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 16,
          ),
        ),
      ),
      backgroundColor: AppColors.primaryBackgroundlColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(flex: 9, child: _movieDescription()),
                  Expanded(flex: 2, child: _title(movie.name)),
                  Divider(
                    color: Colors.grey[800],
                  ),
                  Expanded(flex: 7, child: _synopsisMovie(movie.synopsis))
                ]),
          ),
          _backgroudGradient(context),
          Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              height: 60,
              left: size.width / 5,
              right: size.width / 5,
              child: TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primaryColor)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BookingPage(),
                    ),
                  );
                },
                child: const Text(
                  'Get Reservation',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ))
        ],
      ),
    );
  }

  Widget _synopsisMovie(String synopsis) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Synopsis',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          RichText(
              overflow: TextOverflow.fade,
              text: TextSpan(
                  text: synopsis,
                  style: const TextStyle(fontSize: 14, height: 1.7)))
        ],
      ),
    );
  }

  Widget _backgroudGradient(BuildContext context) {
    return Positioned(
        bottom: 0,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 25,
                    spreadRadius: 25,
                    blurStyle: BlurStyle.normal)
              ],
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.black12])),
        ));
  }

  Widget _title(String title) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(
        title,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _movieDescription() {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: Hero(
              tag: movie.picture,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/images/' + movie.picture))),
              ),
            )),
        Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconCard(
                    title: 'Genre',
                    text: movie.gender,
                    icon: Icons.video_camera_back),
                IconCard(
                    title: 'Duration',
                    text: movie.duractionMinutes,
                    icon: Icons.watch_later),
                IconCard(
                    title: 'Rating',
                    text: movie.raiting.toString() + ' / 10',
                    icon: Icons.star),
              ],
            ))
      ],
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard(
      {Key? key, required this.title, required this.text, required this.icon})
      : super(key: key);
  final String title;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: double.maxFinite,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white24, width: 1)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    color: Colors.white60,
                    blurRadius: 15.0,
                    offset: Offset(-5, 5))
              ]),
          child: Icon(
            icon,
            size: 32,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[500]),
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ]),
    );
  }
}
