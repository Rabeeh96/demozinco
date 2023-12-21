import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


import '../../Api_Functions/Profile/profile_api.dart';
import '../../ModelClasses/Settings/ChangFirstNameModelClass.dart';
import '../../ModelClasses/Settings/ChangeEmailModelClass.dart';
import '../../ModelClasses/Settings/ChangeIsIntrestModelClass.dart';
import '../../ModelClasses/Settings/ChangeIsZakathModelClass.dart';
import '../../ModelClasses/Settings/ChangeNotificationModelClass.dart';
import '../../ModelClasses/Settings/ChangePasswordModelClass.dart';
import '../../ModelClasses/Settings/ChangeProfilePhotoModelClass.dart';
import '../../ModelClasses/Settings/changeRoundimgModelClass.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileApi profileApi;
  late ChangePasswordModelClass changePasswordModelClass ;
  late  ChangFirstNameModelClass changFirstNameModelClass ;
  late ChangeEmailModelClass changeEmailModelClass ;
  late ChangeNotificationModelClass notificationModelClass ;
  late  ChangeIsZakathModelClass changeIsZakathModelClass ;
  late  ChangeIsIntrestModelClass changeIsIntrestModelClass ;
  late ChangeProfilePhotoModelClass changeProfilePhotoModelClass ;
  late   ChangeRoundimgModelClass changeRoundimgModelClass ;




  ProfileBloc(this.profileApi) : super(ProfileInitial()) {
    on<FetchChangePassword>((event, emit)async {
      emit(ChangePasswordLoading());

      try{

        changePasswordModelClass = await profileApi.changePasswordFunction(userName: event.userName, currentPassword:  event.currentPassword, newPassword:  event.newPassword);

        emit(ChangePasswordLoaded());
      }catch(e){
        emit(ChangePasswordError());

      }

    });
    on<FetchChangeFirstName>((event, emit)async {
      emit(ChangeFirstNameLoading());

      try{

        changFirstNameModelClass = await profileApi.changeFirstNameFunction(organisation: event.organisation, firstName: event.firstName);

        emit(ChangeFirstNameLoaded());
      }catch(e){
        emit(ChangeFirstNameError());

      }

    });


    on<FetchChangeEmail>((event, emit)async {
      emit(ChangeEmailLoading());

      try{
        changeEmailModelClass = await profileApi.changeEmailFunction(organisation: event.organisation, email: event.email);

        emit(ChangeEmailLoaded());
      }catch(e){
        emit(ChangeEmailError());

      }

    });
    on<FetchChangeIsNotification>((event, emit)async {
      emit(ChangeIsNotificationLoading());

      try{

        notificationModelClass = await profileApi.changeIsNotificationFunction(organisation: event.organisation, IsNotification: event.IsNotification);

        emit(ChangeIsNotificationLoaded());
      }catch(e){
        emit(ChangeIsNotificationError());

      }

    });
    on<FetchChangeIsZakath>((event, emit)async {
      emit(ChangeIszakathLoading());

      try{

        changeIsZakathModelClass = await profileApi.changeIsZakathFunction(organisation: event.organisation, isZakath: event.IsZakath);

        emit(ChangeIszakathLoaded());
      }catch(e){
        emit(ChangeIszakathError());

      }

    });
    on<FetchChangeIsInterest>((event, emit)async {
      emit(ChangeIsinterestLoading());

      try{

        changeIsIntrestModelClass = await profileApi.changeIsIntrestFunction(organisation: event.organisation, IsInterest: event.IsInterest);

        emit(ChangeIsinterestLoaded());
      }catch(e){
        emit(ChangeIsinterestError());

      }

    });
    on<FetchProfilePicEvent>((event, emit)async {
      emit(ChangeProfilePicLoading());

      try{

        changeProfilePhotoModelClass = await profileApi.editProfilePicFunction( filePath: event.filePath,
            organisation:event.organisation);


        emit(ChangeProfilePicLoaded());
      }catch(e){
        emit(ChangeProfilePicError());

      }

    });



    on<FetchRoundingEvent>((event, emit)async {
      emit(ChangeRoundingLoading());

      try{



        changeRoundimgModelClass = await profileApi.changeRoundingFunction(organisation: event.organisation, value: event.value);

        emit(ChangeRoundingLoaded());
      }catch(e){
        emit(ChangeRoundingError());

      }

    });

  }
  }

