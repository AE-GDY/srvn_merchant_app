//import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/database.dart';

class StaffMembersPage extends StatefulWidget {
  const StaffMembersPage({Key? key}) : super(key: key);

  @override
  _StaffMembersPageState createState() => _StaffMembersPageState();
}

int selectedStaffIdx = 1;
String staffName = "";
String staffRole = "";
int staffServiceAmount = 0;
dynamic staffServices;

class _StaffMembersPageState extends State<StaffMembersPage> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  List<String> availableDays  = [];
  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    availableDays.add('s');

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Dashboard"),
              onTap: (){
                setState(() {
                  selectedPage = 'dashboard';
                });
                Navigator.popAndPushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading: Icon(IconData(0xf320, fontFamily: 'MaterialIcons')),
              title: Text("Services"),
              onTap: (){
                setState(() {
                  selectedPage = 'services';
                });
                Navigator.popAndPushNamed(context, '/services-page');
              },
            ),
            ListTile(
              leading: Icon(IconData(0xf006c, fontFamily: 'MaterialIcons')),
              title: Text("Staff Members"),
              onTap: (){
                setState(() {
                  selectedPage = 'staffMembers';
                });
                Navigator.pushNamed(context, '/staff-members-page');
              },
            ),
            ListTile(
              leading: Icon(IconData(0xf44a, fontFamily: 'MaterialIcons')),
              title: Text("Business Hours"),
              onTap: (){
                setState(() {
                  selectedPage = 'businessHours';
                });
                Navigator.pushNamed(context, '/business-hours-logged-in');
              },
            ),
            ListTile(
              leading: Icon(Icons.bolt_rounded,
                color: selectedPage == 'marketing'?Colors.black:Colors.grey,
                size: selectedPage == 'marketing'?35:iconSize,
              ),
              title: Text("Marketing"),
              //title: Text("Statistics and Reports"),
              onTap: (){
                setState(() {
                  selectedPage = 'marketing';
                });
                Navigator.popAndPushNamed(context, '/marketing');
              },
            ),
            ListTile(
              leading: Icon(Icons.insert_chart_outlined),
              title: Text("Statistics and Reports"),
              onTap: (){
                setState(() {
                  selectedPage = 'statistics';
                });
                Navigator.popAndPushNamed(context, '/stats-and-reports');
              },
            ),
            ListTile(
              leading: Icon(IconData(0xf00ad, fontFamily: 'MaterialIcons')),
              title: Text("Point of Sale"),
              onTap: (){
                setState(() {
                  selectedPage = 'POS';
                });
                Navigator.popAndPushNamed(context, '/POS');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                setState(() {
                  selectedPage = 'settings';
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Staff Members",style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/staff-members-page');
          }, icon: Icon(Icons.refresh),
          ),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout)
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.account_circle),
          ),
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
                top: 0,
                left: 0,
                child: Container(
                  width: 70,
                  height: 1500,
                  decoration: BoxDecoration(
                    //color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Tooltip(
                        message: 'Dashboard',
                        child: ListTile(
                          leading: Icon(Icons.home,
                            color: selectedPage == 'dashboard'?Colors.black:Colors.grey,
                            size: selectedPage == 'dashboard'?35:iconSize,
                          ),
                          //title: Text("Dashboard"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'dashboard';
                            });
                            Navigator.popAndPushNamed(context, '/dashboard');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Services',
                        child: ListTile(
                          leading: Icon(IconData(0xf320, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'services'?Colors.black:Colors.grey,
                            size: selectedPage == 'services'?35:iconSize,
                          ),
                          // title: Text("Services"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'services';
                            });
                            Navigator.popAndPushNamed(context, '/services-page');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Staff Members',
                        child: ListTile(
                          leading: Icon(IconData(0xf006c, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'staffMembers'?Colors.black:Colors.grey,
                            size: selectedPage == 'staffMembers'?35:iconSize,
                          ),
                          //title: Text("Staff Members"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'staffMembers';
                            });
                            Navigator.pushNamed(context, '/staff-members-page');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Business Hours',
                        child: ListTile(
                          leading: Icon(IconData(0xf44a, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'businessHours'?Colors.black:Colors.grey,
                            size: selectedPage == 'businessHours'?35:iconSize,
                          ),
                          //title: Text("Staff Members"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'businessHours';
                            });
                            Navigator.pushNamed(context, '/business-hours-logged-in');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Marketing',
                        child: ListTile(
                          leading: Icon(Icons.bolt_rounded,
                            color: selectedPage == 'marketing'?Colors.black:Colors.grey,
                            size: selectedPage == 'marketing'?35:iconSize,
                          ),
                          //title: Text("Statistics and Reports"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'marketing';
                            });
                            Navigator.popAndPushNamed(context, '/marketing');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Stats and Reports',
                        child: ListTile(
                          leading: Icon(Icons.insert_chart_outlined,
                            color: selectedPage == 'statistics'?Colors.black:Colors.grey,
                            size: selectedPage == 'statistics'?35:iconSize,
                          ),
                          //title: Text("Statistics and Reports"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'statistics';
                            });
                            Navigator.popAndPushNamed(context, '/stats-and-reports');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Checkout',
                        child: ListTile(
                          leading: Icon(IconData(0xf00ad, fontFamily: 'MaterialIcons'),
                            color: selectedPage == 'POS'?Colors.black:Colors.grey,
                            size: selectedPage == 'POS'?35:iconSize,
                          ),
                          //title: Text("Point of Sale"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'POS';
                            });
                            Navigator.popAndPushNamed(context, '/POS');
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      Tooltip(
                        message: 'Settings',
                        child: ListTile(
                          leading: Icon(Icons.settings,color: selectedPage == 'settings'?Colors.black:Colors.grey,size: iconSize,),
                          //title: Text("Settings"),
                          onTap: (){
                            setState(() {
                              selectedPage = 'settings';
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 250,
                child: Container(
                  width: 300,
                  height: 100,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      readOnly: true,
                      textAlignVertical: TextAlignVertical.center,
                      onTap: (){
                        // showSearch(context: context, delegate: DataSearch(condition: false));
                      },
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Search For Staff Member",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: 260,
                child: Row(
                  children: [
                    SizedBox(width: 650,),

                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/add-staff');
                        },
                        icon: Icon(Icons.add,color: Colors.white,),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text("Add Staff Member", style: TextStyle(
                      fontSize: 20,
                    ),),


                  ],
                ),
              ),

              Positioned(
                left: 180,
                top: 170,
                child: Text("All Staff Members", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return Positioned(
                        left: 150,
                        top: 220,
                        child: Container(
                          width: 1000,
                          height: 500,
                          child: Card(
                            elevation: 2.0,
                            child: Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data['$currentShopIndex']['staff-members-amount'],
                                  itemBuilder: (context,index){

                                    if(snapshot.data['$currentShopIndex']['staff-members']['$index']['member-role'] != 'Owner'&&
                                    snapshot.data['$currentShopIndex']['staff-members']['$index']['member-role'] != 'Manager'){


                                      return Container(
                                        width: 800,
                                        height: 70,
                                        margin: EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            Container(
                                              child: ListTile(
                                                leading: VerticalDivider(color: Colors.blue,),
                                                title: Text(snapshot.data['$currentShopIndex']['staff-members']['$index']['member-name'],style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                                subtitle: Text(snapshot.data['$currentShopIndex']['staff-members']['$index']['member-role']),
                                              ),
                                              width: 700,
                                              height: 70,
                                            ),
                                            SizedBox(width: 10,),

                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.green,
                                              ),
                                              child: TextButton(
                                                onPressed: (){
                                                  selectedStaffIdx = index;
                                                  Navigator.pushNamed(context, '/edit-member');

                                                },
                                                child: Text("Edit", style: TextStyle(
                                                  color: Colors.white,
                                                ),),
                                              ),
                                            ),

                                            SizedBox(width: 5,),
                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.red,
                                              ),
                                              child: TextButton(
                                                onPressed: (){

                                                  selectedStaffIdx = index;

                                                  staffName = snapshot.data['$currentShopIndex']['staff-members']['$index']['member-name'];
                                                  staffRole = snapshot.data['$currentShopIndex']['staff-members']['$index']['member-role'];
                                                  staffServices = snapshot.data['$currentShopIndex']['staff-members']['$index']['member-services'];
                                                  staffServiceAmount = snapshot.data['$currentShopIndex']['staff-members']['$index']['member-services-amount'];


                                                  Navigator.pushNamed(context, '/delete-member');

                                                },
                                                child: Text("Delete", style: TextStyle(
                                                  color: Colors.white,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                    else{
                                      return Container();
                                    }
                                  }),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                  return const Text("Please wait");
                },

              ),

              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return Container();
                      //return buildBody(snapshot, selectedStaffIdx);
                  }
                  }
                  return const Text("Please wait");
                },
              ),

            ],
          ),
        ),
      ),
    );
  }





}
