import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/src/products/presentation/providers/products_repository_provider.dart';
import '../../domain/domain.dart';

//EL que no va proveeder el estado a manera global
final productsProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductsNotifier(productsRepository: productsRepository);
});

//State Notifier Provider
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;
  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    //Siempre voy a cargar esta peticion de primero
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading) return;
    if (state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    print("Peticion");
    final products = await productsRepository.getProductsByPage(
        limit: state.limit, offest: state.offest);
    if (products.isEmpty) {
      state.copyWith(isLastPage: true, isLoading: false);
    } else {
      state = state.copyWith(
          isLastPage: false,
          isLoading: false,
          offest: state.offest + 10,
          products: [...state.products, ...products]);
    }
  }
}

//State => Como quiero que luzca la informacion del estado

class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offest;
  final bool isLoading;
  final List<Product> products;

  ProductsState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offest = 0,
      this.isLoading = false,
      this.products = const []});

  ProductsState copyWith(
          {bool? isLastPage,
          int? limit,
          int? offest,
          bool? isLoading,
          List<Product>? products}) =>
      ProductsState(
          isLastPage: isLastPage ?? this.isLastPage,
          limit: limit ?? this.limit,
          offest: offest ?? this.offest,
          isLoading: isLoading ?? this.isLoading,
          products: products ?? this.products);
}
