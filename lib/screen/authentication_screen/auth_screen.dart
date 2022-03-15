import 'package:another_flushbar/flushbar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mp_project/shared/constants.dart';

import '../otp_screen/otp_screen.dart';




class AuthScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: AuthCard()
      ),
    );
  }
}

class AuthCard extends StatefulWidget {

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {

  String fontFamily = "MarkaziText";
  bool clicked = false;
  bool numberSent = false;
  String countryCode = "+2";

  @override
  Widget build(BuildContext context) {
    double screenHeight=MediaQuery.of(context).size.height;
    double screenWidth=MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(height: 20,),
            Container(
              height: clicked == true ? screenHeight*0.45 : screenHeight*0.7,
              width: screenWidth,
              child: Image.asset("assets/images/logo_image.png",fit: BoxFit.fill,),
            ),
            Container(
              height: clicked == true ? screenHeight*0.55 : screenHeight*0.3,
              width: screenWidth,
              child: showNumberCard(screenHeight,screenWidth),
            )
          ],
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formKey2 = GlobalKey();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController password = TextEditingController();
  bool checkNumberOnChanged = false , loading = false,right = false, numberExist = false;

  showNumberCard(double screenHeight,double screenWidth){
    return Form(
      key: _formKey2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        child: Container(
          child: Column(
            children: [
              Container(
                // padding: EdgeInsets.all(10),
                child: Text(
                  "WELCOME TO MUTUAL BENEFIT",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                child: Row(
                  children: [
                    CountryCodePicker(
                      onChanged: (value){
                        setState(() {
                          countryCode = value.toString();
                        });
                      },
                      initialSelection: 'EG',
                      favorite: ['+2','EG'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                    ),
                    Expanded(
                      child: TextFormField(
                        textAlign: TextAlign.left,
                        onTap: (){
                          setState(() {
                            clicked = true;
                          });
                        },
                        onFieldSubmitted: (value){
                          setState(() {
                            clicked = false;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding:  EdgeInsets.all(10),
                          hintText: "Enter your Mobile Number",
                          hintStyle: TextStyle(fontFamily: fontFamily,fontSize: 15),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.black, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.black, width: 1),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                        controller: mobileNumberController,
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          if(value.isEmpty){
                            setState(() {
                              right = false;
                            });
                          }else{
                            setState(() {
                              right = true;
                              numberSent = false;
                            });
                          }
                          if(checkNumberOnChanged == true){
                            _formKey2.currentState!.validate();
                          }
                        },
                        validator: (value) {
                          if (double.tryParse(value!) == null) {
                            return "Please Enter A Valid Number";
                          }
                          if(countryCode == "+2" && (value.length != 11)){
                            return "Please Enter A Valid Number";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight*.04,),
              Container(
                width: double.infinity,
                child: loading == true ? CupertinoActivityIndicator() :
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: appColor,
                        elevation: 0.0
                    ),
                    onPressed: () async{
                      var  valid = _formKey2.currentState!.validate();
                      if(mobileNumberController.text.isEmpty){
                        Flushbar(
                          flushbarPosition: FlushbarPosition.TOP,
                          messageText: Text("Enter Your Phone Number",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                          icon: Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: Colors.amber,
                          ),
                          duration: Duration(seconds: 3),
                          // leftBarIndicatorColor: Colors.grey[800],
                        )..show(context);
                      } else if(valid) {
                        FocusScope.of(context).unfocus();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen(countryCode,mobileNumberController.text.trim())));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Login / Sign Up",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
