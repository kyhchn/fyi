import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/funding.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/models/transaction.dart';
import 'package:fyi/services/funding_service.dart';
import 'package:fyi/services/investor_service.dart';
import 'package:fyi/services/transaction_service.dart';
import 'package:fyi/ui/widgets/loading_alert.dart';

class TransactionPage extends StatelessWidget {
  bool isStartup;
  String uid;
  TransactionPage({super.key, required this.isStartup, required this.uid});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: double.infinity,
          height: size.height * 0.1,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction History',
                style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: TransactionService().getTransactionStream(isStartup, uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TransactionModel> data = [];
                  snapshot.data!.docs.forEach(
                    (element) =>
                        data.add(TransactionModel.fromJson(element.data())),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: ListView.separated(
                        itemBuilder: (context, index) => TransactionItem(
                            size, data[index], isStartup, context),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 15,
                            ),
                        itemCount: data.length),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }

  ListTile TransactionItem(Size size, TransactionModel transactionModel,
      bool isStratup, BuildContext context) {
    return ListTile(
      iconColor: CustomColor.lightBlue,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      tileColor: CustomColor.lighterLightBlue.withOpacity(0.2),
      leading: const Icon(
        Icons.person,
        size: 40,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isStratup
                ? transactionModel.investorName
                : transactionModel.startupName,
            style: TextStyle(color: CustomColor.lightBlue),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 0),
            decoration: BoxDecoration(
                color: transactionModel.status == 'Success'
                    ? Colors.green
                    : transactionModel.status == 'Failed'
                        ? Colors.red
                        : transactionModel.status == 'Confirmation'
                            ? Colors.yellow
                            : Colors.brown.shade300,
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: Text(transactionModel.status),
          )
        ],
      ),
      subtitle: Column(
        children: [
          Text(transactionModel.message),
          transactionModel.status == 'Confirmation' && !isStartup
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            backgroundColor: MaterialStateProperty.all(
                                CustomColor.lightBlue),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14))))),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                LoadingAlert(message: 'Loading...'),
                          );
                          await TransactionService()
                              .updateStatus("Success", transactionModel);
                          InvestorUser? investorUser =
                              await InvestorService().getUser(uid);
                          int totalInvest = investorUser!.totalInvestment!;
                          Funding? funding = await FundingService()
                              .getFunding(transactionModel.startupUid);
                          totalInvest += funding!.totalFunds as int;
                          investorUser.totalInvestment = totalInvest;
                          await InvestorService().updateUser(investorUser);
                          Navigator.pop(context);
                        },
                        child: const Text('Invest')),
                    SizedBox(
                      width: size.width * 0.05,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size.zero),
                            backgroundColor:
                                MaterialStateProperty.all(CustomColor.grey),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 1)),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(14))))),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                LoadingAlert(message: 'Loading...'),
                          );
                          await TransactionService()
                              .updateStatus("Failed", transactionModel);
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )
              : const SizedBox(
                  height: 0,
                )
        ],
      ),
    );
  }
}
