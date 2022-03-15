import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mp_project/cubit/cubit.dart';
import 'package:mp_project/cubit/states.dart';
import 'package:mp_project/shared/constants.dart';

class UserTapsScreen extends StatefulWidget {

  @override
  _UserTapsScreenState createState() => _UserTapsScreenState();
}

class _UserTapsScreenState extends State<UserTapsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AppMainCubit,AppMainStates>(
        listener: (context,state){},
        builder: (context,state){
          AppMainCubit appMainCubitAccess = AppMainCubit.get(context);
          return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: appMainCubitAccess.getUserDataIsLoading ? null :
                AppBar(
                  elevation: 0,
                  // backgroundColor: Colors.blue.withOpacity(0.1),
                  centerTitle: true,
                  title: Column(
                    children: [
                      Text("${appMainCubitAccess.userName}",style: TextStyle(fontSize: 15),),
                      Text("${appMainCubitAccess.userEmail}",style: TextStyle(fontSize: 8,color: Colors.grey),),
                    ],
                  ),
                  actions: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 23,
                          backgroundColor: Colors.blue,
                          child: ClipOval(
                            child: SizedBox(
                                width: 40,
                                height: 40,
                                child: (appMainCubitAccess.userImageUrl != null  && appMainCubitAccess.userImageUrl!.path.isNotEmpty)
                                    ? Image.file(
                                  appMainCubitAccess.userImageUrl!,
                                  fit: BoxFit.contain,
                                ) : Icon(Icons.camera_alt,size: 35,color: Colors.grey[700],)
                              // Image.asset("assets/login_icon.png",fit: BoxFit.contain,)
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                      ],
                    )
                  ],
                ),
                body: appMainCubitAccess.getUserDataIsLoading ? Center(child: CircularProgressIndicator()) : appMainCubitAccess.userPages[appMainCubitAccess.pageCurrentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(LineIcons.home,size: 20,),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(LineIcons.boxes,size: 20,),
                      label: 'Shipments',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(LineIcons.suitcaseRolling,size: 20,),
                      label: 'Trips',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(LineIcons.plusCircle,size: 20,),
                      label: 'Add',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(LineIcons.search,size: 20,),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(LineIcons.handshake,size: 20,),
                      label: 'Deals',
                    ),
                  ],
                  currentIndex: appMainCubitAccess.pageCurrentIndex,
                  selectedItemColor: Colors.blue,
                  selectedLabelStyle: TextStyle(color: appColor),
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedIconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
                  unselectedItemColor: Colors.black.withOpacity(0.7),
                  onTap: (index){
                    appMainCubitAccess.changeBodyIndex(index);
                  },
                ),
                drawer: Container(
                  constraints: BoxConstraints(maxWidth: screenWidth*.85),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Row(
                        children: [
                          SizedBox(width: 5,),
                          CircleAvatar(
                            radius: 33,
                            backgroundColor: Colors.blue,
                            child: ClipOval(
                              child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: (appMainCubitAccess.userImageUrl != null  && appMainCubitAccess.userImageUrl!.path.isNotEmpty)
                                      ? Image.file(
                                    appMainCubitAccess.userImageUrl!,
                                    fit: BoxFit.contain,
                                  ) : Icon(Icons.camera_alt,size: 35,color: Colors.grey[700],)
                                // Image.asset("assets/login_icon.png",fit: BoxFit.contain,)
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${appMainCubitAccess.userName}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                              Text("${appMainCubitAccess.userEmail}",style: TextStyle(fontSize: 12,color: Colors.grey),),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(LineIcons.home,size: 30,),
                            SizedBox(width: 10,),
                            Text("Home",style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(LineIcons.boxes,size: 30,),
                            SizedBox(width: 10,),
                            Text("Shipments",style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(LineIcons.suitcaseRolling,size: 30,),
                            SizedBox(width: 10,),
                            Text("Trips",style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(LineIcons.handshake,size: 30,),
                            SizedBox(width: 10,),
                            Text("Requests",style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(LineIcons.checkCircle,size: 30,),
                            SizedBox(width: 10,),
                            Text("Delivered Orders",style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.settings,size: 30,),
                            SizedBox(width: 10,),
                            Text("Settings",style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(LineIcons.star,size: 30,),
                            SizedBox(width: 10,),
                            Text("Rates",style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
