import 'package:equatable/equatable.dart';
import '../catalog/item.dart';

class CartLine extends Equatable {
  final Item item;
  final int quantity;
  final double discount;

  const CartLine({
    required this.item,
    required this.quantity,
    this.discount = 0.0,
  });

  double get lineNet => item.price * quantity * (1 - discount);

  CartLine copyWith({int? quantity, double? discount}) {
    return CartLine(
      item: item,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
    );
  }

  @override
  List<Object?> get props => [item.id, quantity, discount];
}

class CartTotals extends Equatable {
  final double subtotal;
  final double vat;
  final double grandTotal;

  const CartTotals({
    required this.subtotal,
    required this.vat,
    required this.grandTotal,
  });

  factory CartTotals.fromLines(List<CartLine> lines) {
    final subtotal = lines.fold(0.0, (sum, line) => sum + line.lineNet);
    final vat = subtotal * 0.15;
    final grandTotal = subtotal + vat;
    return CartTotals(
      subtotal: double.parse(subtotal.toStringAsFixed(2)),
      vat: double.parse(vat.toStringAsFixed(2)),
      grandTotal: double.parse(grandTotal.toStringAsFixed(2)),
    );
  }

  @override
  List<Object?> get props => [subtotal, vat, grandTotal];
}
