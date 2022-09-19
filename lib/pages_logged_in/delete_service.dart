import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/pages_logged_in/services_page.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';


class DeleteService extends StatefulWidget {
  const DeleteService({Key? key}) : super(key: key);

  @override
  _DeleteServiceState createState() => _DeleteServiceState();
}

class _DeleteServiceState extends State<DeleteService> {


  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }



  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Service', style: TextStyle(
            color: Colors.black
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          }, icon: Icon(Icons.refresh, color: Colors.black,),
          ),
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout, color: Colors.black,)
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle, color: Colors.black,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: [

              SizedBox(height: 10,),

              Center(
                child: Container(
                  width: 600,
                  height: 500,
                  child: Card(
                    elevation: 1.0,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Service Information", style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(height: 20,),

                        Text("Service Name", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 5,),

                        Text(serviceNameToBeEdited),

                        Text("Service Duration", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 5,),
                        Text(serviceDurationToBeEdited),

                        Text("Service Price", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 5,),
                        Text('$servicePriceToBeEdited EGP'),


                        SizedBox(height: 40,),
                        FutureBuilder(
                          future: categoryData(),
                          builder: (BuildContext context, AsyncSnapshot<
                              dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Text("There is an error");
                              }
                              else if (snapshot.hasData) {
                                return Container(
                                  width: 200,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {


                                      int memberIndex = 0;

                                      int databaseStaffServiceIndex = 0;
                                      while(memberIndex < snapshot.data['$currentShopIndex']['staff-members-amount']){

                                        int serviceIndex = 0;
                                        while(serviceIndex < snapshot.data['$currentShopIndex']['staff-members']['$memberIndex']['member-services-amount']){


                                          String currentService = snapshot.data['$currentShopIndex']['staff-members']['$memberIndex']['member-services']['$serviceIndex'];
                                          String selectedService = snapshot.data['$currentShopIndex']['services']['$selectedIdx']['service-name'];

                                          if(currentService != selectedService){


                                            await databaseService.editStaffMemberServiceInfo(
                                                selectedCategory,
                                                currentShopIndex,
                                                memberIndex,
                                                currentService,
                                                databaseStaffServiceIndex
                                            );

                                            databaseStaffServiceIndex++;

                                          }
                                          serviceIndex++;
                                        }

                                        if(snapshot.data['$currentShopIndex']['staff-members']['$memberIndex']['member-services-amount'] > 0){
                                          await databaseService.deleteStaffMemberServiceInfo(
                                              selectedCategory,
                                              currentShopIndex,
                                              memberIndex,
                                              serviceIndex-1
                                          );
                                        }




                                        memberIndex++;
                                      }




                                      int serviceIndex = 0;
                                      int databaseIndex = 0;
                                      while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){

                                        if(selectedIdx != serviceIndex){
                                          String serviceName = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name'];
                                          String serviceHours = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-hours'];
                                          String serviceMinutes = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-minutes'];
                                          String servicePrice = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-price'];
                                          int serviceMaxAmountOfBookings = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['max-amount-per-timing'];
                                          int serviceMinuteGap = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['minute-gap'];
                                          int serviceFlashAmount = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['flash-promotions-amount'];
                                          int serviceHappyHourAmount = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['happy-hour-promotions-amount'];
                                          int serviceLastMinuteAmount = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['last-minute-promotions-amount'];
                                          dynamic serviceFlashPromotions = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['flash-promotions'];
                                          dynamic serviceHappyHourPromotions = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['happy-hour-promotions'];
                                          dynamic serviceLastMinutePromotions = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['last-minute-promotions'];
                                          bool serviceLinked = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-linked'];

                                          await databaseService.editServiceWhenDeleting(
                                              selectedCategory,
                                              currentShopIndex,
                                              databaseIndex,
                                              serviceName,
                                              serviceHours,
                                              serviceMinutes,
                                              servicePrice,
                                              serviceMaxAmountOfBookings,
                                              serviceMinuteGap,
                                              serviceLinked,
                                              serviceFlashAmount,
                                              serviceLastMinuteAmount,
                                              serviceHappyHourAmount,
                                              serviceFlashPromotions,
                                              serviceLastMinutePromotions,
                                              serviceHappyHourPromotions,
                                          );

                                          databaseIndex++;

                                        }


                                        serviceIndex++;
                                      }

                                      await databaseService.deleteService(
                                          selectedCategory,
                                          currentShopIndex,
                                          serviceIndex-1,
                                      );

                                      Navigator.pushNamed(context, '/services-page');
                                    },
                                    child: Text(
                                      "Delete Service", style: const TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                );
                              }
                            }
                            return const Text("Please wait");
                          },

                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
