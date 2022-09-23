import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/services/database.dart';


class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  TextEditingController clientNameController = TextEditingController();
  TextEditingController clientEmailController = TextEditingController();
  TextEditingController clientNumberController = TextEditingController();


  DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Client"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: categoryData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasError){
                return const Text("There is an error");
              }
              else if(snapshot.hasData){
                return Center(
                  child: Container(
                    width: 500,
                    height: 500,
                    margin: EdgeInsets.all(50),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(height: 50,),
                            Text("New Client",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 50,),
                            TextFormField(
                              controller: clientNameController,
                              decoration: InputDecoration(
                                labelText: "Client Name",
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: clientEmailController,
                              decoration: InputDecoration(
                                labelText: "Client Email",
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: clientNumberController,
                              decoration: InputDecoration(
                                labelText: "Client Number",
                              ),
                            ),
                            SizedBox(height: 60,),
                            Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () async{

                                  await databaseService.addClient(
                                    selectedCategory,
                                    snapshot.data['$currentShopIndex']['client-amount']+1,
                                    currentShopIndex,
                                    clientNameController.text,
                                    clientEmailController.text,
                                  );

                                  Navigator.pushNamed(context, '/POS');


                                },
                                child: Text("Save new client", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
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
