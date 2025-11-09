import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/Presentation/Screens/signup_screen.dart';
import 'package:codifyclub/core/constants/fonts.dart';
import 'package:codifyclub/presentation/screens/Algo%20Visualizer/SortingVisualizer3D.dart';
import 'package:codifyclub/presentation/screens/Alumni%20Connect/alumni_connect_screen.dart';
import 'package:codifyclub/presentation/screens/Events/events_main_screen.dart';
import 'package:codifyclub/presentation/screens/Interview%20AI/interviewform.dart';
import 'package:codifyclub/presentation/screens/Resume%20AI/resume_suggestion_screen.dart';
import 'package:codifyclub/presentation/screens/code_editor.dart';
import 'package:codifyclub/presentation/screens/Courses/courses_screen.dart';
import 'package:codifyclub/presentation/screens/in_app_browser.dart';
import 'package:codifyclub/presentation/widgets/Slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:codifyclub/data/datasources/courseData.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../core/constants/api_keys.dart';
import '../Courses/cources_main.dart';
import '../Roadmap/roadmap_form.dart';

List<Map<String, dynamic>> menubutton = [
  {
    'name': 'Resume',
    'icon': 'assets/images/menu-icon/menu-1.png',
    'navigate': ResumeSuggestionScreen(),
  },
  {
    'name': 'Lounge',
    'icon': 'assets/images/menu-icon/menu-2.png',
    'navigate': InAppBrowser(url: "https://codify-lounge.vercel.app/"),
  },
  {
    'name': 'Ai Interview',
    'icon': 'assets/images/menu-icon/menu-3.png',
    'navigate': InterviewForm(),
  },
  {
    'name': 'Courses',
    'icon': 'assets/images/menu-icon/menu-4.png',
    'navigate': CoursesScreen(),
  },
  {
    'name': 'AI Roadmap',
    'icon': 'assets/images/menu-icon/menu-5.png',
    'navigate': RoadmapForm(),
  },
  {
    'name': 'Code Wizard',
    'icon': 'assets/images/menu-icon/menu-6.png',
    'navigate': CodeEditor(),
  },
  {
    'name': 'AI ChatBot',
    'icon': 'assets/images/menu-icon/menu-7.png',
    'navigate': InAppBrowser(url:"https://cdn.botpress.cloud/webchat/v2.2/shareable.html?configUrl=https://files.bpcontent.cloud/2024/10/17/19/20241017190506-0VEII2RH.json",),
  },
  {
    'name': 'Event Manic',
    'icon': 'assets/images/menu-icon/menu-8.png',
    'navigate': EventsMainScreen(),
  }
];

class Homepagescreen extends StatefulWidget {
  const Homepagescreen({super.key});

  @override
  State<Homepagescreen> createState() => _HomepagescreenState();
}

class _HomepagescreenState extends State<Homepagescreen> {
  late Razorpay _razorpay; // Declare Razorpay as late

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear(); // Clear all Razorpay listeners when disposing
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Successful!')),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment Failed!')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet selection
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('External Wallet Selected!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        toolbarHeight: 80.h,
        backgroundColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome,',
              style: AppFonts().titleStyle,
            ),
            Text(
              'Zaid',
              style: AppFonts().normalTitleStyle1,
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: CircleAvatar(
              radius: 30.r,
              backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/v2/D5603AQF_DfqMNKxPow/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1697396607338?e=2147483647&v=beta&t=JPyHN8qnclFeI5app3kn98M-FxUaQUdrErUap-N4yy4'),
            ),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            //   height: 220.h,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       border: Border.all(color: AppColors.policeBlue, width: 2.r),
            //       borderRadius: BorderRadius.circular(15.r),
            //       image: DecorationImage(
            //           image: NetworkImage(
            //               'https://media.licdn.com/dms/image/v2/D5622AQGd9ivygQ0aSg/feedshare-shrink_2048_1536/feedshare-shrink_2048_1536/0/1714246988461?e=1732147200&v=beta&t=SfDQznFPEeG4etGTM1sz3pDLSEeHFltUBtrO0KF3SvI'),
            //           fit: BoxFit.cover)),
            // ),
            SliderScreen(),
            // Container(
            //   height: 50.h,
            //   width: double.infinity,
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 10,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: EdgeInsets.all(5.r),
            //           height: 30.h,
            //           width: 80.w,
            //           padding: EdgeInsets.all(5.r),
            //           decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20.r),
            //               border: Border.all(
            //                   color: AppColors.policeBlue, width: 1)),
            //           child: Center(
            //               child: Text(
            //             'Tab ${index + 1}',
            //             style: AppFonts().normalTitleStyle1,
            //           )),
            //         );
            //       }),
            // )
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                width: double.infinity,
                // padding: EdgeInsets.all(15.r),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.seaBlue, width: 2.r),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 5.h,
                      ),
                      child: Text(
                        'All Features',
                        style: AppFonts().titleStyle,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 15.h,
                        alignment: WrapAlignment.center,
                        children: List.generate(
                          menubutton.length,
                          (index) => InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              if (menubutton[index]['navigate'] != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            menubutton[index]['navigate']));
                              }
                            },
                            child: Container(
                              //  margin: EdgeInsets.all(9.r),
                              padding: EdgeInsets.all(2.r),
                              height: 100.h,
                              width: 85.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35.r)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (index < 4)
                                          ? AppColors.policeBlue
                                              .withOpacity(0.2)
                                          : AppColors.white,
                                    ),
                                    padding: EdgeInsets.all(10.r),
                                    child: Image.asset(
                                      menubutton[index]['icon'],
                                      height: 32.h,
                                      // color: (index < 4)
                                      //     ? AppColors.white
                                      //     : AppColors.policeBlue,
                                    ),
                                  ),
                                  Text(
                                    menubutton[index]['name'],
                                    style: TextStyle(
                                        color: AppColors.policeBlue,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Our Courses',
                  style: AppFonts().titleStyle,
                )),
            SizedBox(
              height: 380.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courseData.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(10.r),
                  width: 250.w,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.policeBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourcesMain()));
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150.h,
                          margin: EdgeInsets.only(bottom: 5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: DecorationImage(
                                  image: AssetImage(courseData[index].src),
                                  fit: BoxFit.cover)),
                        ),
                      ),

                      InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourcesMain()));
                        },
                        child: Text(
                          courseData[index].title,
                          style: AppFonts().normalTitleStyle,
                        ),
                      ),
                      InkWell(
                        splashColor: AppColors.transparent,
                        highlightColor: AppColors.transparent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourcesMain()));
                        },
                        child: Text(
                          courseData[index].author,
                          style: AppFonts().descriptionStyle,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            courseData[index].rating.toString(),
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5.w),
                          RatingBarIndicator(
                            rating: courseData[index].rating,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            itemCount: 5,
                            itemSize: 16.sp,
                          ),
                        ],
                      ),
                      Spacer(),
                      // Price
                      Row(
                        children: [
                          Text(
                            courseData[index].discountPrice,
                            style: AppFonts().normalTitleStyle,
                          ),
                          SizedBox(width: 10),
                          Text(
                            courseData[index].price,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: AppColors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp),
                          ),
                          Spacer(),
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              var options = {
                                'key': rezorPayApiKey,
                                'amount': 99 * 100,
                                'name': 'Zaid Sayyed',
                                'description': '${courseData[index].title}',
                              };
                              try {
                                Razorpay razorpay = Razorpay();
                                razorpay.open(options);
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: AppColors.policeBlue,
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Center(
                                  child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                              )),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      ),
    );
  }
}
