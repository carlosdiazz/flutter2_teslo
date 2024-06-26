import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/src/products/domain/domain.dart';
import 'package:teslo_shop/src/products/presentation/presentation.dart';
import 'package:teslo_shop/src/shared/infrastructure/inputs/inputs.dart';

//AutoDispose que se limpia cuando no lo este usando
//Family para mandar el tipo de dato, que me servira para crear el Provider
final productFormProvider = StateNotifierProvider.autoDispose
    .family<ProductFormNotifier, ProductFormState, Product>((ref, product) {
  //TODO: createupdateCallBack
  //final createUpdateCallBack =
  //    ref.watch(productsRepositoryProvider).createUpdateProduct;
  final createUpdateCallBack =
      ref.watch(productsProvider.notifier).createOrUpdateProduct;

  return ProductFormNotifier(
      product: product,
      //TODOonSubmitCallback:
      onSubmitCallback: createUpdateCallBack);
});

class ProductFormNotifier extends StateNotifier<ProductFormState> {
  final Future<bool> Function(Map<String, dynamic> productsLike)?
      onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }) : super(ProductFormState(
          id: product.id,
          title: Title.dirty(product.title),
          slug: Slug.dirty(product.slug),
          price: Price.dirty(product.price),
          sizes: product.sizes,
          gender: product.gender,
          inStock: Stock.dirty(product.stock),
          description: product.description,
          tags: product.tags.join(", "),
          images: product.images,
        ));

  void onTitleChanged(String value) {
    state = state.copyWith(
        title: Title.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
        slug: Slug.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(value),
          Price.dirty(state.price.value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
        price: Price.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(value),
          Stock.dirty(state.inStock.value),
        ]));
  }

  void onStockChanged(int value) {
    state = state.copyWith(
        inStock: Stock.dirty(value),
        isFormValid: Formz.validate([
          Title.dirty(state.title.value),
          Slug.dirty(state.slug.value),
          Price.dirty(state.price.value),
          Stock.dirty(value),
        ]));
  }

  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(sizes: sizes);
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(gender: gender);
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(description: description);
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(tags: tags);
  }

  Future<bool> onFormSubmit() async {
    _touchEverything();
    if (!state.isFormValid) return false;

    //TODO
    if (onSubmitCallback == null) return false;
    final productLike = {
      "id": (state.id == "new") ? null : state.id,
      "title": state.title.value,
      "price": state.price.value,
      "description": state.description,
      "slug": state.slug.value,
      "stock": state.inStock.value,
      "sizes": state.sizes,
      "gender": state.gender,
      "tags": state.tags.split(","),
      //TODO
      "images": state.images
          .map((image) =>
              image.replaceAll("${Enviroment.apiUrl}/files/product/", ""))
          .toList()
    };
    try {
      return onSubmitCallback!(productLike);
    } catch (e) {
      return false;
    }
  }

  //Validar que todos los campos sean tocados
  void _touchEverything() {
    state = state.copyWith(
        isFormValid: Formz.validate([
      Title.dirty(state.title.value),
      Slug.dirty(state.slug.value),
      Price.dirty(state.price.value),
      Stock.dirty(state.inStock.value),
    ]));
  }
}

//Estado
class ProductFormState {
  final bool isFormValid;
  final String? id;
  final Title title;
  final Slug slug;
  final Price price;
  final List<String> sizes;
  final String gender;
  final Stock inStock;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState(
      {this.isFormValid = false,
      this.id,
      this.title = const Title.dirty(""),
      this.slug = const Slug.dirty(""),
      this.price = const Price.dirty(0),
      this.sizes = const [],
      this.gender = "men",
      this.inStock = const Stock.dirty(0),
      this.description = "",
      this.tags = "",
      this.images = const []});

  ProductFormState copyWith(
          {bool? isFormValid,
          String? id,
          Title? title,
          Slug? slug,
          Price? price,
          List<String>? sizes,
          String? gender,
          Stock? inStock,
          String? description,
          String? tags,
          List<String>? images}) =>
      ProductFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        title: title ?? this.title,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        sizes: sizes ?? this.sizes,
        gender: gender ?? this.gender,
        inStock: inStock ?? this.inStock,
        description: description ?? this.description,
        tags: tags ?? this.tags,
        images: images ?? this.images,
      );
}
