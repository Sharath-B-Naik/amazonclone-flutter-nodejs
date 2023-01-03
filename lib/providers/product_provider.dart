import 'package:amazon_admin/models/product_model.dart';
import 'package:amazon_admin/services/product_services.dart';
import 'package:amazon_admin/utils/app_utils.dart';
import 'package:flutter/widgets.dart';

class ProductProvider extends ChangeNotifier {
  List<Product>? _productlists;
  List<Product>? get productlists => _productlists;
  set productlists(List<Product>? products) {
    _productlists = products;
    notifyListeners();
  }

  Future<void> getProductsList(BuildContext context) async {
    try {
      productlists?.clear();
      final resp = await ProductService.getProductsList();
      if (resp.data != null) {
        List<Product> products = [];
        for (Map<String, dynamic> item in resp.data) {
          products.add(Product.fromMap(item));
        }
        productlists = products;
      } else {
        productlists = [];
        showSnackBar(context, resp.error!);
      }
    } catch (e) {
      productlists = [];
      showSnackBar(context, e.toString());
    }
  }
}
