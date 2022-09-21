import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/pages_logged_in/staff_members_page.dart';

import '../constants.dart';
import '../services/database.dart';


class EditStaffMember extends StatefulWidget {
  const EditStaffMember({Key? key}) : super(key: key);

  @override
  _EditStaffMemberState createState() => _EditStaffMemberState();
}

class _EditStaffMemberState extends State<EditStaffMember> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  String selectedService = "";
  String tabSelected = "User Info";
  List<String> tabs = ['User Info', 'Services','Working Hours'];


  TextEditingController memberRoleController = TextEditingController();
  TextEditingController memberNameController = TextEditingController();


  String openingHour = '10:00 AM';
  String endingHour = '10:00 PM';
  String dayToChange = 'Sunday';

  DatabaseService databaseService = DatabaseService();


  bool displayError = false;
  bool dayOff = false;


  bool findService(String service, AsyncSnapshot<dynamic> snapshot, int staffIndex){

    int index = 0;
    while(index < snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-services-amount']){

      if(service == snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-services']['$index']){
        return true;
      }

      index++;
    }

    return false;

  }


  List<String> weekDays = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Service',style: TextStyle(
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
            children: [

              FutureBuilder(
                future: categoryData(),
                builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                      return const Text("There is an error");
                    }
                    else if(snapshot.hasData){
                      return buildBody(snapshot, selectedStaffIdx);
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


  Widget buildBody(AsyncSnapshot<dynamic> snapshot, index){

    // Tab selected is user info
    if(tabSelected == "User Info"){
      return Positioned(
        top: 150,
        left: 600,
        child: Container(
          width: 600,
          height: 600,
          child: Card(
            elevation: 1.0,
            child: Column(
              children: [
                SizedBox(height: 20,),
                buildTabs(snapshot),
                SizedBox(height: 20,),
                Text("Edit User Info", style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: memberNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Member Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: memberRoleController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Member Role',
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                FutureBuilder(
                  future: categoryData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () async{



                              await databaseService.editStaffMemberUserInfo(
                                  selectedCategory,
                                  currentShopIndex,
                                  selectedStaffIdx,
                                  memberNameController.text,
                                  memberRoleController.text
                              );

                            },
                            child: Text("Save Changes", style: const TextStyle(
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
      );
    }
    // Tab Selected is Services
    else if(tabSelected == "Services"){
      return Positioned(
        top: 150,
        left: 600,
        child: Container(
          width: 600,
          height: 600,
          child: Card(
            elevation: 1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text("Edit User Services", style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(height: 20,),
                buildTabs(snapshot),
                SizedBox(height: 0,),
                Container(
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
                        hintText: "Search Services",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                FutureBuilder(
                  future: categoryData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Container(
                          width: 300,
                          height: 100,
                          child: ListView.builder(
                              itemCount: snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-services-amount'],
                              itemBuilder: (context,index){
                                return Container(
                                  width: 300,
                                  child: ListTile(
                                    leading: VerticalDivider(color: Colors.blue,),
                                    title: Text(snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-services']['$index']),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        // REMOVES SELECTED SERVICE FROM LIST OF SERVICES FOR SELECTED STAFF MEMBER

                                        // New List of Services for current staff member
                                        List<String> newServiceList = [];

                                        int serviceIndex = 0;

                                        // Fills up new list of services
                                        while(serviceIndex < snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-services-amount']){

                                          // Current service looping on
                                          String currentService = snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-services']['$serviceIndex'];

                                          if(serviceIndex != index){
                                            print("REACHEEEEE");
                                            newServiceList.add(currentService);
                                          }

                                          serviceIndex++;
                                        }

                                        print(newServiceList.length);

                                        // Removes old list of services from database
                                        serviceIndex = 0;
                                        while(serviceIndex < snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-services-amount']){
                                          await databaseService.removeStaffMemberService(
                                            selectedCategory,
                                            currentShopIndex,
                                            selectedStaffIdx,
                                            serviceIndex,
                                          );
                                          serviceIndex++;
                                        }

                                        // Edits Service list for staff member in database
                                        serviceIndex = 0;

                                        while(serviceIndex < newServiceList.length){
                                          await databaseService.editStaffMemberServiceInfo(
                                              selectedCategory,
                                              currentShopIndex,
                                              selectedStaffIdx,
                                              newServiceList[serviceIndex],
                                              serviceIndex
                                          );
                                          serviceIndex++;
                                          print("edited");
                                        }

                                        // If the new list of services is empty, then just edit the amount field in the database
                                        // for the selected staff member
                                        if(newServiceList.isEmpty){
                                          await databaseService.editStaffMemberServiceAmount(
                                              selectedCategory,
                                              currentShopIndex,
                                              selectedStaffIdx
                                          );
                                        }
                                      },
                                      icon: Icon(Icons.highlight_remove, color: Colors.red,),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    }
                    return const Text("Please wait");
                  },

                ),

                SizedBox(height: 70,),

                FutureBuilder(
                  future: categoryData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){

                        List<String> shopServices = [];
                        shopServices.add("");

                        int serviceIdx = 0;

                        while(serviceIdx < snapshot.data['$currentShopIndex']['services-amount']){
                          bool serviceFound = findService(snapshot.data['$currentShopIndex']['services']['$serviceIdx']['service-name'], snapshot, selectedStaffIdx);
                          if(!serviceFound){
                            shopServices.add(snapshot.data['$currentShopIndex']['services']['$serviceIdx']['service-name']);
                          }
                          serviceIdx++;
                        }

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 20,),
                            Text("Service", style: TextStyle(
                              fontSize: 20,
                            ),),
                            SizedBox(width: 30,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0),
                              ),
                              width: 150,
                              child: DropdownButton<String>(
                                value: selectedService,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                //style: const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedService = newValue!;
                                  });
                                },
                                items: shopServices.map<DropdownMenuItem<String>>((String value) {
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
                    return const Text("Please wait");
                  },

                ),

                SizedBox(height: 10,),

                Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () async{

                        if(selectedService != ""){
                          // ADD SELECTED SERVICE TO LIST OF SERVICES IN DATABASE
                          await databaseService.editStaffMemberServiceInfo(
                              selectedCategory,
                              currentShopIndex,
                              selectedStaffIdx,
                              selectedService,
                              snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-services-amount']
                          );

                          selectedService = "";
                        }
                      },
                      child: Text("Add Service", style: TextStyle(
                        color: Colors.white,
                      ),),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
      );
    }
    // Tab Selected is Working Hours
    else{
      return buildEditMember(snapshot, index);
    }
  }


  Widget buildEditMember(AsyncSnapshot<dynamic> snapshot, index){
    if(snapshot.data['$currentShopIndex']['staff-members']['$index']['member-name'] != 'Owner'&&
        snapshot.data['$currentShopIndex']['staff-members']['$index']['member-name'] != 'Manager'){
      return Positioned(
        top: 150,
        left: 600,
        child: Container(
          width: 600,
          height: 600,
          child: Card(
            elevation: 1.0,
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text("Edit Staff Member", style: TextStyle(
                  fontSize: 20,
                ),),
                SizedBox(height: 20,),
                buildTabs(snapshot),
                SizedBox(height: 20,),
                Align(
                  alignment: Alignment.center,
                  child: Text("Business Hours", style: TextStyle(
                    fontSize: 20,
                  ),),
                ),
                SizedBox(height: 30,),
                FutureBuilder(
                  future: categoryData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        return Row(
                          children: [
                            Text("Day", style: TextStyle(
                              fontSize: 20,
                            ),),
                            SizedBox(width: 30,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0),
                              ),
                              width: 150,
                              child: DropdownButton<String>(
                                value: dayToChange,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                //style: const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dayToChange = newValue!;
                                    displayError = false;
                                    dayOff = false;
                                  });
                                },
                                items: weekDays
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
                    return const Text("Please wait");
                  },

                ),

                SizedBox(height: 30,),
                Row(
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
                            displayError = false;
                            dayOff = false;
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
                            displayError = false;
                            dayOff = false;
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
                ),
                SizedBox(height: 40,),
                buildErrorMessage(),
                SizedBox(height: 85,),
                FutureBuilder(
                  future: categoryData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){
                        // businessHours[currentDayWorkingHoursToChange]!['begin'] = openingHour;
                        //businessHours[currentDayWorkingHoursToChange]!['end'] = endingHour;

                        return Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () async{

                              int currentTimeIndex = 0;
                              bool isDayOff = snapshot.data['$currentShopIndex']['staff-members']['$selectedStaffIdx']['member-timings'][dayToChange]['day-off'];


                              if(isDayOff){
                                setState(() {
                                  dayOff = true;
                                });
                              }
                              else{

                                if(!displayError){

                                  await databaseService.editStaffMemberTimings(
                                      selectedCategory,
                                      currentShopIndex,
                                      selectedStaffIdx,
                                      dayToChange,
                                      openingHour,
                                      endingHour
                                  );

                                }
                              }

                              Navigator.pushNamed(context, '/staff-members-page');


                            },
                            child: Text("Save Changes", style: const TextStyle(
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
      );
    }
    else{
      return Container();
    }
  }

  Widget buildErrorMessage(){
    if(displayError){
      return Column(
        children: [
          Text("The working hours entered are in conflict with the staff's current appointments", style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),),
          Text("Please try again when the staff has no conflicting appointments",style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),),
          Text("or wait after until the last appointment of the day",style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),),
        ],
      );
    }
    else if(dayOff){
      return Text("$dayToChange is not a working day, you can change the working days from the settings", style: TextStyle(
        color: Colors.red,
        fontSize: 15,
      ),);
    }
    else{
      return Container();
    }
  }

  Widget buildTabs(AsyncSnapshot<dynamic> snapshot){
    return Container(
      width: 400,
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          itemCount: tabs.length,
          itemBuilder: (context,index){
            return Container(
              margin: EdgeInsets.all(10),
              height: 60,
              child: TextButton(
                onPressed: (){
                  setState(() {
                    tabSelected = tabs[index];
                  });
                },
                child: Column(
                  children: [
                    Text(tabs[index], style: TextStyle(
                      color: tabSelected == tabs[index]? Colors.black : Colors.grey,
                    ),),
                    Divider(color: tabSelected == tabs[index]?Colors.black:Colors.transparent,thickness: 2.0,),
                  ],
                ),
              ),
            );
          }),
    );
  }


}
