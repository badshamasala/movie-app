import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/utensils/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.fromARGB(255, 47, 74, 97),
      highlightColor: Color.fromARGB(255, 106, 137, 165),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 15.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        itemCount: 5,
        itemBuilder: (context, index) => Container(
          height: 110.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 74, 97),
              borderRadius: BorderRadius.circular(10.sp)),
        ),
      ),
    );
  }
}
