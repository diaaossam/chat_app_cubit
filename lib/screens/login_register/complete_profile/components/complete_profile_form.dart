import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../shared/helper/constants.dart';
import '../../../../../shared/helper/size_config.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/helper/methods.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/form_error.dart';
import '../../../main_layout/main_screen.dart';
import '../cubit/complete_profile_cubit.dart';
import '../cubit/complete_profile_state.dart';

class CompleteProfileForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var phoneNumber = TextEditingController();
  var address = TextEditingController();
  var dateOfBirth = TextEditingController();

  void addError({required CompleteProfileCubit cubit, String? error}) {
    if (!cubit.errors.contains(error)) cubit.setErrors(error!);
  }

  void removeError({required CompleteProfileCubit cubit, String? error}) {
    if (cubit.errors.contains(error)) cubit.removeErrors(error!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is LoadingUploadUserInfoCompleteProfile) {
          showCustomProgressIndicator(context);
        } else if (state is ErrorUploadUserInfoCompleteProfile) {
          Navigator.pop(context);
          showSnackBar(context, state.errorMsg);
        } else if (state is SucessUploadUserInfoCompleteProfile) {
          navigateToAndFinish(context, MainScreen());
        }
      },
      builder: (context, state) {
        CompleteProfileCubit cubit = CompleteProfileCubit.get(context);
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: firstName,
                  lableText: "First Name",
                  hintText: "Enter your first name",
                  type: TextInputType.text,
                  suffixIcon: "assets/icons/User.svg",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(cubit: cubit, error: kNamelNullError);
                    }
                    return null;
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      addError(cubit: cubit, error: kNamelNullError);
                      return "";
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                CustomTextFormField(
                  controller: lastName,
                  lableText: "Last Name",
                  hintText: "Enter your last name",
                  type: TextInputType.text,
                  suffixIcon: "assets/icons/User.svg",
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                CustomTextFormField(
                  controller: phoneNumber,
                  lableText: "Phone Number",
                  hintText: "Enter your phone number",
                  type: TextInputType.phone,
                  suffixIcon: "assets/icons/Phone.svg",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(cubit: cubit, error: kPhoneNumberNullError);
                    }
                    return null;
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      addError(cubit: cubit, error: kPhoneNumberNullError);
                      return "";
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                CustomTextFormField(
                  controller: address,
                  lableText: "Address",
                  hintText: "Enter your address",
                  type: TextInputType.streetAddress,
                  suffixIcon: "assets/icons/Location point.svg",
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(cubit: cubit, error: kAddressNullError);
                    }
                    return null;
                  },
                  validate: (value) {
                    if (value!.isEmpty) {
                      addError(cubit: cubit, error: kAddressNullError);
                      return "";
                    }
                    return null;
                  },
                  isPassword: false,
                ),
                SizedBox(height: getProportionateScreenHeight(30)),
                CustomTextFormField(
                  controller: dateOfBirth,
                  lableText: "Birth Date",
                  hintText: "Enter your birth date",
                  type: TextInputType.streetAddress,
                  suffixIcon: "assets/icons/calender.svg",
                  onTap: (){
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2021, 12, 31),
                      lastDate: DateTime.now(),
                    ).then((value) => dateOfBirth.text =
                        DateFormat.yMMMd().format(value!));
                  },
                ),
                FormError(errors: cubit.errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                CustomButton(
                    text: 'Continue',
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.setUserInfo(
                            userModel: UserModel(
                              token: 'token',
                                uid: cubit.getLoggedInUser().uid,
                                bio: 'Hello I`m Using Chat App .. !',
                                image: 'DEFULT',
                                firstName: firstName.text,
                                lastName: lastName.text,
                                phone: phoneNumber.text,
                                address: address.text,
                                dateOfBirth: dateOfBirth.text));
                      }
                    })
              ],
            ),
          ),
        );
      },
    );
  }


}
