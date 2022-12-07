import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lift_to_live_flutter/presentation/views/home_page_view.dart';

import '../../../helper.dart';

class NewsArticleHolder extends StatelessWidget {
  final HomePageView view;
  final int index;

  const NewsArticleHolder({super.key, required this.view, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index.isOdd
          ? Helper.lightBlueColor
          : Helper.paragraphBackgroundColor
          .withOpacity(0.12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                height: 80,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20)),
                    child: view.currentNews.articles[index]
                        .urlToImage.isEmpty
                        ? null
                        : Image.network(
                      view.currentNews
                          .articles[index].urlToImage,
                      loadingBuilder: (context, child,
                          loadingProgress) =>
                      (loadingProgress == null)
                          ? child
                          : const Center(
                        child:
                        CircularProgressIndicator(
                          color: Helper
                              .pageBackgroundColor,
                        ),
                      ),
                      errorBuilder: (context, error,
                          stackTrace) =>
                          Container(
                            height: 80,
                            width: 160,
                            color: Helper.backgroundColor,
                          ),
                      scale: 0.1,
                      height: 80,
                      width: 160,
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      view.currentNews.articles[index].title,
                      style: const TextStyle(
                          color: Helper.defaultTextColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${view.currentNews.articles[index].description}\n\n${view.currentNews.articles[index].content}',
              style: const TextStyle(
                color: Helper.defaultTextColor,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.extended(
                heroTag: index.toString(),
                onPressed: () async {
                  view.redirectToUrl(index);
                },
                icon: const Icon(
                  CupertinoIcons.arrow_turn_down_right,
                  color: Helper.actionButtonTextColor,
                ),
                label: const Text('Read More', style: TextStyle(color: Helper.blackColor),),
                backgroundColor: Helper.actionButtonColor,
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}