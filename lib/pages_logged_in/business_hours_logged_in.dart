import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../services/database.dart';


class BusinessHoursLoggedIn extends StatefulWidget {
  const BusinessHoursLoggedIn({Key? key}) : super(key: key);

  @override
  _BusinessHoursLoggedInState createState() => _BusinessHoursLoggedInState();
}

String daySelectedToEdit = "";

class _BusinessHoursLoggedInState extends State<BusinessHoursLoggedIn> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();



  List<String> weekDays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];


  @override
  Widget build(BuildContext context) {
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
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text('Business Hours', style: TextStyle(
          color: Colors.black,
        ),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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



              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return Positioned(
                        left: (MediaQuery.of(context).size.width / 2) - 250,
                        top: 50,
                        child: Card(
                          elevation: 2.0,
                          child: Container(
                            width: 500,
                            height: 450,
                            child: ListView.builder(
                                itemCount: weekDays.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    width: 400,
                                    height: 50,
                                    margin: EdgeInsets.all(5),
                                    child: ListTile(
                                      leading: VerticalDivider(color: Colors.blue,),
                                      title: Text(weekDays[index]),
                                      subtitle: Text((snapshot.data['$currentShopIndex']['business-hours'][weekDays[index]]['day-off'] == true)?"Closed":'${snapshot.data['$currentShopIndex']['business-hours'][weekDays[index]]['from']} - '
                                          '${snapshot.data['$currentShopIndex']['business-hours'][weekDays[index]]['to']}',),
                                      trailing: Container(
                                        width: 100,
                                        height: 50,
                                        child: Row(
                                          children: [

                                            Container(
                                              width: 100,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.green,
                                              ),
                                              child: TextButton(
                                                onPressed: (){

                                                  daySelectedToEdit = weekDays[index];
                                                  Navigator.pushNamed(context, '/edit-business-hours');
                                                },
                                                child: Text("Edit", style: TextStyle(
                                                  color: Colors.white,
                                                ),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      );
                    }
                  }
                  return const Text("Please wait");
                },

              ),





              // BLOCKED HOURS FUNCTIONALITY
              /*

              Positioned(
                top: 50,
                left: 740,
                child: Text('Blocked Hours', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),
              ),

              Positioned(
                top: 40,
                left: 1080,
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/block-hours');
                    },
                    child: Text('Block Hours', style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),
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
                        left: 730,
                        top: 100,
                        child: Card(
                          elevation: 2.0,
                          child: Container(
                            width: 500,
                            height: 500,
                            child: snapshot.data['$currentShopIndex']['blocked-hours-amount'] != 0?ListView.builder(
                                  itemCount: snapshot.data['$currentShopIndex']['blocked-hours-amount'],
                                  itemBuilder: (context,index){
                                    return Container(
                                      width: 400,
                                      height: 50,
                                      margin: EdgeInsets.all(5),
                                      child: ListTile(
                                        leading: VerticalDivider(color: Colors.blue,),
                                        title: Text('${snapshot.data['$currentShopIndex']['blocked-hours']['$index']['from']} - ${snapshot.data['$currentShopIndex']['blocked-hours']['$index']['to']}'),
                                        subtitle: Text('${snapshot.data['$currentShopIndex']['blocked-hours']['$index']['day']} ${snapshot.data['$currentShopIndex']['blocked-hours']['$index']['month']} ${snapshot.data['$currentShopIndex']['blocked-hours']['$index']['year']}'),
                                        trailing: Container(
                                          width: 220,
                                          height: 50,
                                          child: Row(
                                            children: [

                                              Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.green,
                                                ),
                                                child: TextButton(
                                                  onPressed: (){


                                                  },
                                                  child: Text("Edit", style: TextStyle(
                                                    color: Colors.white,
                                                  ),),
                                                ),
                                              ),
                                              SizedBox(width: 10,),
                                              Container(
                                                width: 100,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.red,
                                                ),
                                                child: TextButton(
                                                  onPressed: (){


                                                  },
                                                  child: Text("Delete", style: TextStyle(
                                                    color: Colors.white,
                                                  ),),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }):
                           Container(
                                alignment: Alignment.center,
                                width: 200,
                                height: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('You have no blocked hours', style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    SizedBox(height: 50,),
                                    Container(
                                      width: 300,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: (){
                                          Navigator.pushNamed(context, '/block-hours');
                                        },
                                        child: Text('Block hours', style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                      );
                    }
                  }
                  return const Text("Please wait");
                },

              ),
              */

            ],
          ),
        ),
      ),
    );
  }
}
