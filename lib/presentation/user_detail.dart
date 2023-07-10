import 'package:bloc_pagination/data/models/home_model.dart';
import 'package:bloc_pagination/data/models/user_model.dart';
import 'package:bloc_pagination/widget/cache_network_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_bloc.dart';
import '../data/services/home_respository.dart';
import '../data/services/home_service.dart';

class UserDetailScreen extends StatelessWidget {
  final int user_id;

  const UserDetailScreen({
    Key? key,
    required this.user_id,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final HomeBloc userBloc = HomeBloc(PostsRepository(PostsService()));
    userBloc.usersDetail(user_id);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: BlocProvider(
                  create: (_) => userBloc,
                  child: BlocListener<HomeBloc, HomeState>(
                  listener: (context, state) {
                    if (state is UserLoad) {

                    }
                  },
                  child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                    UserData posts = UserData();
                    bool isLoading = false;

                    if (state is UserLoad) {
                      posts = state.data;
                      print("gAGAXG===${posts.firstName}");
                      isLoading = true;
                    }

                    return userCard(height, posts) ;

                  }),
                  ),
                  ),
                ),
              ),
            )));
  }
  Widget userCard(height, posts){

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: height*.05,),
          MyCacheNetworkImages(imageUrl: posts.avatar ??"", radius: 100,height: 100,width: 100,),
          // CircleAvatar(backgroundImage: posts.avatar ? NetworkImage(posts.avatar ??"") : CircularProgressIndicator.adaptive(),radius: 50,),
          SizedBox(height: height*.05,),
          RichText(text: TextSpan(
              text: "${posts.firstName} ",
              style: TextStyle(fontSize: 22,fontWeight: FontWeight.w400,color: Colors.black) ,
              children: [
                TextSpan(text: posts.lastName ??"",style:TextStyle(fontSize: 22,fontWeight: FontWeight.w400,color: Colors.black) ,)
              ])),
          SizedBox(height: height*.01,),
          Text(posts.email ??"",style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black) ,),
          SizedBox(height: height*.05,),
        ],
      ),
    );
  }
}
