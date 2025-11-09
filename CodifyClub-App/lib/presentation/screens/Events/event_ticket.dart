import 'package:codifyclub/Core/Constants/colors.dart';
import 'package:codifyclub/core/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class EventTicket extends StatelessWidget {
  const EventTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: 50.h, left: 15.w, right: 15.w, bottom: 20.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue.withOpacity(0.4),
              AppColors.pinkRose.withOpacity(0.5)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Tickets',
                style: AppFonts().titleStyle,
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                padding: EdgeInsets.all(20.r),
                // height: 600.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 250.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/hero-slider/slide-1.jpg'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'Name',
                      style: AppFonts().normalTitleStyle1,
                    ),
                    Text(
                      'Zaid Sayyed',
                      style: AppFonts().normalTitleStyle,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date',
                              style: AppFonts().normalTitleStyle1,
                            ),
                            Text(
                              '21 Nov 2024',
                              style: AppFonts().normalTitleStyle,
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Time',
                              style: AppFonts().normalTitleStyle1,
                            ),
                            Text(
                              '08:00 AM',
                              style: AppFonts().normalTitleStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gate',
                              style: AppFonts().normalTitleStyle1,
                            ),
                            Text(
                              'UGI-17',
                              style: AppFonts().normalTitleStyle,
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Seat',
                              style: AppFonts().normalTitleStyle1,
                            ),
                            Text(
                              'Prime A, 21',
                              style: AppFonts().normalTitleStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Image(image: NetworkImage('https://miro.medium.com/v2/resize:fit:789/1*A9YcoX1YxBUsTg7p-P6GBQ.png'),width: double.infinity,),
                    Container(
                        alignment: Alignment.center,
                        // margin: EdgeInsets.all(50.r),
                        height: 200.h,
                        child: PrettyQrView.data(
                            data: 'slkfjasoffdjjsofijwfjfdskjfasdofijsdfdfkj'))
                  ],
                ),
              ),

              SizedBox(
                height: 20.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
