import 'package:bloc/bloc.dart';
import 'package:daftra_flutter_task/src/cart/bloc/cart_event.dart';
import 'package:daftra_flutter_task/src/cart/bloc/cart_state.dart';
import 'package:daftra_flutter_task/src/cart/models.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.empty()) {
    /// First I check if the cart item already exists in the cart
    /// and if not, I add it with a quantity of 0.
    on<AddItem>((event, emit) {
      final existing = state.lines.firstWhere(
        (line) => line.item.id == event.item.id,
        orElse: () => CartLine(item: event.item, quantity: 0),
      );

      /// then here I add all items except the existing one
      /// which add it separately and increase its quantity by 1.
      ///  This way, if the item already exists, it will just increase the quantity.
      /// If it doesn't exist, it will add it with a quantity of 1
      /// because we added it before with quantity 0.
      final updatedLines = [
        ...state.lines.where((line) => line.item.id != event.item.id),
        existing.copyWith(quantity: existing.quantity + 1),
      ];
      emit(CartState(lines: updatedLines));
    });

    on<RemoveItem>((event, emit) {
      final updatedLines = state.lines
          .where((line) => line.item.id != event.itemId)
          .toList();
      emit(CartState(lines: updatedLines));
    });

    on<ChangeQty>((event, emit) {
      final updatedLines = state.lines.map((line) {
        return line.item.id == event.itemId
            ? line.copyWith(quantity: event.qty)
            : line;
      }).toList();
      emit(CartState(lines: updatedLines));
    });

    on<ChangeDiscount>((event, emit) {
      final updatedLines = state.lines.map((line) {
        return line.item.id == event.itemId
            ? line.copyWith(discount: event.discount)
            : line;
      }).toList();
      emit(CartState(lines: updatedLines));
    });

    on<ClearCart>((event, emit) => emit(CartState.empty()));
  }
}
