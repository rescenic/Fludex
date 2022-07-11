import 'package:cached_network_image/cached_network_image.dart';
import 'package:fludex/mangaReader/aboutManga.dart';
import 'package:fludex/utils.dart';
import 'package:flutter/material.dart';
import 'package:mangadex_library/mangadex_library.dart' as lib;
import 'package:mangadex_library/models/common/data.dart';
import 'package:mangadex_library/models/login/Login.dart';

class SearchResultHolder extends StatefulWidget {
  final bool? gridView;
  final bool dataSaver;
  final Token? token;
  final Data mangaData;
  SearchResultHolder(
      {required this.dataSaver,
      this.gridView = false,
      required this.mangaData,
      required this.token});
  _SearchResultHolder createState() => _SearchResultHolder();
}

class _SearchResultHolder extends State<SearchResultHolder> {
  bool hasPressed = false;
  late bool lightMode;
  Widget build(BuildContext context) {
    print(widget.gridView);
    lightMode = Theme.of(context).brightness == Brightness.light;
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder(
        future: lib.getCoverArtUrl([widget.mangaData.id], res: 256),
        builder: (context, AsyncSnapshot<List<String>> coverUrl) {
          if (coverUrl.connectionState == ConnectionState.done) {
            if (coverUrl.data != null) {
              List<Widget> tagWidgets = <Widget>[];
              var requiredTagList = widget.mangaData.attributes.tags.take(4);
              for (int i = 0; i < requiredTagList.length; i++) {
                tagWidgets.add(
                  Container(
                    decoration: BoxDecoration(
                      color: lightMode
                          ? Colors.white
                          : Color.fromARGB(150, 18, 18, 18),
                      border:
                          lightMode ? Border.all(color: Colors.black) : null,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      widget.mangaData.attributes.tags[i].attributes.name.en,
                      style: TextStyle(
                        color: lightMode ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                );
              }
              if (hasPressed == false) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    child: InkWell(
                      child: Card(
                        elevation: 1,
                        child: (constraints.maxWidth < 427 &&
                                    widget.gridView == true ||
                                constraints.maxWidth < 427 ||
                                widget.gridView == true)
                            ? Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(coverUrl.data![0]),
                                  ),
                                ),
                                height: 200,
                                //alignment: Alignment.centerLeft,
                                // CachedNetworkImage(
                                //   imageUrl: coverUrl.data!,
                                //   fit: BoxFit.contain,
                                //   placeholder:
                                //       (BuildContext context, url) => Center(
                                //     child: Container(
                                //       height: 100,
                                //       width: 100,
                                //       child: CircularProgressIndicator(),
                                //     ),
                                //   ),
                                // ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                Colors.black,
                                                Colors.transparent
                                              ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter)),
                                          height: 40,
                                          child: Center(
                                            child: Text(
                                              widget.mangaData.attributes.title
                                                  .en,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Row(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: CachedNetworkImage(
                                      imageUrl: coverUrl.data![0],
                                      placeholder:
                                          (BuildContext context, url) => Center(
                                        child: Container(
                                          height: 100,
                                          width: 100,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              widget.mangaData.attributes.title
                                                  .en,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 21,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: Container(
                                              child: LimitedBox(
                                                maxWidth: 500,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: tagWidgets,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              widget.mangaData.attributes
                                                  .description.en,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 4,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                FludexUtils.statusContainer(
                                                    widget.mangaData.attributes
                                                        .status,
                                                    lightMode),
                                                FludexUtils.demographicContainer(
                                                    widget.mangaData.attributes
                                                        .publicationDemographic,
                                                    lightMode),
                                                FludexUtils.ratingContainer(
                                                    widget.mangaData.attributes
                                                        .contentRating,
                                                    lightMode),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutManga(
                              token: widget.token,
                              dataSaver: widget.dataSaver,
                              lightMode: lightMode,
                              mangaData: widget.mangaData,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else {
              return Container(
                child: Center(
                  child: Text(
                    'Couldn\'t load data :(',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              );
            }
          } else {
            return Center(
              child: Container(
                  height: 100, width: 100, child: CircularProgressIndicator()),
            );
          }
        },
      );
    });
  }

  void showBanner() => ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text(
              'Something went wrong, make sure you are connected to the internet.'),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: Text('Dismiss'),
              style: TextButton.styleFrom(),
            )
          ],
        ),
      );
}
