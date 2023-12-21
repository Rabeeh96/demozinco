import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


  late List<CameraDescription> cameras;
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});


  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;
  late Future<void> cameraValue;
  bool isRecording = false;
  bool flash = false;
  bool isCameraFront = true;
  double transform = 0;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  File? image;
  XFile? img;

  final _picker = ImagePicker();
  /// Function for pick image from gallery
  Future<void> _openImagePicker() async {
    final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);

        //print(pickedImage.path);
      });
      /// pass image profile screen
      Navigator.pop(context, image);
    }
  }


  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                return SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: CameraPreview(_cameraController));


              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            _openImagePicker();


                          }),
                      /// flash option code;
                      // IconButton(
                      //     icon: Icon(
                      //       flash ? Icons.flash_on : Icons.flash_off,
                      //       color: Colors.white,
                      //       size: 28,
                      //     ),
                      //     onPressed: () {
                      //       setState(() {
                      //         flash = !flash;
                      //       });
                      //       flash
                      //           ? _cameraController
                      //           .setFlashMode(FlashMode.torch)
                      //           : _cameraController.setFlashMode(FlashMode.off);
                      //     }),
                      GestureDetector(
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            isRecording = true;
                          });
                        },
                        /// vdo recording code;
                        onLongPressUp: () async {
                          XFile videopath =
                          await _cameraController.stopVideoRecording();
                          setState(() {
                            isRecording = false;
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (builder) => VideoViewPage(
                          //           path: videopath.path,
                          //         )));
                        },
                        onTap: () {
                          if (!isRecording) takePhoto();
                        },
                        child: isRecording
                            ? const Icon(
                          Icons.radio_button_on,
                          color: Colors.red,
                          size: 80,
                        )
                            : const Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 90,
                          // weight: 1,
                        ),
                      ),
                      IconButton(
                          icon: Transform.rotate(
                            angle: transform,
                            child: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              isCameraFront = !isCameraFront;
                              transform = transform + pi;
                            });
                            int cameraPos = isCameraFront ? 0 : 1;
                            _cameraController = CameraController(
                                cameras[cameraPos], ResolutionPreset.high);
                            cameraValue = _cameraController.initialize();
                          }),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

///  Function for take photo in camera ;
  Future<void> takePhoto() async {
    final XFile file = await _cameraController.takePicture();
    setState(() {
        image = File(file.path);
      });
    Navigator.pop(context, image);

  }
}
