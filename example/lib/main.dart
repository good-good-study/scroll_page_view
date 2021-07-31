import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    'https://img0.baidu.com/it/u=1653580614,1680935100&fm=26&fmt=auto&gp=0.jpg',
    'https://img2.baidu.com/it/u=3610762567,1537181675&fm=26&fmt=auto&gp=0.jpg',
    'https://img1.baidu.com/it/u=392290897,2018293179&fm=26&fmt=auto&gp=0.jpg',
    'https://img0.baidu.com/it/u=1174472233,2731877603&fm=26&fmt=auto&gp=0.jpg',
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
        body: CustomScrollView(
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
              child: SizedBox(
                height: 164,
                child: ScrollPageView(
                  controller: ScrollPageController(),
                  children: _images.map((image) => _imageView(image)).toList(),
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
          ],
        ),
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
