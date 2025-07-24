
import 'package:daftra_flutter_task/src/catalog/item.dart';


abstract class CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Item> items;
  CatalogLoaded(this.items);
}