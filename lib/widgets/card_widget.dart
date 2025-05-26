import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../screens/scan_screen.dart';

class CardWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final bool? showText;
  final bool? isClickable;

  const CardWidget({
    super.key,
    this.width,
    this.height,
    this.iconSize,
    this.showText = true,
    this.isClickable = true,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isClickable!) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ScanScreen()),
            (route) => true,
          );
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: widget.height ?? 200,
            width: widget.width ?? 300,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: .3),
                  BlendMode.srcIn,
                ),
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 120,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          padding: EdgeInsets.only(top: 5),
                          child: PrettyQrView.data(data: 'https://google.com'),
                        ),
                        SizedBox(height: 5),
                        widget.showText!
                            ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt_rounded, size: 18),
                                SizedBox(width: 5),
                                Text("Scanner"),
                              ],
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: widget.iconSize ?? 50,
                    ),
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
