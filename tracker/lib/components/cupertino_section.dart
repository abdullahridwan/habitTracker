import 'package:flutter/material.dart';

class CupertinoSection extends StatelessWidget {
  const CupertinoSection({
    Key? key,
    required String title,
    required List<Map<String, dynamic>> variables,
  })  : _title = title,
        _variables = variables,
        super(key: key);

  final String _title;
  final List<Map<String, dynamic>> _variables;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    _variables.forEach((element) {
      rows.add(element['widget']);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
          child: Text(
            _title,
            style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: Theme.of(context).textTheme.labelLarge!.fontSize),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: rows,
          ),
        ),
      ],
    );
  }
}
