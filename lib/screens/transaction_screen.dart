import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionScreen extends StatefulWidget {
  final String menu;

  const TransactionScreen({super.key, required this.menu});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Contact> contacts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  getContacts() async {
    setState(() {
      isLoading = true;
    });
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(withProperties: true);
      contacts.removeWhere((element) => element.phones.isEmpty);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.menu == "Transfert"
              ? "Envoyer de l'argent"
              : "Achat de crédit",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                autofocus: false,
                decoration: InputDecoration(labelText: "À"),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Icon(Icons.add, color: Colors.white, size: 45),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Saisir un nouveau numéro",
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.blue,
                    size: 45,
                  ),

                  SizedBox(width: 10),
                  Text(
                    "Scanner pour envoyer",
                    style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Contacts",
                style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: contacts.length > 50 ? 50 : contacts.length,
                    itemBuilder: (context, index) {
                      Contact c = contacts[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withValues(alpha: .2),
                                borderRadius: BorderRadius.circular(45),
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey.shade700,
                                size: 35,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  c.displayName,
                                  style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(c.phones[0].number),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
