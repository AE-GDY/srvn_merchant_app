import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:servnn_client_side/services/database.dart';
import '../constants.dart';

class ImageUpload extends StatefulWidget {
  final String? userId;
  const ImageUpload({Key? key, this.userId}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  // show snack bar
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(content: Text(snackText), duration: d);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  // initializing some values

  String? _image1;
  late Uint8List _image2;
  late FilePickerResult imageresult;

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

  Future<Map<String, dynamic>?> categoryData() async {
    return (await FirebaseFirestore.instance
        .collection('shops')
        .doc(selectedCategory)
        .get())
        .data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Dashboard"),
              onTap: () {
                setState(() {
                  selectedPage = 'dashboard';
                });
                Navigator.popAndPushNamed(context, '/dashboard');
              },
            ),
            ListTile(
              leading:
              const Icon(IconData(0xf320, fontFamily: 'MaterialIcons')),
              title: const Text("Services"),
              onTap: () {
                setState(() {
                  selectedPage = 'services';
                });
                Navigator.popAndPushNamed(context, '/services-page');
              },
            ),
            ListTile(
              leading:
              const Icon(IconData(0xf006c, fontFamily: 'MaterialIcons')),
              title: const Text("Staff Members"),
              onTap: () {
                setState(() {
                  selectedPage = 'staffMembers';
                });
                Navigator.pushNamed(context, '/staff-members-page');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.bolt_rounded,
                color: selectedPage == 'marketing' ? Colors.black : Colors.grey,
                size: selectedPage == 'marketing' ? 35 : iconSize,
              ),
              title: const Text("Marketing"),
              onTap: () {
                setState(() {
                  selectedPage = 'marketing';
                });
                Navigator.popAndPushNamed(context, '/marketing');
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_chart_outlined),
              title: const Text("Statistics and Reports"),
              onTap: () {
                setState(() {
                  selectedPage = 'statistics';
                });
                Navigator.popAndPushNamed(context, '/stats-and-reports');
              },
            ),
            ListTile(
              leading:
              const Icon(IconData(0xf00ad, fontFamily: 'MaterialIcons')),
              title: const Text("Point of Sale"),
              onTap: () {
                setState(() {
                  selectedPage = 'POS';
                });
                Navigator.popAndPushNamed(context, '/POS');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                setState(() {
                  selectedPage = 'settings';
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Portfolio"),
              onTap: () {
                setState(() {
                  selectedPage = 'edit-portfolio';
                });
                Navigator.popAndPushNamed(context, '/edit-portfolio');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          '$shopName Portfolio',
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: Column(children: [
                      const Text("Upload Image"),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Center(
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // the image that we wanted to upload
                                Expanded(
                                    child: _image1 == null
                                        ? const Center(
                                        child: Text("No image selected"))
                                        : Image.memory(_image2)),
                                ElevatedButton(
                                    onPressed: () {
                                      _openPicker();
                                      if (kDebugMode) {
                                        print(selectedCategory);
                                      }
                                    },
                                    child: const Text("Select Image")),
                                FutureBuilder(
                                  future: categoryData(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasError) {
                                        return const Text("There is an error");
                                      } else if (snapshot.hasData) {
                                        return ElevatedButton(
                                            onPressed: () async {
                                              print('1q');
                                              if (_image1 != null) {


                                                print('2q');
                                                int imageIndex = snapshot.data['$currentShopIndex']['total-images'];
                                                print('3q');
                                                print(imageIndex);

                                                print('1w');

                                                String? downloadURL;

                                                final imgId = DateTime.now().millisecondsSinceEpoch.toString();
                                                print('1wa');
                                                firebase_storage.Reference reference = firebase_storage.FirebaseStorage.instance.refFromURL('gs://servnn.appspot.com/$selectedCategory/$currentShopIndex/images').child('post_$imgId');

                                                print('2w');
                                                firebase_storage.TaskSnapshot uploadTask = await reference.putData(_image2, firebase_storage.SettableMetadata(contentType: 'image/jpeg'));
                                                print('3w');
                                                downloadURL = await uploadTask.ref.getDownloadURL();


                                                if (uploadTask.state == firebase_storage.TaskState.success) {
                                                  print('done');
                                                  print('URL: $downloadURL');
                                                } else {
                                                  print(uploadTask.state);
                                                }

                                                await DatabaseService().uploadImage(selectedCategory, currentShopIndex, imageIndex,_image2,downloadURL).whenComplete(() => const AlertDialog(
                                                    title: Text(
                                                      "Image Uploaded",
                                                    )));
                                              }

                                            },
                                            child: const Text("Upload Image"));
                                      }
                                    }
                                    return const Text("Please wait");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                    )
                )
            )
        ),
      ),
    );
  }
}