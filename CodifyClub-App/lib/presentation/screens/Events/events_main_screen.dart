import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/datasources/courseData.dart';
import '../../../data/datasources/eventData.dart';
import '../../widgets/category_selector.dart';
import '../../widgets/eventCard.dart';

class EventsMainScreen extends StatelessWidget {
  const EventsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: EdgeInsets.all(15.r),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              Text(
                '22 Oct 2024'.toString(),
                style: AppFonts().normalTitleStyle1,
                textAlign: TextAlign.start,
              ),
              Text(
                'Explore Events',
                style: AppFonts().titleStyle,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                maxLines: 1,
                cursorColor: AppColors.black,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.policeBlue.withOpacity(0.1),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.policeBlue,
                    size: 25.sp,
                  ),
                  suffixIcon: Icon(
                    Icons.edit_note_outlined,
                    color: AppColors.policeBlue,
                    size: 25.sp,
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.policeBlue.withOpacity(0.7),
                    fontSize: 18.sp,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    borderSide:
                        BorderSide.none, // This removes the visible border
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.r)),
                      borderSide: BorderSide(
                          color: AppColors.policeBlue
                              .withOpacity(0.2)) // No visible border on focus
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.r)),
                    borderSide:
                        BorderSide.none, // No visible border when enabled
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Popular Events',
                style: AppFonts().normalTitleStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [EventCard(
                    day: '21',
                    month: 'NOV',
                    eventName: 'Star Night Performance',
                    eventCategory: 'Song & Party',
                    time: '08:00 PM',
                    imagepath: 'assets/images/hero-slider/slide-1.jpg',
                  ),
                    EventCard(
                      day: '22',
                      month: 'NOV',
                      eventName: 'UHack 3.0 ',
                      eventCategory: 'Tech',
                      time: '09:00 AM',
                      imagepath: 'assets/images/hero-slider/slide-2.jpg',
                    ),
                    EventCard(
                      day: '22',
                      month: 'NOV',
                      eventName: 'Gen AI WorkShop 2.0 ',
                      eventCategory: 'Tech',
                      time: '09:00 AM',
                      imagepath: 'assets/images/hero-slider/slide-3.jpg',
                    ),],
                ),
              ),
              CategorySelectorWidget(
                categories: eventCategories.values.toList(),
                selectedCategory: 0,
                onCategorySelected: (index) {

                },
              ),
              EventCard(
                isMini: false,
                day: '21',
                month: 'NOV',
                eventName: 'Star Night Performance',
                eventCategory: 'Song & Party',
                time: '08:00 PM',
                imagepath: 'assets/images/hero-slider/slide-1.jpg',
              ),
              EventCard(
                isMini: false,
                day: '22',
                month: 'NOV',
                eventName: 'UHack 3.0 ',
                eventCategory: 'Tech',
                time: '09:00 AM',
                imagepath: 'assets/images/hero-slider/slide-2.jpg',
              ),
              EventCard(
                day: '22',
                month: 'NOV',
                eventName: 'Gen AI WorkShop 2.0 ',
                eventCategory: 'Tech',
                time: '09:00 AM',
                imagepath: 'assets/images/hero-slider/slide-3.jpg',
                isMini: false,
              ),



            ],
          ),
        ),
      ),
    );
  }
}
