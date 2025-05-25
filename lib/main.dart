import 'package:flutter/material.dart';
import 'package:scroll_image/map_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(
        title: 'Señor de los anillos',
        imageUrl: "https://m.media-amazon.com/images/I/718b9hBS4AL.jpg",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.imageUrl});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final String imageUrl;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double imageWidth = 0;
  double imageHeight = 0;
  Image? imageToShow;

  @override
  void initState() {
    super.initState();
    _getImageDimensions();
  }

  void _getImageDimensions() async {
    imageToShow = Image.network(widget.imageUrl);
    if (imageToShow != null) {
      final ImageStream stream =
          imageToShow!.image.resolve(ImageConfiguration.empty);

      stream.addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          final img = info.image;
          setState(() {
            imageWidth = img.width.toDouble();
            imageHeight = img.height.toDouble();
          });
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Increment',
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 500,
              child: MapImage(imageUrl: widget.imageUrl),
            ),
            const Text("Detalle"),
          ],
        ),
      ),
    );
  }
}
