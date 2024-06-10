class ProfileModel {
  String? name, mobile, email, profile, uid, token;

  ProfileModel(
      {this.name, this.email, this.mobile, this.profile, this.uid, this.token});

  factory ProfileModel.maptoModel(Map m1, String id) {
    return ProfileModel(
        profile: m1['profile'],
        mobile: m1['mobile'],
        email: m1['email'],
        name: m1['name'],
        token: m1['token'],
        uid: id);
  }
}
