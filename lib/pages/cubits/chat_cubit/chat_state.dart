part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class CatSuccess extends ChatState {
  final List<Message> messages;
  CatSuccess({required this.messages});
}

final class CatFailure extends ChatState {}
