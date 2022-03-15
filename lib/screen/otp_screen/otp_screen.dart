import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp_project/cubit/cubit.dart';
import 'package:mp_project/cubit/states.dart';
import 'dart:io' show Platform;

import 'package:sms_autofill/sms_autofill.dart';

import '../singup_page/SignUpPage.dart';


class OTPScreen extends StatefulWidget {

  final String number;
  final String countryCode;

  OTPScreen(this.countryCode,this.number);


  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {


  Future verifyPhone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${widget.countryCode}"+'$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("PHONE AUTHENTICATION VERIFICATION COMPLETED ${credential.smsCode}");
        },
        verificationFailed: (FirebaseAuthException e) {
          print("PHONE AUTHENTICATION VERIFICATION FAILED ${e.message}");
        },
        codeSent: (String verificationID, int ? resendToken) {
          _verificationCode = verificationID;
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          _verificationCode = verificationID;
        },
        timeout: Duration(minutes: 2)
    );
  }

  late String _verificationCode;
  String _code="";
  bool verificationIsLoading = false;

  @override
  void initState() {
    verifyPhone(widget.number);
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("OTP Screen",),
        elevation: 0,
        backgroundColor: Colors.grey[300],
      ),
      body: BlocConsumer<AppMainCubit,AppMainStates>(
        listener: (context,state){},
        builder: (context,state){
          AppMainCubit appMainCubitAccess = AppMainCubit.get(context);
          return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("MUTUAL BENEFIT",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Directionality(textDirection: TextDirection.rtl, child: Text("welcome to mutual benefit app",style: TextStyle(fontSize: 16,),),),
                          SizedBox(height: 5,),
                          Text("you will get OTP message to your phone number",style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                          Directionality(textDirection: TextDirection.rtl, child: Text(widget.number,style: TextStyle(fontSize: 16),),),
                          SizedBox(height: 20,),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: PinFieldAutoFill(
                              decoration: UnderlineDecoration(
                                textStyle: TextStyle(fontSize: 20, color: Colors.black),
                                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
                              ),
                              cursor: Cursor(color: Colors.amber),
                              currentCode: _code,
                              onCodeChanged: (code) async{
                                if(code!.length == 6){
                                  setState(() {
                                    verificationIsLoading = true;
                                  });
                                  // await Future.delayed(Duration(seconds: 2));
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SignUpPage(widget.number)));

                                  await FirebaseAuth.instance
                                      .signInWithCredential(PhoneAuthProvider.credential(
                                      verificationId: _verificationCode, smsCode: code))
                                      .then((value) async {
                                    if (value.user != null) {
                                      FocusScope.of(context).unfocus();
                                      await FirebaseFirestore.instance.collection("Users").where("mobileNumber",isEqualTo: widget.number).get().then((query) async{
                                        if(query.docs.isEmpty){
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SignUpPage(widget.number)));
                                        }else{
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => SignUpPage(widget.number)));
                                        }
                                      }).catchError((error){

                                      });
                                    }
                                  }).catchError((error){

                                  });

                                }else{
                                  Flushbar(
                                    messageText: Text("code not correct"),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 30,),
                          verificationIsLoading == true ? CupertinoActivityIndicator() :
                          Column(
                            children: [
                              Text("Enter OTP Code",style: TextStyle(fontSize: 16),),
                              SizedBox(height: 8,),
                              Text("if you don't receive code you will get new one after 2 minutes",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("your data still safe in any state",style: TextStyle(fontSize: 15,color: Colors.blue),),
                    ),
                  )
                ],
              )
          );
        },
      ),
    );
  }
}
