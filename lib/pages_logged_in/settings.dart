import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';



class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Settings",style: TextStyle(
          color: Colors.black,
        ),),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
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
              leading: Icon(Icons.bolt_rounded,
                color: selectedPage == 'marketing'?Colors.black:Colors.grey,
                size: selectedPage == 'marketing'?35:iconSize,
              ),
              title: Text("Marketing"),
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
                Navigator.popAndPushNamed(context, '/settings');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: FutureBuilder(
            future: categoryData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
            {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1.5,
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
                                    leading: Icon(Icons.settings,color: selectedPage == 'settings'?Colors.black:Colors.grey,
                                      size: selectedPage == 'settings'?35:iconSize,),
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
                          top: 50,
                          left: 150,
                          child: Column(
                            children: [

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    elevation: 2.0,
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('General Information', style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),),

                                              Icon(Icons.admin_panel_settings,size: 50,),
                                            ],
                                          ),

                                          Text("Shop Name",style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          Text(snapshot.data['$currentShopIndex']['shop-name'],style: TextStyle(
                                            fontSize: 14,
                                          ),),


                                          Text("Shop Address",style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          Text(snapshot.data['$currentShopIndex']['shop-address'],style: TextStyle(
                                            fontSize: 14,
                                          ),),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("Contact Number",style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                                  Text(snapshot.data['$currentShopIndex']['contact-number'],style: TextStyle(
                                                    fontSize: 14,
                                                  ),),
                                                ],
                                              ),

                                              Container(
                                                width: 150,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                  onPressed: (){},
                                                  child: Text("Edit",style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                  Card(
                                    elevation: 2.0,
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('User Information', style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),),

                                              Icon(Icons.supervisor_account_sharp,size: 50,),
                                            ],
                                          ),

                                          Text("User Name",style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          Text(snapshot.data['$currentShopIndex']['users']['$currentUserIndex']['name'],style: TextStyle(
                                            fontSize: 14,
                                          ),),


                                          Text("User Email",style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          Text(snapshot.data['$currentShopIndex']['users']['$currentUserIndex']['email'],style: TextStyle(
                                            fontSize: 14,
                                          ),),

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(
                                                width: 100,
                                              ),


                                              Container(
                                                width: 150,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                  onPressed: (){

                                                  },
                                                  child: Text(
                                                    snapshot.data['$currentShopIndex']['users']['$currentUserIndex']['admin']?
                                                    "Edit Users":'Edit',style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 50,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
                                    elevation: 2.0,
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      height: MediaQuery.of(context).size.height * 0.35,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text('Portfolio', style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),),

                                              Icon(Icons.supervisor_account_sharp,size: 50,),
                                            ],
                                          ),

                                          Text("Images in Portfolio",style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),),
                                          Text('${snapshot.data['$currentShopIndex']['total-images']}',style: TextStyle(
                                            fontSize: 14,
                                          ),),


                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [

                                              Container(
                                                width: 100,
                                              ),


                                              Container(
                                                width: 150,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: TextButton(
                                                  onPressed: (){
                                                 //   Navigator.pushNamed(context, '/portfolio');
                                                   Navigator.pushNamed(context, '/image-upload');
                                                  },
                                                  child: Text("Edit",style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),

                                  Card(
                                    elevation: 2.0,
                                    child: Container(
                                      margin: EdgeInsets.all(20),
                                      width: MediaQuery.of(context).size.width / 2.5,
                                      height: MediaQuery.of(context).size.height * 0.35,
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),


                      ],
                    ),
                  );
                }
              }
              return const Center(child: CircularProgressIndicator(),);
            },

          ),
        ),
      ),
    );
  }
}
