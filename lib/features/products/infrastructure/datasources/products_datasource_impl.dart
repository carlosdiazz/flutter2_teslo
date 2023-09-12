import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductsDatasourceImpl extends ProductsDataSource {
  @override
  Future<List<Products>> createUpdateProduct(
      {required Map<String, dynamic> productLike}) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Products> getProductById({required String id}) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Products>> getProductsByPage({int limit = 10, int offest = 0}) {
    // TODO: implement getProductsByPage
    throw UnimplementedError();
  }

  @override
  Future<List<Products>> searchProductByTerm({required String term}) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
