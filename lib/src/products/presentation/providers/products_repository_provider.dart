import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/src/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_shop/src/products/domain/domain.dart';
import 'package:teslo_shop/src/products/infrastructure/infrastrucuture.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accesToken = ref.watch(authProvider).user?.token ?? "";
  final productsRepository =
      ProductsRepositoryImpl(ProductsDatasourceImpl(accessToken: accesToken));

  return productsRepository;
});
