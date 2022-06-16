import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/app_states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeThemeMode({bool? theme}){
    if(theme != null){
      isDark = theme;
      emit(AppChangeThemeModeState());
    }else{
      isDark = !isDark;
      CacheHelper.setData(isDark);
      emit(AppChangeThemeModeState());
    }
  }
}