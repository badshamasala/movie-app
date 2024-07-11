import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_app/model/movie_description_model.dart';
import 'package:movie_app/model/movie_list_model.dart';

import 'package:http/http.dart' as http;

class MovieListController extends GetxController {
  Rx<bool> isLoading = false.obs;
  Rx<MovieList?> movieListData = MovieList().obs;
  Rx<MovieDescription?> movieDescriptionData = MovieDescription().obs;

  @override
  void onInit() async {
    getMovieListMethod();

    super.onInit();
  }

  Future<void> getMovieListMethod() async {
    try {
      isLoading.value = true;
      MovieList? response = await MovieListService().getMovieList();
      if (response != null && response.data != null) {
        movieListData.value = response;
      } else {
        movieListData.value = null;
      }
    } catch (exp) {
      print(exp);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> getMovieDescriptionMethod(int? id) async {
    try {
      isLoading.value = true;
      MovieDescription? response =
          await MovieListService().getMovieDescription(id);
      if (response != null) {
        movieDescriptionData.value = response;
      } else {
        movieDescriptionData.value = null;
      }
    } catch (exp) {
      print(exp);
    } finally {
      isLoading.value = false;
      update();
    }
  }
}

class MovieListService {
  Future<MovieList?> getMovieList() async {
    dynamic response = await http.get(
      Uri.parse("http://enl-qa.centralindia.cloudapp.azure.com:8900/movies"),
    );
    dynamic responseData = jsonDecode(response.body);
    if (response != null) {
      MovieList movieListResponse = MovieList();
      movieListResponse = MovieList.fromJson({"data": responseData});
      return movieListResponse;
    } else {
      print("error");
    }
  }

  Future<MovieDescription?> getMovieDescription(int? id) async {
    dynamic response = await http.get(
      Uri.parse(
          "http://enl-qa.centralindia.cloudapp.azure.com:8900/movies/$id"),
    );
    dynamic responseData = jsonDecode(response.body);
    if (response != null) {
      MovieDescription movieListResponse = MovieDescription();
      movieListResponse = MovieDescription.fromJson(responseData);
      return movieListResponse;
    } else {
      print("error");
    }
  }
}
