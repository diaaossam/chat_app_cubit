import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../shared/services/network/dio_helper.dart';

part 'out_comming_calls_state.dart';

class OutCommingCallsCubit extends Cubit<OutCommingCallsState> {
  OutCommingCallsCubit() : super(OutCommingCallsInitial());

  static OutCommingCallsCubit get(context) => BlocProvider.of(context);

  void setupCall(
      {required bool isVedio,
      required bool isCancel,
      required String receiverToken,
      required String userName,
      required String uid}) {
    final data = {
      "to": "${receiverToken}",
      "notification": {
        "body": "Calling ${userName} ..... ",
        "title": isVedio ? "Vedio Calling ... " : "Voice Calling ... ",
        "sound": "default"
      },
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_HIGH",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true,
        },
      },
      "data": {
        "uid": "${uid}",
        "cancel": isCancel ? true:false,
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
      }
    };
    DioHelper().postData(path: 'fcm/send', data: data).then((Response value) {
      if (value.statusCode == 200) {

      }
    });
  }
}
