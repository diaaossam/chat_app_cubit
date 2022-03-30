part of 'message_cubit.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}
class ReadMessageState extends MessageState {}

//
 class SendMessageSuccessState extends MessageState {}
 class SendMessageErrorState extends MessageState {}
 class GetMessageSuccessState extends MessageState {}
 class GetMessageErrorState extends MessageState {}