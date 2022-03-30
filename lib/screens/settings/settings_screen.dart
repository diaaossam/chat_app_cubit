import 'dart:io';
import 'package:chat_app/screens/settings/cubit/settings_cubit.dart';
import 'package:chat_app/shared/helper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (BuildContext context) => SettingsCubit()..getUserInfo(),
      child: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {},
        builder: (context, state) {
          SettingsCubit cubit = SettingsCubit.get(context);
          return Scaffold(
            body: state is GetUserInfoLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.bodyHeight * 0.08,
                      ),
                      Center(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: SizeConfig.bodyHeight * .105,
                                  backgroundColor: kPrimaryColor,
                                ),
                                CircleAvatar(
                                  radius: SizeConfig.bodyHeight * .1,
                                  backgroundColor: Colors.white,
                                  backgroundImage: setImage(cubit),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              backgroundColor: kPrimaryColor,
                              radius: getProportionateScreenHeight(25.0),
                              child: IconButton(
                                  onPressed: () {
                                    cubit.getproductImage();
                                  },
                                  icon: Icon(Icons.camera_alt)),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
          );
        },
      ),
    );
  }

  ImageProvider setImage(SettingsCubit cubit) {
    if (cubit.userModel!.image == 'DEFULT') {
      return AssetImage('assets/images/user.png');
    } else {
      if (cubit.profileImage != null) {
        return FileImage(cubit.profileImage ?? File(''));
      } else {
        return NetworkImage(cubit.userModel!.image ?? '');
      }
    }
  }
}
