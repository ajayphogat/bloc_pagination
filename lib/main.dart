import 'package:bloc_pagination/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'cubit/home_bloc.dart';
import 'data/services/home_respository.dart';
import 'data/services/home_service.dart';

void main() {
  runApp(MyApp(
    repository: PostsRepository(PostsService()),
  ));
}

class MyApp extends StatelessWidget {
  final PostsRepository? repository;

  const MyApp({Key? key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MultiBlocProvider(providers: [

        BlocProvider(
          create: (context) {
            return HomeBloc(repository!);
          },
        ),
        // BlocProvider(
        //   create: (context) {
        //     return UserBloc(repository!);
        //   },
        // )
      ],
          child: HomeScreen()),
    );
  }




}
