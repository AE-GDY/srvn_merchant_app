import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';

import '../constants.dart';


class ProfileReady extends StatefulWidget {
  const ProfileReady({Key? key}) : super(key: key);

  @override
  _ProfileReadyState createState() => _ProfileReadyState();
}

class _ProfileReadyState extends State<ProfileReady> {


  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance.collection('shops').
    doc(selectedCategory).get()).data();
  }

  DatabaseService databaseService = DatabaseService();


  String? _image1;
  late Uint8List _image2;
  late FilePickerResult imageresult;


  String? logo1;
  late Uint8List logo2;
  late FilePickerResult imageresult2;

  void _openPicker() async {
    imageresult = (await FilePicker.platform.pickFiles(type: FileType.image))!;
    setState(() {
      _image2 = imageresult.files.single.bytes!;
      _image1 = imageresult.files.single.name;
      if (kDebugMode) {
        print(selectedCategory);
      }
    });
  }

  void _openLogoPicker() async {
    imageresult2 = (await FilePicker.platform.pickFiles(type: FileType.image))!;
    setState(() {
      logo2 = imageresult2.files.single.bytes!;
      logo1 = imageresult2.files.single.name;
      if (kDebugMode) {
        print(selectedCategory);
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Welcome"),
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height * 1.5,
                margin: EdgeInsets.all(50),
                child: Card(
                  elevation: 5.0,
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      Text("Your All Set", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 30,),
                      Text("Welcome to Servnn!", style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),),

                      SizedBox(height: 30,),

                      // IMAGE UPLOAD

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(children: [
                                        Container(
                                          width: 250,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              _openPicker();
                                              if (kDebugMode) {
                                                print(selectedCategory);
                                              }
                                            },
                                            child: const Text("Select Cover Image",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.grey),
                                            ),
                                            child: Center(
                                              child:Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  // the image that we wanted to upload
                                                  Expanded(
                                                      child: _image1 == null
                                                          ? const Center(
                                                          child: Icon(Icons.image_search_rounded,size: 50,))
                                                          : Image.memory(_image2,width: 350,height: 250,)),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                      ),
                                      SizedBox(width: 10,),
                                      Column(children: [
                                        Container(
                                          width: 250,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: TextButton(
                                            onPressed: () {
                                              _openLogoPicker();
                                              if (kDebugMode) {
                                                print(selectedCategory);
                                              }
                                            },
                                            child: const Text("Select Logo",style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            width: 250,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: Colors.grey),
                                            ),
                                            child: Center(
                                              child:Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  // the image that we wanted to upload
                                                  Expanded(
                                                      child: logo1 == null
                                                          ? const Center(
                                                          child: Icon(Icons.image_search_rounded,size: 50,))
                                                          : Image.memory(logo2,width: 350,height: 250,)),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]
                                      ),
                                    ],
                                  ),
                              )
                          ),
                        ),
                      ),





                      SizedBox(height: 60,),
                      FutureBuilder(
                        future: categoryData(),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            if(snapshot.hasError){
                              return const Text("There is an error");
                            }
                            else if(snapshot.hasData){
                              print("reached here");
                              return Container(
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () async {


                                    // Adds initial shop data
                                    await databaseService.addShop(
                                        selectedCategory,
                                        shopName,
                                        snapshot.data['total-shop-amount']+1,
                                        timePicked.year,
                                        timePicked.month,
                                        timePicked.day
                                    );

                                    // Adds Staff Members
                                    int staffIdx = 0;
                                    while(staffIdx < staffMembers.length){
                                      await databaseService.addStaffMembers(
                                        selectedCategory,
                                        staffIdx!= 0?serviceStaffMembers[staffIdx-1]:{},
                                        snapshot.data['total-shop-amount']+1,
                                        staffIdx,
                                      );
                                      staffIdx++;
                                    }

                                    // Adds services
                                    int serviceIdx = 0;
                                    while(serviceIdx < services.length){
                                      await databaseService.addServices(
                                        selectedCategory,
                                        snapshot.data['total-shop-amount']+1,
                                        serviceIdx,
                                        services[serviceIdx].gap,
                                        services[serviceIdx].maxBookings,
                                        services[serviceIdx].maxBookings == 1?false:true,
                                      );
                                      serviceIdx++;
                                    }


                                    if (_image1 != null) {

                                      int imageIndex = 0;
                                      String? downloadURL;

                                      final imgId = DateTime.now().millisecondsSinceEpoch.toString();

                                      firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.refFromURL('gs://servnn.appspot.com/$selectedCategory/$currentShopIndex/images').child('post_$imgId');

                                      firebase_storage.TaskSnapshot uploadTask = await reference.putData(_image2, firebase_storage.SettableMetadata(contentType: 'image/jpeg'));

                                      downloadURL = await uploadTask.ref.getDownloadURL();


                                      if (uploadTask.state == firebase_storage.TaskState.success) {
                                        print('done');
                                        print('URL: $downloadURL');
                                      } else {
                                        print(uploadTask.state);
                                      }

                                      await databaseService.uploadImage(
                                          selectedCategory,
                                          snapshot.data['total-shop-amount']+1,
                                          imageIndex,
                                          _image2,
                                          downloadURL,
                                          false,
                                          imageIndex+1,
                                      );

                                    }

                                    if(logo1 != null){
                                      int imageIndex = 0;
                                      String? downloadURL;

                                      final imgId = DateTime.now().millisecondsSinceEpoch.toString();

                                      firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.refFromURL('gs://servnn.appspot.com/$selectedCategory/$currentShopIndex/images').child('post_$imgId');

                                      firebase_storage.TaskSnapshot uploadTask = await reference.putData(logo2, firebase_storage.SettableMetadata(contentType: 'image/jpeg'));

                                      downloadURL = await uploadTask.ref.getDownloadURL();


                                      if (uploadTask.state == firebase_storage.TaskState.success) {
                                        print('done');
                                        print('URL: $downloadURL');
                                      } else {
                                        print(uploadTask.state);
                                      }

                                      await databaseService.uploadImage(
                                        selectedCategory,
                                        snapshot.data['total-shop-amount']+1,
                                        -1,
                                        logo2,
                                        downloadURL,
                                        false,
                                        imageIndex+1,
                                      );
                                    }



                                    // Sets the current logged in shop's index
                                    setState(() {
                                      currentShopIndex = snapshot.data['total-shop-amount'] + 1;
                                    });

                                    Navigator.pushNamed(context, '/dashboard');
                                  },
                                  child: Text("Continue", style: TextStyle(
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
