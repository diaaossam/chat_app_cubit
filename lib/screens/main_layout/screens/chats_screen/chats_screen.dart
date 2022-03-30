import 'package:chat_app/screens/main_layout/cubit/main_cubit.dart';
import 'package:chat_app/widgets/custom_user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {

        },
        builder: (cotext, state) {
          return ListView.builder(
              itemCount: MainCubit.get(context).userList.length,
              itemBuilder: (context, index) {
                return CustomUserItem(
                    userModel: MainCubit.get(context).userList[index]);
              });
        });
  }
}
