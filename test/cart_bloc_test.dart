import 'package:daftra_flutter_task/src/cart/bloc/cart_bloc.dart';
import 'package:daftra_flutter_task/src/cart/bloc/cart_event.dart';
import 'package:daftra_flutter_task/src/cart/bloc/cart_state.dart';
import 'package:daftra_flutter_task/src/catalog/item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

final item1 = Item(id: '1', name: 'Coffee', price: 10);
final item2 = Item(id: '2', name: 'Tea', price: 5);

void main() {
  group('Cart Bloc Test', () {
    late CartBloc bloc;

    setUp(() => bloc = CartBloc());

    blocTest<CartBloc, CartState>(
      'Add two items',
      build: () => bloc,
      act: (b) {
        b.add(AddItem(item1));
        b.add(AddItem(item2));
      },
      verify: (b) {
        final totals = b.state.totals;
        expect(totals.subtotal, 15.0);
        expect(totals.vat, 2.25);
        expect(totals.grandTotal, 17.25);
      },
    );

    blocTest<CartBloc, CartState>(
      'Change quantity and discount',
      build: () => bloc,
      act: (b) {
        b.add(AddItem(item1));
        b.add(ChangeQty(item1.id, 2));
        b.add(ChangeDiscount(item1.id, 0.5));
      },
      verify: (b) {
        expect(b.state.totals.subtotal, 10.0);
      },
    );

    blocTest<CartBloc, CartState>(
      'Clear cart resets state',
      build: () => bloc,
      act: (b) {
        b.add(AddItem(item1));
        b.add(ClearCart());
      },
      expect: () => [isA<CartState>(), isA<CartState>()],
      verify: (b) => expect(b.state.lines, isEmpty),
    );
  });
}
