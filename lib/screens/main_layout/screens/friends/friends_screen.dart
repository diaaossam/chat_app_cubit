import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/helper/methods.dart';
import '../../../../shared/helper/size_config.dart';
import '../../../../shared/styles/icon_broken.dart';
import '../../../../widgets/custom_user_item.dart';
import '../../../messages_screen/message_screen.dart';
import 'cubit/friends_cubit.dart';

class FriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsCubit()..getFriends(),
      child: BlocConsumer<FriendsCubit, FriendsState>(
        listener: (context, state) {
          if (state is GetAllFrindsStateFaliure) {
            showSnackBar(context, state.errorMsg);
          }
        },
        builder: (context, state) {
          FriendsCubit cubit = FriendsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Column(
                children: [
                  AppText(
                    text: 'Friends List',
                    color: Colors.white,
                    textSize: 24,
                  ),
                  AppText(
                    text: '${cubit.freindsList.length} contact',
                    color: Colors.white,
                    textSize: 16,
                  ),
                ],
              ),
              centerTitle: true,
              elevation: 20.0,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
              ],
            ),
            body: state is GetAllFrindsStateLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenHeight(15.0),
                        right: getProportionateScreenHeight(15.0),
                        top: getProportionateScreenHeight(15.0),
                        bottom: getProportionateScreenHeight(5.0),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              navigateToWithAnimation(
                                  context,
                                  MessageScreen(
                                      userModel: cubit.freindsList[0]));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(IconBroken.User1,
                                      color: Colors.white70,
                                      size: getProportionateScreenHeight(40)),
                                  backgroundColor: Colors.lightBlueAccent,
                                  radius: getProportionateScreenHeight(35.0),
                                ),
                                SizedBox(
                                  width: getProportionateScreenHeight(15.0),
                                ),
                                Column(
                                  children: [
                                    AppText(text: 'New Group'),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10.0)),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Icon(IconBroken.Add_User,
                                      color: Colors.white70,
                                      size: getProportionateScreenHeight(40)),
                                  backgroundColor: Colors.lightBlueAccent,
                                  radius: getProportionateScreenHeight(35.0),
                                ),
                                SizedBox(
                                  width: getProportionateScreenHeight(15.0),
                                ),
                                Column(
                                  children: [
                                    AppText(text: 'New Contact'),
                                  ],
                                ),
                                Spacer(),
                                Icon(Icons.qr_code),
                              ],
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10.0)),
                          cubit.freindsList.length == 0
                              ? AppText(
                                  text: 'No Friends ',
                                  isTitle: true,
                                  color: Colors.black38,
                                )
                              : ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: cubit.freindsList.length,
                                  physics: BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              getProportionateScreenHeight(7),
                                          horizontal:
                                              getProportionateScreenHeight(
                                                  20.0)),
                                      child: Container(
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return CustomUserItem(
                                      userModel: cubit.freindsList[index],
                                    );
                                  }),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
