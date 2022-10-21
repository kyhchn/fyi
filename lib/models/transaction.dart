class Transaction {
  String startupUid, investorUid, status, message;
  Transaction(
      {required this.investorUid,
      required this.message,
      required this.startupUid,
      required this.status});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['startupUid'] = startupUid;
    data['message'] = message;
    data['startupUid'] = startupUid;
    data['status'] = status;
    return data;
  }

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
        investorUid: json['investorUid'],
        message: json['message'],
        startupUid: json['startupUid'],
        status: json['status']);
  }
}
