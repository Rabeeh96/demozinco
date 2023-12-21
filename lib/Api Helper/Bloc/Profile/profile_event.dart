part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}
class FetchChangePassword extends ProfileEvent{
  final String userName;
  final String currentPassword;
  final String newPassword;

  FetchChangePassword({required this.userName,required this.currentPassword,required this.newPassword});

}
class FetchChangeFirstName extends ProfileEvent{
  final String organisation;
      final String firstName;

  FetchChangeFirstName({required this.organisation,required this.firstName});



}
class FetchChangeEmail extends ProfileEvent{
  final String organisation;
  final String email;

  FetchChangeEmail({required this.organisation,required this.email});
}
class FetchChangeIsNotification extends ProfileEvent{
  final String organisation;
  final bool IsNotification;

  FetchChangeIsNotification({required this.organisation,required this.IsNotification});
}
class FetchChangeIsZakath extends ProfileEvent{
  final String organisation;
  final bool IsZakath;

  FetchChangeIsZakath({required this.organisation,required this.IsZakath});
}


class FetchChangeIsBiometric extends ProfileEvent{
  final String organisation;
  final bool IsBiometric;

  FetchChangeIsBiometric({required this.organisation,required this.IsBiometric});
}
class FetchChangeIsInterest extends ProfileEvent{
  final String organisation;
  final bool IsInterest;

  FetchChangeIsInterest({required this.organisation,required this.IsInterest});
}
class FetchProfilePicEvent extends ProfileEvent {
  final File filePath;
  final String organisation;

  FetchProfilePicEvent({required this.filePath,required this.organisation});
}

class FetchRoundingEvent extends ProfileEvent{
  final String organisation;
  final String value;

  FetchRoundingEvent({required this.organisation,required this.value});
}