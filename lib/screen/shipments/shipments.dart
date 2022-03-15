import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../models/order_model.dart';

class Shipments extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppMainCubit,AppMainStates>(
          listener: (context,state){},
          builder: (context,state){
            AppMainCubit appMainCubitAccess = AppMainCubit.get(context);
            List<OrderModel> shipmentsList = appMainCubitAccess.ordersList.where((element) => element.orderType == "shipment").toList();
            return shipmentsList.length == 0 ? Center(
              child: Image.asset("assets/images/empty_orders.png"),
            ) :
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 25),
              child: ListView.builder(
                itemCount: shipmentsList.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(7)
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 35,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(6),topRight: Radius.circular(6))
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${shipmentsList[index].orderType}"),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 5,),
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.blue,
                                    child: ClipOval(
                                      child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: (appMainCubitAccess.userImageUrl != null)
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
                                      Text("${appMainCubitAccess.userName}",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                      Row(
                                        children: [
                                          Text("${appMainCubitAccess.userRate}",style: TextStyle(fontSize: 12,color: Colors.grey),),
                                          Icon(Icons.star,color: Colors.blue,size: 15,)
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.file(shipmentsList[index].orderImage!,fit: BoxFit.fill,),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("From Address"),
                              Text("${shipmentsList[index].fromAddress!}",style: TextStyle(color: Colors.grey),),
                              SizedBox(height: 10,),
                              Text("To Address"),
                              Text("${shipmentsList[index].toAddress!}",style: TextStyle(color: Colors.grey),),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  shipmentsList[index].orderType == "shipment" ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Reward Amount"),
                                      Text("${shipmentsList[index].rewardAmount!}",style: TextStyle(color: Colors.grey),),
                                    ],
                                  ) :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Number Of Free KG"),
                                      Text("${shipmentsList[index].availableWeight!}",style: TextStyle(color: Colors.grey),),
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: (){

                                      },
                                      child: Text("Send Request")
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
