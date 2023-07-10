part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class PostsInitial extends HomeState {}



class PostsLoaded extends HomeState {
  final List<Data> posts;
  final bool isFirstFetch;
  PostsLoaded(this.posts,{this.isFirstFetch=false});
}

class PostsLoading extends HomeState {
  final List<Data> oldPosts;
  final bool isFirstFetch;
  PostsLoading(this.oldPosts, {this.isFirstFetch=false});

}



class UserLoad extends HomeState {
  final UserData data;
  UserLoad(this.data );
}

