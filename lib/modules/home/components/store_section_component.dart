import 'package:flutter/material.dart';
import 'package:organaki_app/core/colors_app.dart';
import 'package:organaki_app/core/extensions.dart';
import 'package:organaki_app/models/producer.dart';
import "dart:math";

class Database {
  final List<String> productsImagesDataBase = [
    'images/alface.jpg',
    'images/banana.jpg',
    'images/maças.jpg',
    'images/cenouras.jpg',
    'images/laticinios.jpg',
    'images/leite.jpg',
    'images/queijo.jpg',
    'images/tomate.jpg'
  ];
  final _random = Random();
}

class StoreSectionComponent extends StatelessWidget {
  const StoreSectionComponent({super.key, required this.producer});
  final Producer producer;

  @override
  Widget build(BuildContext context) {
    Database db = Database();
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorApp.blue3, width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: ColorApp.grey1),
                  child: const FlutterLogo(
                    size: 30,
                  )),
              8.sizeW,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            producer.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorApp.blue3,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Abhaya Libre',
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),
                        Flexible(
                          child: Text(
                            producer.email,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: ColorApp.grey2,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Abhaya Libre',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorApp.grey1,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.heart_broken,
                  color: Colors.red,
                ),
              )
            ],
          ),
          10.sizeH,
          const Divider(),
          10.sizeH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.airplane_ticket_outlined,
                    color: Colors.blue,
                  ),
                  3.sizeW,
                  const Text(
                    "200m",
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Icon(
                      Icons.star,
                      size: 18,
                      color: i == 4 ? ColorApp.grey1 : Colors.yellow,
                    ),
                  Text(
                    "(1.293)",
                    style: TextStyle(color: ColorApp.grey2, fontSize: 14),
                  ),
                ],
              ),
              const Text(
                "ABERTO",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Abhaya Libre',
                ),
              )
            ],
          ),
          20.sizeH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  height: 50,
                  width: 60,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: ColorApp.grey1,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(
                        db.productsImagesDataBase[db._random
                            .nextInt(db.productsImagesDataBase.length)],
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                )
            ],
          )
        ],
      ),
    );
  }
}
