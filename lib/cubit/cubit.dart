import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mp_project/cubit/states.dart';
import 'package:mp_project/models/order_model.dart';
import 'package:mp_project/screen/add_order/add_order_page.dart';
import 'package:mp_project/screen/deals/deals_page.dart';
import 'package:mp_project/screen/search/search_page.dart';
import 'package:mp_project/screen/shipments/shipments.dart';
import 'package:mp_project/screen/trips/trips.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../screen/home/home.dart';

class AppMainCubit extends Cubit<AppMainStates>
{

  AppMainCubit() : super(AppMainInitialState());

  static AppMainCubit get(context) => BlocProvider.of(context);

  String userId = "1";
  // final String userOTP = "123456";
  File ? userImageUrl;
  String userName = "";
  String userEmail = "";
  int userRate = 5;
  int pageCurrentIndex = 0;
  List<Widget> userPages = [
    Home(),
    Shipments(),
    Trips(),
    AddOrderPage(),
    SearchPage(),
    DealsPage(),
  ];

  TextEditingController productNameController = TextEditingController();
  TextEditingController fromAddressTitleController = TextEditingController();
  TextEditingController toAddressTitleController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController rewardController = TextEditingController();
  TextEditingController productWeightController = TextEditingController();
  TextEditingController arrivalTimeController = TextEditingController();
  TextEditingController availableWeightController = TextEditingController();
  String orderTypeGroupValue = "";
  File ? orderImageUrl;
  String fromGov = "";
  String fromCity = "";
  String toGov = "";
  String toCity = "";


  List<OrderModel> ordersList = [];
  Database ? database;
  bool getUserDataIsLoading = false;


  Future<void> createDatabase() async
  {
    changeGetUserDataIsLoadingState(true);
    database = await openDatabase(
      "MB",
      version: 1,
      onCreate: (Database db, int version) async
      {
        await db.execute('CREATE TABLE Orders ('
            'id INTEGER PRIMARY KEY,'
            ' ownerId TEXT,'
            ' orderType TEXT,'
            ' date TEXT,'
            ' productName TEXT,'
            ' fromGov TEXT,'
            ' fromCity TEXT,'
            ' fromAddress TEXT,'
            ' toGov TEXT,'
            ' toCity TEXT,'
            ' toAddress TEXT,'
            ' productPrice REAL,'
            ' productWeight REAL,'
            ' rewardAmount REAL,'
            ' arrivalDate TEXT,'
            ' availableWeight REAL,'
            ' orderImage TEXT'
            ')'
        ).catchError((error){
          print(error.toString());
        });
        await db.execute(
            'CREATE TABLE Users (id INTEGER PRIMARY KEY, userPhone TEXT, userImageUrl TEXT, userName TEXT, userEmail TEXT, userRate INTEGER)'
        ).catchError((error){
          print(error.toString());
        });
      },
      onOpen: (Database db) async{
        await getUserData(db);
        await getOrdersData(db).catchError((error){});
      }
    ).catchError((error){
      print(error.toString());
    });
    changeGetUserDataIsLoadingState(false);
  }

  Future<void> getUserData(Database db) async
  {
    final prefs = await SharedPreferences.getInstance();
    dynamic autoLogin = prefs.getBool('autoLogin');
    if(autoLogin == true){
      List<Map> list = await db.rawQuery('SELECT * FROM Users');
      // List<Map> list = await db.rawQuery('SELECT * FROM Users WHERE id = ?', [2]);
      list.forEach((element) {
        if(element["id"] == 1){
          userId = element["id"].toString();
          userImageUrl = File(element["userImageUrl"]);
          userName = element["userName"];
          userEmail = element["userEmail"];
          userRate = element["userRate"];
        }
      });
    }
    emit(GetUserDataState());
  }

  Future<void> getOrdersData(Database db) async
  {
    final prefs = await SharedPreferences.getInstance();
    dynamic autoLogin = prefs.getBool('autoLogin');
    if(autoLogin == true){
      List<Map> list = await db.rawQuery('SELECT * FROM Orders');
      // List<Map> list = await db.rawQuery('SELECT * FROM Orders WHERE ownerId = ?', ["$userId"]);
      list.forEach((element) {
        addToOrdersList(
            OrderModel(
                ownerId: element["ownerId"],
                orderType: element["orderType"],
                date: element["date"],
                productName: element["productName"],
                fromGov: element["fromGov"],
                fromCity: element["fromCity"],
                fromAddress: element["fromAddress"],
                toGov: element["toGov"],
                toCity: element["toCity"],
                toAddress: element["toAddress"],
                productPrice: element["productPrice"],
                productWeight: element["productWeight"],
                rewardAmount: element["rewardAmount"],
                arrivalDate: element["arrivalDate"],
                availableWeight: element["availableWeight"],
                orderImage: File(element["orderImage"])
            )
          );
      });
    }
    emit(GetOrdersrDataState());
  }

