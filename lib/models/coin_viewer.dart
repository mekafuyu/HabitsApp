import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoinViewer extends StatelessWidget {
  const CoinViewer({
    super.key,
    required this.value,
    required this.color,
  });

  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(
            CupertinoIcons.money_dollar_circle_fill,
            color: color,
            size: 16,
          ),
          Expanded(
            child: Card(
              margin: const EdgeInsets.only(left: 10),
              color: color.withOpacity(0.3),
              child: Text(
                value.toString(),
                style: const TextStyle(fontFamily: "Righteous", fontSize: 12),
                textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),
    );
  }
}
