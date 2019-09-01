import 'dart:collection';

import 'package:flutter/material.dart';
import 'Item.dart';

class CardModel extends ChangeNotifier {
  //用于保存购物车中的商品列表
  final List<Item> _items = [];

  //禁止改变购物车里的商品信息
  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  //购物车中的商品总价
  double get totalPrice =>
      _items.fold(0, (value, item) => value + item.count * item.price);

  //将Item添加到购物车，这是唯一一种从外部改变购物车的方法
  void addItem(Item item) {
    _items.add(item);
    //通知监听器，重新构建InheritedProvider 更新状态
    notifyListeners();
  }
}
