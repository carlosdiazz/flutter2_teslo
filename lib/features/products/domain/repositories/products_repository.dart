import '../entities/product.dart';

abstract class ProductsRepository {
  Future<List<Products>> getProductsByPage({int limit = 10, int offest = 0});

  Future<Products> getProductById({required String id});

  Future<List<Products>> searchProductByTerm({required String term});

  Future<List<Products>> createUpdateProduct(
      {required Map<String, dynamic> productLike});
}
