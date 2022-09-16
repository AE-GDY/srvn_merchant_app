import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/models/service.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';


class addService extends StatefulWidget {
  const addService({Key? key}) : super(key: key);

  @override
  _addServiceState createState() => _addServiceState();
}

class _addServiceState extends State<addService> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  bool initialEdit = true;

  TextEditingController serviceTitleController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();
  TextEditingController serviceMaxTimingAmountController = TextEditingController();

  String hours = '0h';
  String minutes = '0min';

  int minuteGap = 15;
  int numberOfBookings = 1;

  List<bool> staffSelected = [];

  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Service details"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: FutureBuilder(
          future: categoryData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return const Text("There is an error");
              }
              else if(snapshot.hasData){

                if(initialEdit){
                  staffSelected = [];

                  int staffIndex = 0;
                  while(staffIndex < snapshot.data['$currentShopIndex']['staff-members-amount']){

                    staffSelected.add(false);

                    staffIndex++;
                  }

                  initialEdit = false;

                }


                return Center(
                  child: Container(
                    width: 1000,
                    height: 1100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        Container(
                          width: 500,
                          height: 900,
                          child: Card(
                            elevation: 2.0,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: serviceTitleController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Service Name',
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      TextField(
                                        controller: servicePriceController,
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Service Price',
                                        ),
                                      ),
                                      SizedBox(height: 20,),

                                      Text("Max bookings per time slot", style: TextStyle(
                                        fontSize: 20,
                                      ),),
                                    ],
                                  ),
                                ),

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
                                        onPressed: () {
                                          if (numberOfBookings > 1) {
                                            setState(() {
                                              numberOfBookings--;
                                            });
                                          }
                                        },
                                        child: Icon(Icons.remove, color: Colors.white,),
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
                                        onPressed: () {
                                          setState(() {
                                            numberOfBookings++;
                                          });
                                        },
                                        child: Icon(Icons.add, color: Colors.white,),
                                      ),
                                    ),

                                  ],
                                ),

                                SizedBox(height: 30,),

                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Minute Gap", style: TextStyle(
                                    fontSize: 20,
                                  ),),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, width: 1.0),
                                  ),
                                  child: DropdownButton<String>(
                                    value: '$minuteGap',
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    //style: const TextStyle(color: Colors.deepPurple),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        minuteGap = int.parse(newValue!);
                                      });
                                    },
                                    items: <String>[
                                      '5',
                                      '10',
                                      '15',
                                      '30',
                                      '60',
                                    ]
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(height: 30,),

                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Service duration", style: TextStyle(
                                    fontSize: 20,
                                  ),),
                                ),
                                SizedBox(height: 10,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black, width: 1.0),
                                      ),
                                      width: 100,
                                      child: DropdownButton<String>(
                                        value: hours,
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        //style: const TextStyle(color: Colors.deepPurple),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            hours = newValue!;
                                          });
                                        },
                                        items: <String>['0h', '1h', '2h', '3h']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(width: 40,),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black, width: 1.0),
                                      ),
                                      width: 100,
                                      child: DropdownButton<String>(
                                        value: minutes,
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        //style: const TextStyle(color: Colors.deepPurple),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            minutes = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          '0min',
                                          '15min',
                                          '30min',
                                          '60min'
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

                                SizedBox(height: 20,),

                                Text('Staff Members to perform this service', style: TextStyle(
                                  fontSize: 18,
                                ),),

                                SizedBox(height: 20,),

                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                      itemCount: snapshot.data['$currentShopIndex']['staff-members-amount'],
                                      itemBuilder: (context,index){

                                        if(index != 0){
                                          return ListTile(
                                            leading: VerticalDivider(color: Colors.blue,),
                                            title: Text(snapshot.data['$currentShopIndex']['staff-members']['$index']['member-name']),
                                            subtitle: Text(snapshot.data['$currentShopIndex']['staff-members']['$index']['member-role']),
                                            trailing: Container(
                                              width: 110,
                                              height: 50,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: staffSelected[index]?Colors.green:Colors.grey,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          staffSelected[index] = true;
                                                        });
                                                      },
                                                      child: Icon(Icons.check,color: Colors.white,),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10,),
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      color: !staffSelected[index]?Colors.red:Colors.grey,
                                                      borderRadius: BorderRadius.circular(30),
                                                    ),
                                                    child: TextButton(
                                                      onPressed: (){
                                                        setState(() {
                                                          staffSelected[index] = false;
                                                        });
                                                      },
                                                      child: Icon(Icons.close,color: Colors.white,),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                        else{
                                          return Container();
                                        }
                                      }),
                                ),

                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 20,),




                        SizedBox(height: 40,),
                        Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextButton(
                            onPressed: () async {

                              int newServiceIndex = snapshot.data['$currentShopIndex']['services-amount'];

                              await databaseService.addNewService(
                                selectedCategory,
                                currentShopIndex,
                                snapshot.data['$currentShopIndex']['services-amount'],
                                serviceTitleController.text,
                                hours,
                                minutes,
                                servicePriceController.text,
                                minuteGap,
                                numberOfBookings,
                              );

                              int staffIndex = 0;
                              int serviceIndex = 0;
                              while(staffIndex < snapshot.data['$currentShopIndex']['staff-members-amount']){

                                if(staffSelected[staffIndex]){
                                  await databaseService.editStaffMemberServiceInfo(
                                      selectedCategory,
                                      currentShopIndex,
                                      staffIndex,
                                      serviceTitleController.text,
                                      serviceIndex
                                  );
                                  serviceIndex++;
                                }

                                staffIndex++;
                              }


                              Navigator.pushNamed(context, '/services-page');
                            },
                            child: Text("Add Service", style: const TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            return const Text("Please wait");
          },

        ),
      ),
    );
  }


}