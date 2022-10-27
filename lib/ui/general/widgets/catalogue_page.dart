import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/funding.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/services/funding_service.dart';
import 'package:fyi/ui/general/category_detail_page.dart';
import 'package:fyi/ui/general/startup_detail_page.dart';

class CataloguePage extends StatelessWidget {
  InvestorUser? investorUser;
  User user;
  CataloguePage(
      {super.key,
      required this.isStartup,
      this.investorUser,
      required this.user});
  bool isStartup;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                'Categories',
                style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: size.height * 0.12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryItem(
                isStartup: isStartup,
                user: user,
                color: CustomColor.toscaBlue,
                icon: const ImageIcon(
                  AssetImage('assets/icons/computerIcon.png'),
                  color: Colors.blue,
                ),
                text: 'Technology',
              ),
              CategoryItem(
                isStartup: isStartup,
                user: user,
                color: CustomColor.lightGrey,
                icon: const ImageIcon(AssetImage('assets/icons/dollarIcon.png'),
                    color: Colors.blue),
                text: 'Finance',
              ),
              CategoryItem(
                isStartup: isStartup,
                user: user,
                color: CustomColor.pink,
                icon: const ImageIcon(AssetImage('assets/icons/healthIcon.png'),
                    color: Colors.blue),
                text: 'Health',
              ),
              CategoryItem(
                isStartup: isStartup,
                user: user,
                color: CustomColor.lightYellow,
                icon: const ImageIcon(
                  AssetImage('assets/icons/bachelorIcon.png'),
                  color: Colors.blue,
                ),
                text: 'Education',
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Text(
            'Most Popular',
            style: TextStyle(color: CustomColor.lightBlue, fontSize: 22),
          ),
        ),
        StreamBuilder(
            stream: FundingService().getCollectionReference().snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Funding> data = [];
                for (var element in snapshot.data!.docs) {
                  data.add(Funding.fromJson(element.data()));
                }
                return Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
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
                  ),
                ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  String text;
  ImageIcon icon;
  Color color;
  bool isStartup;
  User user;
  InvestorUser? investorUser;
  CategoryItem(
      {Key? key,
      required this.icon,
      required this.user,
      required this.text,
      this.investorUser,
      required this.color,
      required this.isStartup})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => CategoryDetailPage(
          user: user,
          investorUser: investorUser,
          category: text,
          isStartup: isStartup,
        ),
      )),
      child: Container(
        height: 75,
        width: 75,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(
              text,
              style: const TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
