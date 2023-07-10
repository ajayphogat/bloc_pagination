import 'package:bloc/bloc.dart';
import 'package:bloc_pagination/data/models/user_model.dart';
import 'package:meta/meta.dart';

import '../data/models/home_model.dart';
import '../data/services/home_respository.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc(this.repository) : super(PostsInitial());

 bool pageLoader = false;
 bool isFetching = false;
  int page = 1;
  final PostsRepository repository;

  void loadPosts() {
    if (state is PostsLoading) return;

    final currentState = state;

    var oldPosts = <Data>[];
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    }

    emit(PostsLoading(oldPosts, isFirstFetch: page == 1));

    repository.fetchPosts(page).then((newPosts) {
      page++;

      final posts = (state as PostsLoading).oldPosts;
      posts.addAll(newPosts as Iterable<Data>);

      emit(PostsLoaded(posts));
    });

  }

  void usersDetail(id)async {

    if(state is UserLoad) return;
    // final currentState = state;
    // var data = Data();
 final data = await repository.fetchSingleData(id);
    emit(UserLoad(data as UserData));
    // print("data ===${data.firstName}");

  }

// void usersDetail(id) {
//
//   repository.fetchSingleData(id);
// }
}

