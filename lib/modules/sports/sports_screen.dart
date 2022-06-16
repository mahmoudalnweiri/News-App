import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/cubit/app_cubit.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var news = NewsCubit.get(context).sports;

        return news.isNotEmpty
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewScreen(news[index]['url'])));
                  },
                  child: Card(
                      color: AppCubit.get(context).isDark ? HexColor('333739') : Colors.white,
                      elevation: 0,
                      margin:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage('${news[index]['urlToImage']??'https://miro.medium.com/max/880/0*H3jZONKqRuAAeHnG.jpg'}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${news[index]['title']}',
                                      style: Theme.of(context).textTheme.bodyText1,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    '${news[index]['publishedAt']}',
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.all(0),
                  child: Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 0.5,
                  ),
                ),
                itemCount: 10,
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      listener: (context, state) {},
    );
  }
}
