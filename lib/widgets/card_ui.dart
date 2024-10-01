import 'package:flutter/material.dart';

class CustomInformationCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  CustomInformationCard(
      {required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40), // Icon with a larger size
          SizedBox(height: 8), // Spacing between icon and title
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 4), // Spacing between title and value
          Text(value, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
