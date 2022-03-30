part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}
class ChangeUserImage extends SettingsState {}
class GetUserInfoLoading extends SettingsState {}
class GetUserInfoSuccess extends SettingsState {}
class GetUserInfoFailure extends SettingsState {}
