import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:tracker/screens/onboarding_screen.dart';

Color kPrimaryColor = Colors.blue.shade900;
double kBorderRadius = 12;

// Determines the onboarding screen information
final List<Onboard> demo_data = [
  Onboard(
    illustration: UnDrawIllustration.mobile_application,
    title: "Title 1",
    description: "Title 1 description",
  ),
  Onboard(
    illustration: UnDrawIllustration.mobile_application,
    title: "Influencers all around",
    description:
        "And there are so many different influencers, websites, and more \n that show you the coolest halal places in NYC",
  ),
  Onboard(
    illustration: UnDrawIllustration.mobile_application,
    title: "All in one place",
    description:
        "Our goal is to put all the amazing halal places in one place. \nFind and explore neighborhood stores around you! \n Let's get started!",
  ),
];
