import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mp_project/cubit/cubit.dart';
import 'package:mp_project/cubit/states.dart';
import 'package:mp_project/models/order_model.dart';

class AddOrderPage extends StatelessWidget {



  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocConsumer<AppMainCubit,AppMainStates>(
        listener: (context,state){},
        builder: (context,state){
          AppMainCubit appMainCubitAccess = AppMainCubit.get(context);
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ADD ORDER",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 20,),
                Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("shipment",style: TextStyle(fontSize: 18)),
                      SizedBox(width: 10,),
                      Container(
                        width: 10,
                        height: 20,
                        child: Radio(
                            value: "shipment",
                            groupValue: appMainCubitAccess.orderTypeGroupValue,
                            onChanged: (newValue){
                              appMainCubitAccess.clearData();
                              appMainCubitAccess.changeOrderTypeGroupValueState(newValue.toString());
                            }
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("trip",style: TextStyle(fontSize: 18)),
                      SizedBox(width: 10,),
                      Container(
                        width: 10,
                        height: 20,
                        child: Radio(
                            value: "trip",
                            groupValue: appMainCubitAccess.orderTypeGroupValue,
                            onChanged: (newValue){
                              appMainCubitAccess.clearData();
                              appMainCubitAccess.changeOrderTypeGroupValueState(newValue.toString());
                            }
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                if(appMainCubitAccess.orderTypeGroupValue != "")
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 2)
                    ),
                    padding: EdgeInsets.all(8),
                    // width: screenWidth,
                    child: Column(
                      children: [
                        Expanded(
                          child: Form(
                            key: _formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter ${appMainCubitAccess.orderTypeGroupValue} details",style: TextStyle(fontSize: 16),),
                                  SizedBox(height: 20,),
                                  if(appMainCubitAccess.orderTypeGroupValue == "shipment")
                                  Container(
                                    height: 35,
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        contentPadding:  EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius: BorderRadius.circular(5)),
                                        labelText: "Enter Product Name",
                                        labelStyle: TextStyle(fontSize: 12),
                                      ),
                                      controller: appMainCubitAccess.productNameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'value must be added';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DropdownButton<String>(
                                        hint: Text("From Gov"),
                                        value: appMainCubitAccess.fromGov == "" ? null : appMainCubitAccess.fromGov,
                                        items: <String>['Egypt','England'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          appMainCubitAccess.changeFromGovState(value.toString());
                                        },
                                      ),
                                      DropdownButton<String>(
                                        hint: Text("From City"),
                                        value: appMainCubitAccess.fromCity == "" ? null : appMainCubitAccess.fromCity,
                                        items: <String>["Cairo","London"].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          appMainCubitAccess.changeFromCityState(value.toString());
                                        },
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 35,
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                        contentPadding:  EdgeInsets.all(8),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 2),
                                            borderRadius: BorderRadius.circular(5)),
                                        labelText: "Enter From Address",
                                        labelStyle: TextStyle(fontSize: 12),
                                      ),
                                      controller: appMainCubitAccess.fromAddressTitleController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'value must be added';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      DropdownButton<String>(
                                        hint: Text("to Gov"),
                                        value: appMainCubitAccess.toGov == "" ? null : appMainCubitAccess.toGov,
                                        items: <String>['Egypt','England'].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          appMainCubitAccess.changeToGovState(value.toString());
                                        },
                                      ),
                                      DropdownButton<String>(
                                        hint: Text("to City"),
                                        value: appMainCubitAccess.toCity == "" ? null : appMainCubitAccess.toCity,
                                        items: <String>["Cairo","London"].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          appMainCubitAccess.changeToCityState(value.toString());
                                        },
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: 35,
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          contentPadding:  EdgeInsets.all(8),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2),
                                              borderRadius: BorderRadius.circular(5)),
                                          labelText: "Enter To Address",
                                          labelStyle: TextStyle(fontSize: 12),
                                          counterText: ""
                                      ),
                                      controller: appMainCubitAccess.toAddressTitleController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'value must be added';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  appMainCubitAccess.orderTypeGroupValue == "shipment" ?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 120,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                              contentPadding:  EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 2),
                                                  borderRadius: BorderRadius.circular(5)),
                                              labelText: "Product Price",
                                              labelStyle: TextStyle(fontSize: 12),
                                              counterText: ""
                                          ),
                                          controller: appMainCubitAccess.productPriceController,
                                          validator: (value) {
                                            if (double.tryParse(value!) == null) {
                                              return "Please Enter A Valid Number";
                                            }
                                            if (value.isEmpty) {
                                              return 'value must be added';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 120,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                              contentPadding:  EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 2),
                                                  borderRadius: BorderRadius.circular(5)),
                                              labelText: "Product Weight",
                                              labelStyle: TextStyle(fontSize: 12),
                                              counterText: ""
                                          ),
                                          controller: appMainCubitAccess.productWeightController,
                                          validator: (value) {
                                            if (double.tryParse(value!) == null) {
                                              return "Please Enter A Valid Number";
                                            }
                                            if (value.isEmpty) {
                                              return 'value must be added';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        height: 35,
                                        width: 120,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                              contentPadding:  EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 2),
                                                  borderRadius: BorderRadius.circular(5)),
                                              labelText: "Arrival Date",
                                              labelStyle: TextStyle(fontSize: 12),
                                          ),
                                          controller: appMainCubitAccess.arrivalTimeController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'value must be added';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 35,
                                        width: 120,
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          decoration: InputDecoration(
                                              contentPadding:  EdgeInsets.all(8),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 2),
                                                  borderRadius: BorderRadius.circular(5)),
                                              labelText: "Available Weight",
                                              labelStyle: TextStyle(fontSize: 12),
                                          ),
                                          controller: appMainCubitAccess.availableWeightController,
                                          validator: (value) {
                                            if (double.tryParse(value!) == null) {
                                              return "Please Enter A Valid Number";
                                            }
                                            if (value.isEmpty) {
                                              return 'value must be added';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  if(appMainCubitAccess.orderTypeGroupValue == "shipment")
                                  Container(
                                    height: 35,
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          contentPadding:  EdgeInsets.all(8),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(width: 2),
                                              borderRadius: BorderRadius.circular(5)),
                                          labelText: "Enter Your Reward",
                                          labelStyle: TextStyle(fontSize: 12),
                                          counterText: ""
                                      ),
                                      controller: appMainCubitAccess.rewardController,
                                      validator: (value) {
                                        if (double.tryParse(value!) == null) {
                                          return "Please Enter A Valid Number";
                                        }
                                        if (value.isEmpty) {
                                          return 'value must be added';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(appMainCubitAccess.orderTypeGroupValue == "shipment" ? "Add Product Image" : "Add Ticket Photo"),
                                      GestureDetector(
                                        onTap: () async{
                                          final image = await _picker.pickImage(source: ImageSource.gallery);
                                          if(image != null){
                                            appMainCubitAccess.changeProductImageUrlState(File(image.path));
                                          }
                                        },
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey[100],
                                          child: ClipOval(
                                            child:  SizedBox(
                                                width: 50,
                                                height: 50,
                                                child: (appMainCubitAccess.orderImageUrl != null)
                                                    ? Image.file(
                                                  appMainCubitAccess.orderImageUrl!,
                                                  fit: BoxFit.contain,
                                                ) : Icon(appMainCubitAccess.orderTypeGroupValue == "shipment" ? Icons.photo : Icons.airplane_ticket,size: 35,color: Colors.grey[700],)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 120,
                              child: ElevatedButton(
                                  onPressed: (){
                                    var valid = _formKey.currentState!.validate();
                                    if(valid && appMainCubitAccess.fromGov != "" && appMainCubitAccess.toGov != "" && appMainCubitAccess.fromCity != "" && appMainCubitAccess.toCity != "" && appMainCubitAccess.orderImageUrl != null) {
                                       appMainCubitAccess.insertToOrders(
                                          ownerId: appMainCubitAccess.userId,
                                          orderType: appMainCubitAccess.orderTypeGroupValue,
                                          date: DateTime.now().toString(),
                                          productName: appMainCubitAccess.productNameController.text,
                                          fromGov: appMainCubitAccess.fromGov,
                                          fromCity: appMainCubitAccess.fromCity,
                                          fromAddress: appMainCubitAccess.fromAddressTitleController.text,
                                          toGov: appMainCubitAccess.toGov,
                                          toCity: appMainCubitAccess.toCity,
                                          toAddress: appMainCubitAccess.toAddressTitleController.text,
                                          productPrice: appMainCubitAccess.productPriceController.text.isEmpty ? 0 : appMainCubitAccess.productPriceController.text,
                                          productWeight: appMainCubitAccess.productWeightController.text.isEmpty ? 0 : appMainCubitAccess.productWeightController.text,
                                          rewardAmount: appMainCubitAccess.rewardController.text.isEmpty ? 0 : appMainCubitAccess.rewardController.text,
                                          arrivalDate: appMainCubitAccess.arrivalTimeController.text.isEmpty ? "" : appMainCubitAccess.arrivalTimeController.text,
                                          availableWeight: appMainCubitAccess.availableWeightController.text.isEmpty ? 0 : appMainCubitAccess.availableWeightController.text,
                                          orderImage: appMainCubitAccess.orderImageUrl!.path
                                      ).then((value) {
                                         appMainCubitAccess.getOrdersData(appMainCubitAccess.database!);
                                       });

                                      // appMainCubitAccess.addToOrdersList(
                                      //   OrderModel(
                                      //       ownerId: appMainCubitAccess.userId,
                                      //       orderType: appMainCubitAccess.orderTypeGroupValue,
                                      //       date: DateTime.now().toString(),
                                      //       productName: appMainCubitAccess.productNameController.text,
                                      //       fromGov: appMainCubitAccess.fromGov,
                                      //       fromCity: appMainCubitAccess.fromCity,
                                      //       fromAddress: appMainCubitAccess.fromAddressTitleController.text,
                                      //       toGov: appMainCubitAccess.toGov,
                                      //       toCity: appMainCubitAccess.toCity,
                                      //       toAddress: appMainCubitAccess.toAddressTitleController.text,
                                      //       productPrice: appMainCubitAccess.productPriceController.text,
                                      //       productWeight: appMainCubitAccess.productWeightController.text,
                                      //       rewardAmount: appMainCubitAccess.rewardController.text,
                                      //       arrivalDate: appMainCubitAccess.arrivalTimeController.text,
                                      //       availableWeight: appMainCubitAccess.availableWeightController.text,
                                      //       orderImage: appMainCubitAccess.orderImageUrl
                                      //   )
                                      // );
                                      appMainCubitAccess.clearData();
                                      appMainCubitAccess.changeBodyIndex(0);
                                    }else{
                                      Flushbar(
                                        messageText: Text("Please Enter All Fields",style: TextStyle(color: Colors.white),),
                                        flushbarPosition: FlushbarPosition.TOP,
                                        duration: Duration(seconds: 1),
                                      )..show(context);
                                    }
                                  },
                                  child: Text("Post")
                              ),
                            ),
                            Container(
                              width: 120,
                              child: ElevatedButton(
                                  onPressed: (){
                                    appMainCubitAccess.clearData();
                                  },
                                  child: Text("Clear Fields")
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
