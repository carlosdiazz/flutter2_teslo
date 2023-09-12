import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/src/products/domain/domain.dart';
import 'package:teslo_shop/src/products/infrastructure/mappers/products_mapper.dart';

class ProductsDatasourceImpl extends ProductsDataSource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Enviroment.apiUrl,
            headers: {"Authorization": "Bearer $accessToken"}));

  @override
  Future<List<Product>> createUpdateProduct(
      {required Map<String, dynamic> productLike}) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById({required String id}) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsByPage(
      {int limit = 10, int offest = 0}) async {
    final response =
        await dio.get<List>("/products?limit=$limit&offset=$offest");
    final List<Product> products = [];
    for (final product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }
    return products;
  }

  @override
  Future<List<Product>> searchProductByTerm({required String term}) {
    // TODO: implement searchProductByTerm
    throw UnimplementedError();
  }
}
