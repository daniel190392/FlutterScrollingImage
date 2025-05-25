import 'dart:math';

import 'package:flutter/material.dart';

class MapImage extends StatefulWidget {
  const MapImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<MapImage> createState() => _MapImageState();
}

class _MapImageState extends State<MapImage> {
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
            print(imageWidth);
            print(imageHeight);
          });
        }),
      );
    }
  }

  void _showMarkerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Marker Info'),
        content: Text('You tapped on a marker!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: imageWidth,
          height: imageHeight,
          child: Stack(
            children: [
              Image.network(
                widget.imageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 340,
                top: 230,
                child: GestureDetector(
                  onTap: () => _showMarkerDialog(context),
                  child: const Tooltip(
                    message: 'Tap for info',
                    child:
                        Icon(Icons.location_on, color: Colors.green, size: 32),
                  ),
                ),
              ),
              const Positioned(
                left: 420, // Adjust to center marker
                top: 140,
                child: Icon(Icons.location_on, color: Colors.red, size: 32),
              ),
              const Positioned(
                left: 825, // Adjust to center marker
                top: 330,
                child: Icon(Icons.location_on, color: Colors.red, size: 32),
              ),
              const Positioned(
                left: 610, // Adjust to center marker
                top: 490,
                child: Icon(Icons.location_on, color: Colors.red, size: 32),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
