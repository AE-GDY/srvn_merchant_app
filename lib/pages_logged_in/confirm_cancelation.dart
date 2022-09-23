import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';

class ConfirmCancellation extends StatefulWidget {
  const ConfirmCancellation({Key? key}) : super(key: key);

  @override
  _ConfirmCancellationState createState() => _ConfirmCancellationState();
}

class _ConfirmCancellationState extends State<ConfirmCancellation> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm Transaction"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: Container(
            width: 500,
            height: 500,
            child: Card(
              elevation: 4.0,
              child: FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){

                    }
                    else if(snapshot.hasData){

                      String startTime = '';
                      String endTime = '';

                      int startHour = snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['start-hour'];
                      int endHour = snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['end-hour'];

                      int startHourActual = snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['start-hour-actual'];
                      int endHourActual = snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['end-hour-actual'];

                      int startMinutes = snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['start-minutes'];
                      int endMinutes = snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['end-minutes'];






                      if(startHourActual < 12){
                        if(startMinutes == 0){
                          startTime = '$startHour:00 AM';
                        }
                        else{
                          startTime = '$startHour:$startMinutes AM';
                        }
                      }
                      else if(startHourActual == 12){
                        if(startHourActual < endHourActual){
                          if(startMinutes == 0){
                            startTime = '$startHour:00 PM';
                          }
                          else{
                            startTime = '$startHour:$startMinutes PM';
                          }
                        }
                        else{
                          if(startMinutes == 0){
                            startTime = '$startHour:00 PM';

                          }
                          else{
                            startTime = '$startHour:$startMinutes PM';
                          }
                        }
                      }
                      else{
                        if(startMinutes == 0){
                          startTime = '$startHour:00 PM';
                        }
                        else{
                          startTime = '$startHour:$startMinutes PM';
                        }
                      }

                      if(endHourActual < 12){

                        if(endMinutes == 0){
                          endTime = '$endHour:00 AM';

                        }
                        else{
                          endTime = '$endHour:$endMinutes AM';

                        }
                      }
                      else if(endHourActual == 12){
                        if(endHourActual < startHourActual){
                          if(endMinutes == 0){
                            endTime = '$endHour:00 PM';

                          }
                          else{
                            endTime = '$endHour:$endMinutes PM';

                          }
                        }
                        else{
                          if(endMinutes == 0){
                            endTime = '$endHour:00 PM';
                          }
                          else{
                            endTime = '$endHour:$endMinutes PM';
                          }
                        }
                      }
                      else{
                        if(endMinutes == 0){
                          endTime = '$endHour:00 PM';
                        }
                        else{
                          endTime = '$endHour:$endMinutes PM';
                        }
                      }


                      return Column(
                        children: [
                          SizedBox(height: 20,),

                          Text("Client Name",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 5,),
                          Text("${snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['client-name']}",style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),

                          Text("Service Provider",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 5,),
                          Text("${snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['member-name']}", style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),
                          Text("Service",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 5,),
                          Text("${snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['service-name']}", style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),

                          Text("Start time",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 5,),
                          Text(startTime, style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),

                          Text("End time",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 5,),
                          Text(endTime, style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),

                          Text("${snapshot.data['$currentShopIndex']['appointments']['$currentTransactionIndex']['service-price']} EGP",style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 20,),
                          Container(
                            width: 250,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                await databaseService.appointmentCancelled(
                                  selectedCategory,
                                  currentShopIndex,
                                  currentTransactionIndex,
                                  snapshot.data['$currentShopIndex']['appointments']['complete'],
                                  snapshot.data['$currentShopIndex']['appointments']['incomplete'] - 1,
                                  snapshot.data['$currentShopIndex']['appointments']['cancelled'] + 1,
                                );

                                Navigator.pushNamed(context, '/POS');

                              },
                              child: Text("Complete Cancelation", style: TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                  return const Text("Please wait");
                },

              ),
            ),
          ),
        ),
      ),
    );
  }
}