import 'package:flutter/material.dart';



class ReservationOptions extends StatefulWidget {
  const ReservationOptions({Key? key}) : super(key: key);

  @override
  _ReservationOptionsState createState() => _ReservationOptionsState();
}

List<String> tables = [];
List<int> tableAmount = [];


bool tablesRequiresConfirmation = false;
TextEditingController downPaymentController = TextEditingController();

bool downPayment = false;
String restaurantMinuteGap = "15";

bool restaurantBoth = true;
bool restaurantCredit = false;
bool restaurantCash = false;


class _ReservationOptionsState extends State<ReservationOptions> {




  int numberOfTables = 5;


  bool dynamicAvailability = false;

  TextEditingController tableSizeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Reservation Options'),
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height + 400,
          child: Column(
            children: [

              Container(
               // alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height + 200,
                margin: EdgeInsets.all(10),
                child: Card(
                  elevation: 2.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20,),

                      Container(
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: Switch(
                            activeColor: Colors.deepPurple,
                            value: tablesRequiresConfirmation,
                            onChanged: (bool value) {
                              setState(() {
                                tablesRequiresConfirmation = !tablesRequiresConfirmation;
                              });
                            },

                          ),
                          title: Text('Requires Confirmation', style: TextStyle(

                          ),),
                        ),
                      ),

                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: Switch(
                            activeColor: Colors.deepPurple,
                            value: downPayment,
                            onChanged: (bool value) {
                              setState(() {
                                downPayment = !downPayment;
                              });
                            },

                          ),
                          title: Text('Down Payment', style: TextStyle(

                          ),),
                        ),
                      ),

                     downPayment?SizedBox(height: 10,):Container(),

                     downPayment? Container(
                       margin: EdgeInsets.all(10),
                        width: 300,
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          controller: downPaymentController,
                          decoration: InputDecoration(
                            hintText: "Down Payment",
                          ),
                        ),
                      ):Container(),

                      SizedBox(height: 10,),


                      dynamicAvailability? Container(): Text('Tables',style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),


                      dynamicAvailability? Container(): Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Container(
                            width: 200,
                            height: 50,
                            child: TextField(
                              controller: tableSizeController,
                              decoration: InputDecoration(
                                hintText: "Table Size",
                              ),
                            ),
                          ),

                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: (){
                                if(numberOfTables > 1){
                                  setState(() {
                                    numberOfTables--;
                                  });
                                }
                              },
                              child: Icon(Icons.remove,color: Colors.white,),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Text('$numberOfTables'),
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
                                  numberOfTables++;
                                });
                              },
                              child: Icon(Icons.add,color: Colors.white,),
                            ),
                          ),

                        SizedBox(width: 30,),


                        dynamicAvailability?  Container(): Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: (){

                                setState(() {
                                  tables.add(tableSizeController.text);
                                  tableAmount.add(numberOfTables);

                                  tableSizeController.text = "";
                                  numberOfTables = 5;

                                });

                              },
                              child: Text('Add Tables',style: TextStyle(
                                color: Colors.white,
                              ),),
                            ),
                          ),

                        ],
                      ),


                      Container(
                        height: 200,
                        child: ListView.builder(
                            itemCount: tables.length,
                            itemBuilder: (context,index){
                              return ListTile(
                                leading: VerticalDivider(color: Colors.deepPurple,thickness: 2,),
                                title: Text("${tables[index]}"),
                                subtitle: Text('Amount: ${tableAmount[index]}'),
                              );
                        }),
                      ),

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
                          value: restaurantMinuteGap,
                          //icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          //style: const TextStyle(color: Colors.deepPurple),
                          onChanged: (String? newValue) {
                            setState(() {
                              restaurantMinuteGap = newValue!;
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

                      Text("Accepted Payment Methods for Down Payment", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),

                      SizedBox(height: 10,),


                      ListTile(
                        leading: Switch(
                          activeColor: Colors.deepPurple,
                          onChanged: (bool value) {
                            setState(() {
                              restaurantBoth = !restaurantBoth;

                              restaurantCredit = false;
                              restaurantCash = false;

                            });
                          },
                          value: restaurantBoth,

                        ),
                        title: Text("Credit Card and Cash"),
                      ),

                      SizedBox(height: 5,),

                      ListTile(
                        leading: Switch(
                          activeColor: Colors.deepPurple,
                          onChanged: (bool value) {
                            setState(() {
                              restaurantCredit = !restaurantCredit;
                              restaurantBoth = false;
                            });
                          },
                          value: restaurantCredit,

                        ),
                        title: Text("Credit Card Only"),
                      ),

                      SizedBox(height: 5,),


                      ListTile(
                        leading: Switch(
                          activeColor: Colors.deepPurple,
                          onChanged: (bool value) {
                            setState(() {
                              restaurantCash = !restaurantCash;
                              restaurantBoth = false;
                            });
                          },
                          value: restaurantCash,

                        ),
                        title: Text("Cash Only"),
                      ),

                      Container(
                        alignment: Alignment.center,
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/business-hours');
                          },
                          child: Text('Continue',style: TextStyle(
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
