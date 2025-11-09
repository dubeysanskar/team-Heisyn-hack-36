import 'package:codifyclub/presentation/screens/Courses/cources_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/api_keys.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/fonts.dart';
import '../../../data/datasources/courseData.dart';
import '../../widgets/category_selector.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int selectedCategory = 0;
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
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.policeBlue,
        title: Text(
          "Courses",
          style: AppFonts().normalTitleStyle.copyWith(color: AppColors.white),
        ),
      ),
      body: Column(
        children: [
          CategorySelectorWidget(
            categories: categories.values.toList(),
            selectedCategory: selectedCategory,
            onCategorySelected: (index) {
              setState(() {
                selectedCategory = index;
              });
            },
          ),
          Expanded(child: _buildCourseList()),
        ],
      ),
    );
  }

  Widget _buildCourseList() {
    return ListView.builder(
      itemCount: courseData.length,
      itemBuilder: (context, index) {
        final course = courseData[index];
        final selectedCategoryName =
        categories.values.toList()[selectedCategory];
        if (selectedCategoryName != 'All' &&
            course.category != selectedCategoryName) {
          return SizedBox.shrink();
        }
        return _CourseCard(course: course);
      },
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;

  const _CourseCard({Key? key, required this.course}) : super(key: key);

  void _openCourse(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourcesMain(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.policeBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageSection(context),
          SizedBox(width: 15.w),
          Expanded(child: _buildCourseDetailsSection(context)),
        ],
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            _openCourse(context);
          },
          child: Container(
            width: 192.w,
            height: 108.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              image: DecorationImage(
                image: AssetImage(course.src),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        _buildRating(),
        _buildPriceSection(),
      ],
    );
  }

  Widget _buildRating() {
    return Row(
      children: [
        Text(
          course.rating.toString(),
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 5.w),
        RatingBarIndicator(
          rating: course.rating,
          itemBuilder: (context, index) => Icon(Icons.star, color: Colors.orange),
          itemCount: 5,
          itemSize: 16.sp,
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Row(
      children: [
        Text(course.discountPrice, style: AppFonts().normalTitleStyle),
        SizedBox(width: 10.w),
        Text(
          course.price,
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCourseDetailsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            _openCourse(context);
          },
          child: Text(
            course.title,
            style: AppFonts().normalTitleStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 5.h),
        Text(course.author, style: AppFonts().descriptionStyle),
        SizedBox(height: 25.h),
        _buildBuyNowButton(context),
      ],
    );
  }

  Widget _buildBuyNowButton(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        var options = {
          'key': rezorPayApiKey,
          'amount': 1*100, // amount in the smallest currency unit (paise for INR)
          'name': 'Zaid Sayyed',
          'description': '${course.title}',
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
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
