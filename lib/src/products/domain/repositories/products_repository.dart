import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Product>> getProductsByPage({int limit = 10, int offest = 0});

  Future<Product> getProductById({required String id});

  Future<List<Product>> searchProductByTerm({required String term});

  Future<Product> createUpdateProduct(
      {required Map<String, dynamic> productLike});
}
