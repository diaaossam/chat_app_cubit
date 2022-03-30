import 'package:flutter/material.dart';
import '../../../../../shared/helper/size_config.dart';
import '../../../../../shared/styles/colors.dart';
import '../../../../models/phone_model.dart';


class PhoneContent extends StatelessWidget {

  final PhoneModel phoneModel;

  PhoneContent({required this.phoneModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: getProportionateScreenHeight(20.0),
        bottom: getProportionateScreenHeight(20.0),
        end: getProportionateScreenHeight(20.0)
      ),
      child: Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Image.asset(
              '${phoneModel.image}',
              height: getProportionateScreenHeight(250),
              width: getProportionateScreenWidth(300),
            ),
            SizedBox(height: SizeConfig.bodyHeight * 0.02),
            Padding(
              padding:  EdgeInsetsDirectional.only(start: getProportionateScreenHeight(25)),
              child: Text(
                "${phoneModel.text}",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(22.0),
                  color: kTextColor,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.bodyHeight * 0.08),
            Expanded(
              child: phoneModel.widget,
            ),
          ],
        ),
      ),
    );
  }
}
