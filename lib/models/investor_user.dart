class InvestorUser {
  String uid, name, email, numberPhone, adress, dateTime, ktpUrl;
  bool isVerified;
  String? profileImage, description, linkedinLink, instagramLink, twitterLink;
  int? totalInvestment;
  InvestorUser(
      {required this.uid,
      required this.isVerified,
      required this.ktpUrl,
      this.description,
      this.linkedinLink,
      this.instagramLink,
      this.twitterLink,
      required this.profileImage,
      required this.name,
      required this.adress,
      required this.dateTime,
      required this.email,
      required this.numberPhone,
      this.totalInvestment});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ktp'] = ktpUrl;
    data['isVerified'] = isVerified;
    data['uid'] = uid;
    data['description'] = description;
    data['name'] = name;
    data['profileImage'] = profileImage;
    data['email'] = email;
    data['numberPhone'] = numberPhone;
    data['adress'] = adress;
    data['dateTime'] = dateTime;
    data['totalInvestment'] = totalInvestment;
    data['linkedinLink'] = linkedinLink;
    data['instagramLink'] = instagramLink;
    data['twitterLink'] = twitterLink;
    return data;
  }

  factory InvestorUser.fromJson(Map<String, dynamic> json) {
    return InvestorUser(
        ktpUrl: json['ktp'],
        isVerified: json['isVerified'],
        uid: json['uid'],
        description: json['description'],
        twitterLink: json['twitterLink'],
        instagramLink: json['instagramLink'],
        linkedinLink: json['linkedinLink'],
        profileImage: json['profileImage'],
        name: json['name'],
        adress: json['adress'],
        dateTime: json['dateTime'],
        email: json['email'],
        numberPhone: json['numberPhone'],
        totalInvestment: json['totalInvestment'] ?? 0);
  }
}
