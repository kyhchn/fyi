class StartupUser {
  String uid, name, email, numberPhone, adress, profileImage;
  DateTime dateTime;
  int? totalInvestment;
  StartupUser(
      {required this.uid,
      required this.profileImage,
      required this.name,
      required this.adress,
      required this.dateTime,
      required this.email,
      required this.numberPhone,
      this.totalInvestment});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['uid'] = uid;
    data['name'] = name;
    data['profileImage'] = profileImage;
    data['email'] = email;
    data['numberPhone'] = numberPhone;
    data['adress'] = adress;
    data['dateTime'] = dateTime.microsecondsSinceEpoch;
    data['totalInvestment'] = totalInvestment;
    return data;
  }

  factory StartupUser.fromJson(Map<String, dynamic> json) {
    return StartupUser(
        uid: json['uid']!,
        profileImage: json['profileImage'],
        name: json['name'],
        adress: json['adress'],
        dateTime: json['dateTime'],
        email: json['email'],
        numberPhone: json['numberPhone'],
        totalInvestment: json['totalInvestment'] ?? 0);
  }
}
