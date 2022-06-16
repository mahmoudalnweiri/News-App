import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/app_cubit.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeThemeMode();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: SalomonBottomBar(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            currentIndex: NewsCubit.get(context).currentIndex,
            onTap: (index){
              NewsCubit.get(context).changeBottomNavBar(index);
            },
            items: NewsCubit.get(context).bottomItem,
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
