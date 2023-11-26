import 'package:flutter/material.dart';
import 'package:movies/core/constants.dart';
import 'package:movies/models/details_model.dart';
import 'package:movies/pages/browse/browse_view_model.dart';
import 'package:provider/provider.dart';

class GenreMovieItem extends StatelessWidget {
  final BrowseViewModel vm;
  final DetailsModel model;

  const GenreMovieItem({
    super.key,
    required this.model,
    required this.vm,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      builder: (context, child) => Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: 90,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 90,
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                            '${Constants.imageBaseURL}${model.posterPath}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Consumer<BrowseViewModel>(
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
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.title!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        Row(
                          children: [
                            const ImageIcon(
                              AssetImage("assets/images/star_rate.png"),
                              color: Color(0xffFFBB3B),
                            ),
                            Text(
                              "${model.voteAverage}",
                              style: const TextStyle(
                                  color:
                                      Colors.white), // Adjust style as needed
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              Constants.getMovieReleaseYear(model.releaseDate!),
                              style: const TextStyle(
                                color: Color(0XFFB5B4B4),
                              ), // Adjust style as needed
                            ),
                            const SizedBox(width: 5),
                            Text(
                              Constants.getMovieDuration(model.runtime!),
                              style: const TextStyle(
                                color: Color(0XFFB5B4B4),
                              ), // Adjust style as needed
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: const Divider(
              height: 2,
              color: Color(0xff707070),
            ),
          ),
        ],
      ),
    );
  }
}
