import 'dart:io';

class OrderModel
{
  String ? ownerId;
  String ? orderType;
  String ? date;
  String ? productName;
  String ? fromGov;
  String ? fromCity;
  String ? fromAddress;
  String ? toGov;
  String ? toCity;
  String ? toAddress;
  dynamic  productPrice;
  dynamic  productWeight;
  dynamic  rewardAmount;
  String ? arrivalDate;
  dynamic availableWeight;
  File ? orderImage;

  OrderModel({
    required this.ownerId,
    required this.orderType,
    required this.date,
    required this.productName,
    required this.fromGov,
    required this.fromCity,
    required this.fromAddress,
    required this.toGov,
    required this.toCity,
    required this.toAddress,
    required this.productPrice,
    required this.productWeight,
    required this.rewardAmount,
    required this.arrivalDate,
    required this.availableWeight,
    required this.orderImage,
  });

  OrderModel.fromJson(Map<String,dynamic> json){
    ownerId = json["ownerId"];
    orderType = json["orderType"];
    date = json["date"];
    productName = json["productName"] == null ? "" : json["productName"];
    fromGov = json["fromGov"];
    fromCity = json["fromCity"];
    fromAddress = json["fromAddress"];
    toGov = json["toGov"];
    toCity = json["toCity"];
    toAddress = json["toAddress"];
    productPrice = json["productPrice"] == null ? "" : json["productPrice"];
    productWeight = json["productWeight"] == null ? "" : json["productWeight"];
    rewardAmount = json["rewardAmount"] == null ? "" : json["rewardAmount"];
    arrivalDate = json["arrivalDate"] == null ? "" : json["arrivalDate"];
    availableWeight = json["availableWeight"] == null ? "" : json["availableWeight"];
    orderImage = json["orderImage"];
  }

}