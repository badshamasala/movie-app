import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movieList_controller.dart';
import 'package:movie_app/utensils/app_colors.dart';
import 'package:movie_app/utensils/shimmer_effect.dart';
import 'package:movie_app/view/movie_description_screen.dart';

// ignore: must_be_immutable
class MovieListScreen extends StatelessWidget {
  MovieListScreen({super.key});
  MovieListController movieListController = Get.find<MovieListController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          title: Text(
            "Collection",
            style: TextStyle(
                color: AppColors.titleColor, fontSize: 25.sp, letterSpacing: 1),
          ),
        ),
        body: Obx(() {
          if (movieListController.isLoading.value == true ||
              movieListController.movieListData.value?.data == null) {
            return const ShimmerScreen();
          } else {
            return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                  backgroundColor: Colors.blueGrey,
                                ),
                              ));

                      await movieListController
                          .getMovieDescriptionMethod(movieListController
                              .movieListData.value?.data?[index]?.id)
                          .whenComplete(() => Get.back());

                      Get.to(() => MovieDescriptionScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.sp),
                                bottomLeft: Radius.circular(10.sp)),
                            child: Image.network(
                              movieListController.movieListData.value
                                      ?.data?[index]?.tilePictureUrl ??
                                  "",
                              fit: BoxFit.fill,
                              height: 110.h,
                              width: 80.w,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 110.h,
                                width: 80.h,
                                color: Colors.grey,
                                child: const Center(child: Text("No\nImage")),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.sp, vertical: 15.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieListController.movieListData.value
                                          ?.data?[index]?.title ??
                                      "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  width: 200.w,
                                  child: Text(
                                    movieListController.movieListData.value
                                            ?.data?[index]?.shortDescription ??
                                        "",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15.sp),
                                    maxLines: 3,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                      height: 20.h,
                    ),
                itemCount:
                    movieListController.movieListData.value?.data?.length ?? 0);
          }
        }));
  }
}
