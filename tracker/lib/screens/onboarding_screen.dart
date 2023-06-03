import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/components/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    itemCount: demo_data.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => OnboardingContent(
                        illustration: demo_data[index].illustration,
                        text: demo_data[index].title,
                        description: demo_data[index].description)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ...List.generate(
                      demo_data.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_pageController.page == demo_data.length - 1) {
                            Navigator.pushNamed(context, "/auth");
                          } else {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Icon(Icons.arrow_right_alt),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;
    return Container(
      height: isActive ? sh * 0.04 : sh * 0.02,
      width: sh * 0.006,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor : Colors.grey.shade400,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onboard {
  final String title, description;
  final UnDrawIllustration illustration;
  Onboard(
      {required this.illustration,
      required this.title,
      required this.description});
}
