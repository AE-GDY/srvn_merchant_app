import 'package:flutter/material.dart';

import '../constants.dart';


class ShopName extends StatefulWidget {
  const ShopName({Key? key}) : super(key: key);

  @override
  _ShopNameState createState() => _ShopNameState();
}

class _ShopNameState extends State<ShopName> {

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
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
        child: Form(
          key: formKey,
          child: Container(
            height: 1000,
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: 370,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 700,
                    width: 500,
                    child: Card(
                      elevation: 3.0,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text("Shop Details", style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 70,),
                            TextFormField(
                              controller: userNameController,
                              validator: (value){
                                if(value!.length < 4){
                                  return "Enter at least 4 characters";
                                }
                                else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Admin Email",
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value){
                                if(value!.length < 6){
                                  return "Enter at least 4 characters";
                                }
                                else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                labelText: "Admin Password",
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "Shop Name",
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: addressController,
                              decoration: InputDecoration(
                                labelText: "Address",
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: numberController,
                              decoration: InputDecoration(
                                labelText: "Phone number",
                              ),
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(
                                labelText: "Short Description",
                              ),
                            ),
                            SizedBox(height: 50,),
                            Container(
                              width: 250,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextButton(
                                onPressed: (){

                                  FocusScope.of(context).unfocus();
                                  final isValid = formKey.currentState!.validate();

                                  if(isValid){
                                    setState(() {
                                      userName = userNameController.text;
                                      phoneNumber = numberController.text;
                                      password = passwordController.text;
                                      shopName = nameController.text;
                                      shopAddress = addressController.text;
                                      shopDescription = descriptionController.text;
                                    });
                                    Navigator.pushNamed(context, '/business-category');
                                  }
                                },
                                child: Text("Continue", style: TextStyle(
                                  color: Colors.white,
                                ),),
                              ),

                            ),
                          ],
                        ),
                      ),
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
}
