import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp_project/cubit/cubit.dart';
import 'package:mp_project/screen/main_splash_screen/quicker_main_splash_screen.dart';
import 'package:mp_project/shared/bloc_observer.dart';
import 'package:mp_project/shared/constants.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  BlocOverrides.runZoned(() {
    runApp(
        MultiBlocProvider(
            providers: [
              BlocProvider<AppMainCubit>(
                  create: (context)=> AppMainCubit()..createDatabase()
              ),
            ],
            child: MyApp()
        )
    );
  },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'MB',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: QuickerMainSplashScreen(),
    );
  }
}