  Future<void> insertToUsers({
    required String userPhone,
    required String userImageUrl,
    required String userName,
    required String userEmail,
    required int userRate,
  }) async
  {
    await database!.transaction((txn) async {
      await txn.rawInsert(
          // 'INSERT INTO Users(userPhone, userImageUrl, userName, userEmail, userRate) VALUES($userPhone, $userImageUrl, $userName, $userEmail,5)'
          'INSERT INTO Users(userPhone, userImageUrl, userName, userEmail, userRate) VALUES("$userPhone", "$userImageUrl", "$userName", "$userEmail", $userRate)'
      );
    }).then((value) {print("user add successfully");}).catchError((error){print(error.toString());});
  }

  Future<void> insertToOrders({
    required String ownerId,
    required String orderType,
    required String date,
    required String productName,
    required String fromGov,
    required String fromCity,
    required String fromAddress,
    required String toGov,
    required String toCity,
    required String toAddress,
    required dynamic productPrice,
    required dynamic productWeight,
    required dynamic rewardAmount,
    required String arrivalDate,
    required dynamic availableWeight,
    required String orderImage,
  }) async
  {
    await database!.transaction((txn) async {
       await txn.rawInsert('INSERT INTO Orders('
           ' ownerId,'
           ' orderType,'
           ' date,'
           ' productName,'
           ' fromGov,'
           ' fromCity,'
           ' fromAddress,'
           ' toGov,'
           ' toCity,'
           ' toAddress,'
           ' productPrice,'
           ' productWeight,'
           ' rewardAmount,'
           ' arrivalDate,'
           ' availableWeight,'
           ' orderImage'
           ') '
           'VALUES('
           ' "$ownerId",'
           ' "$orderType",'
           ' "$date",'
           ' "$productName",'
           ' "$fromGov",'
           ' "$fromCity",'
           ' "$fromAddress",'
           ' "$toGov",'
           ' "$toCity",'
           ' "$toAddress",'
           ' $productPrice,'
           ' $productWeight,'
           ' $rewardAmount,'
           ' "$arrivalDate",'
           ' $availableWeight,'
           ' "$orderImage"'
           ')'
       );
    }).then((value) {print("order add successfully");}).catchError((error){
      print("error on adding order");
      print(error.toString());
    });
  }

  void addToOrdersList(OrderModel newOrder)
  {
    ordersList.add(newOrder);
    emit(AddToOrdersListState());
  }

  void clearData()
  {
    productNameController.clear();
    fromAddressTitleController.clear();
    toAddressTitleController.clear();
    productPriceController.clear();
    rewardController.clear();
    productWeightController.clear();
    arrivalTimeController.clear();
    availableWeightController.clear();
    orderTypeGroupValue = "";
    orderImageUrl = null;
    fromGov = "";
    fromCity = "";
    toGov = "";
    toCity = "";
    emit(ClearDataSuccessState());
  }


  void changeGetUserDataIsLoadingState(bool value)
  {
    getUserDataIsLoading = value;
    emit(ChangeGetUserDataIsLoadingState());
  }

  void changeFromGovState(String value)
  {
    fromGov = value;
    emit(ChangeFromGovState());
  }

  void changeFromCityState(String value)
  {
    fromCity = value;
    emit(ChangeFromCityState());
  }

  void changeToGovState(String value)
  {
    toGov = value;
    emit(ChangeToGovState());
  }

  void changeToCityState(String value)
  {
    toCity = value;
    emit(ChangeToCityState());
  }

  void changeProductImageUrlState(File newValue){
    orderImageUrl = newValue;
    emit(ChangeProductImageUrlState());
  }

  void changeOrderTypeGroupValueState(String value)
  {
    orderTypeGroupValue = value;
    emit(ChangeOrderTypeGroupValueState());
  }

  void changeBodyIndex(int index){
    pageCurrentIndex = index;
    emit(ChangeBodyIndexState());
  }

  void changeUserImageUrlState(File newValue){
    userImageUrl = newValue;
    emit(ChangeUserImageUrlState());
  }

  void changeUserNameState(String newValue){
    userName = newValue;
    emit(ChangeUserNameState());
  }

  void changeUserEmailState(String newValue){
    userEmail = newValue;
    emit(ChangeUserEmailState());
  }

}