import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mp_project/cubit/cubit.dart';
import 'package:mp_project/cubit/states.dart';
import 'package:mp_project/layout/user_taps_scrren.dart';
import 'package:shared_preferences/shared_preferences.dart';






class SignUpPage extends StatefulWidget {
  final String accountNumber;
  // final String accountType;

  SignUpPage(this.accountNumber);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();



  bool _isLoading = false, pass = true , conditions = false;
  TextEditingController companyName = TextEditingController(),
      name = TextEditingController(),
      lastName = TextEditingController(),
      email = TextEditingController(),
      titleController = TextEditingController();

  String fontFamily = "MarkaziText";

  File ? _image;
  final ImagePicker _picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser;


  void getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      setState(() {
        _image = File(image.path);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[300],
            elevation: 0.000,
            title: Text("Create New Account",style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamily
            ),)),
        body: BlocConsumer<AppMainCubit,AppMainStates>(
          listener: (context,state){},
          builder: (context,state){
            AppMainCubit appMainCubitAccess = AppMainCubit.get(context);
            return GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Container(
                // height: screenHeight*.85,
                width: screenWidth,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        // color: Colors.amber.withOpacity(0.2),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    getImage();
                                  },
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey[100],
                                      child: ClipOval(
                                        child: SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: (_image != null)
                                                ? Image.file(
                                              _image!,
                                              fit: BoxFit.contain,
                                            ) : Icon(Icons.camera_alt,size: 35,color: Colors.grey[700],)
                                          // Image.asset("assets/login_icon.png",fit: BoxFit.contain,)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Text("add image (optional)",style: TextStyle(fontFamily: fontFamily,fontSize: 10),)
                              ],
                            ),
                            SizedBox(
                              height: screenHeight*.018,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView(
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                margin: EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  style: TextStyle(fontFamily: fontFamily),
                                  decoration: InputDecoration(
                                      contentPadding:  EdgeInsets.all(8),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2),
                                          borderRadius: BorderRadius.circular(5)),
                                      labelText: "Enter Your Name",
                                      labelStyle: TextStyle(fontSize: screenHeight*.02),
                                      counterText: ""
                                  ),
                                  controller: name,
                                  maxLength: 25,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'enter valid name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
                                child: TextFormField(
                                  style: TextStyle(fontFamily: fontFamily,color: Colors.grey),
                                  decoration: InputDecoration(
                                    contentPadding:  EdgeInsets.all(8),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(width: 2)),
                                    labelText: "Enter Your Email (optional)",
                                    labelStyle: TextStyle(fontFamily: fontFamily),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: email,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5),
                                child: TextFormField(
                                  style: TextStyle(fontFamily: fontFamily,color: Colors.grey),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    enabled: false,
                                    contentPadding:  EdgeInsets.all(8),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(width: 2)),
                                    hintText: "${widget.accountNumber}",
                                    hintStyle: TextStyle(fontFamily: fontFamily),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                      Container(
                        // color: Colors.grey[100],
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(height: 20,),
                            Container(
                              width: screenHeight*.25,
                              child: _isLoading == true ? CupertinoActivityIndicator() :
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[700],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  // primary: Colors.amber,
                                ),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,fontFamily: fontFamily,
                                      color: Colors.white
                                  ),
                                ),
                                onPressed: () async{
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  var valid = _formKey.currentState!.validate();
                                  if(valid) {
                                    await appMainCubitAccess.insertToUsers(
                                        userPhone: widget.accountNumber,
                                        userImageUrl: _image != null ? _image!.path : "",
                                        userName: name.text,
                                        userEmail: email.text.isNotEmpty ? email.text : "",
                                        userRate: 5
                                    );
                                    final prefs = await SharedPreferences.getInstance();
                                    await prefs.setBool('autoLogin', true);
                                    await appMainCubitAccess.getUserData(appMainCubitAccess.database!);
                                    // appMainCubitAccess.changeUserNameState(name.text);
                                    // if(email.text.isNotEmpty){
                                    //   appMainCubitAccess.changeUserEmailState(email.text);
                                    // }
                                    // if(_image != null){
                                    //   appMainCubitAccess.changeUserImageUrlState(_image!);
                                    // }
                                    // await Future.delayed(Duration(seconds: 2));
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => UserTapsScreen()));
                                  }else{
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("create new account in mutual benefit app.....",style: TextStyle(fontFamily: fontFamily,fontSize: 11),),
                            InkWell(
                              child: Text(
                                "in mutual benefit privacy and policy",
                                style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 11,
                                    color: Colors.blue
                                ),
                              ),
                              onTap: (){

                              },
                            ),
                            SizedBox(height: 20,),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // ),
              ),
            );
          },
        )
    );
  }
}





