import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mp_project/layout/user_taps_scrren.dart';
import 'package:mp_project/screen/authentication_screen/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';




class QuickerMainSplashScreen extends StatefulWidget {
  @override
  State<QuickerMainSplashScreen> createState() => _QuickerMainSplashScreenState();
}

class _QuickerMainSplashScreenState extends State<QuickerMainSplashScreen> {

  dynamic autoLogin;

  Future<void> check() async
  {
    final prefs = await SharedPreferences.getInstance();
    autoLogin = prefs.getBool('autoLogin');
  }

  @override
  void initState(){
    check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          width: screenWidth,
          height: screenHeight,
          // color: Colors.amber.withOpacity(0.8),
          child: Stack(
            children: [
              Container(
                  width: screenWidth,
                  height: screenHeight,
                  child: Image.asset("assets/images/splash_image.png",fit: BoxFit.fill,)
              ),
              Container(
                width: screenWidth,
                height: screenHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpinKitThreeBounce(color: Colors.white,size: 25,),
                    ),
                    Container(
                      height: 1,
                      width: 1,
                      child: AnimatedSplashScreen(
                        splash: SizedBox(),
                        nextScreen:
                        // AuthScreen(),
                        autoLogin == true ? UserTapsScreen() : AuthScreen(),
                        duration: 1500,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}



