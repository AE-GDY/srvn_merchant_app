import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/services/database.dart';

import 'active-promotions.dart';


class EditPromotion extends StatefulWidget {
  const EditPromotion({Key? key}) : super(key: key);

  @override
  _EditPromotionState createState() => _EditPromotionState();
}

class _EditPromotionState extends State<EditPromotion> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  int discount = 10;
  int bookingWindow = 2;
  String salePeriod = "Today Only";

  String startDay = "";
  String endDay = "";
  String startYear = "";
  String endYear = "";
  String startMonth = "";
  String endMonth = "";

  DatabaseService databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Promotion',style: TextStyle(
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
              Card(
                elevation: 5.0,
                child: Container(
                  width: 600,
                  height: 600,
                  child: buildBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildBody(){


    if(promotionType == "Flash Promotions"){
      return Container(
        width: 400,
        height: 500,
        child: Column(
          children: [

            SizedBox(height: 10,),

            Text("Flash Sale Discount"),

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
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount--;
                      });
                    },
                    icon: Icon(Icons.remove,color: Colors.white,),
                  ),
                ),
                SizedBox(width: 10,),
                Text("$discount%"),
                SizedBox(width: 10,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount++;
                      });
                    },
                    icon: Icon(Icons.add,color: Colors.white,),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Text("Off The Service Price"),



            SizedBox(height: 10,),


            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              width: 200,
              child: DropdownButton<String>(
                value: salePeriod,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                //style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  setState(() {
                    salePeriod = newValue!;
                  });
                },
                items: <String>[
                  'Today Only',
                  '2 days',
                  '3 days',
                  '7 days',
                  '14 days',
                  '30 days',
                  '45 days',
                  '60 days',
                  '90 days',
                ]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            Text("Booking date(s) to quality"),
            SizedBox(height: 10,),
            Text("Start Date"),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  width: 100,
                  child: DropdownButton<String>(
                    value: startDay,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        startDay = newValue!;
                      });
                    },
                    items: <String>[
                      '', '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15'
                      ,'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
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
                  width: 100,
                  child: DropdownButton<String>(
                    value: startMonth,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        startMonth = newValue!;
                      });
                    },
                    items: <String>[
                      '',  'JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
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
                  width: 100,
                  child: DropdownButton<String>(
                    value: startYear,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        startYear = newValue!;
                      });
                    },
                    items: <String>[
                      '', '2022','2023','2024','2025','2026'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(width: 10,),


              ],
            ),


            SizedBox(height: 10,),

            Text("End Date"),

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
                    value: endDay,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        endDay = newValue!;
                      });
                    },
                    items: <String>[
                      '', '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15'
                      ,'16','17','18','19','20','21','22','23','24','25','26','27','28','29','30',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
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
                  width: 100,
                  child: DropdownButton<String>(
                    value: endMonth,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        endMonth = newValue!;
                      });
                    },
                    items: <String>[
                      '',  'JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC',
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
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
                  width: 100,
                  child: DropdownButton<String>(
                    value: endYear,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    //style: const TextStyle(color: Colors.deepPurple),
                    onChanged: (String? newValue) {
                      setState(() {
                        endYear = newValue!;
                      });
                    },
                    items: <String>[
                      '',    '2022','2023','2024','2025','2026'
                    ]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(width: 10,),
              ],
            ),

            SizedBox(height: 80,),

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
                        onPressed: () async {

                          await databaseService.editFlashPromotion(
                              selectedCategory,
                              currentShopIndex,
                              promotionServiceIndexes[promotionToBeEdited],
                              promotionToBeEdited,
                              salePeriod,
                              '$discount',
                              promotionType,
                              startDay,
                              endDay,
                              startMonth,
                              endMonth,
                              startYear,
                              endYear
                          );

                          Navigator.pushNamed(context, '/active-promotions');

                        },
                        child: Text("Edit Promotion", style: TextStyle(
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
      );
    }
    else if(promotionType == "Last Minute Promotions"){
      return Container(
        width: 400,
        height: 600,
        child: Column(
          children: [

            SizedBox(height: 10,),
            Text("Last Minute Discount"),
            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount--;
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 10,),
                Text("$discount%"),
                SizedBox(width: 10,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        discount++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10,),

            Text("Off The Service"),

            SizedBox(height: 10,),

            Text("Booking Window"),

            SizedBox(height: 10,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        bookingWindow--;
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 10,),
                Text("$bookingWindow hours"),
                SizedBox(width: 10,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        bookingWindow++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ],
            ),

            SizedBox(height: 80,),

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
                        onPressed: () async {

                          // PROBLEM IS HERE

                          if(promotionType == "Flash Promotions"){
                            await databaseService.editFlashPromotion(
                                selectedCategory,
                                currentShopIndex,
                                promotionServiceIndexes[promotionToBeEdited],
                                promotionToBeEdited,
                                salePeriod,
                                '$discount',
                                promotionType,
                                startDay,
                                endDay,
                                startMonth,
                                endMonth,
                                startYear,
                                endYear
                            );
                          }
                          else{
                            await databaseService.editLastMinutePromotion(
                                selectedCategory,
                                currentShopIndex,
                                promotionServiceIndexes[promotionToBeEdited],
                                promotionToBeEdited,
                                '$discount',
                                promotionType,
                                promotionBookingWindows[promotionToBeEdited]
                            );
                          }



                          Navigator.pushNamed(context, '/active-promotions');

                        },
                        child: Text("Edit Promotion", style: TextStyle(
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
      );
    }
    else{
      return Container();
    }



  }
}
