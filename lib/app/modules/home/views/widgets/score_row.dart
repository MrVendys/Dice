import 'package:flutter/material.dart';

class ScoreRow extends StatelessWidget {
  final String title;
  final List<String> values;

  const ScoreRow({
    Key? key,
    required this.title,
    required this.values,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
          ...values
              .map(
                (value) => SizedBox(
                  width: 100,
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
