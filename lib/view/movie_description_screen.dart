import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movieList_controller.dart';
import 'package:movie_app/utensils/app_colors.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

// ignore: must_be_immutable
class MovieDescriptionScreen extends StatelessWidget {
  MovieDescriptionScreen({
    super.key,
  });
  MovieListController movieListController = Get.find<MovieListController>();

  @override
  Widget build(BuildContext context) {
    // Extract the numeric part (3.5) from the rating value
    double numericRating = double.parse(
        movieListController.movieDescriptionData.value!.rating!.split('/')[0]);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Image.network(
            movieListController.movieDescriptionData.value?.posterPictureUrl ??
                "",
            fit: BoxFit.fill,
            height: 300.h,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 300.h,
              width: double.infinity,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movieListController.movieDescriptionData.value?.title ?? "",
                  style: TextStyle(fontSize: 25.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 10.h,
                ),
                RatingStars(
                  value: numericRating,
                  onValueChanged: (v) {},
                  starBuilder: (index, color) => Icon(
                    Icons.star,
                    color: color,
                  ),
                  starCount: 5,
                  starSize: 20,
                  maxValue: 5,
                  starSpacing: 2,
                  maxValueVisibility: false,
                  valueLabelVisibility: false,
                  animationDuration: Duration(milliseconds: 1000),
                  valueLabelPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  valueLabelMargin: const EdgeInsets.only(right: 8),
                  starOffColor: const Color(0xffe7e8ea),
                  starColor: Colors.purple,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  movieListController.movieDescriptionData.value?.description ??
                      "",
                  style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                  maxLines: 3,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
