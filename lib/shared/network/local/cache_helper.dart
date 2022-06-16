import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void setData(val){
    sharedPreferences!.setBool('isDark', val);
  }

  static bool? getData(){
    return sharedPreferences!.getBool('isDark');
  }
}