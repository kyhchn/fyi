class TransactionModel {
  String startupUid, investorUid, status, message, startupName, investorName;
  late String combinedUid;
  TransactionModel(
      {required this.investorUid,
      required this.message,
      required this.startupUid,
      required this.startupName,
      required this.investorName,
      required this.status}) {
    combinedUid = startupUid + investorUid;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['startupUid'] = startupUid;
    data['startupName'] = startupName;
    data['investorName'] = investorName;
    data['message'] = message;
    data['investorUid'] = investorUid;
    data['status'] = status;
    data['combinedUid'] = combinedUid;
    return data;
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        investorName: json['investorName'],
        startupName: json['startupName'],
        investorUid: json['investorUid'],
        message: json['message'],
        startupUid: json['startupUid'],
        status: json['status']);
  }
}
