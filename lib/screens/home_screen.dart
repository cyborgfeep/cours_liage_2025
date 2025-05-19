import 'package:cours_iage_2025/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 90,
            backgroundColor: Constants.primaryColor,
            leading: IconButton(
              onPressed: () {
                print("Settings");
              },
              icon: Icon(Icons.settings, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isVisible
                        ? RichText(
                          text: TextSpan(
                            text: "10.000",
                            style: GoogleFonts.aBeeZee(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "F",
                                style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                        : Text(
                          "••••••••",
                          style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                    SizedBox(width: 5),
                    Icon(
                      !isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                margin: EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Icon(Icons.sim_card, size: 15, color: Colors.black),
                    Text(
                      "6789",
                      style: GoogleFonts.aBeeZee(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 2000,
              child: Stack(
                children: [
                  Container(color: Constants.primaryColor),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      cardWidget(),
                      GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        shrinkWrap: true,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Constants.primaryColor.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 35,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              Text("Transfert"),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Icon(
                                  Icons.shopping_cart,
                                  size: 35,
                                  color: Colors.orange,
                                ),
                              ),
                              Text("Paiements"),
                            ],
                          ),
                        ],
                      ),
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

  Widget cardWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 200,
          width: 300,
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
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.only(top: 5),
                        child: PrettyQrView.data(data: 'https://google.com'),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_rounded, size: 18),
                          SizedBox(width: 5),
                          Text("Scanner"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/images/logo.png", width: 50),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
