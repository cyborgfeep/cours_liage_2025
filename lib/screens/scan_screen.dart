import 'package:camera/camera.dart';
import 'package:cours_iage_2025/main.dart';
import 'package:flutter/material.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isFlashOn = false;
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController
        .initialize()
        .then((value) {
          if (!mounted) {
            return;
          }
          setState(() {});
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
                // Handle other errors here.
                break;
            }
          }
        });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: MediaQuery.of(context).size.aspectRatio,
              child: CameraPreview(cameraController),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40.0),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear, color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFlashOn = !isFlashOn;
                      });
                      cameraController.setFlashMode(
                        isFlashOn ? FlashMode.torch : FlashMode.off,
                      );
                    },
                    child: Icon(
                      isFlashOn ? Icons.flash_off : Icons.flash_on,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
