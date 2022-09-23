import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/services/database.dart';



class AddMembership extends StatefulWidget {
  const AddMembership({Key? key}) : super(key: key);

  @override
  _AddMembershipState createState() => _AddMembershipState();
}

class _AddMembershipState extends State<AddMembership> {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  List<bool> servicesSelected = [];
  List<bool> discountedServices = [];
  List<int> discountedServicesPercentages = [];
  List<String> servicesToSelectFrom = [];


  bool initialEdit = true;

  int membershipDuration = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Membership",style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
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
                  int serviceIndex = 0;

                  servicesToSelectFrom.add('All');
                  servicesSelected.add(false);
                  discountedServices.add(false);
                  discountedServicesPercentages.add(0);

                  while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                    discountedServices.add(false);
                    servicesSelected.add(false);
                    servicesToSelectFrom.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']);
                    discountedServicesPercentages.add(0);
                    serviceIndex++;
                  }

                  initialEdit = false;
                }


                return Center(
                  child: Card(
                    elevation: 2.0,
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height + 400,
                      child: Column(
                        children: [

                          // Membership name

                          Text('Membership Information', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),

                          SizedBox(height: 10,),

                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              labelText: 'Membership name',
                            ),
                          ),


                          SizedBox(height: 5,),
                          // Membership price
                          TextField(
                            controller: priceController,
                            decoration: InputDecoration(
                              labelText: 'Membership price',
                            ),
                          ),

                          SizedBox(height: 10,),

                          Text('Services Included', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),

                          SizedBox(height: 10,),


                          // Membership services
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 250,
                            child: ListView.builder(
                                itemCount: servicesToSelectFrom.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      leading: Switch(
                                        value: servicesSelected[index],
                                        onChanged: (bool value) {
                                          setState(() {


                                            if(index == 0){

                                              int serviceIndex = 0;

                                              if(servicesSelected[index] == false){
                                                while(serviceIndex < servicesSelected.length){
                                                  servicesSelected[serviceIndex] = true;
                                                  serviceIndex++;
                                                }
                                              }
                                              else{
                                                while(serviceIndex < servicesSelected.length){
                                                  servicesSelected[serviceIndex] = false;
                                                  serviceIndex++;
                                                }
                                              }
                                            }
                                            else{

                                              servicesSelected[index] = !servicesSelected[index];

                                              int serviceIndex = 1;

                                              bool allSelected = true;

                                              while(serviceIndex < servicesSelected.length){
                                                if(servicesSelected[serviceIndex] == false){
                                                  allSelected = false;
                                                  break;
                                                }
                                                serviceIndex++;
                                              }

                                              if(allSelected){
                                                servicesSelected[0] = true;
                                              }
                                              else{
                                                servicesSelected[0] = false;
                                              }

                                            }

                                          });
                                        },

                                      ),
                                      title: Text(servicesToSelectFrom[index]),
                                    ),
                                  );
                                }
                                )
                          ),


                          SizedBox(height: 20,),



                          // Discounted Services

                          Text('Discounted Services', style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),),

                          SizedBox(height: 10,),


                          // Membership services
                          Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 250,
                              child: ListView.builder(
                                  itemCount: servicesToSelectFrom.length,
                                  itemBuilder: (context,index){
                                    return Container(
                                      margin: EdgeInsets.all(10),
                                      child: ListTile(
                                        leading: Switch(
                                          value: discountedServices[index],
                                          onChanged: (bool value) {
                                            setState(() {


                                              if(index == 0){

                                                int serviceIndex = 0;

                                                if(discountedServices[index] == false){
                                                  while(serviceIndex < discountedServices.length){
                                                    discountedServices[serviceIndex] = true;
                                                    serviceIndex++;
                                                  }
                                                }
                                                else{
                                                  while(serviceIndex < discountedServices.length){
                                                    discountedServices[serviceIndex] = false;
                                                    serviceIndex++;
                                                  }
                                                }
                                              }
                                              else{

                                                discountedServices[index] = !discountedServices[index];

                                                int serviceIndex = 1;

                                                bool allSelected = true;

                                                while(serviceIndex < discountedServices.length){
                                                  if(discountedServices[serviceIndex] == false){
                                                    allSelected = false;
                                                    break;
                                                  }
                                                  serviceIndex++;
                                                }

                                                if(allSelected){
                                                  discountedServices[0] = true;
                                                }
                                                else{
                                                  discountedServices[0] = false;
                                                }

                                              }

                                            });
                                          },

                                        ),
                                        title: Text(servicesToSelectFrom[index]),
                                        trailing: (index != 0)?Container(
                                        width: 200,
                                        height: 50,
                                        child: Row(
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
                                                    discountedServicesPercentages[index]--;
                                                  });
                                                },
                                                icon: Icon(Icons.remove,color: Colors.white,),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            Text("${discountedServicesPercentages[index]} %"),
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
                                                    discountedServicesPercentages[index]++;
                                                  });
                                                },
                                                icon: Icon(Icons.add,color: Colors.white,),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ):Container(width: 200, height: 50,),
                                      ),
                                    );
                                  }
                              )
                          ),


                          SizedBox(height: 30,),



                          // Membership duration

                          Text('Duration', style: TextStyle(
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
                                child: IconButton(
                                  onPressed: (){
                                    setState(() {
                                      membershipDuration--;
                                    });
                                  },
                                  icon: Icon(Icons.remove,color: Colors.white,),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Text("$membershipDuration month/s"),
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
                                      membershipDuration++;
                                    });
                                  },
                                  icon: Icon(Icons.add,color: Colors.white,),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40,),

                          Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.deepPurple,
                            ),

                            child: TextButton(
                              onPressed: () async {


                                List<String> servicesToAddToDatabase = [];
                                List<String> discountedServiceToAddToDatabase = [];
                                List<int> discounts = [];

                                int serviceIndex = 1;
                                while(serviceIndex < servicesSelected.length){

                                  if(servicesSelected[serviceIndex]){
                                    servicesToAddToDatabase.add(servicesToSelectFrom[serviceIndex]);
                                  }

                                  if(discountedServices[serviceIndex]){
                                    discountedServiceToAddToDatabase.add(servicesToSelectFrom[serviceIndex]);
                                    discounts.add(discountedServicesPercentages[serviceIndex]);
                                  }

                                  serviceIndex++;

                                }

                                await DatabaseService().addMembership(
                                    selectedCategory,
                                    currentShopIndex,
                                    snapshot.data['$currentShopIndex']['memberships-amount']+1,
                                    nameController.text,
                                    priceController.text,
                                    servicesToAddToDatabase,
                                    discountedServiceToAddToDatabase,
                                    discounts,
                                    membershipDuration
                                );

                                Navigator.pushNamed(context, '/POS');

                              },
                              child: Text('Add Membership', style: TextStyle(
                                color: Colors.white,
                              ),),
                            ),

                          ),


                        ],
                      ),
                    ),
                  ),
                );
              }
            }
            return (const Center(
              child: CircularProgressIndicator(),
            ));
          },

        ),
      ),

    );
  }
}
