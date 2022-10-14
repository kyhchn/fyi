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
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoryItem(
                color: CustomColor.toscaBlue,
                icon: Icons.abc,
                text: 'halooo',
              ),
              CategoryItem(
                color: CustomColor.lightGrey,
                icon: Icons.abc,
                text: 'halooo',
              ),
              CategoryItem(
                color: CustomColor.pink,
                icon: Icons.abc,
                text: 'halooo',
              ),
              CategoryItem(
                color: CustomColor.lightYellow,
                icon: Icons.abc,
                text: 'halooo',
              ),
            ],
          ),
          width: double.infinity,
          height: size.height * 0.12,
        )
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  String text;
  IconData icon;
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
          Icon(
            icon,
            color: Colors.blue,
          ),
          Text(text)
        ],
      ),
      height: 75,
      width: 75,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }
}
