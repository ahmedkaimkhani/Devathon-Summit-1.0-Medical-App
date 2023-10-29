import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDoctor extends StatelessWidget {
  final String name;
  final String subtile;
  final Image? image;
  const CustomDoctor(
      {super.key, required this.name, required this.subtile, this.image});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: SvgPicture.asset('assets/images/dr1.svg'),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(name),
                        SizedBox(
                          height: 6,
                        ),
                        Text(subtile)
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
