class StartupUser {
  String uid, name, email, numberPhone, adress;
  bool isVerified;
  String? profileImage, instagramLink, linkedinLink, twitterLink, description;
  StartupUser(
      {required this.uid,
      required this.isVerified,
      this.description,
      this.twitterLink,
      this.instagramLink,
      this.linkedinLink,
      this.profileImage,
      required this.name,
      required this.adress,
      required this.email,
      required this.numberPhone});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['isVerified'] = isVerified;
    data['profileImage'] = profileImage;
    data['email'] = email;
    data['numberPhone'] = numberPhone;
    data['adress'] = adress;
    data['description'] = description;
    data['linkedinLink'] = linkedinLink;
    data['instagramLink'] = instagramLink;
    data['twitterLink'] = twitterLink;
    return data;
  }

  factory StartupUser.fromJson(Map<String, dynamic> json) {
    return StartupUser(
        uid: json['uid'],
        isVerified: json['isVerified'],
        profileImage: json['profileImage'],
        name: json['name'],
        description: json['description'],
        instagramLink: json['instagramLink'],
        linkedinLink: json['linkedinLink'],
        twitterLink: json['twitterLink'],
        adress: json['adress'],
        email: json['email'],
        numberPhone: json['numberPhone']);
  }
}
