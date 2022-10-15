import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';



class Marketing extends StatefulWidget {
  const Marketing({Key? key}) : super(key: key);

  @override
  _MarketingState createState() => _MarketingState();
}

class _MarketingState extends State<Marketing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 100,),
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
              leading: Icon(Icons.bolt_rounded),
              title: Text("Marketing"),
              onTap: (){
                setState(() {
                  selectedPage = 'marketing';
                });
                Navigator.pushNamed(context, '/marketing');
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
                Navigator.popAndPushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('$shopName Marketing',style: TextStyle(
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
          width: 1500,
          height: 1500,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 5,
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
                            Navigator.popAndPushNamed(context, '/settings');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 490,
                top: 30,
                child: Text("Srvn Boost",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),),
              ),



              Positioned(
                top: 70,
                left: (MediaQuery.of(context).size.width / 2) - 500,
                child: Container(
                  width: 800,
                  height: 200,
                  child: Card(
                    elevation: 5.0,
                    child: Stack(
                      children: [

                        Positioned(
                          left: 30,
                          top: 60,
                          child: Container(
                            child: Icon(Icons.rocket_launch,size: 60,),
                          ),
                        ),

                        Positioned(
                          left: 150,
                          top: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Lifetime Boost Profit"),
                              SizedBox(height: 10,),
                              Text("0 EGP", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ),

                        Positioned(
                          right: 50,
                          top: 50,
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Total Boost Clients"),
                                      SizedBox(height: 5,),
                                      Text("0"),
                                    ],
                                  ),
                                  SizedBox(width: 50,),
                                  Column(
                                    children: [
                                      Text("Total Boost Appointments"),
                                      SizedBox(height: 5,),
                                      Text("0"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 70,
                left: MediaQuery.of(context).size.width * 0.75,
                child: Container(
                  width: 300,
                  height: 200,
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Boost Marketing", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 5,),
                        Text("Utilize boost to increase clients!"),
                        SizedBox(height: 50,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 200,
                          height: 50,
                          child: TextButton(
                            onPressed: (){},
                            child: Text("Add Boost", style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),



              Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 490,
                top: 330,
                child: Row(
                  children: [
                    Text("Promotions",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),

                    SizedBox(width: 800 - 360,),

                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/active-promotions');
                        },
                        child: Text("View Active Promotions", style: TextStyle(
                          color: Colors.white,
                        ),),
                      ),
                    ),

                  ],
                ),
              ),

              Positioned(
                top: 400,
                left: (MediaQuery.of(context).size.width / 2) - 500,
                child: Container(
                  width: 800,
                  height: 200,
                  child: Card(
                    elevation: 5.0,
                    child: Stack(
                      children: [

                        Positioned(
                          left: 30,
                          top: 60,
                          child: Container(
                            child: Icon(Icons.discount,size: 60,),
                          ),
                        ),

                        Positioned(
                          left: 150,
                          top: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Lifetime Promotion Profit"),
                              SizedBox(height: 10,),
                              Text("0 EGP", style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),),
                            ],
                          ),
                        ),

                        Positioned(
                          right: 10,
                          top: 50,
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text("Total Promotions Clients"),
                                      SizedBox(height: 5,),
                                      Text("0"),
                                    ],
                                  ),
                                  SizedBox(width: 50,),
                                  Column(
                                    children: [
                                      Text("Total Promotions Appointments"),
                                      SizedBox(height: 5,),
                                      Text("0"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 400,
                left: MediaQuery.of(context).size.width * 0.75,
                child: Container(
                  width: 300,
                  height: 200,
                  child: Card(
                    elevation: 5.0,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text("Get Promoted", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 5,),
                        Text("Add promotions to increase sales!"),
                        SizedBox(height: 50,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: 200,
                          height: 50,
                          child: TextButton(
                            onPressed: (){

                              Navigator.pushNamed(context, '/add-promotion');

                            },
                            child: Text("Add Promotion", style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
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
