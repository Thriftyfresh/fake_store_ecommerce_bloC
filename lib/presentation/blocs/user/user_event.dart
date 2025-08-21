part of 'user_bloc.dart';

abstract class UserEvent {}

class LoadUserProfile extends UserEvent {
  final int userId;
  LoadUserProfile(this.userId);
}
