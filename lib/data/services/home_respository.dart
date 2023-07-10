

import 'package:bloc_pagination/data/models/user_model.dart';

import '../models/home_model.dart';
import 'home_service.dart';

class PostsRepository {

  final PostsService service;

  PostsRepository(this.service);

  Future<List> fetchPosts(int page) async {
    final posts = await service.fetchPosts(page);
    return posts;
  }

  Future<UserData?> fetchSingleData(int id) async {
    final posts = await service.fetchSingleUser(id);
    print(posts?.firstName);
    return posts;
  }

}