import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';



class AddStaffMember extends StatefulWidget {
  const AddStaffMember({Key? key}) : super(key: key);

  @override
  _AddStaffMemberState createState() => _AddStaffMemberState();
}

class _AddStaffMemberState extends State<AddStaffMember> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();

  String openingHour = '10:00 AM';
  String endingHour = '10:00 PM';

  // Keeps track if new user will have default business hours
  bool isDefault = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  // Will be used to check if isChecked list has been edited or not
  bool isInitialEdit = true;

  // isChecked list is used to track which services have been selected
  // To be added to the staff member's service list in the database
  List<bool> isChecked = [];


  // Map for the services to be selected for new staff member
  Map<String,String> staffServices = {};


  Map<String,Map<String,String>> businessHours = {};


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
        title: Text("Add Staff Member",style: TextStyle(
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
            onPressed: (){

            },
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width - 400,
            height: MediaQuery.of(context).size.height + 1000,
            child: Card(
              elevation: 5.0,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    width: 600,
                    height: 300,
                    child: Column(
                      children: [

                        Text("General Information", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10,),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "Staff Member Name",
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextField(
                          controller: roleController,
                          decoration: InputDecoration(
                            labelText: "Staff Member Role",
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text("Business Hours", style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: isDefault?Colors.green:Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 200,
                              height: 50,
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    isDefault = true;
                                  });
                                },
                                child: Text("Default Working Hours", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                color: isDefault?Colors.grey:Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: 200,
                              height: 50,
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    isDefault = false;
                                  });
                                },
                                child: Text("Custom Working Hours", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  buildWorkingHours(),

                  SizedBox(height: 10,),
                  Text("Services", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 10,),

                  FutureBuilder(
                    future: categoryData(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasError){
                          return const Text("There is an error");
                        }
                        else if(snapshot.hasData){


                          if(isInitialEdit){
                            print("EDITED");
                            int serviceIndex = 0;

                            while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){

                              isChecked.add(false);

                              serviceIndex++;
                            }

                            isInitialEdit = false;
                          }

                          return Container(
                            width: 400,
                            height: 520,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemCount: snapshot.data['$currentShopIndex']['services-amount'],
                                itemBuilder: (context,index){

                                  return Container(
                                    height: 150,
                                    width: 350,
                                    child: Row(
                                      children: [
                                        Container(
                                          child: ListTile(
                                            leading: VerticalDivider(color: Colors.blue,),
                                            title: Column(
                                              children: [
                                                Text(snapshot.data['$currentShopIndex']['services']['$index']['service-name'], style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),),
                                                Text("${snapshot.data['$currentShopIndex']['services']['$index']['service-hours']} ${snapshot.data['$currentShopIndex']['services']['$index']['service-minutes']}"),
                                              ],
                                            ),
                                            trailing: Text("${snapshot.data['$currentShopIndex']['services']['$index']['service-price']} EGP"),
                                          ),
                                          width: 300,
                                          height: 100,
                                        ),

                                        Container(
                                          child: IconButton(
                                              onPressed: (){
                                                setState(() {
                                                  isChecked[index] = true;
                                                  //staffServices['${staffServices.length}'] = snapshot.data['$currentShopIndex']['services']['$index']['service-name'];
                                                });
                                              },
                                              icon: Icon(Icons.check_circle_outline, color: isChecked[index]?Colors.green:Colors.grey,),
                                          ),
                                          width: 50,
                                          height: 50,
                                        ),
                                        SizedBox(width: 5,),
                                        Container(
                                          child: IconButton(
                                              onPressed: (){
                                                setState(() {
                                                  isChecked[index] = false;
                                                  //staffServices.remove(snapshot.data['$currentShopIndex']['services']['$index']['service-name']);
                                                });
                                              },
                                              icon: Icon(Icons.highlight_remove, color: isChecked[index]?Colors.grey:Colors.green,),
                                          ),
                                          width: 50,
                                          height: 50,
                                        ),

                                      ],
                                    ),
                                  );
                                }
                                ),
                          );
                        }
                      }
                      return const Text("Please wait");
                    },
                  ),

                  FutureBuilder(
                    future: categoryData(),
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.hasError){
                          return const Text("There is an error");
                        }
                        else if(snapshot.hasData){
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: 200,
                            height: 50,
                            child: TextButton(
                              onPressed: () async {

                                int dayIndex = 0;

                                if(isDefault){

                                  Map<String,String> currentDayTimings = {};

                                  while(dayIndex < weekDays.length){
                                    int timingIndex = 0;
                                    int currentDayTimingAmount = int.parse(snapshot.data['$currentShopIndex']['business-hours'][weekDays[dayIndex]]['${-1}']);
                                    while(timingIndex < currentDayTimingAmount){
                                      String currentTime = snapshot.data['$currentShopIndex']['business-hours'][weekDays[dayIndex]]['$timingIndex'];
                                      currentDayTimings['$timingIndex'] = currentTime;
                                      timingIndex++;
                                    }

                                    if(currentDayTimingAmount != 0){
                                      currentDayTimings['${-1}'] = '$timingIndex';
                                    }
                                    else{
                                      currentDayTimings['${-1}'] = '${0}';
                                    }

                                    businessHours[weekDays[dayIndex]] = currentDayTimings;
                                    currentDayTimings = {};
                                    dayIndex++;
                                  }

                                }
                                else{

                                  Map<String,String> currentDayTimings = {};

                                  while(dayIndex < weekDays.length){

                                    int businessHourIndex = 0;
                                    print('1');
                                    int currentDayTimingAmount = int.parse(snapshot.data['$currentShopIndex']['business-hours'][weekDays[dayIndex]]['${-1}']);
                                    print('2');
                                    int timingIndex = 0;

                                    while(timingIndex < currentDayTimingAmount){

                                      print('3');
                                      if(openingHour == snapshot.data['$currentShopIndex']['business-hours'][weekDays[dayIndex]]['$timingIndex']){
                                        print('4');
                                        currentDayTimings['$businessHourIndex'] = openingHour;
                                        //businessHours[weekDays[dayIndex]]!['$businessHourIndex'] = openingHour;
                                        timingIndex++;

                                        String currentTime = openingHour;
                                        while(currentTime != endingHour){

                                          print('5');
                                          currentDayTimings['$businessHourIndex'] = snapshot.data['$currentShopIndex']['business-hours'][weekDays[dayIndex]]['$timingIndex'];
                                          currentTime = snapshot.data['$currentShopIndex']['business-hours'][weekDays[dayIndex]]['$timingIndex'];
                                          print('6');
                                          //businessHours[weekDays[dayIndex]]!['$businessHourIndex'] = snapshot.data['$currentShopIndex']['business-hours'][weekDays[dayIndex]]['$timingIndex'];
                                          timingIndex++;
                                          businessHourIndex++;
                                        }

                                        if(currentDayTimingAmount != 0){
                                          currentDayTimings['${-1}'] = '$businessHourIndex';
                                        }
                                        else{
                                          currentDayTimings['${-1}'] = '${0}';
                                        }

                                        businessHours[weekDays[dayIndex]] = currentDayTimings;
                                        currentDayTimings = {};
                                        break;

                                      }
                                      timingIndex++;
                                    }
                                    dayIndex++;
                                  }
                                }

                                int serviceIndex = 0;
                                int staffServiceIndex = 0;
                                while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){

                                  if(isChecked[serviceIndex]){
                                    staffServices['$staffServiceIndex'] = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name'];
                                    staffServiceIndex++;
                                  }

                                  serviceIndex++;
                                }



                                await databaseService.addStaffMemberLoggedIn(
                                    selectedCategory,
                                    staffServices,
                                    currentShopIndex,
                                    snapshot.data['$currentShopIndex']['staff-members-amount'],
                                    nameController.text,
                                    roleController.text,
                                    businessHours,
                                );


                                Navigator.pushNamed(context, '/staff-members-page');



                              },
                              child: Text("Add Staff Member", style: TextStyle(
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
      ),
    );
  }

  Widget buildWorkingHours(){
    if(isDefault){
      return Container();
    }
    else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Working hours ", style: TextStyle(
            fontSize: 20,
          ),),
          SizedBox(width: 30,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0),
            ),
            width: 100,
            child: DropdownButton<String>(
              value: openingHour,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              //style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? newValue) {
                setState(() {
                  openingHour = newValue!;
                });
              },
              items: <String>[
                '10:00 AM',
                '11:00 AM',
                '12:00 PM',
                '1:00 PM',
                '2:00 PM',
                '3:00 PM',
                '4:00 PM',
                '5:00 PM',
                '6:00 PM',
                '7:00 PM',
                '8:00 PM',
                '9:00 PM',
                '10:00 PM',
              ]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          SizedBox(width: 30,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0),
            ),
            width: 100,
            child: DropdownButton<String>(
              value: endingHour,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              //style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? newValue) {
                setState(() {
                  endingHour = newValue!;
                });
              },
              items: <String>[
                '10:00 AM',
                '11:00 AM',
                '12:00 PM',
                '1:00 PM',
                '2:00 PM',
                '3:00 PM',
                '4:00 PM',
                '5:00 PM',
                '6:00 PM',
                '7:00 PM',
                '8:00 PM',
                '9:00 PM',
                '10:00 PM',
              ]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      );
    }
  }


}





