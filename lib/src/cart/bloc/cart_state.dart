import 'package:daftra_flutter_task/src/cart/models.dart';
import 'package:equatable/equatable.dart';

class CartState extends Equatable {
  final List<CartLine> lines;
  final CartTotals totals;

  CartState({required this.lines}) : totals = CartTotals.fromLines(lines);

  factory CartState.empty() => CartState(lines: []);

  @override
  List<Object?> get props => [lines, totals];
}
