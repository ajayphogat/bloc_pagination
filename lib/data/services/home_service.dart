import 'dart:convert';
import 'dart:developer';

import 'package:bloc_pagination/data/models/home_model.dart';
import 'package:bloc_pagination/data/models/user_model.dart';
import 'package:http/http.dart';

class PostsService {

  static const FETCH_LIMIT = 9;

  Future<List<dynamic>> fetchPosts(int page) async {


      List<Data> home = [];

      try {
        var response = await get(Uri.parse(
            'https://reqres.in/api/users?page=${page.toString()}&per_page=$FETCH_LIMIT'));
        // print(page);
        if (response.statusCode != 200) {
          return [];
        }
        final result = jsonDecode(response.body);
        final data = HomeModel.fromJson(result);

        home = data.data!;

        return home;
      } catch (e) {
        log(e.toString());
        return [];
      }
    }


  Future<UserData?> fetchSingleUser(int id) async {

    UserData home = UserData();

    try {
      var response = await get(Uri.parse(
          'https://reqres.in/api/users/$id'));
      print(id);
      if (response.statusCode != 200) {
        return null;
      }
      final result = jsonDecode(response.body);
      final data = UserModel.fromJson(result);

      home = data.data!;
      print(home.firstName);

      return home;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


}