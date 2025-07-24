import 'package:daftra_flutter_task/src/catalog/bloc/catalog_bloc.dart';
import 'package:daftra_flutter_task/src/catalog/bloc/catalog_events.dart';
import 'package:daftra_flutter_task/src/catalog/bloc/catalog_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Catalog Bloc Test', () {
    late CatalogBloc bloc;

    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();
    });

    setUp(() {
      bloc = CatalogBloc();
    });

    blocTest<CatalogBloc, CatalogState>(
      'loads catalog from JSON',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadCatalog()),
      expect: () => [isA<CatalogLoaded>()],
    );
  });
}
