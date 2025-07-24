import 'package:daftra_flutter_task/src/cart/bloc/cart_state.dart';

import 'models.dart';

class Receipt {
  final DateTime date;
  final List<CartLine> lines;
  final CartTotals totals;

  Receipt({
    required this.date,
    required this.lines,
    required this.totals,
  });
}

Receipt buildReceipt(CartState state, DateTime now) {
  return Receipt(
    date: now,
    lines: state.lines,
    totals: state.totals,
  );
}
