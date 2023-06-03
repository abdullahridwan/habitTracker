import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.illustration,
    required this.text,
    required this.description,
  }) : super(key: key);

  final UnDrawIllustration illustration;
  final String text;
  final String description;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Spacer(),
        UnDraw(
          illustration: illustration,
          color: Theme.of(context).primaryColor,
          height: screenHeight * 0.35,
          width: screenWidth * 0.35,
        ),
        Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: screenHeight * 0.035,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: screenHeight * 0.02,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: screenHeight * 0.02),
        ),
        Spacer(),
      ],
    );
  }
}
