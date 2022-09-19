import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';

class ConfirmPurchase extends StatefulWidget {
  const ConfirmPurchase({Key? key}) : super(key: key);

  @override
  _ConfirmPurchaseState createState() => _ConfirmPurchaseState();
}

class _ConfirmPurchaseState extends State<ConfirmPurchase> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  Future<Map<String, dynamic>?> userData() async {
    return (await FirebaseFirestore.instance.collection('users').
    doc('signed-up').get()).data();
  }

  DatabaseService databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Confirm Transaction",style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(50),
            width: 500,
            height: 500,
            child: Card(
              elevation: 4.0,
              child: FutureBuilder(
                future: Future.wait([categoryData(),userData()]),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){

                    }
                    else if(snapshot.hasData){

                      String startTime = '';
                      String endTime = '';

                      int startHour = snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['start-hour'];
                      int endHour = snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['end-hour'];

                      int startHourActual = snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['start-hour-actual'];
                      int endHourActual = snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['end-hour-actual'];

                      int startMinutes = snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['start-minutes'];
                      int endMinutes = snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['end-minutes'];






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
                          Text("${snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['client-name']}",style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),

                          Text("Service Provider",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 5,),
                          Text("${snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['member-name']}", style: TextStyle(
                            fontSize: 18,
                          ),),
                          SizedBox(height: 10,),
                          Text("Service",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 5,),
                          Text("${snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['service-name']}", style: TextStyle(
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

                          Text("${snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['service-price']} EGP",style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 20,),
                          Container(
                            width: 250,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () async {

                                await databaseService.appointmentComplete(
                                  selectedCategory,
                                  currentShopIndex,
                                  currentTransactionIndex,
                                  snapshot.data[0]['$currentShopIndex']['appointments']['complete'] + 1,
                                  snapshot.data[0]['$currentShopIndex']['appointments']['incomplete'] - 1,
                                );


                                int currentMonthIndex = 0;
                                String currentMonth = '';
                                while(currentMonthIndex < months.length){
                                  if(snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['start-month'] == currentMonthIndex+1){
                                    setState(() {
                                      currentMonth = months[currentMonthIndex];
                                    });
                                    break;
                                  }
                                  currentMonthIndex++;
                                }



                                print("Current month: $currentMonth");

                                print("REACHED HERE BEFORE APPOINTMENT REVENUE");

                                num appRev = int.parse(snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['service-price']) + snapshot.data[0]['$currentShopIndex']['appointment-stats'][currentMonth]['appointment-revenue'];

                                print("REACHED HERE AFTER APPOINTMENT REVENUE");

                                int clientIndex = 0;

                                while(clientIndex <= snapshot.data[0]['$currentShopIndex']['client-amount']){

                                  if(snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['client-name']
                                      == snapshot.data[0]['$currentShopIndex']['clients']['$clientIndex']['name']){
                                    //updateClientData

                                    await databaseService.updateClientData(
                                      snapshot.data[0]['$currentShopIndex']['clients']['$clientIndex']['appointments'] == 0?'new':'returning',
                                      selectedCategory,
                                      clientIndex,
                                      currentShopIndex,
                                      snapshot.data[0]['$currentShopIndex']['clients']['$clientIndex']['amount-paid']
                                          +int.parse(snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['service-price']),
                                      snapshot.data[0]['$currentShopIndex']['clients']['$clientIndex']['appointments']+1,
                                      snapshot.data[0]['$currentShopIndex']['client-amount'],
                                    );

                                  }

                                  clientIndex++;
                                }



                                await databaseService.updateAppointmentRevenue(
                                  selectedCategory,
                                  currentShopIndex,
                                  currentMonth,
                                  appRev,
                                );

                                // Send notification to user in order to leave a review

                                int userIndex = 0;

                                while(userIndex <= snapshot.data[1]['total-user-amount']){

                                  // If the user email listed in the current appoinmtent is equal to the current user looping through,
                                  // then send a notification to the user with userIndex
                                  if(snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['client-email']
                                  == snapshot.data[1]['$userIndex']['email']) {


                                    await databaseService.updateUserAppointmentStatus(
                                        userIndex,
                                        snapshot.data[0]['$currentShopIndex']['appointments']['$currentTransactionIndex']['user-appointment-index'],
                                    );

                                    await databaseService.sendAppointmentCompleteNotificationToUser(
                                        userIndex,
                                        shopName,
                                        snapshot.data[1]['$userIndex']['notification-amount']+1,
                                    );
                                  }

                                  userIndex++;
                                }





                                print("FINISHED UPDATING REVENUE STATS");
                                Navigator.pushNamed(context, '/POS');

                              },
                              child: Text("Complete Transaction", style: TextStyle(
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

  /*
  Widget buildClientList(AsyncSnapshot<dynamic> snapshot){

  }
  */


}
