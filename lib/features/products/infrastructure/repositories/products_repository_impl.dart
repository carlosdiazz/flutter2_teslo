import 'package:teslo_shop/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDataSource datasource;
  ProductsRepositoryImpl(this.datasource);

  @override
  Future<List<Products>> createUpdateProduct(
      {required Map<String, dynamic> productLike}) {
    return datasource.createUpdateProduct(productLike: productLike);
  }

  @override
  Future<Products> getProductById({required String id}) {
    return datasource.getProductById(id: id);
  }

  @override
  Future<List<Products>> getProductsByPage({int limit = 10, int offest = 0}) {
    return datasource.getProductsByPage(limit: limit, offest: offest);
  }

  @override
  Future<List<Products>> searchProductByTerm({required String term}) {
    return datasource.searchProductByTerm(term: term);
  }
}
