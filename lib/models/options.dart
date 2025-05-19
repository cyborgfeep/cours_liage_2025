import 'package:cours_iage_2025/utils/constants.dart';
import 'package:flutter/material.dart';

class Option {
  String title;
  Color color;
  IconData icon;

  Option({required this.title, required this.color, required this.icon});

  static List<Option> optionList = [
    Option(
      title: "Transfert",
      icon: Icons.person,
      color: Constants.primaryColor,
    ),
    Option(title: "Paiement", icon: Icons.shopping_cart, color: Colors.orange),
    Option(
      title: "Crédit",
      icon: Icons.phone_android_outlined,
      color: Colors.blue,
    ),
    Option(
      title: "Banque",
      icon: Icons.account_balance_rounded,
      color: Colors.red,
    ),
    Option(title: "Cadeaux", icon: Icons.card_giftcard, color: Colors.green),
    Option(
      title: "Coffres",
      icon: Icons.account_balance_wallet_outlined,
      color: Colors.pink,
    ),
    Option(
      title: "Transport",
      icon: Icons.directions_bus,
      color: Colors.orangeAccent,
    ),
    Option(title: "Visa", icon: Icons.credit_card, color: Colors.blueAccent),
  ];
}
