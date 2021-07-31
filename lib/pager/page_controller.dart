import 'package:flutter/material.dart';

///PageView滑动监听
class ScrollPageController {
  PageController controller;

  ///[PageController.initialPage]
  final int initialPage;

  ///[PageController.keepPage]
  final bool keepPage;

  /// [PageController.viewportFraction]
  final double viewportFraction;

  ScrollPageController({
    this.initialPage = 0,
    this.keepPage = true,
    this.viewportFraction = 1.0,
  })  : assert(viewportFraction > 0.0),
        controller = PageController(
          initialPage: getInitialPage(initialPage),
          keepPage: keepPage,
          viewportFraction: viewportFraction,
        );

  static int getInitialPage(int initialPage) {
    if (initialPage == 0) return 1;
    return initialPage;
  }

  PageController get() => controller;
}
