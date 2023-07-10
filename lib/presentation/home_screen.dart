import 'dart:async';

import 'package:bloc_pagination/cubit/home_bloc.dart';
import 'package:bloc_pagination/presentation/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import '../data/models/home_model.dart';
import '../widget/cache_network_img.dart';

class HomeScreen extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HomeBloc>(context).loadPosts();
        }
      }
    });
  }
  // bool  pageLoader = false;
  // bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<HomeBloc>(context).loadPosts();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
            if (state is PostsLoading && state.isFirstFetch) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            List<Data> posts = [];
            bool isLoading = false;

            if (state is PostsLoading) {
              posts = state.oldPosts;
              isLoading = true;
            } else if (state is PostsLoaded) {
              posts = state.posts;
            }

            return    ListView.separated(
              controller: scrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                if (index < posts.length) {
                return GestureDetector(
                  onTap: () {
                    // BlocProvider.of<HomeBloc>(context).usersDetail(posts[index].id!,);
                    Get.to(UserDetailScreen( user_id:posts[index].id!));

                  },
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide()),
                    child: ListTile(


                      leading: MyCacheNetworkImages(imageUrl: posts[index].avatar ??"", radius: 100,height: 55,width: 55,),

                      // leading: CircleAvatar(backgroundImage: NetworkImage(posts[index].avatar ??""),radius: 30,),
                      title: RichText(text: TextSpan(
                          text: "${posts[index].firstName} ",
                          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black) ,
                          children: [
                            TextSpan(text: posts[index].lastName ??"",style:TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black) ,)
                          ])),
                      subtitle: Text(posts[index].email ??""),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                );
                } else {
                  Timer(const Duration(milliseconds: 30), () {
                    scrollController
                        .jumpTo(scrollController.position.maxScrollExtent);
                  });

                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.grey[400],);
              },

            );
          }),
        ),
      ),
    );
  }
}
