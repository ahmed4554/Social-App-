import 'package:social_app/cubit/cubit.dart';

abstract class SocialAppStatesMain {}

class ShopAppMainCubitInitialState extends SocialAppStatesMain {}

class ShopAppMainCubitGetUserDataLoadingState extends SocialAppStatesMain {}

class ShopAppMainCubitGetUserDataSuccesState extends SocialAppStatesMain {
  bool isEmailVerified;
  ShopAppMainCubitGetUserDataSuccesState(this.isEmailVerified);
}

class ShopAppMainCubitGetUserDataFailedState extends SocialAppStatesMain {}

class ChangeNavBarState extends SocialAppStatesMain {}

class ImagePickerProfileSucces extends SocialAppStatesMain {}

class ImagePickerProfileFailed extends SocialAppStatesMain {}

class ImagePickerCoverSucces extends SocialAppStatesMain {}

class ImagePickerCoverFailed extends SocialAppStatesMain {}

class UpdateUserDataSuccessState extends SocialAppStatesMain {}

class UpdateUserDataErrorState extends SocialAppStatesMain {}

class UploadProfileImageSuccessState extends SocialAppStatesMain {}

class UploadProfileImageErrorState extends SocialAppStatesMain {}

class UploadCoverImageSuccessState extends SocialAppStatesMain {}

class UploadCoverImageErrorState extends SocialAppStatesMain {}

class ImagePickerPostSucces extends SocialAppStatesMain {}

class ImagePickerPostFailed extends SocialAppStatesMain {}

class UploadPostImageLoadingState extends SocialAppStatesMain {}

class UploadPostImageSuccessState extends SocialAppStatesMain {}

class UploadPostImageErrorState extends SocialAppStatesMain {}

class CreatePostLoadingState extends SocialAppStatesMain {}

class CreatePostSuccessState extends SocialAppStatesMain {}

class CreatePostErrorState extends SocialAppStatesMain {}

class RemovePostImageState extends SocialAppStatesMain {}

class GetPostsLoadingState extends SocialAppStatesMain {}

class GetPostsSuccessState extends SocialAppStatesMain {}

class GetPostsErrorState extends SocialAppStatesMain {
  String error;
  GetPostsErrorState(this.error);
}

class LikePostSuccessState extends SocialAppStatesMain {}

class GetLikedPostsSuccessState extends SocialAppStatesMain {}

class LikePostErrorState extends SocialAppStatesMain {
  String error;
  LikePostErrorState(this.error);
}

class GetAllUsersLoadingState extends SocialAppStatesMain {}

class GetAllUsersSuccessState extends SocialAppStatesMain {}

class GetAllUsersErrorState extends SocialAppStatesMain {
  String error;
  GetAllUsersErrorState(this.error);
}

class SendMessageSuccessState extends SocialAppStatesMain {}

class SendMessageErrorState extends SocialAppStatesMain {}

class GetMessageSuccessState extends SocialAppStatesMain {}
