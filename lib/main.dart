import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';
import 'pages/cubits/chat_cubit/chat_cubit.dart';
import 'pages/cubits/login_cubit/login_cubit.dart';
import 'pages/cubits/signin_cubit/signin_cubit.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/resgiter_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SigninCubit(),
        ),
        BlocProvider(create: (context) => ChatCubit()),
      ],
      child: MaterialApp(
        routes: {
          'loginPage': (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          'homePage': (context) => HomePage(),
        },
        initialRoute: 'loginPage',
      ),
    );
  }
}
