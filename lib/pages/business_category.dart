import 'package:flutter/material.dart';
import 'package:servnn_client_side/constants.dart';


class BusinessCategory extends StatefulWidget {
  const BusinessCategory({Key? key}) : super(key: key);

  @override
  _BusinessCategoryState createState() => _BusinessCategoryState();
}

class _BusinessCategoryState extends State<BusinessCategory> {
  List<bool> isChecked = [false,false,false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  height: 400,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),

                      Text("Choose your business category", style: TextStyle(
                        fontSize: 20,
                      ),),
                      SizedBox(height: 20,),
                      Expanded(
                        child: ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context,index){
                              return Container(
                                height: 60,
                                margin: EdgeInsets.all(5),
                                child: Card(
                                  elevation: 1.0,
                                  child: ListTile(
                                    //  tileColor: Colors.grey[100],
                                    dense: true,
                                    leading: Checkbox(
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
                                    title: Text(categories[index],),
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue,
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
