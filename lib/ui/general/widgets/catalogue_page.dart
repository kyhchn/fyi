import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';

class CataloguePage extends StatelessWidget {
  const CataloguePage({super.key});

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
                color: CustomColor.toscaBlue,
                icon: const ImageIcon(
                  AssetImage('assets/icons/computerIcon.png'),
                  color: Colors.blue,
                ),
                text: 'Technology',
              ),
              CategoryItem(
                color: CustomColor.lightGrey,
                icon: const ImageIcon(AssetImage('assets/icons/dollarIcon.png'),
                    color: Colors.blue),
                text: 'Finance',
              ),
              CategoryItem(
                color: CustomColor.pink,
                icon: const ImageIcon(AssetImage('assets/icons/healthIcon.png'),
                    color: Colors.blue),
                text: 'Health',
              ),
              CategoryItem(
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
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.8,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemBuilder: (context, index) => Card(
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
                      color: CustomColor.lightBlue,
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
                          const Text('Startup Name'),
                          Text(
                            '\$1k',
                            style: TextStyle(color: CustomColor.grey),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            itemCount: 10,
          ),
        ))
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  String text;
  ImageIcon icon;
  Color color;
  CategoryItem(
      {Key? key, required this.icon, required this.text, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      height: 75,
      width: 75,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
    );
  }
}
