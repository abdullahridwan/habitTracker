import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {
  const RectButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required double vp,
    required double hp,
    required Function() handler,
  })  : _formKey = formKey,
        _vp = vp,
        _hp = hp,
        _handler = handler,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final double _vp;
  final double _hp;
  final Function() _handler;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _hp, vertical: _vp),
      child: Container(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.9),
            elevation: 0,
          ),
          onPressed: _handler,
          child: const Text('Submit'),
        ),
      ),
    );
  }
}
