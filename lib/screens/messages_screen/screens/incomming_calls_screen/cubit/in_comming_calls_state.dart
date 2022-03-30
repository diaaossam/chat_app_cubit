part of 'in_comming_calls_cubit.dart';

@immutable
abstract class InCommingCallsState {}

class InCommingCallsInitial extends InCommingCallsState {}
class GetUserInfoStateLoading extends InCommingCallsState {}
class GetUserInfoStateSuccess extends InCommingCallsState {}
