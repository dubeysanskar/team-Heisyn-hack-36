import 'package:carousel_slider/carousel_slider.dart';
import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  final List<Map<String, dynamic>> imageList = [
    {
      "id": 1,
      "navigate": null,
      "image_path": 'assets/images/hero-slider/slide-1.jpg',
    },
    {
      "id": 2,
      "navigate": null,
      "image_path": 'assets/images/hero-slider/slide-2.jpg',
    },
    {
      "id": 3,
      "navigate": null,
      "image_path": 'assets/images/hero-slider/slide-3.jpg',
    },
  ];

  final CarouselSliderController carouselController =
      CarouselSliderController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: () {
                // Action when tapping on the image slider
              },
              child: CarouselSlider(
                items: imageList
                    .map(
                      (item) => InkWell(
                        onTap: () {
                          if (item['navigate'] != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => item['navigate'],
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(item['image_path']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: true,
                  aspectRatio: 1.4,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Container(
                      width: currentIndex == entry.key ? 17 : 7,
                      height: 8.h,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 3.0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == entry.key
                            ? AppColors.seaBlue
                            : AppColors.pinkRose,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
