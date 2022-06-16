import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<SalomonBottomBarItem> bottomItem = [
    SalomonBottomBarItem(icon: const Icon(Icons.business), title: const Text('Business')),
    SalomonBottomBarItem(icon: const Icon(Icons.sports), title: const Text('Sports')),
    SalomonBottomBarItem(icon: const Icon(Icons.science), title: const Text('Science')),
  ];

  List screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(index) {
    currentIndex = index;
    if (index == 1) {
      getSports();
    } else if (index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List business = [];
  List sports = [];
  List science = [];
  List search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '1a30cd8160c74a908687e71699afda6c',
      },
    ).then((value) {
      //print(value.data['articles']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());

      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'sports',
          'apiKey': '1a30cd8160c74a908687e71699afda6c',
        },
      ).then((value) {
        //print(value.data['articles']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'us',
          'category': 'science',
          'apiKey': '1a30cd8160c74a908687e71699afda6c',
        },
      ).then((value) {
        //print(value.data['articles']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());

        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  void getSearch({required val}) {

    emit(NewsGetSearchLoadingState());
    search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$val',
        'apiKey': '1a30cd8160c74a908687e71699afda6c',
      },
    ).then((value) {
      if(val == null){
        search = [];
      }else{
        search = value.data['articles'];
      }
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
