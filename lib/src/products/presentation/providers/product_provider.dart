import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/src/products/domain/domain.dart';
//import 'package:teslo_shop/src/products/infrastructure/infrastrucuture.dart';
import 'package:teslo_shop/src/products/presentation/presentation.dart';

//Es autodispose para que se limpie cada vez que se va a utilziar
// y el family para esperar un valor cada vez que se va a utilizar
final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  print("object");
  return ProductNotifier(
      productsRepository: productsRepository, productId: productId);
});

//Este es el Notifier
class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productsRepository;

  //Este constructor crea la isntancia del ProductState
  ProductNotifier({required this.productsRepository, required String productId})
      : super(ProductState(id: productId)) {
    //Llamo esta funcion desde que se Construya la clase
    loadProduct();
  }

  Product _newProductEmpy() => Product(
        id: "new",
        title: "",
        price: 0,
        description: "description",
        slug: "",
        stock: 0,
        sizes: [],
        gender: "man",
        tags: [],
        images: [],
      );

  Future<void> loadProduct() async {
    try {
      if (state.id == "new") {
        state = state.copyWith(isLoading: false, product: _newProductEmpy());
        return;
      }
      final product = await productsRepository.getProductById(id: state.id);
      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      print(e);
    }
  }
}

//Este es el estado
class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) =>
      ProductState(
          id: id ?? this.id,
          product: product ?? this.product,
          isLoading: isLoading ?? this.isLoading,
          isSaving: isSaving ?? this.isSaving);
}
