import 'dart:ui';

import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:move_app/src/core/animations/opacity_tween.dart';
import 'package:move_app/src/core/animations/slide_up_tween.dart';
import 'package:move_app/src/core/constants/app_colors.dart';
import 'package:move_app/src/core/data/model.dart';
import 'package:move_app/src/pages/widgets/movie_view.dart';

import '../core/constants/constants.dart';

class MoviePages extends StatelessWidget {
  const MoviePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundlColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(
              height: 30,
            ),
            MyAppBar(),
            SizedBox(
              height: 20,
            ),
            MovieSearchBar(),
            SizedBox(
              height: 20,
            ),
            MoviesCategories(),
            SizedBox(
              height: 20,
            ),
            Text(
              'Showing this month',
              style: titleSecond,
            ),
            Expanded(child: MoviesView())
          ],
        ),
      ),
      bottomNavigationBar:
          BottomBar(selectedIndex: 0, onTap: (index) {}, items: [
        BottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Home'),
          activeColor: Colors.blue,
        ),
        BottomBarItem(
          icon: const Icon(Icons.explore),
          title: const Text('Explorer'),
          activeColor: Colors.red,
          darkActiveColor: Colors.red.shade400, // Optional
        ),
        BottomBarItem(
          icon: const Icon(Icons.person),
          title: const Text('Account'),
          activeColor: Colors.greenAccent.shade700,
          darkActiveColor: Colors.greenAccent.shade400, // Optional
        ),
        BottomBarItem(
          icon: const Icon(Icons.settings),
          title: const Text('Settings'),
          activeColor: Colors.orange,
        ),
      ]),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Welcome Stanley 👋',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Let relax and watch a movie',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 23,
            backgroundImage: AssetImage('assets/images/perfilFoto.jpg'),
          )
        ],
      ),
    );
  }
}

class MovieSearchBar extends StatelessWidget {
  const MovieSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: OpacityTween(
          child: SlideUpTween(
              begin: const Offset(-100, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.secondaryColor),
                child: TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 35,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ))),
    );
  }
}

class MoviesCategories extends StatelessWidget {
  const MoviesCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Category',
                  style: titleSecond,
                ),
                Row(
                  children: const [
                    Text(
                      'See All',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.primaryColor,
                      size: 12,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return Column(
                      children: [
                        Container(
                          width: 80,
                          height: 70,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            category.icon,
                            style: const TextStyle(fontSize: 30),
                          )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          category.name,
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        width: 25.0,
                      ),
                  itemCount: categories.length),
            )
          ],
        ),
      ),
    );
  }
}
