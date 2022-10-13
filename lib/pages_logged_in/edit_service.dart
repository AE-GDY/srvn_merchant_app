import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/pages_logged_in/services_page.dart';

import '../constants.dart';
import '../services/database.dart';


class EditService extends StatefulWidget {
  const EditService({Key? key}) : super(key: key);

  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }


  String gap = '15';
  TextEditingController serviceTitleController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();

  bool membersOnly = false;
  bool requiresConfirmation = false;

  String hours = '0h';
  String minutes = '0min';

  bool both = true;
  bool credit = false;
  bool cash = false;

  DatabaseService databaseService = DatabaseService();


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
          height: MediaQuery.of(context).size.height * 2,
          child: Column(
            children: [

              SizedBox(height: 10,),

              Center(
                child: Container(
                  width: 600,
                  height: 900,
                  child: Card(
                    elevation: 1.0,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Container(
                          alignment: Alignment.center,
                          child: ListTile(
                            leading: Switch(
                              activeColor: Colors.deepPurple,
                              value: membersOnly,
                              onChanged: (bool value) {
                                setState(() {
                                  membersOnly = !membersOnly;
                                });
                              },

                            ),
                            title: Text('Members Only', style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          child: ListTile(
                            leading: Switch(
                              activeColor: Colors.deepPurple,
                              value: requiresConfirmation,
                              onChanged: (bool value) {
                                setState(() {
                                  requiresConfirmation = !requiresConfirmation;
                                });
                              },

                            ),
                            title: Text('Requires Confirmation', style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: serviceTitleController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Service Name',
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: servicePriceController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Service Price',
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Align(
                          alignment: Alignment.center,
                          child: Text("Service duration", style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            SizedBox(width: 170,),
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
                                items: <String>['0min','15min', '30min', '45min', '60min']
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

                        SizedBox(height: 30,),

                        Text("Gap Between Time Slots (minutes)", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.0),
                          ),
                          width: 100,
                          height: 50,
                          child: DropdownButton<String>(
                            value: gap,
                            //icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            //style: const TextStyle(color: Colors.deepPurple),
                            onChanged: (String? newValue) {
                              setState(() {
                                gap = newValue!;
                              });
                            },
                            items: <String>['5','10','15','30','60']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 30,),

                        Text("Accepted Payment Methods", style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),),

                        SizedBox(height: 10,),


                        Center(
                          child: ListTile(
                            leading: Switch(
                              activeColor: Colors.deepPurple,
                              onChanged: (bool value) {
                                setState(() {
                                  both = !both;

                                  credit = false;
                                  cash = false;

                                });
                              },
                              value: both,

                            ),
                            title: Text("Credit Card and Cash"),
                          ),
                        ),

                        SizedBox(height: 5,),

                        ListTile(
                          leading: Switch(
                            activeColor: Colors.deepPurple,
                            onChanged: (bool value) {
                              setState(() {
                                credit = !credit;
                                both = false;
                              });
                            },
                            value: credit,

                          ),
                          title: Text("Credit Card Only"),
                        ),

                        SizedBox(height: 5,),


                        ListTile(
                          leading: Switch(
                            activeColor: Colors.deepPurple,
                            onChanged: (bool value) {
                              setState(() {
                                cash = !cash;
                                both = false;
                              });
                            },
                            value: cash,

                          ),
                          title: Text("Cash Only"),
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
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextButton(
                                    onPressed: () async{
                                      await databaseService.editService(
                                        selectedCategory,
                                        currentShopIndex,
                                        selectedIdx,
                                        serviceTitleController.text,
                                        hours,
                                        minutes,
                                        servicePriceController.text,
                                        both,
                                        cash,
                                        credit,
                                        int.parse(gap),
                                        membersOnly,
                                        requiresConfirmation,
                                      );


                                      Navigator.pushNamed(context, '/services-page');

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
