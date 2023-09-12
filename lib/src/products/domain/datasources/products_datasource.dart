import 'package:teslo_shop/src/products/domain/entities/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getProductsByPage({int limit = 10, int offest = 0});

  Future<Product> getProductById({required String id});

  Future<List<Product>> searchProductByTerm({required String term});

  Future<List<Product>> createUpdateProduct(
      {required Map<String, dynamic> productLike});
}
