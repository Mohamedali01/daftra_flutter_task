import 'package:daftra_flutter_task/src/catalog/item.dart';

abstract class CartEvent {}

class AddItem extends CartEvent {
  final Item item;
  AddItem(this.item);
}

class RemoveItem extends CartEvent {
  final String itemId;
  RemoveItem(this.itemId);
}

class ChangeQty extends CartEvent {
  final String itemId;
  final int qty;
  ChangeQty(this.itemId, this.qty);
}

class ChangeDiscount extends CartEvent {
  final String itemId;
  final double discount;
  ChangeDiscount(this.itemId, this.discount);
}

class ClearCart extends CartEvent {}
