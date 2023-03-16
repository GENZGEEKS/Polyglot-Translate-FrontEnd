import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polyglot/main.dart';
import 'package:http/http.dart' as http;
import 'package:polyglot/screens/InputText.dart';
import 'package:polyglot/screens/output.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int stepCount = 0;
  String language = "English";
  bool isLoading = false;
  String base64Image = "";
  List<String> languageList = <String>['English', 'Hindi', 'Gujarati'];
//  List<String> languageList = <String>['English', 'Hindi', 'Gujarati'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    pickImage() async {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return image;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80.0,
        title: const Text(
          'POLYGLOT',
          style: TextStyle(color: Color(0xff545454), fontSize: 28.0),
        ),
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            minRadius: 20,
            maxRadius: 30,
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text(
                    'Translation Made Easier',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff4b9600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Color(0xFF9F9F9F),
            thickness: 4,
            height: 20,
          ),
          Spacer(),

          const SizedBox(height: 16),

          GestureDetector(
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? photo =
                  await _picker.pickImage(source: ImageSource.camera);
              String path = photo?.path ?? "";
              if (path.isEmpty) return null;
              File cameraFile = File(path);
              var bytes = cameraFile.readAsBytesSync();
              base64Image = base64Encode(bytes);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: const Alignment(-1, 0),
                      children: [
                        Container(
                          width: size.width - 36,
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.center,
                          height: 68,
                          color: Colors.grey,
                          child: const Text(
                            "Scan Image",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.green,
                          child: Image.asset(
                            "assets/images/camera_icon.png",
                            width: 60,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),

          GestureDetector(
            onTap: () async {
              var selectedImage = await pickImage();
              if (selectedImage != null) {
                File imageFile = File(selectedImage.path);
                var bytes = imageFile.readAsBytesSync();
                base64Image = base64Encode(bytes);
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: const Alignment(1, 0),
                      children: [
                        Container(
                          width: size.width - 36,
                          margin: const EdgeInsets.only(right: 20),
                          alignment: Alignment.center,
                          height: 68,
                          color: Colors.grey,
                          child: const Text(
                            "Import Image",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.green,
                          child: Image.asset(
                            "assets/images/gallery_icon.png",
                            width: 60,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InputText(
                        language: language,
                      )));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: const Alignment(-1, 0),
                      children: [
                        Container(
                          width: size.width - 36,
                          margin: const EdgeInsets.only(left: 20),
                          alignment: Alignment.center,
                          height: 68,
                          color: Colors.grey,
                          child: const Text(
                            "Input Text",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.green,
                          child: Image.asset(
                            "assets/images/text_icon.png",
                            width: 60,
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 68, vertical: 8),
            // width: size.width * .5,
            child: DropdownButton<String>(
              value: language,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  language = value!;
                });
              },
              items: languageList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          const Spacer(),

          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: ElevatedButton(
              onPressed: () async {
                print("Calling api");
                print(base64Image);

                setState(() {
                  isLoading = true;
                });
                http.Response response = await http
                    .post(
                      Uri.parse(
                          "https://polyglot-translation.onrender.com/translate"),
                      headers: {
                        'accept': 'application/json',
                        'Content-Type': 'application/json'
                      },
                      body: jsonEncode(
                        <String, String>{
                          "base64_image": base64Image,
                          "language": language
                        },
                      ),
                    )
                    .catchError(print)
                    .whenComplete(() {
                  setState(() {
                    isLoading = false;
                  });
                });

                print(response.body);
                final jsonData = jsonDecode(response.body);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Output(
                          output: jsonData['translation'],
                        )));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Translating ...    ",
                            style: TextStyle(fontSize: 20),
                          ),
                          CircularProgressIndicator(
                            color: Colors.white,
                          )
                        ],
                      )
                    : const Text(
                        "Get Translation",
                        style: TextStyle(fontSize: 18),
                      ),
              ),
            ),
          ),

          const Spacer(),

          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         buildHomeListTile(
          //             'assets/images/camera_icon.png', 'Scan Image'),
          //         buildHomeListTile(
          //             'assets/images/gallery_icon.png', 'Import Image'),
          //         buildHomeListTile(
          //             'assets/images/text_icon.png', 'Input Text'),
          //       ],
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding:
          //       const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.grey.shade400),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: const [
          //         Text(
          //           'Select Language',
          //           style: TextStyle(color: Color(0xff454545)),
          //         ),
          //         Icon(
          //           CupertinoIcons.chevron_down,
          //           color: Color(0xff454545),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  SizedBox buildHomeListTile(String imagePath, String label) {
    return SizedBox(
      height: 100,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 100,
              color: const Color(0xff4b9700),
              child: Image.asset(imagePath),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              color: Colors.grey.shade200,
              height: 100,
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Stepper(
//             currentStep: stepCount,
//             type: StepperType.vertical,
//             onStepContinue: () async {
//               if (stepCount < 1) {
//                 setState(() {
//                   stepCount++;
//                 });
//               }
//               // API CALL
//               print(base64Image);
//               print(stepCount);
//               if (stepCount == 2) {
//                 print("Calling api");
//                 http.Response response = await http
//                     .post(
//                       Uri.parse(
//                           "https://polyglot-translation.onrender.com/translate"),
//                       headers: {
//                         'accept': 'application/json',
//                         'Content-Type': 'application/json'
//                       },
//                       body: jsonEncode(
//                         <String, String>{
//                           "base64_image": base64Image,
//                           "language": language
//                         },
//                       ),
//                     )
//                     .catchError(print);

//                 print(response.body);
//               }
//             },
//             onStepCancel: () {
//               if (stepCount > 0) {
//                 setState(() {
//                   stepCount--;
//                 });
//               }
//             },
//             steps: [
//               Step(
//                 title: const Text('Select Language'),
//                 isActive: stepCount == 0 ? true : false,
//                 content: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24.0,
//                     vertical: 10.0,
//                   ),
//                   child: DropdownButton<String>(
//                     value: language,
//                     icon: const Icon(Icons.arrow_downward),
//                     elevation: 16,
//                     style: const TextStyle(color: Colors.deepPurple),
//                     underline: Container(
//                       height: 2,
//                       color: Colors.deepPurpleAccent,
//                     ),
//                     onChanged: (String? value) {
//                       // This is called when the user selects an item.
//                       setState(() {
//                         language = value!;
//                       });
//                     },
//                     items: languageList
//                         .map<DropdownMenuItem<String>>((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                   ),
//                   // ElevatedButton(
//                   //   onPressed: () {},
//                   //   style: ElevatedButton.styleFrom(
//                   //       backgroundColor: Colors.grey.shade400),
//                   //   child: Row(
//                   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //     children: const [
//                   //       Text(
//                   //         'Select Language',
//                   //         style: TextStyle(
//                   //           color: Color(0xff454545),
//                   //         ),
//                   //       ),
//                   //       Icon(
//                   //         CupertinoIcons.chevron_down,
//                   //         color: Color(0xff454545),
//                   //       )
//                   //     ],
//                   //   ),
//                   // ),
//                 ),
//               ),
//               Step(
//                 title: Text('Select Type'),
//                 isActive: stepCount == 1 ? true : false,
//                 content: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // ListTile(),
//                         // ListTile(),
//                         GestureDetector(
//                           onTap: () async {
//                             final ImagePicker _picker = ImagePicker();
//                             final XFile? photo = await _picker.pickImage(
//                                 source: ImageSource.camera);
//                             String path = photo?.path ?? "";
//                             if (path.isEmpty) return null;
//                             File cameraFile = File(path);
//                             var bytes = cameraFile.readAsBytesSync();
//                             base64Image = base64Encode(bytes);
//                             print(base64Image);
//                           },
//                           child: buildHomeListTile(
//                               'assets/images/camera_icon.png', 'Scan Image'),
//                         ),
//                         SizedBox(height: 10.0),
//                         GestureDetector(
//                           onTap: () async {
//                             var selectedImage = await pickImage();
//                             if (selectedImage != null) {
//                               File imageFile = File(selectedImage.path);
//                               var bytes = imageFile.readAsBytesSync();
//                               base64Image = base64Encode(bytes);

//                               //   Navigator.push(
//                               //       context,
//                               //       MaterialPageRoute(
//                               //           builder: (context) =>
//                               //               NextScreen(xys: base64Image)));
//                             }
//                             print('Tapped');
//                           },
//                           child: buildHomeListTile(
//                               'assets/images/gallery_icon.png', 'Import Image'),
//                         ),
//                         SizedBox(height: 10.0),
//                         buildHomeListTile(
//                             'assets/images/text_icon.png', 'Input Text'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
