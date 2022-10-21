class InvestorUser {
  String uid, name, email, numberPhone, adress, dateTime, ktpUrl;
  String? profileImage;
  int? totalInvestment;
  InvestorUser(
      {required this.uid,
      required this.ktpUrl,
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
    data['uid'] = uid;
    data['name'] = name;
    data['profileImage'] = profileImage;
    data['email'] = email;
    data['numberPhone'] = numberPhone;
    data['adress'] = adress;
    data['dateTime'] = dateTime;
    data['totalInvestment'] = totalInvestment;
    return data;
  }

  factory InvestorUser.fromJson(Map<String, dynamic> json) {
    return InvestorUser(
        ktpUrl: json['ktpUrl'],
        uid: json['uid'],
        profileImage: json['profileImage'],
        name: json['name'],
        adress: json['adress'],
        dateTime: json['dateTime'],
        email: json['email'],
        numberPhone: json['numberPhone'],
        totalInvestment: json['totalInvestment'] ?? 0);
  }
}
