import 'package:cours_iage_2025/models/options.dart';
import 'package:cours_iage_2025/models/transaction.dart';
import 'package:cours_iage_2025/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    loadJiffy();
  }

  loadJiffy() async {
    await Jiffy.setLocale('fr_FR');
  }

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
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        shrinkWrap: true,
                        itemCount: Option.optionList.length,
                        itemBuilder: (context, index) {
                          Option o = Option.optionList[index];
                          return optionWidget(option: o);
                        },
                      ),
                      Divider(
                        color: Colors.grey.withValues(alpha: .2),
                        thickness: 5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: Transaction.transList.length,
                        itemBuilder: (context, index) {
                          Transaction t = Transaction.transList[index];
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      t.title,
                                      style: GoogleFonts.montserrat(
                                        color: Constants.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${t.amount}F",
                                      style: GoogleFonts.montserrat(
                                        color: Constants.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  Jiffy.parseFromDateTime(
                                    t.dateTime,
                                  ).format(pattern: "dd MMM yyyy à HH:mm"),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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

  Widget optionWidget({required Option option}) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: option.color.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(45),
          ),
          child: Icon(option.icon, size: 30, color: option.color),
        ),
        Text(option.title),
      ],
    );
  }
}
