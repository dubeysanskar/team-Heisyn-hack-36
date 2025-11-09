import 'dart:ui';
import 'package:codifyclub/core/constants/colors.dart';
import 'package:codifyclub/core/constants/fonts.dart';
import 'package:codifyclub/presentation/screens/Events/event_ticket.dart';
import 'package:codifyclub/presentation/screens/in_app_browser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventViewScreen extends StatelessWidget {
  const EventViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height, // Ensure full screen height
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hero-slider/slide-1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 10.w),
                      Row(
                        children: [
                          Icon(
                            Icons.headset_mic_outlined,
                            color: Colors.white,
                            size: 30.sp, // Adjust icon size
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'Tech',
                            style: TextStyle(
                              fontSize: 25.sp, // Adjust font size
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Time
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: Colors.white,
                            size: 30.sp, // Adjust icon size
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            '09:00 AM',
                            style: TextStyle(
                              fontSize: 25.sp, // Adjust font size
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'EventName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InAppBrowser(
                                  url:
                                      "https://maps.app.goo.gl/Q9JCneStyJZP8DSaA")));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 150.h,
                            width: double.infinity,
                            margin: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://img.freepik.com/premium-vector/3d-top-view-map-with-destination-location-point-aerial-clean-top-view-day-time-city-map-with-street-river-blank-urban-imagination-map-gps-map-navigator-concept_34645-1097.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Aligns the icon with the text top
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColors.policeBlue,
                                size: 35.sp, // Adjust icon size
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                // Ensure text takes up available space
                                child: Text(
                                  'United Tower 53, Leader Road, Allahabad, U.P. India',
                                  style: TextStyle(
                                    fontSize: 20.sp, // Adjust font size
                                    color: AppColors.policeBlue,
                                  ),
                                  softWrap:
                                      true, // Allows text to wrap to a new line
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>EventTicket()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>InAppBrowser(url: "https://reddit-sclone.vercel.app/")));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10), // Button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15.r), // Circular border radius
                        ),
                        elevation:
                            5, // Optional: Adjust elevation for shadow effect
                      ),
                      child: Text(
                        'Buy Ticket',
                        style: AppFonts()
                            .titleStyle, // Text style from your AppFonts class
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
