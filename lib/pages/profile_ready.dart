import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';


class ProfileReady extends StatefulWidget {
  const ProfileReady({Key? key}) : super(key: key);

  @override
  _ProfileReadyState createState() => _ProfileReadyState();
}

class _ProfileReadyState extends State<ProfileReady> {


  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 1500,
          height: 1500,
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 430,
                child: Container(
                  width: 400,
                  height: 400,
                  child: Card(
                    elevation: 1.0,
                    child: Column(
                      children: [
                        SizedBox(height: 130,),
                        Text("Your All Set", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 30,),
                        Text("Welcome to Servnn!", style: TextStyle(
                          fontSize: 15,
                        ),),
                        SizedBox(height: 60,),
                        FutureBuilder(
                          future: categoryData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                print("reached here");
                                return Container(
                                  width: 150,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {


                                      // Adds initial shop data
                                      await databaseService.addShop(
                                          selectedCategory,
                                          shopName,
                                          snapshot.data['total-shop-amount']+1,
                                          timePicked.year,
                                          timePicked.month,
                                          timePicked.day
                                      );

                                      // Adds Staff Members
                                      int staffIdx = 0;
                                      while(staffIdx < staffMembers.length){
                                        await databaseService.addStaffMembers(
                                            selectedCategory,
                                            staffIdx!= 0?serviceStaffMembers[staffIdx-1]:{},
                                            snapshot.data['total-shop-amount']+1,
                                            staffIdx,
                                        );
                                        staffIdx++;
                                      }

                                      // Adds services
                                      int serviceIdx = 0;
                                      while(serviceIdx < services.length){
                                        await databaseService.addServices(
                                            selectedCategory,
                                            snapshot.data['total-shop-amount']+1,
                                            serviceIdx,
                                            services[serviceIdx].gap,
                                            services[serviceIdx].maxBookings,
                                            services[serviceIdx].maxBookings == 1?false:true,
                                        );
                                        serviceIdx++;
                                      }

                                      // Sets the current logged in shop's index
                                      setState(() {
                                        currentShopIndex = snapshot.data['total-shop-amount'] + 1;
                                      });

                                      Navigator.pushNamed(context, '/dashboard');
                                    },
                                    child: Text("Continue", style: TextStyle(
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
