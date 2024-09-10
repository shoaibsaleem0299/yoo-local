import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yoo_local/screens/category/category_view.dart';
import 'package:yoo_local/widgets/app_button.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  ImageSliderState createState() => ImageSliderState();
}

class ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7Kzinyb-fKpIW7KzHy6w8VRGXkikkTQlv011R5d4nS8xHh0N_UfpdMaSbp1EL4_Z0g68&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWiXH60_04PEj5N5YrxzFq_O5VTl2FZCdktdakCa7dH0uWNEXqCcXE73s7-662wiQmiXk&usqp=CAU',
    'https://thumbs.dreamstime.com/z/two-glasses-red-wine-one-full-empty-stand-wooden-table-next-to-bottles-cheese-grapes-327803949.jpg',
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % imgList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgList[_currentIndex]),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Explore',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                AppButton(
                    title: "Shop Now",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryView()));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
