class Funding {
  String startupName,
      startupCategory,
      dividend,
      totalFunds,
      startupUid,
      companyProfileUrl,
      shortDescription,
      bussinessPlanUrl,
      fundingProposalUrl,
      imageUrl;
  String? cashFlowUrl;
  Funding(
      {required this.startupName,
      required this.imageUrl,
      required this.shortDescription,
      required this.bussinessPlanUrl,
      required this.dividend,
      required this.startupCategory,
      this.cashFlowUrl,
      required this.companyProfileUrl,
      required this.fundingProposalUrl,
      required this.startupUid,
      required this.totalFunds});
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['startupCategory'] = startupCategory;
    data['dividend'] = dividend;
    data['shortDescription'] = shortDescription;
    data['imageUrl'] = imageUrl;
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
        imageUrl: json['imageUrl'],
        shortDescription: json['shortDescription'],
        dividend: json['dividend'],
        cashFlowUrl: json['cashFlowUrl'],
        startupCategory: json['startupCategory'],
        startupName: json['startupName'],
        bussinessPlanUrl: json['bussinessPlanUrl'],
        companyProfileUrl: json['companyProfileUrl'],
        fundingProposalUrl: json['fundingProposalUrl'],
        startupUid: json['startupUid'],
        totalFunds: json['totalFunds']);
  }
}
