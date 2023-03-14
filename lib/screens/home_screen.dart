import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polyglot/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int stepCount = 0;

  @override
  Widget build(BuildContext context) {

    pickImage() async {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if(image!=null){
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Happy',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4b9600),
                  ),
                ),
                Text(
                  'Translating',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff4b9600),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFF9F9F9F),
            thickness: 4,
            height: 20,
          ),
          Stepper(
            currentStep: stepCount,
            type: StepperType.vertical,
            onStepContinue: () {
              if (stepCount < 1) {
                setState(() {
                  stepCount++;
                });
              }
            },
            onStepCancel: () {
              if (stepCount > 0) {
                setState(() {
                  stepCount--;
                });
              }
            },
            steps: [
              Step(
                title: const Text('Select Language'),
                isActive: stepCount == 0 ? true : false,
                content: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 10.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Select Language',
                          style: TextStyle(
                            color: Color(0xff454545),
                          ),
                        ),
                        Icon(
                          CupertinoIcons.chevron_down,
                          color: Color(0xff454545),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                title: Text('Select Type'),
                isActive: stepCount == 1 ? true : false,
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ListTile(),
                        // ListTile(),
                        buildHomeListTile(
                            'assets/images/camera_icon.png', 'Scan Image'),
                        SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: () async {
                            var selectedImage = await pickImage();
                            if(selectedImage != null){
                              File imageFile = File(selectedImage.path);
                              var bytes = imageFile.readAsBytesSync();
                              String base64Image = base64Encode(bytes);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen(xys: base64Image)));
                            }
                            print('Tapped');
                          },
                          child: buildHomeListTile(
                              'assets/images/gallery_icon.png', 'Import Image'),
                        ),
                        SizedBox(height: 10.0),
                        buildHomeListTile(
                            'assets/images/text_icon.png', 'Input Text'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
