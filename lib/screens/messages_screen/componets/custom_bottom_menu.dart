import 'package:chat_app/shared/helper/size_config.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class CustomBottomMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.bodyHeight * 0.35,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.all(getProportionateScreenHeight(15.0)),
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(getProportionateScreenHeight(15.0))),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(20.0)),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setBottomSheetColoum(
                      iconModel: IconModel(
                          title: "Document",
                          iconData: Icons.insert_drive_file,
                          color: Colors.indigo)),
                  SizedBox(
                    width: getProportionateScreenHeight(25.0),
                  ),
                  setBottomSheetColoum(
                      iconModel: IconModel(
                          title: "Camera",
                          iconData: Icons.camera_alt,
                          color: Colors.pink)),
                  SizedBox(
                    width: getProportionateScreenHeight(25.0),
                  ),
                  setBottomSheetColoum(
                      iconModel: IconModel(
                          title: "Gallery",
                          iconData: Icons.insert_photo,
                          color: Colors.purple)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  setBottomSheetColoum(
                      iconModel: IconModel(
                          title: "Audio",
                          iconData: Icons.headset,
                          color: Colors.orange)),
                  SizedBox(
                    width: getProportionateScreenHeight(25.0),
                  ),
                  setBottomSheetColoum(
                      iconModel: IconModel(
                          title: "Location",
                          iconData: Icons.location_pin,
                          color: Colors.teal)),
                  SizedBox(
                    width: getProportionateScreenHeight(25.0),
                  ),
                  setBottomSheetColoum(
                      iconModel: IconModel(
                          title: "Contact",
                          iconData: Icons.person,
                          color: Colors.blue)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget setBottomSheetColoum({required IconModel iconModel}) {
    return InkWell(
        onTap: (){
          if(iconModel.title =="Document"){}
          else if(iconModel.title =="Camera"){}
          else if(iconModel.title =="Gallery"){}
          else if(iconModel.title =="Audio"){}
          else if(iconModel.title =="Location"){}
          else if(iconModel.title =="Contact"){}
        },
      child: Column(
        children: [
          Container(
              width: getProportionateScreenHeight(60.0),
              height: getProportionateScreenHeight(60.0),
              decoration:
                  BoxDecoration(color: iconModel.color, shape: BoxShape.circle),
              child: Icon(iconModel.iconData,
                  color: Colors.white, size: getProportionateScreenHeight(35.0))),
          SizedBox(
            height: getProportionateScreenHeight(10.0),
          ),
          AppText(
            text: iconModel.title,
            color: Colors.black,
            textSize: getProportionateScreenHeight(17.0),
          )
        ],
      ),
    );
  }
}

class IconModel {
  String title;
  IconData iconData;
  Color color;

  IconModel({required this.title, required this.iconData, required this.color});
}
