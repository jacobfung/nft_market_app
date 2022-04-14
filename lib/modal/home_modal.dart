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

class BidingGoodsModel {
  List<BidingGoods>? bidingList;

  BidingGoodsModel.fromJson(Map<String, dynamic> json) {
    if (json['bidingList'] != null) {
      bidingList = List<BidingGoods>.empty(growable: true);
      json['bidingList'].forEach((v) {
        bidingList!.add(BidingGoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bidingList != null) {
      data['bidingList'] = bidingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class BidingGoods {
  late String imgPath;
  late String author;
  late String title;
  late String value;
  late String timesLeft;
  late String bigImgPath;

  BidingGoods.fromJson(Map<String, dynamic> json) {
    imgPath = json['imgPath'];
    author = json['author'];
    title = json['title'];
    value = json['value'];
    timesLeft = json['timesLeft'];
    bigImgPath = json['bigImgPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imgPath'] = imgPath;
    data['author'] = author;
    data['title'] = title;
    data['value'] = value;
    data['timesLeft'] = timesLeft;
    data['bigImgPath'] = bigImgPath;
    return data;
  }
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