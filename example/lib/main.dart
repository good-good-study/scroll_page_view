import 'package:flutter/material.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const _images = [
    'https://files.flutter-io.cn/flutter-cn/landing/images/Dash_Phone_Games_v04.width-635.png',
    'https://files.flutter-io.cn/flutter-cn/landing/images/flutter_roadmap_2022.width-635.png',
    'https://files.flutter-io.cn/flutter-cn/landing/images/windows_flutter.width-635.jpg',
    'https://files.flutter-io.cn/posts/flutter-cn/2022/dart-2-18/image3.png',
    'https://files.flutter-io.cn/flutter-cn/landing/images/dart_image.width-635.png',
  ];

  @override
  void initState() {
    precache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scroll Page View Demo',
      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: Colors.deepOrange,
          centerTitle: false,
          title: const Text('Scroll Page View Demo'),
        ),
        body: Builder(builder: (context) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              ///Default
              const SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Default',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) {
                        return Scaffold(
                            appBar: AppBar(title: const Text('二级页面')));
                      }),
                    );
                  },
                  child: SizedBox(
                    height: 164,
                    child: ScrollPageView(
                      key: const Key('d'),
                      controller: ScrollPageController(),
                      children:
                          _images.map((image) => _imageView(image)).toList(),
                    ),
                  ),
                ),
              ),

              ///Indicator
              const SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Indicator',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 164,
                  child: ScrollPageView(
                    controller: ScrollPageController(),
                    delay: const Duration(seconds: 3),
                    indicatorAlign: Alignment.centerRight,
                    children: (_images.reversed)
                        .map((image) => _imageView(image))
                        .toList(),
                  ),
                ),
              ),

              ///Indicator Builder
              const SliverPadding(
                padding: EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'Indicator Builder',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 24),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(
                    height: 164,
                    child: ScrollPageView(
                      controller: ScrollPageController(),
                      delay: const Duration(seconds: 4),
                      indicatorAlign: Alignment.bottomRight,
                      indicatorPadding:
                          const EdgeInsets.only(bottom: 8, right: 16),
                      indicatorWidgetBuilder: _indicatorBuilder,
                      children:
                          _images.map((image) => _imageView(image)).toList(),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 1080))
            ],
          );
        }),
      ),
    );
  }

  ///Image
  Widget _imageView(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Image.network(image, fit: BoxFit.cover),
      ),
    );
  }

  ///[IndicatorWidgetBuilder]
  Widget? _indicatorBuilder(BuildContext context, int index, int length) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: const BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: RichText(
        text: TextSpan(
          text: '${index + 1}',
          style: const TextStyle(
              fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          children: [
            const TextSpan(
              text: '/',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            TextSpan(
              text: '$length',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  ///预加载图片
  Future<void> precache() async {
    for (var image in _images) {
      precacheImage(NetworkImage(image), context);
    }
  }
}
