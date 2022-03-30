import 'package:flutter/material.dart';

import 'components/otp_body.dart';

class OtpScreen extends StatelessWidget {
  String number;


  OtpScreen(this.number);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: OtpBody(number),
    );
  }
}
