import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:muthamizh/middleware/bloc.dart';
import 'package:muthamizh/screens/Initial.dart';
import 'package:muthamizh/screens/Team.dart';
import 'package:muthamizh/screens/editprofile.dart';
import 'package:muthamizh/screens/landing.dart';
import 'package:muthamizh/screens/login.dart';
import 'package:muthamizh/screens/profile.dart';
import 'package:muthamizh/screens/searchmember.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Initial(),
          routes: [
            GoRoute(
              path: 'profile/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return Profile(id: id,);
              },
            )
          ]
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/editprofile',
        builder: (context, state) => EditProfile(),
      ),
      GoRoute(
        path: '/team',
        builder: (context, state) => Team(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => Search(),
      ),
      // GoRoute(
      //   path: '/profile/:id',
      //   builder: (context, state) {
      //     final id = state.pathParameters['id']!;
      //     return Profile(id: id,);
      //   },
      // ),
      // GoRoute(
      //   path: '/profile/:id',
      //   builder: (context, state) {
      //     final id = state.pathParameters['id']!;
      //     return Profile(id: id,);
      //   },
      // )
      // GoRoute(
      //   path: '/profile',
      //   builder: (context, state) => Profile(),
      // ),

      // Add other routes as needed...
    ],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StringBloc(),
      child: MaterialApp.router(
          title: 'Muthamizh Varthagargal',
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: Landing(),
        ),
    );
   
  }
}

