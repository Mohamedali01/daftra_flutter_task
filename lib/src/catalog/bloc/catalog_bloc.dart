import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:daftra_flutter_task/src/catalog/bloc/catalog_events.dart';
import 'package:daftra_flutter_task/src/catalog/bloc/catalog_state.dart';
import 'package:daftra_flutter_task/src/catalog/item.dart';
import 'package:flutter/services.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(CatalogLoading()) {
    on<LoadCatalog>((event, emit) async {
      final jsonAsString = await rootBundle.loadString('assets/catalog.json');
      final List decoded = json.decode(jsonAsString);
      final items = decoded.map((e) => Item.fromJson(e)).toList();
      emit(CatalogLoaded(items));
    });
  }
}
