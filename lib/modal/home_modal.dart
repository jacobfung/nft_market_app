import 'package:flutter/material.dart';
import 'package:nft_market/utils/color_util.dart';

class Category {
  String imgPath;
  Color bgColor;
  String title;

  Category({required this.imgPath, required this.bgColor, required this.title});

  static List<Category> categoryList = <Category>[
    Category(
      imgPath: 'assets/images/art.png',
      bgColor: const Color.fromRGBO(213, 154, 49, .17),
      title: 'Art'
    ),
    Category(
      imgPath: 'assets/images/sports.png',
      bgColor: const Color.fromRGBO(229, 116, 52, .17),
      title: 'Sports'
    ),
    Category(
      imgPath: 'assets/images/music.png',
      bgColor: const Color.fromRGBO(214, 127, 127, .17),
      title: 'Music'
    ),
    Category(
      imgPath: 'assets/images/photo.png',
      bgColor: const Color.fromRGBO(60, 60, 60, .17),
      title: 'Photo'
    ),
  ];
}

class BidingGoods {
  String imgPath;
  String author;
  String title;
  String value;
  String timesLeft;
  String bigImgPath;

  BidingGoods({
    required this.imgPath,
    required this.bigImgPath,
    required this.author, 
    required this.title, 
    required this.value, 
    required this.timesLeft
  });

  static List<BidingGoods> bidingGoodsList = <BidingGoods>[
    BidingGoods(
      imgPath: 'assets/images/first_goods.png',
      bigImgPath: 'assets/images/first_goods_big.png',
      author: 'Shapire Cole',
      title: 'The Astronut 321',
      value: '0.47',
      timesLeft: '3h 12m 36s'
    ),
    BidingGoods(
      imgPath: 'assets/images/sec_goods.png',
      bigImgPath: 'assets/images/sec_goods_big.png',
      author: 'Golden Future',
      title: 'The sky 565',
      value: '0.47',
      timesLeft: '3h 12m 36s'
    ),
    BidingGoods(
      imgPath: 'assets/images/third_goods.png',
      bigImgPath: 'assets/images/third_goods.png',
      author: 'Shapire Cole',
      title: 'The Astronut 321',
      value: '0.47',
      timesLeft: '3h 12m 36s'
    ),
  ];
}
class Collections {
  String imgPath;
  String author;
  String title;
  String value;
  String riseAndFall;

  Collections({required this.imgPath, required this.author, required this.title, required this.value, required this.riseAndFall});

  static List<Collections> bidingGoodsList = <Collections>[
    Collections(
      imgPath: 'assets/images/first_clt.png',
      author: 'Adezuq_blk',
      title: 'queen a',
      value: '4,218',
      riseAndFall: '+23.00%'
    ),
    Collections(
      imgPath: 'assets/images/sec_clt.png',
      author: 'RoycoJack',
      title: 'Astro',
      value: '4,017',
      riseAndFall: '-32.01%'
    ),
    Collections(
      imgPath: 'assets/images/third_clt.png',
      author: '_AxiomaBetrix',
      title: 'dardar',
      value: '3,122',
      riseAndFall: '-10.98%'
    ),
    Collections(
      imgPath: 'assets/images/first_clt.png',
      author: 'Adezuq_blk',
      title: 'queen a',
      value: '4,218',
      riseAndFall: '+23.00%'
    ),
    Collections(
      imgPath: 'assets/images/sec_clt.png',
      author: 'RoycoJack',
      title: 'Astro',
      value: '4,017',
      riseAndFall: '-32.01%'
    ),
    Collections(
      imgPath: 'assets/images/third_clt.png',
      author: '_AxiomaBetrix',
      title: 'dardar',
      value: '3,122',
      riseAndFall: '-10.98%'
    ),
  ];
}