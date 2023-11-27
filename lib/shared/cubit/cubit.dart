import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/science_page.dart';
import 'package:news_app/modules/sports_page.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/dio_helper.dart';

import '../../modules/business_page.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_soccer_outlined,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    if (index == 1) {
      getSports();
    }
    if (index == 2) {
      getScience();
    }
    currentindex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLodingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {'q': 'business', 'apiKey': 'd319242d2ca6474c88ead42a94b7f18d'},
    ).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(
        error.toString(),
      );
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {'q': 'sport', 'apiKey': 'd319242d2ca6474c88ead42a94b7f18d'},
      ).then((value) {
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(
          error.toString(),
        );
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {'q': 'science', 'apiKey': 'd319242d2ca6474c88ead42a94b7f18d'},
      ).then((value) {
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(
          error.toString(),
        );
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(AppChangeMode());
  }
}
