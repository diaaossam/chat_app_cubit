part of 'friends_cubit.dart';

@immutable
abstract class FriendsState {}

class FriendsInitial extends FriendsState {}
class GetAllFrindsStateLoading extends FriendsState {}
class GetAllFrindsStateSuccess extends FriendsState {}
class GetAllFrindsStateFaliure extends FriendsState {
  String errorMsg;

  GetAllFrindsStateFaliure({required this.errorMsg});
}
