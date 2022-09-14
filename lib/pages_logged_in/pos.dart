import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/models/service.dart';
import 'package:servnn_client_side/services/database.dart';



class Pos extends StatefulWidget {
  const Pos({Key? key}) : super(key: key);

  @override
  _PosState createState() => _PosState();
}

class _PosState extends State<Pos> {


  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }


  DatabaseService databaseService = DatabaseService();

  String selectedInPos = 'Quick Sale';
  String selectedType = "New Sale";

  bool selectingClient = false;
  bool showClientNotSelected = false;






  String selectedTypeOfService = "Services";
  String selectedService = "";
  String selectedProduct = "";

  String hours = '0h';
  String minutes = '0min';

  TextEditingController customAmountController = TextEditingController();
  TextEditingController serviceDescriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();


  bool numberFound = false;
  bool displayError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 100,),
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
        title: Text("Checkout",style: TextStyle(
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
                return Container(
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
                                //title: Text("Statistics and Reports"),
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
                        top: 32,
                        left: 102,
                        child: Container(
                          width: 1095,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 350,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: selectedType=="New Sale"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      showClientNotSelected = false;
                                      selectedType = "New Sale";
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("New Sale", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "New Sale"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),

                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: selectedType=="Transactions"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      showClientNotSelected = false;
                                      selectedType = "Transactions";
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Transactions", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Transactions"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),

                                ),
                              ),
                              SizedBox(width: 50,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color:selectedType=="Invoices"?Colors.black:Colors.grey[100]!,width: 2.0),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    setState(() {
                                      showClientNotSelected = false;
                                      selectedType = "Invoices";
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Invoices", style: TextStyle(
                                        fontSize: 16,
                                        color: selectedType == "Invoices"?Colors.black:Colors.grey,
                                      ),),
                                    ],
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        top: 80,
                        left: 100,
                        child: Container(
                          width: 1100,
                          height: 500,
                          child: Card(
                            elevation: 3.0,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Card(
                                    elevation: 4.0,
                                    child: Container(
                                      width: 250,
                                      height: 480,
                                      child: Column(
                                        children: [
                                          SizedBox(height: 50,),
                                          ListTile(
                                            leading: buildLVerticalLine("Quick Sale"),
                                            title: Text("Quick Sale"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "Quick Sale";
                                              });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          ListTile(
                                            leading: buildLVerticalLine("To Be Charged"),
                                            title: Text("To Be Charged"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "To Be Charged";
                                              });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          ListTile(
                                            leading: buildLVerticalLine("Services"),
                                            title: Text("Services"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "Services";
                                              });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          ListTile(
                                            leading: buildLVerticalLine("Products"),
                                            title: Text("Products"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "Products";
                                              });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          ListTile(
                                            leading: buildLVerticalLine("Custom Amount"),
                                            title: Text("Custom Amount"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "Custom Amount";
                                              });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          ListTile(
                                            leading: buildLVerticalLine("Gift Cards"),
                                            title: Text("Gift Cards"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "Gift Cards";
                                              });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          ListTile(
                                            leading: buildLVerticalLine("Packages"),
                                            title: Text("Packages"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "Packages";
                                              });
                                            },
                                          ),
                                          SizedBox(height: 5,),
                                          ListTile(
                                            leading: buildLVerticalLine("Memberships"),
                                            title: Text("Memberships"),
                                            onTap: (){
                                              setState(() {
                                                showClientNotSelected = false;
                                                selectedInPos = "Memberships";
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 20,
                                  right: 20,
                                  child: Container(
                                    width: 360,
                                    height: 450,
                                    child: Card(
                                      elevation: 6.0,
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children:[
                                            SizedBox(height: 20,),
                                            buildCurrentClient(),
                                            buildCartEmpty(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 320,
                                  right: 0,
                                  child: Container(
                                    width: 150,
                                    height: 100,
                                    child: Column(
                                      children: [
                                        Text("Total", textAlign: TextAlign.end,),
                                        Text("$currentTotal EGP", style: TextStyle(
                                          fontSize: 25,
                                        ),),
                                      ],
                                    ),
                                  ),
                                ),

                                Positioned(
                                  top: 400,
                                  right: 100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: 200,
                                    height: 50,
                                    child: TextButton(
                                      onPressed: (){
                                        if(currentClient != ''){
                                          showClientNotSelected = false;
                                          Navigator.pushNamed(context, '/booking-screen');
                                        }
                                        else{
                                          setState(() {
                                            showClientNotSelected = true;
                                          });
                                        }
                                      },
                                      child: Text("Continue", style: TextStyle(
                                        color: Colors.white,
                                      ),),
                                    ),
                                  ),
                                ),


                                buildBody(snapshot),


                              ],
                            ),
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
    );
  }



  Widget buildLVerticalLine(String current){
    if(current == selectedInPos){
      return VerticalDivider(color: Colors.black,
        thickness: 2,);
    }
    else{
      return Container(width: 20,);
    }
  }

  Widget buildCartEmpty(){
    if(cart.isEmpty){
      return Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Text("Cart is Empty", style: TextStyle(
                fontSize: 20,
              ),),
              Text("Select items that you would like to add to the cart", style: TextStyle(
                fontSize: 13,
              ),),
            ],
          ),
        ),
      );
    }
    else{
      return Container(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(
                    ),
                    itemCount: cart.length,
                    itemBuilder: (context,index){
                      return Column(
                        children: [
                          SizedBox(height: 10,),
                          cart[index].type == 'Services'? Text("Service: ${cart[index].title}",style: TextStyle(
                            fontSize: 17,
                          ),):cart[index].type == 'Packages'?Text("Package: ${cart[index].title}",style: TextStyle(
                            fontSize: 17,
                          ),):Text("Product: ${cart[index].title}",style: TextStyle(
                            fontSize: 17,
                          ),),
                          SizedBox(height: 5,),
                          cart[index].type == 'Services'? Text("Duration: ${cart[index].duration}")
                              :cart[index].type == 'Packages'?Text("Duration: ${cart[index].duration}",style: TextStyle(
                          ),):Container(),
                          SizedBox(height: 5,),
                          Text("Price: ${cart[index].price} EGP"),
                          SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: (){
                                setState(() {
                                  currentTotal -= double.parse(cart[index].price);
                                  cart.remove(cart[index]);
                                  serviceBooked.remove(serviceBooked[index]);
                                  serviceDuration.remove(serviceDuration[index]);
                                  servicePrice.remove(servicePrice[index]);
                                });
                              },
                              child: Text("Remove item", style: TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                          ),
                          SizedBox(height: 15,),
                        ],
                      );
                    }),
              ),
              Divider(
                color: Colors.grey,
              ),
            ],
          ),
        );
    }
  }


  Widget buildBody(AsyncSnapshot<dynamic> snapshot){
    if(selectedInPos == "Quick Sale"){
      if(!selectingClient){
        return  Positioned(
          top: 50,
          left: 200,
          child: Container(
            width: 300,
            height: 400,
            child: Column(
              children: [
                Text("Popular items", style: TextStyle(
                  color: Colors.grey,
                ),),
              ],
            ),
          ),
        );
      }
      else{
        return Positioned(
          top: 50,
          left: 260,
          child: Container(
            width: 450,
            height: 420,
            child: FutureBuilder(
              future: categoryData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){

                    shopClients = [];
                    int clientIndex = 0;
                    while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                      shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                      clientIndex++;
                    }

                    print("CLIENT AMOUNT ${shopClients.length}");


                    if(shopClients.length > 0){
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Search for clients"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: shopClients.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          showClientNotSelected = false;
                                          selectingClient = false;
                                          currentClient = shopClients[index];
                                        });
                                      },
                                      leading: VerticalDivider(color: Colors.blue,
                                        thickness: 2,),
                                      title: Text(shopClients[index]),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Client list empty"),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                }
                return const Text("Please wait");
              },

            ),
          ),
        );
      }
    }
    else if(selectedInPos == "To Be Charged"){
      if(!selectingClient){
        return Positioned(
          top: 50,
          left: 270,
          child: Container(
            width: 420,
            height: 400,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Search for appointment"),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data['$currentShopIndex']['appointments']['appointment-amount'] + 1,
                      itemBuilder: (context,index){
                        if(snapshot.data['$currentShopIndex']['appointments']['$index']['appointment-status'] != 'incomplete'){
                          return Container();
                        }
                        else{
                          return Container(
                            height: 200,
                            margin: EdgeInsets.all(10),
                            child: Card(
                              elevation: 3.0,
                              child: Row(
                                children: [
                                  VerticalDivider(color: Colors.blue,
                                    thickness: 2,),
                                  SizedBox(width: 10,),
                                  Column(
                                    children: [
                                      Text("Client Name", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),),
                                      SizedBox(height: 5,),
                                      Text("${snapshot.data['$currentShopIndex']['appointments']['$index']['client-name']}"),
                                      SizedBox(height: 10,),
                                      Text("Service Provider", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),),
                                      SizedBox(height: 5,),
                                      Text("${snapshot.data['$currentShopIndex']['appointments']['$index']['member-name']}"),
                                      SizedBox(height: 10,),
                                      Text("Service Name", style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17
                                      ),),
                                      Text(" ${snapshot.data['$currentShopIndex']['appointments']['$index']['service-name']}"),

                                    ],
                                  ),
                                  SizedBox(width: 100,),
                                  Column(
                                    children: [
                                      SizedBox(height: 40,),
                                      Text("${snapshot.data['$currentShopIndex']['appointments']['$index']['service-price']} EGP",style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),),
                                      SizedBox(height: 20,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            setState(() {
                                              currentTransactionIndex = index;
                                            });

                                            Navigator.pushNamed(context, '/complete-transaction');
                                          },
                                          child: Text("Charge", style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: (){
                                            setState(() {
                                              currentTransactionIndex = index;
                                            });
                                            Navigator.pushNamed(context, '/complete-cancellation');
                                          },
                                          child: Text("Cancel", style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      }
      else{
        return Positioned(
          top: 50,
          left: 260,
          child: Container(
            width: 450,
            height: 420,
            child: FutureBuilder(
              future: categoryData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){

                    shopClients = [];
                    int clientIndex = 0;
                    while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                      shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                      clientIndex++;
                    }

                    print("CLIENT AMOUNT ${shopClients.length}");


                    if(shopClients.length > 0){
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Search for clients"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: shopClients.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          showClientNotSelected = false;
                                          selectingClient = false;
                                          currentClient = shopClients[index];
                                        });
                                      },
                                      leading: VerticalDivider(color: Colors.blue,
                                        thickness: 2,),
                                      title: Text(shopClients[index]),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Client list empty"),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                }
                return const Text("Please wait");
              },

            ),
          ),
        );
      }
    }
    else if(selectedInPos == "Services"){
      if(!selectingClient){
        return Positioned(
          top: 50,
          left: 250,
          child: Container(
            width: 450,
            height: 400,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Search for services"),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data['$currentShopIndex']['services-amount'],
                      itemBuilder: (context,index){
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                            onTap: (){
                              setState(() {
                                serviceBooked.add(snapshot.data['$currentShopIndex']['services']['$index']['service-name']);
                                serviceDuration.add(snapshot.data['$currentShopIndex']['services']['$index']['service-hours'] +
                                    snapshot.data['$currentShopIndex']['services']['$index']['service-minutes']);
                                servicePrice.add(snapshot.data['$currentShopIndex']['services']['$index']['service-price']);

                                ServiceToBook currentService = ServiceToBook(
                                  title: snapshot.data['$currentShopIndex']['services']['$index']['service-name'],
                                  duration: snapshot.data['$currentShopIndex']['services']['$index']['service-hours'] +
                                      snapshot.data['$currentShopIndex']['services']['$index']['service-minutes'],
                                  price: snapshot.data['$currentShopIndex']['services']['$index']['service-price'],
                                  type: 'Services',
                                  serviceLinked: snapshot.data['$currentShopIndex']['services']['$index']['service-linked'],
                                );

                                currentTotal += double.parse(snapshot.data['$currentShopIndex']['services']['$index']['service-price']);
                                cart.add(currentService);

                              });
                            },
                            leading: VerticalDivider(color: Colors.blue,
                              thickness: 2,),
                            title:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data['$currentShopIndex']['services']['$index']['service-name'],style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    Text(snapshot.data['$currentShopIndex']['services']['$index']['service-hours'],style: TextStyle(
                                      fontSize: 12,
                                    ),),
                                    SizedBox(width: 5,),
                                    Text(snapshot.data['$currentShopIndex']['services']['$index']['service-minutes'],style: TextStyle(
                                      fontSize: 13,
                                    ),),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Text("${snapshot.data['$currentShopIndex']['services']['$index']['service-price']} EGP"),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      }
      else{
        return Positioned(
          top: 50,
          left: 260,
          child: Container(
            width: 450,
            height: 420,
            child: FutureBuilder(
              future: categoryData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){

                    shopClients = [];
                    int clientIndex = 0;
                    while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                      shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                      clientIndex++;
                    }

                    print("CLIENT AMOUNT ${shopClients.length}");


                    if(shopClients.length > 0){
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Search for clients"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: shopClients.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          showClientNotSelected = false;
                                          selectingClient = false;
                                          currentClient = shopClients[index];
                                        });
                                      },
                                      leading: VerticalDivider(color: Colors.blue,
                                        thickness: 2,),
                                      title: Text(shopClients[index]),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Client list empty"),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                }
                return const Text("Please wait");
              },

            ),
          ),
        );
      }
    }
    else if(selectedInPos == "Products"){
      if(!selectingClient){
        return Positioned(
          top: 50,
          left: 270,
          child: Container(
            width: 400,
            height: 400,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Search for products"),
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: ListView.builder(
                      itemCount: (snapshot.data['$currentShopIndex']['products-amount'] == -1)?1:snapshot.data['$currentShopIndex']['products-amount']+1,
                      itemBuilder: (context,index){
                        if(snapshot.data['$currentShopIndex']['products-amount'] == -1){
                          return Column(
                            children: [
                              SizedBox(height: 50,),
                              Text("You have no products",style: TextStyle(
                                fontSize: 18,
                              ),),
                            ],
                          );
                        }
                        else{
                          return Container(
                            margin: EdgeInsets.all(10),
                            child: ListTile(
                              onTap: (){
                                setState(() {
                                  serviceBooked.add(snapshot.data['$currentShopIndex']['products']['$index']['product-name']);
                                  serviceDuration.add('');
                                  servicePrice.add('${snapshot.data['$currentShopIndex']['products']['$index']['product-price']}');

                                  ServiceToBook currentService = ServiceToBook(
                                    title: snapshot.data['$currentShopIndex']['products']['$index']['product-name'],
                                    duration: '',
                                    price: '${snapshot.data['$currentShopIndex']['products']['$index']['product-price']}',
                                    type: 'Products',
                                    serviceLinked: false,
                                  );

                                  currentTotal += double.parse('${snapshot.data['$currentShopIndex']['products']['$index']['product-price']}');
                                  cart.add(currentService);
                                });
                              },
                              leading: VerticalDivider(color: Colors.blue,
                                thickness: 2,),
                              title: Row(
                                children: [
                                  Text(snapshot.data['$currentShopIndex']['products']['$index']['product-name']),
                                ],
                              ),
                              trailing: Text("${snapshot.data['$currentShopIndex']['products']['$index']['product-price']} EGP"),
                            ),
                          );
                        }
                      }),
                ),
                Container(
                  width: 150,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/add-product');
                    },
                    child: Text("Add New Product", style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),
              ],
            ),
          ),
        );
      }
      else{
        return Positioned(
          top: 50,
          left: 260,
          child: Container(
            width: 450,
            height: 420,
            child: FutureBuilder(
              future: categoryData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){

                    shopClients = [];
                    int clientIndex = 0;
                    while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                      shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                      clientIndex++;
                    }

                    print("CLIENT AMOUNT ${shopClients.length}");


                    if(shopClients.length > 0){
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Search for clients"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: shopClients.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          showClientNotSelected = false;
                                          selectingClient = false;
                                          currentClient = shopClients[index];
                                        });
                                      },
                                      leading: VerticalDivider(color: Colors.blue,
                                        thickness: 2,),
                                      title: Text(shopClients[index]),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Client list empty"),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                }
                return const Text("Please wait");
              },

            ),
          ),
        );
      }
    }
    else if(selectedInPos == "Custom Amount"){
      if(!selectingClient){
        return Positioned(
          top: 50,
          left: 270,
          child: Container(
            width: 430,
            height: 450,
            child: Column(
              children: [
                buildValidCustomAmount(),
                SizedBox(height: 15,),
                TextFormField(
                  controller: customAmountController,
                  decoration: InputDecoration(
                    labelText: "Amount (EGP)",
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text("Type:"),
                    SizedBox(width: 20,),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                      ),
                      width: 180,
                      child: DropdownButton<String>(
                        value: selectedTypeOfService,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        //style: const TextStyle(color: Colors.deepPurple),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTypeOfService = newValue!;
                            displayError = false;
                          });
                        },
                        items: <String>['Services','Products']
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
                SizedBox(height: 15,),
                FutureBuilder(
                  future: categoryData(),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.connectionState == ConnectionState.done){
                      if(snapshot.hasError){
                        return const Text("There is an error");
                      }
                      else if(snapshot.hasData){


                        List<String> services = [];
                        List<String> products = [];

                        services.add("");
                        products.add("");

                        int serviceIndex = 0;
                        while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){
                          services.add(snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']);
                          serviceIndex++;
                        }

                        int productIndex = 0;
                        while(productIndex <= snapshot.data['$currentShopIndex']['products-amount']){
                          products.add(snapshot.data['$currentShopIndex']['products']['$productIndex']['product-name']);
                          productIndex++;
                        }

                        return Row(
                          children: [
                            Text(selectedTypeOfService == "Services"?"Service:":"Product:"),
                            SizedBox(width: 20,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 1.0),
                              ),
                              width: 180,
                              child: DropdownButton<String>(
                                value: selectedTypeOfService == "Services"?selectedService:selectedProduct,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                //style: const TextStyle(color: Colors.deepPurple),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    if(selectedTypeOfService == "Services"){
                                      selectedService = newValue!;
                                    }
                                    else{
                                      selectedProduct = newValue!;
                                    }
                                    displayError = false;
                                  });
                                },
                                items: selectedTypeOfService == "Services"?services.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList():products.map<DropdownMenuItem<String>>((String value) {
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
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 150,
                          height: 50,
                          child: TextButton(
                            onPressed: (){

                              List<String> numbers = ['0','1','2','3','4','5','6','7','8','9'];
                              int customAmountIndex = 0;


                              if(selectedTypeOfService == "Services"){
                                int serviceIndex = 0;
                                while(serviceIndex < snapshot.data['$currentShopIndex']['services-amount']){

                                  if(selectedService == snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-name']){
                                    hours = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-hours'];
                                    minutes = snapshot.data['$currentShopIndex']['services']['$serviceIndex']['service-minutes'];
                                    break;
                                  }

                                  serviceIndex++;
                                }
                              }
                              else{
                                hours = "";
                                minutes = "";
                              }





                              while(customAmountIndex < customAmountController.text.length){
                                numberFound = false;
                                int currentNumber = 0;
                                while(currentNumber < numbers.length){
                                  if(customAmountController.text[customAmountIndex] == numbers[currentNumber]){
                                    setState(() {
                                      numberFound = true;
                                      displayError = false;
                                    });
                                    break;
                                  }
                                  currentNumber++;
                                }
                                if(!numberFound){
                                  break;
                                }
                                customAmountIndex++;
                              }

                              if(!numberFound){
                                setState(() {
                                  displayError = true;
                                });
                              }
                              else{
                                print("NUMBER FOUND");
                                setState(() {
                                  serviceBooked.add(serviceDescriptionController.text);
                                  serviceDuration.add(hours + minutes);
                                  servicePrice.add(customAmountController.text);
                                  ServiceToBook currentService = ServiceToBook(
                                    title: serviceDescriptionController.text,
                                    duration: hours + minutes,
                                    price: customAmountController.text,
                                    type: selectedTypeOfService,
                                    serviceLinked: false,
                                  );

                                  currentTotal += double.parse(customAmountController.text);
                                  cart.add(currentService);

                                });
                              }
                            },
                            child: Text("Add to cart", style: TextStyle(
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
        );
      }
      else{
        return Positioned(
          top: 50,
          left: 260,
          child: Container(
            width: 450,
            height: 420,
            child: FutureBuilder(
              future: categoryData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){

                    shopClients = [];
                    int clientIndex = 0;
                    while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                      shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                      clientIndex++;
                    }

                    print("CLIENT AMOUNT ${shopClients.length}");


                    if(shopClients.length > 0){
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Search for clients"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: shopClients.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          showClientNotSelected = false;
                                          selectingClient = false;
                                          currentClient = shopClients[index];
                                        });
                                      },
                                      leading: VerticalDivider(color: Colors.blue,
                                        thickness: 2,),
                                      title: Text(shopClients[index]),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Client list empty"),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                }
                return const Text("Please wait");
              },

            ),
          ),
        );
      }
    }
    else if(selectedInPos == "Gift Cards"){
      if(!selectingClient){
        return Container();
      }
      else{
        return Positioned(
          top: 50,
          left: 260,
          child: Container(
            width: 450,
            height: 420,
            child: FutureBuilder(
              future: categoryData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){

                    shopClients = [];
                    int clientIndex = 0;
                    while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                      shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                      clientIndex++;
                    }

                    print("CLIENT AMOUNT ${shopClients.length}");


                    if(shopClients.length > 0){
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Search for clients"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: shopClients.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          showClientNotSelected = false;
                                          selectingClient = false;
                                          currentClient = shopClients[index];
                                        });
                                      },
                                      leading: VerticalDivider(color: Colors.blue,
                                        thickness: 2,),
                                      title: Text(shopClients[index]),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Client list empty"),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                }
                return const Text("Please wait");
              },

            ),
          ),
        );
      }
    }
    else if(selectedInPos == "Packages"){
      return Positioned(
        top: 50,
        left: 260,
        child: Container(
          width: 450,
          height: 420,
          child: FutureBuilder(
            future: categoryData(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasError){
                  return const Text("There is an error");
                }
                else if(snapshot.hasData){

                  shopClients = [];
                  int clientIndex = 0;
                  while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                    shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                    clientIndex++;
                  }

                  print("CLIENT AMOUNT ${shopClients.length}");


                  if(snapshot.data['$currentShopIndex']['packages-amount'] >= 0){
                    return Column(
                      children: [
                        Center(
                          child: ListTile(
                            leading: Icon(Icons.search),
                            title: Text("Search for package"),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data['$currentShopIndex']['packages-amount']+1,
                              itemBuilder: (context,index){
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                                    onTap: (){
                                      setState(() {
                                        serviceBooked.add(snapshot.data['$currentShopIndex']['packages']['$index']['package-name']);
                                        serviceDuration.add(snapshot.data['$currentShopIndex']['packages']['$index']['package-hours'] +
                                            snapshot.data['$currentShopIndex']['packages']['$index']['package-minutes']);
                                        servicePrice.add(snapshot.data['$currentShopIndex']['packages']['$index']['package-price']);

                                        ServiceToBook currentService = ServiceToBook(
                                          title: snapshot.data['$currentShopIndex']['packages']['$index']['package-name'],
                                          duration: snapshot.data['$currentShopIndex']['packages']['$index']['package-hours'] +
                                              snapshot.data['$currentShopIndex']['packages']['$index']['package-minutes'],
                                          price: snapshot.data['$currentShopIndex']['packages']['$index']['package-price'],
                                          type: 'Packages',
                                          serviceLinked: snapshot.data['$currentShopIndex']['packages']['$index']['service-linked'],
                                        );

                                        currentTotal += double.parse(snapshot.data['$currentShopIndex']['packages']['$index']['package-price']);
                                        cart.add(currentService);

                                      });
                                    },
                                    leading: VerticalDivider(color: Colors.blue,
                                      thickness: 2,),
                                    title: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data['$currentShopIndex']['packages']['$index']['package-name']),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            Text(snapshot.data['$currentShopIndex']['packages']['$index']['package-hours']),
                                            SizedBox(width: 5,),
                                            Text(snapshot.data['$currentShopIndex']['packages']['$index']['package-minutes']),
                                          ],
                                        ),
                                      ],
                                    ),
                                    trailing: Text("${snapshot.data['$currentShopIndex']['packages']['$index']['package-price']} EGP"),
                                  ),
                                );
                              }),
                        ),
                        Center(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/add-package');
                              },
                              child: Text("Add New Package", style: TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    return Column(
                      children: [
                        Center(
                          child: ListTile(
                            leading: Icon(Icons.search),
                            title: Text("No Packages Created"),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                              onPressed: (){
                                Navigator.pushNamed(context, '/add-package');
                              },
                              child: Text("Add New Package", style: TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }
              }
              return const Text("Please wait");
            },

          ),
        ),
      );
    }
    else if(selectedInPos == "Memberships"){
      if(!selectingClient){
        return Container();
      }
      else{
        return Positioned(
          top: 50,
          left: 260,
          child: Container(
            width: 450,
            height: 420,
            child: FutureBuilder(
              future: categoryData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  if(snapshot.hasError){
                    return const Text("There is an error");
                  }
                  else if(snapshot.hasData){

                    shopClients = [];
                    int clientIndex = 0;
                    while(clientIndex <= snapshot.data['$currentShopIndex']['client-amount']){
                      shopClients.add(snapshot.data['$currentShopIndex']['clients']['$clientIndex']['name']);
                      clientIndex++;
                    }

                    print("CLIENT AMOUNT ${shopClients.length}");


                    if(shopClients.length > 0){
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Search for clients"),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: shopClients.length,
                                itemBuilder: (context,index){
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    child: ListTile(
                                      onTap: (){
                                        setState(() {
                                          showClientNotSelected = false;
                                          selectingClient = false;
                                          currentClient = shopClients[index];
                                        });
                                      },
                                      leading: VerticalDivider(color: Colors.blue,
                                        thickness: 2,),
                                      title: Text(shopClients[index]),
                                    ),
                                  );
                                }),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Column(
                        children: [
                          Center(
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Client list empty"),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, '/add-client');
                                },
                                child: Text("Add new Client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }
                }
                return const Text("Please wait");
              },

            ),
          ),
        );
      }
    }
    else{
      return Container();
    }
  }

  Widget buildValidCustomAmount(){
    if(displayError){
      return Text("The amount you entered is not valid, please try again", style: TextStyle(
        color: Colors.red,
      ),);
    }
    else{
      return Container();
    }
  }

  Widget buildCurrentClient(){
    if(currentClient != ''){
      return Positioned(
        top: 100,
        left: 100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: 250,
          height: 150,
          child: Column(
            children: [
              Text("Client Selected: ", style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 10,),
              Text(currentClient),
              SizedBox(height: 20,),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: (){
                    setState(() {
                      selectingClient = true;
                    });
                  },
                  child: Text("Change client selected", style: TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ),
            ],
          ),
        ),
      );
    }
    else if(showClientNotSelected){
      return Positioned(
        top: 100,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: 250,
          height: 75,
          child: Column(
            children: [
              Text("No client selected", style: TextStyle(
                color: Colors.red,
              ),),
              Text("Please select a client",style: TextStyle(
                color: Colors.red,
              ),),
            ],
          ),
        ),
      );
    }
    else{
     return Positioned(
        top: 100,
        left: 20,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: 250,
          height: 75,
          child: Card(
            elevation: 4.0,
            child: TextButton(
              onPressed: (){
                setState(() {
                  selectingClient = true;
                });
              },
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 10,
                    child:Text("Select Client or", style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),
                  Positioned(
                    top: 40,
                    left: 10,
                    child: Text("add new client",style: TextStyle(
                      color: Colors.black,
                    ),),
                  ),


                ],
              ),
            ),
          ),
        ),
      );
    }
  }




}
