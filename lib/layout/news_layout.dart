// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeAppMode();
                  print(cubit.isDark);
                },
                icon: Icon(Icons.dark_mode),
              ),
            ],
            title: Text(
              'News App',
            ),
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              cubit.changeBottomNavBar(value);
            },
            currentIndex: cubit.currentindex,
            items: cubit.bottomItems,
          ),
        );
      },
    );
  }
}
