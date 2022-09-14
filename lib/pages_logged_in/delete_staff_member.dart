import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/pages_logged_in/staff_members_page.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';


class DeleteStaffMember extends StatefulWidget {
  const DeleteStaffMember({Key? key}) : super(key: key);

  @override
  _DeleteStaffMemberState createState() => _DeleteStaffMemberState();
}

class _DeleteStaffMemberState extends State<DeleteStaffMember> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Promotion',style: TextStyle(
            color: Colors.black
        ),),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/dashboard');
          }, icon: Icon(Icons.refresh,color: Colors.black,),
          ),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout,color: Colors.black,)
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.account_circle,color: Colors.black,),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),


              Center(
                child: Container(
                  width: 600,
                  height: 550,
                  child: Card(
                    elevation: 1.0,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Service Information", style: TextStyle(
                          fontSize: 20,
                        ),),
                        SizedBox(height: 20,),

                        Text("Staff Member Name", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 5,),

                        Text(staffName),

                        Text("Staff Member Role", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 5,),
                        Text(staffRole),

                        Text("Staff Member Services", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 5,),
                        FutureBuilder(
                          future: categoryData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                return Center(
                                  child: Container(
                                    width: 600,
                                    height: 200,
                                    child: ListView.builder(
                                        itemCount: staffServiceAmount,
                                        itemBuilder: (context,index){
                                          return Center(
                                            child: Container(
                                                margin: EdgeInsets.all(10),
                                                child: Text(snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-services']['$index'])
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              }
                            }
                            return const Text("Please wait");
                          },
                        ),

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

                                      int staffIndex = 0;
                                      int databaseIndex = 0;
                                      while(staffIndex < snapshot.data['$currentShopIndex']['staff-members-amount']){

                                        if(selectedStaffIdx != staffIndex){
                                          String staffName = snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-name'];
                                          String staffRole = snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-role'];
                                          int staffServicesAmount = snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-services-amount'];
                                          dynamic staffTimingData = snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-availability'];
                                          dynamic staffServices = snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-services'];

                                          await databaseService.editStaffMemberWhenDeleting(
                                              selectedCategory,
                                              currentShopIndex,
                                              databaseIndex,
                                              staffName,
                                              staffRole,
                                              staffServicesAmount,
                                              staffTimingData,
                                              staffServices
                                          );

                                          databaseIndex++;

                                        }
                                        staffIndex++;
                                      }

                                      await databaseService.deleteStaffMember(
                                        selectedCategory,
                                        currentShopIndex,
                                        staffIndex-1,
                                      );


                                      Navigator.pushNamed(context, '/staff-members-page');
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
