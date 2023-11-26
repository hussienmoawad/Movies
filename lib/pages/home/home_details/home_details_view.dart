import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../models/details_model.dart';
import '../home_view_model.dart';
import 'similar_movies_view.dart';

class HomeDetailsView extends StatelessWidget {
  static String routeName = "home details";
  HomeViewModel vm = HomeViewModel();

  HomeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context)?.settings.arguments as DetailsModel;
    vm.getSimilarMovies(model.id!);
    var mediaQuery = MediaQuery.of(context);
    var width = mediaQuery.size.width;

    return ChangeNotifierProvider(
      create: (context) => vm,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            model.originalTitle ?? "",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "${Constants.imageBaseURL}${model.backdropPath}"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Image.asset("assets/images/play_button.png"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.originalTitle ?? "",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          Constants.getMovieReleaseYear(model.releaseDate!),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          Constants.getMovieDuration(model.runtime!),
                          style: TextStyle(
                              fontSize: 15, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          "${Constants.imageBaseURL}${model.posterPath}",
                          width: 140,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        Consumer<HomeViewModel>(
                          builder: (context, vm, child) => GestureDetector(
                            onTap: () {
                              vm.bookmarkButtonPressed(model);
                            },
                            child: Image.asset(
                              (model.isFavorite)
                                  ? 'assets/images/bookmarked.png'
                                  : 'assets/images/bookmark.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxHeight:
                                  ((model.genres!.length) <= 3) ? 50 : 75,
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 2.2,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    model.genres?[index]['name'],
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              },
                              itemCount: model.genres?.length,
                            ),
                          ),
                          Text(
                            model.overview ?? "",
                            maxLines: 5,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset("assets/images/Group16.png"),
                              const SizedBox(width: 5),
                              Text(
                                "${model.voteAverage}",
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.white),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SimilarMoviesView(vm: vm),
            ],
          ),
        ),
      ),
    );
  }
}

/*
SingleChildScrollView(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                  child: Column(
                    children: [

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  childAspectRatio: 3 / 4,
                                ),
                                itemBuilder: (context, index) {
                                  return
                                },
                                itemCount: model.genres?.length,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
 */
