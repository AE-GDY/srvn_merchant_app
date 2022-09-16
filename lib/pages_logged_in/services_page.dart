import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/services/database.dart';


class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  _ServicesPageState createState() => _ServicesPageState();
}

// Checks which service has been selected to be edited
int selectedIdx = 0;

String serviceNameToBeEdited = "";
String serviceDurationToBeEdited = "";
String servicePriceToBeEdited = "";

class _ServicesPageState extends State<ServicesPage> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

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
                Navigator.popAndPushNamed(context, 'Rep');
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
        title: Text("Services", style: TextStyle(
          color: Colors.black
        ),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/services-page');
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
                      ListTile(
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
                      SizedBox(height: 10,),
                      ListTile(
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
                      SizedBox(height: 10,),
                      ListTile(
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
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.bolt_rounded,
                          color: selectedPage == 'marketing'?Colors.black:Colors.grey,
                          size: selectedPage == 'marketing'?35:iconSize,
                        ),
                        onTap: (){
                          setState(() {
                            selectedPage = 'marketing';
                          });
                          Navigator.popAndPushNamed(context, '/marketing');
                        },
                      ),
                      SizedBox(height: 10,),
                      ListTile(
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
                      SizedBox(height: 10,),
                      ListTile(
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
                      SizedBox(height: 10,),
                      ListTile(
                        leading: Icon(Icons.settings,color: selectedPage == 'settings'?Colors.black:Colors.grey,size: iconSize,),
                        //title: Text("Settings"),
                        onTap: (){
                          setState(() {
                            selectedPage = 'settings';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 150,
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
                        hintText: "Search For Service",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 100,
                left: 260,
                child: Row(
                  children: [
                    SizedBox(width: 700,),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/add-service');
                        },
                        icon: Icon(Icons.add,color: Colors.white,),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text("Add Service", style: TextStyle(
                      fontSize: 20,
                    ),),

                  ],
                ),
              ),


              Positioned(
                left: 180,
                top: 170,
                child: Text("All Services", style: TextStyle(
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
                          margin: EdgeInsets.all(10),
                          width: 1000,
                          height: 500,
                          child: Card(
                            elevation: 2.0,
                            child: Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data['$currentShopIndex']['services-amount'],
                                  itemBuilder: (context,index){

                                    return Container(
                                      width: 600,
                                      height: 70,
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: ListTile(
                                              leading: VerticalDivider(color: Colors.blue,),
                                              title: Text(snapshot.data['$currentShopIndex']['services']['$index']['service-name'],style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),),
                                              subtitle: Text("${snapshot.data['$currentShopIndex']['services']['$index']['service-hours']} ${snapshot.data['$currentShopIndex']['services']['$index']['service-minutes']}"),
                                              trailing: Text("${snapshot.data['$currentShopIndex']['services']['$index']['service-price']} EGP", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),) ,
                                            ),
                                            width: 600,
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
                                                selectedIdx = index;
                                                Navigator.pushNamed(context, '/edit-service');

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

                                                selectedIdx = index;

                                                serviceNameToBeEdited = snapshot.data['$currentShopIndex']['services']['$index']['service-name'];
                                                serviceDurationToBeEdited = '${snapshot.data['$currentShopIndex']['services']['$index']['service-hours']} ${snapshot.data['$currentShopIndex']['services']['$index']['service-minutes']}';
                                                servicePriceToBeEdited = snapshot.data['$currentShopIndex']['services']['$index']['service-price'];

                                                Navigator.pushNamed(context, '/delete-service');

                                              },
                                              child: Text("Delete", style: TextStyle(
                                                color: Colors.white,
                                              ),),
                                            ),
                                          ),


                                        ],
                                      ),
                                    );
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
            ],
          ),
        ),
      ),

    );
  }
}
