import 'package:teslo_shop/src/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDataSource datasource;
  ProductsRepositoryImpl(this.datasource);

  @override
  Future<Product> createUpdateProduct(
      {required Map<String, dynamic> productLike}) {
    return datasource.createUpdateProduct(productLike: productLike);
  }

  @override
  Future<Product> getProductById({required String id}) {
    return datasource.getProductById(id: id);
  }

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offest = 0}) {
    return datasource.getProductsByPage(limit: limit, offest: offest);
  }

  @override
  Future<List<Product>> searchProductByTerm({required String term}) {
    return datasource.searchProductByTerm(term: term);
  }
}
