import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/cubit/app_cubit.dart';
import 'package:news_app/layout/cubit/cubit.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        List news = NewsCubit.get(context).search;

        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppCubit.get(context).isDark
                        ? Colors.grey
                        : Colors.white,
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                  child: TextFormField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(28.0)),
                      ),
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                    onChanged: (val) {
                      NewsCubit.get(context).getSearch(val: val);
                    },
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Search must not be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewScreen(news[index]['url'])));
                    },
                    child: Card(
                        color: AppCubit.get(context).isDark
                            ? HexColor('333739')
                            : Colors.white,
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${news[index]['urlToImage'] ?? 'https://miro.medium.com/max/880/0*H3jZONKqRuAAeHnG.jpg'}'),
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
                                        style:
                                            Theme.of(context).textTheme.bodyText1,
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
                  itemCount: news.isEmpty ? 0 : 15,
                ),
              ),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
