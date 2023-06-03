import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsRow extends StatelessWidget {
  SettingsRow({
    Key? key,
    required this.color,
    required this.icon,
    required this.title,
    required this.description,
    required this.endWidget,
  }) : super(key: key);
  Color color;
  IconData icon;
  String title;
  String description;
  Widget endWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: this.color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  this.icon,
                  color: Colors.white,
                  size: 17,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    this.title,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                    ),
                  ),
                  Text(
                    this.description,
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.labelMedium!.fontSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            child: this.endWidget,
          )
        ],
      ),
    );
  }
}
