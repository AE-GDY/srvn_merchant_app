import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  List<String> servicesSelected = [];
  String selectedService = "";
  String selectedHour = "";
  String selectedMinute = "";
  String minuteGap = "";

  bool isError = false;

  // KEEPS TRACK WHETHER PACKAGE WILL REQUIRE STAFF MEMBER OR NOT
  bool serviceLinked = true;


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
          child: Container(
            width: 1000,
            height: 700,
            child: Column(
              children: [
                showError(),
                SizedBox(height: 10,),
                Container(
                  width: 1000,
                  height: 600,
                  margin: EdgeInsets.all(10),
                  child: Card(
                    elevation: 5.0,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: Container(
                            width: 200,
                            height: 500,
                            alignment: Alignment.topLeft,
                            child: Column(
                              children: [
                                SizedBox(height: 20,),
                                TextField(
                                  controller: packageNameController,
                                  decoration: InputDecoration(
                                    labelText: "Package Name",
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text("Services Selected"),
                                Container(
                                  width: 200,
                                  height: 400,
                                  child: ListView.builder(
                                      itemCount: servicesSelected.length,
                                      itemBuilder: (context,index){
                                        return ListTile(
                                          leading: VerticalDivider(
                                            thickness: 1.0,
                                            color: Colors.blue,
                                          ),
                                          title: Text(servicesSelected[index]),
                                        );
                                      }
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: 10,
                          left: 300,
                          child: Container(
                            width: 300,
                            height: 500,
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                Text("Select Service"),
                                SizedBox(height: 10,),
                                FutureBuilder(
                                  future: categoryData(),
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                    if(snapshot.connectionState == ConnectionState.done){
                                      if(snapshot.hasError){
                                        return const Text("There is an error");
                                      }
                                      else if(snapshot.hasData){

                                        List<String> services = [];

                                        services.add('');

                                        int serviceIndex = 0;
                                        while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                                          services.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']);
                                          serviceIndex++;
                                        }

                                        return Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black, width: 1.0),
                                          ),
                                          width: 180,
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
                                            items: services.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      }
                                    }
                                    return const Text("Please wait");
                                  },

                                ),
                                SizedBox(height: 20,),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  width: 200,
                                  height: 50,
                                  child: TextButton(
                                    onPressed: (){

                                      setState(() {
                                        if(selectedService != ''){
                                          int idx = 0;
                                          bool alreadyExists = false;
                                          while(idx < servicesSelected.length){
                                            if (selectedService == servicesSelected[idx]){
                                              alreadyExists = true;
                                              break;
                                            }
                                            idx++;
                                          }

                                          if(!alreadyExists){
                                            servicesSelected.add(selectedService);
                                            selectedService = "";
                                          }
                                          else{
                                            isError = true;
                                          }
                                        }
                                        else{
                                          isError = true;
                                        }
                                      });

                                    },
                                    child: Text("Add Service", style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),

                                Text("Duration"),
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
                                            '20min',
                                            '25min',
                                            '30min',
                                            '35min',
                                            '40min',
                                            '45min',
                                            '50min',
                                            '55min',
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

                                TextField(
                                  controller: priceController,
                                  decoration: InputDecoration(
                                    labelText: "Package Price (EGP)",
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),


                        Positioned(
                          top: 10,
                          left: 620,
                          child: Container(
                            width: 300,
                            height: 500,
                            alignment: Alignment.topRight,
                            child: Column(
                              children: [
                                SizedBox(height: 10,),

                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: serviceLinked?Colors.green:Colors.grey,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: (){
                                          setState(() {
                                            serviceLinked = true;
                                          });
                                        },
                                        child: Text("Service Linked", style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Container(
                                      width: 150,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: serviceLinked?Colors.grey:Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextButton(
                                        onPressed: (){
                                          setState(() {
                                            serviceLinked = false;
                                          });
                                        },
                                        child: Text("Staff Linked", style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                serviceLinked?Text("Minute Gap"):Container(),
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
                                    items: ['',
                                      '0',
                                      '5',
                                      '10',
                                      '15',
                                      '20',
                                      '25',
                                      '30',
                                      '35',
                                      '40',
                                      '45',
                                      '50',
                                      '55',].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ):Container(),


                                SizedBox(height: 30,),

                                Text("Max Bookings Per Time Slot"),
                                SizedBox(height: 10,),
                                Container(
                                  width: 200,
                                  child: TextField(
                                    controller: maxController,
                                    decoration: InputDecoration(
                                      labelText: "Amount",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),

                        FutureBuilder(
                          future: categoryData(),
                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                            if(snapshot.connectionState == ConnectionState.done){
                              if(snapshot.hasError){
                                return const Text("There is an error");
                              }
                              else if(snapshot.hasData){
                                return Positioned(
                                  bottom: 10,
                                  left: 300,
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {

                                        isError = false;

                                        // IF SERVICE LINKED, THEN THE MINUTE GAP DEPENDS ON
                                        // THE STAFF MEMBER, SO AS A DEFAULT WILL BE EQUAL TO 0
                                        if(serviceLinked == false){
                                          minuteGap = '${0}';
                                        }

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

                                          // CHECKS IF MAX AMOUNT PER BOOKING IS VALID
                                          int maxIndex = 0;
                                          String maxPerSlot = maxController.text;
                                          while(maxIndex < maxPerSlot.length){
                                            int idx = 0;
                                            bool numberFound = false;
                                            while(idx <= 9){
                                              if(maxPerSlot[maxIndex] == '$idx'){
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

                                            maxIndex++;
                                          }



                                          // IF THERE IS NO ERROR, THEN ADD NEW PACKAGE TO DATABASE
                                          if(!isError) {

                                            int packageIndex = snapshot.data['$currentShopIndex']['packages-amount']+1;

                                            await databaseService.addPackage(
                                                selectedCategory,
                                                currentShopIndex,
                                                packageIndex,
                                                packageNameController.text,
                                                servicesSelected,
                                                selectedHour,
                                                selectedMinute,
                                                priceController.text,
                                                int.parse(minuteGap),
                                                maxPerSlot,
                                                serviceLinked,
                                            );


                                            // IF PACKAGE IS SERVICE LINKED, THEN TIMING DATA FOR THIS SERVICE NEEDS TO BE SPECIFIC
                                            // ELSE, NO NEED TO DO ANYTHING SINCE TIMING DATA WILL BE ACCESSED FROM THE STAFF MEMBER
                                            if(serviceLinked){
                                              // SHOPS MINUTE GAP
                                              int shopMinuteGap = snapshot.data['$currentShopIndex']['minute-gap'];

                                              // THIS IS THE AMOUNT TO SKIP FROM THE BUSINESS HOURS
                                              // THIS WILL BE USED TO STORE THE DESIRED TIMING DATA FOR THE PACKAGE
                                              int amountToSkip = int.parse('${int.parse(minuteGap) / shopMinuteGap}');

                                              // LOOPS THROUGH ALL WEEKDAYS TO STORE TIMING DATA FOR EACH WEEKDAY
                                              int weekDayIndex = 0;
                                              while(weekDayIndex < weekDays.length){

                                                // LOOPS THROUGH BUSINESS HOURS FOR EACH DAY
                                                int timeIndex = 0;

                                                // KEEPS TRACK OF TIMING INDEX IN THE PACKAGE DATA SO THAT INDEXES ARE NOT SKIPPED
                                                // AND STORED CORRECTLY IN DATABASE
                                                int packageTimeIndex = 0;

                                                int currentDayTimingAmount = int.parse(snapshot.data['$currentShopIndex']['business-hours'][weekDays[weekDayIndex]]['${-1}']);

                                                while(timeIndex < currentDayTimingAmount){

                                                  // STORES THE CURRENT TIME IN THE PACKAGE DATA IN DATABASE

                                                  String currentTime = snapshot.data['$currentShopIndex']['business-hours'][weekDays[weekDayIndex]]['$timeIndex'];

                                                  await databaseService.addPackageTiming(
                                                      selectedCategory,
                                                      currentShopIndex,
                                                      packageIndex,
                                                      weekDays[weekDayIndex],
                                                      packageTimeIndex,
                                                      currentTime
                                                  );

                                                  // ADDS PACKAGE TIME INDEX BY ONE
                                                  packageTimeIndex++;

                                                  // ADDS TIME INDEX BY THE AMOUNT TO SKIP TO GET THE NEXT TIME DEPENDING ON THE MINUTE GAP
                                                  timeIndex += amountToSkip;
                                                }

                                                // ADDS THE AMOUNT OF TIMINGS FOR CURRENT DAY IN INDEX -1
                                                await databaseService.addPackageTiming(
                                                    selectedCategory,
                                                    currentShopIndex,
                                                    packageIndex,
                                                    weekDays[weekDayIndex],
                                                    -1,
                                                    '$packageTimeIndex'
                                                );

                                                weekDayIndex++;
                                              }
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
              ],
            ),
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
