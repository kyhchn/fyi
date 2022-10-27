import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/funding.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/services/funding_service.dart';
import 'package:fyi/ui/general/startup_detail_page.dart';

class CategoryDetailPage extends StatelessWidget {
  User user;
  InvestorUser? investorUser;
  String category;
  bool isStartup;
  CategoryDetailPage(
      {super.key,
      required this.user,
      required this.category,
      required this.isStartup,
      this.investorUser});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15), right: Radius.circular(15))),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          category,
          style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: FutureBuilder(
            future: FundingService().getFundingCollectionByCategory(category),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                List<Funding> data = [];
                snapshot.data!.docs.forEach((element) {
                  data.add(Funding.fromJson(element.data()));
                });
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.8,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartupDetailPage(
                              user: user,
                              funding: data[index],
                              isStartup: isStartup),
                        )),
                    child: Card(
                      elevation: 4.5,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: size.height * 0.15,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data[index].imageUrl)),
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].startupName),
                                  Text(
                                    '\$${data[index].totalFunds}',
                                    style: TextStyle(color: CustomColor.grey),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  itemCount: data.length,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
