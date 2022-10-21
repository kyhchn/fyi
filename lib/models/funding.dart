class Funding {
  String startupName,
      totalFunds,
      startupUid,
      companyProfileUrl,
      bussinessPlanUrl,
      fundingProposalUrl;
  String? cashFlowUrl;
  Funding(
      {required this.startupName,
      required this.bussinessPlanUrl,
      this.cashFlowUrl,
      required this.companyProfileUrl,
      required this.fundingProposalUrl,
      required this.startupUid,
      required this.totalFunds});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['startupName'] = startupName;
    data['totalFunds'] = totalFunds;
    data['startupUid'] = startupUid;
    data['companyProfileUrl'] = companyProfileUrl;
    data['bussinessPlanUrl'] = bussinessPlanUrl;
    data['fundingProposalUrl'] = fundingProposalUrl;
    data['cashFlowUrl'] = cashFlowUrl;
    return data;
  }

  factory Funding.fromJson(Map<String, dynamic> json) {
    return Funding(
        startupName: json['startupName'],
        bussinessPlanUrl: json['bussinessPlanUrl'],
        companyProfileUrl: json['companyProfileUrl'],
        fundingProposalUrl: json['fundingProposalUrl'],
        startupUid: json['startupUid'],
        totalFunds: json['totalFunds']);
  }
}
