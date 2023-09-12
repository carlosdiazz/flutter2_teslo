import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/src/auth/infrastructure/user_mapper.dart';
import 'package:teslo_shop/src/products/domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) => Product(
      id: json["id"],
      title: json["title"],
      price: double.parse(json["price"].toString()),
      description: json["description"],
      slug: json["slug"],
      stock: json["stock"],
      sizes: List<String>.from(json["sizes"].map((size) => size)),
      gender: json["gender"],
      tags: List<String>.from(json["tags"].map((tags) => tags)),
      images: List<String>.from(json["images"].map((image) =>
          image.startsWith("http")
              ? image
              : "${Enviroment.apiUrl}/files/product/$image")),
      user: UserMapper.userJsonToEntity(json["user"]));
}
