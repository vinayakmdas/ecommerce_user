abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final String imageUrl;
  ProfileSuccess(this.imageUrl);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
