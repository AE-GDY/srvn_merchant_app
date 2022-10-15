import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';
import 'package:servnn_client_side/services/database.dart';


class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  int productStock = 0;

  DatabaseService databaseService = DatabaseService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
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
                return Center(
                  child: Container(
                    width: 500,
                    height: 500,
                    child: Card(
                      elevation: 3.0,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: productNameController,
                              decoration: const InputDecoration(
                                labelText: "Product Name",
                              ),
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: productPriceController,
                              decoration: const InputDecoration(
                                labelText: "Product Price",
                              ),
                            ),
                            SizedBox(height: 30,),
                            Text("Stock",style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
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
                                      setState(() {
                                        productStock++;
                                      });
                                    },
                                    child: Text("-", style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),
                                SizedBox(width: 20,),
                                Text("$productStock",style: TextStyle(
                                    fontSize: 18
                                ),),
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
                                        productStock++;
                                      });
                                    },
                                    child: Text("+", style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(height: 80,),

                            Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: () async {
                                  await databaseService.addProduct(
                                    selectedCategory,
                                    currentShopIndex,
                                    productNameController.text,
                                    int.parse(productPriceController.text),
                                    productStock,
                                    snapshot.data['$currentShopIndex']['products-amount'] + 1,
                                  );

                                  Navigator.pushNamed(context, '/dashboard');
                                },
                                child: Text("Save Product", style: TextStyle(
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
