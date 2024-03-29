import 'package:flutter/material.dart';
import 'package:servnn_client_side/models/service.dart';

import '../constants.dart';


class ServiceDetails extends StatefulWidget {
  const ServiceDetails({Key? key}) : super(key: key);

  @override
  _ServiceDetailsState createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {

  TextEditingController serviceTitleController = TextEditingController();
  TextEditingController servicePriceController = TextEditingController();
  String hours = '0h';
  String minutes = '0min';

  String gap = "15";

  int numberOfBookings = 1;

  bool membersOnly = false;
  bool requiresConfirmation = false;

  bool both = true;
  bool credit = false;
  bool cash = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: true,
        title: Text("Service details"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/login');
          }, icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          width: 1500,
          height: 1200,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Card(
                elevation: 2.0,
                child: Container(
                  width: 450,
                  height: 1000,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
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
                      SizedBox(height: 30,),

                      Text("Max bookings per time slot", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),

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

                      SizedBox(height: 30,),
                      Text("Service duration", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          SizedBox(width: 100,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1.0),
                            ),
                            width: 100,
                            child: DropdownButton<String>(
                              value: hours,
                              //icon: const Icon(Icons.arrow_downward),
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
                              //icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              //style: const TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  minutes = newValue!;
                                });
                              },
                              items: <String>['0min','5min','10min','15min','30min','60min']
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

                      SizedBox(height: 20,),

                      Text("Accepted Payment Methods", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),

                      SizedBox(height: 10,),


                      ListTile(
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


                      SizedBox(height: 40,),

                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            Service newService = Service(
                              hours: hours,
                              minutes: minutes,
                              title: serviceTitleController.text,
                              price: servicePriceController.text,
                              maxBookings: numberOfBookings,
                              gap: int.parse(gap),
                              cash: cash,
                              credit: credit,
                              both: both,
                              membersOnly: membersOnly,
                              requiresConfirmation: requiresConfirmation,

                            );

                            setState(() {
                              services.add(newService);
                            });

                            Navigator.pushNamed(context, '/adding-services');

                          },
                          child: Text("Save Service", style: const TextStyle(
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
        ),
      ),
    );
  }
}
