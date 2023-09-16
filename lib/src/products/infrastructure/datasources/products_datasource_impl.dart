import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/src/products/domain/domain.dart';
import 'package:teslo_shop/src/products/infrastructure/errors/products_error.dart';
import 'package:teslo_shop/src/products/infrastructure/mappers/products_mapper.dart';

class ProductsDatasourceImpl extends ProductsDataSource {
  late final Dio dio;
  final String accessToken;

  ProductsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
            baseUrl: Enviroment.apiUrl,
            headers: {"Authorization": "Bearer $accessToken"}));

  @override
  Future<Product> createUpdateProduct(
      {required Map<String, dynamic> productLike}) async {
    try {
      final String? productId = productLike["id"];
      final String method = (productId == null) ? "POST" : "PATCH";
      final String url = (productId == null) ? "/post" : "/products/$productId";
      productLike.remove("id");

      final response = await dio.request(url,
          data: productLike, options: Options(method: method));
      final Product product = ProductMapper.jsonToEntity(response.data);
      return product;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Product> getProductById({required String id}) async {
    try {
      final response = await dio.get("/products/$id");
      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
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
