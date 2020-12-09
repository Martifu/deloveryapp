import 'package:flutter/material.dart';

import '../theme.dart';

class DeliveryButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final EdgeInsets padding;

  const DeliveryButton({Key key, this.onTap, this.text, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            colors: deliveryGradiants,
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: Padding(
          padding: padding,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
