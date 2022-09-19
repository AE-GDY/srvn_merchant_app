import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../services/database.dart';


class AddPackage extends StatefulWidget {
  const AddPackage({Key? key}) : super(key: key);

  @override
  _AddPackageState createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }


  DatabaseService databaseService = DatabaseService();


  TextEditingController packageNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  List<String> services = [];
  List<String> servicesInPackage = [];
  List<bool> selectedServices = [];

  List<String> staffMembers = [];
  List<String> staffMembersRoles = [];
  List<String> staffMembersForPackage = [];
  List<bool> selectedStaffMembers = [];

  String selectedService = "";
  String selectedHour = "";
  String selectedMinute = "";
  String minuteGap = "";

  bool isError = false;

  // KEEPS TRACK WHETHER PACKAGE WILL REQUIRE STAFF MEMBER OR NOT
  bool serviceLinked = true;

  bool initialEdit = true;

  int numberOfBookings = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Package Details",style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Center(
          child: FutureBuilder(
            future: categoryData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){


                  if(initialEdit){
                    int serviceIndex = 0;

                    services.add('All');
                    selectedServices.add(false);
                    while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                      services.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']);
                      selectedServices.add(false);
                      serviceIndex++;
                    }


                    int staffIndex = 1;

                    staffMembers.add('All');
                    selectedStaffMembers.add(false);
                    staffMembersRoles.add('');

                    while(staffIndex < snapshot.data['$currentShopIndex']['staff-members-amount']){

                      staffMembers.add(snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-name']);
                      staffMembersRoles.add(snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-role']);
                      selectedStaffMembers.add(false);
                      staffIndex++;

                    }

                    initialEdit = false;

                  }

                  return Container(
                    width: 1000,
                    height: 1500,
                    child: Column(
                      children: [
                        showError(),
                        SizedBox(height: 10,),
                        Container(
                          width: 750,
                          height: 1300,
                          margin: EdgeInsets.all(10),
                          child: Card(
                            elevation: 5.0,
                            child: Column(
                              children: [
                                Container(
                                  width: 400,
                                  height: 700,
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Text("Package Information", style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      TextField(
                                        controller: packageNameController,
                                        decoration: InputDecoration(
                                          labelText: "Package Name",
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      TextField(
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          labelText: "Package Price (EGP)",
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Text("Services In Package", style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Container(
                                        width: 300,
                                        height: 200,
                                        child: ListView.builder(
                                            itemCount: services.length,
                                            itemBuilder: (context,index){
                                              return ListTile(
                                                leading: Switch(
                                                  value: selectedServices[index],
                                                  onChanged: (bool value) {
                                                    setState(() {

                                                      if(index == 0){
                                                        if(selectedServices[index]){
                                                          int idx = 1;
                                                          while(idx < selectedServices.length){
                                                            selectedServices[idx] = false;
                                                            idx++;
                                                          }
                                                        }
                                                        else{
                                                          int idx = 1;
                                                          while(idx < selectedServices.length){
                                                            selectedServices[idx] = true;
                                                            idx++;
                                                          }
                                                        }
                                                      }
                                                      else{
                                                        selectedServices[0] = false;
                                                      }

                                                      selectedServices[index] = !selectedServices[index];

                                                      int idx = 1;
                                                      bool allSelected = true;
                                                      while(idx < selectedServices.length){

                                                        if(selectedServices[idx] == false){
                                                          allSelected = false;
                                                          break;
                                                        }
                                                        idx++;
                                                      }

                                                      if(allSelected){
                                                        selectedServices[0] = true;
                                                      }

                                                    });
                                                  },
                                                ),
                                                title: Text(services[index]),
                                              );
                                            }
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Text("Staff Members for this Package", style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      Container(
                                        width: 300,
                                        height: 220,
                                        child: ListView.builder(
                                            itemCount: staffMembers.length,
                                            itemBuilder: (context,index){
                                              return ListTile(
                                                leading: Switch(
                                                  value: selectedStaffMembers[index],
                                                  onChanged: (bool value) {
                                                    setState(() {

                                                      if(index == 0){
                                                        if(selectedStaffMembers[index]){
                                                          int idx = 1;
                                                          while(idx < selectedStaffMembers.length){
                                                            selectedStaffMembers[idx] = false;
                                                            idx++;
                                                          }
                                                        }
                                                        else{
                                                          int idx = 1;
                                                          while(idx < selectedStaffMembers.length){
                                                            selectedStaffMembers[idx] = true;
                                                            idx++;
                                                          }
                                                        }
                                                      }
                                                      else{
                                                        selectedStaffMembers[0] = false;
                                                      }

                                                      selectedStaffMembers[index] = !selectedStaffMembers[index];

                                                      int idx = 1;
                                                      bool allSelected = true;
                                                      while(idx < selectedStaffMembers.length){

                                                        if(selectedStaffMembers[idx] == false){
                                                          allSelected = false;
                                                          break;
                                                        }
                                                        idx++;
                                                      }

                                                      if(allSelected){
                                                        selectedStaffMembers[0] = true;
                                                      }

                                                    });
                                                  },
                                                ),
                                                title: ListTile(
                                                  title: Text(staffMembers[index]),
                                                  subtitle: Text(staffMembersRoles[index]),
                                                ),
                                              );
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),



                                SizedBox(height: 0,),
                                Text("Duration", style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),),
                                SizedBox(height: 10,),
                                Container(
                                  width: 200,
                                  height: 100,
                                  child: Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 1.0),
                                        ),
                                        width: 80,
                                        child: DropdownButton<String>(
                                          value: selectedHour,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          //style: const TextStyle(color: Colors.deepPurple),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedHour = newValue!;
                                            });
                                          },
                                          items: <String>['','0h','1h','2h','3h','4h','5h','6h','7h'].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 1.0),
                                        ),
                                        width: 80,
                                        child: DropdownButton<String>(
                                          value: selectedMinute,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          //style: const TextStyle(color: Colors.deepPurple),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedMinute = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            '',
                                            '0min',
                                            '5min',
                                            '10min',
                                            '15min',
                                            '30min',
                                          ].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10,),


                                Container(
                                  width: 300,
                                  height: 300,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10,),

                                      SizedBox(height: 10,),
                                      Text("Minute Gap", style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 10,),
                                      serviceLinked?Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black, width: 1.0),
                                        ),
                                        width: 180,
                                        child: DropdownButton<String>(
                                          value: minuteGap,
                                          icon: const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          //style: const TextStyle(color: Colors.deepPurple),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              minuteGap = newValue!;
                                            });
                                          },
                                          items: ['', '5', '10', '15', '30', '60'].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ):Container(),


                                      SizedBox(height: 30,),

                                      Text("Max bookings per time slot", style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: TextButton(
                                              onPressed: (){
                                                if(numberOfBookings > 1){
                                                  setState(() {
                                                    numberOfBookings--;
                                                  });
                                                }
                                              },
                                              child: Icon(Icons.remove,color: Colors.white,),
                                            ),
                                          ),
                                          SizedBox(width: 20,),
                                          Text('$numberOfBookings'),
                                          SizedBox(width: 20,),
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: TextButton(
                                              onPressed: (){
                                                setState(() {
                                                  numberOfBookings++;
                                                });
                                              },
                                              child: Icon(Icons.add,color: Colors.white,),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 10,),

                                Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {

                                      isError = false;

                                      // IF PACKAGE NAME IS NOT EMPTY AND MINUTE GAP IS VALID
                                      if(packageNameController.text.isNotEmpty && minuteGap != ''){

                                        String price = priceController.text;
                                        int priceIndex = 0;

                                        // CHECKS IF PRICE IS WRITTEN CORRECTLY
                                        while(priceIndex < price.length){
                                          int idx = 0;
                                          bool numberFound = false;
                                          while(idx <= 9){
                                            if(price[priceIndex] == '$idx'){
                                              numberFound = true;
                                            }
                                            idx++;
                                          }
                                          if(!numberFound){
                                            setState(() {
                                              isError = true;
                                            });
                                            break;
                                          }
                                          priceIndex++;
                                        }



                                        // IF THERE IS NO ERROR, THEN ADD NEW PACKAGE TO DATABASE
                                        if(!isError) {

                                          int serviceIndex = 0;
                                          while(serviceIndex < services.length){

                                            if(selectedServices[serviceIndex]){
                                              servicesInPackage.add(services[serviceIndex]);
                                            }

                                            serviceIndex++;
                                          }

                                          int packageIndex = snapshot.data['$currentShopIndex']['packages-amount']+1;

                                          await databaseService.addPackage(
                                            selectedCategory,
                                            currentShopIndex,
                                            packageIndex,
                                            packageNameController.text,
                                            servicesInPackage,
                                            selectedHour,
                                            selectedMinute,
                                            priceController.text,
                                            int.parse(minuteGap),
                                            numberOfBookings,
                                            staffMembersForPackage.isEmpty?true:false,
                                          );


                                          int staffIndex = 1;
                                          while(staffIndex < staffMembers.length){

                                            if(selectedStaffMembers[staffIndex]){

                                              await databaseService.addStaffMemberPackage(
                                                  selectedCategory,
                                                  currentShopIndex,
                                                  staffIndex,
                                                  snapshot.data['$currentShopIndex']['staff-members']['$staffIndex']['member-packages-amount'],
                                                  packageNameController.text,
                                              );

                                            }

                                            staffIndex++;
                                          }


                                          Navigator.pushNamed(context, '/POS');
                                        }

                                      }
                                      // IF PACKAGE NAME IS EMPTY AND MINUTE GAP IS NOT VALID, THEN THERE IS AN ERROR
                                      else{
                                        setState(() {
                                          isError = true;
                                        });
                                      }
                                    },
                                    child: Text("Add Package",style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              return const Text("Please wait");
            },

          ),
        ),
      ),
    );
  }

  Widget showError(){
    if(isError){
      return Text("There was an error with one of your inputs, please try again", style: TextStyle(
        color: Colors.red,
      ),);
    }
    else{
      return Container();
    }
  }


}
