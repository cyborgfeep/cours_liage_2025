import 'package:camera/camera.dart';
import 'package:cours_iage_2025/main.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../widgets/card_widget.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isFlashOn = false;
  int pageIndex = 0;
  late CameraController cameraController;
  PageController pageController = PageController(initialPage: 0);

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
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              cameraWidget(),
              Container(
                color: Colors.white,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: CardWidget(
                    width: 500,
                    height: 300,
                    iconSize: 80,
                    showText: false,
                    isClickable: false,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: ToggleSwitch(
                minWidth: 150.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.grey],
                  [Colors.white],
                ],
                activeFgColor: pageIndex == 0 ? Colors.white : Colors.black,
                inactiveBgColor: pageIndex == 0 ? Colors.black : Colors.grey,
                inactiveFgColor: pageIndex == 0 ? Colors.white : Colors.black,
                initialLabelIndex: pageIndex,
                totalSwitches: 2,
                labels: ['Scanner un code', 'Ma carte'],
                radiusStyle: true,
                onToggle: (index) {
                  setState(() {
                    pageIndex = index!;
                  });
                  pageController.jumpToPage(pageIndex);
                  print('switched to: $index');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cameraWidget() {
    return Center(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            child: CameraPreview(cameraController),
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.srcOut,
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ), // This one will handle background + difference out
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
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
    );
  }
}
