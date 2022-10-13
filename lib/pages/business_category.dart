import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';


class BusinessCategory extends StatefulWidget {
  const BusinessCategory({Key? key}) : super(key: key);

  @override
  _BusinessCategoryState createState() => _BusinessCategoryState();
}

class _BusinessCategoryState extends State<BusinessCategory> {
  List<bool> isChecked = [false,false,false,false,false,false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: true,
        title: Text("Business Category"),
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
          height: 1000,
          child: Column(
            children: [
              SizedBox(height: 50,),
              Card(
                elevation: 2.0,
                child: Container(
                  width: 500,
                  height: 500,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),

                      Text("Choose your business category", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 30,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context,index){
                              return Container(
                                height: 60,
                                margin: EdgeInsets.only(left: 50,bottom: 5,top: 5),
                                child: ListTile(
                                  //  tileColor: Colors.grey[100],
                                  dense: true,
                                  leading: Checkbox(
                                    activeColor: Colors.deepPurple,
                                    value: isChecked[index],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        int idx = 0;
                                        while(idx < isChecked.length){
                                          if(idx != index){
                                            isChecked[idx] = false;
                                          }
                                          idx++;
                                        }
                                        isChecked[index] = !isChecked[index];
                                        selectedCategory = categories[index];
                                      });
                                    },
                                  ),
                                  title: Text(categories[index],style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),),
                                ),
                              );
                            }
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/adding-services');
                          },
                          child: Center(
                            child: Text("Continue", style: TextStyle(
                              color: Colors.white,
                            ),),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
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
