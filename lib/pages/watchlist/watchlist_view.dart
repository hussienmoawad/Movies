import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/network_layer/firebase_utils.dart';
import 'package:movies/pages/watchlist/widgets/watchlist_movie_item.dart';

import '../../models/details_model.dart';
import '../home/home_details/home_details_view.dart';

class WatchListView extends StatefulWidget {
  const WatchListView({super.key});

  @override
  State<WatchListView> createState() => _WatchListViewState();
}

class _WatchListViewState extends State<WatchListView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Watchlist',
            style: TextStyle(
              fontFamily: 'Inter',
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot<DetailsModel>>(
              stream: FirestoreUtils.getRealTimeDataFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.error.toString()),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var moviesList = snapshot.data?.docs
                        .map((element) => element.data())
                        .toList() ??
                    [];
                print('MoviesList: ${moviesList.length}');
                return (moviesList.isEmpty)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('assets/images/search_body.png'),
                          const SizedBox(height: 20),
                          const Text(
                            "No Movies Found",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff514F4F),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : ListView.builder(
                  itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, HomeDetailsView.routeName,
                                  arguments: moviesList[index]);
                            },
                            child:
                                WatchlistMovieItem(model: moviesList[index])),
                        itemCount: moviesList.length,
                        padding: EdgeInsets.zero,
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
