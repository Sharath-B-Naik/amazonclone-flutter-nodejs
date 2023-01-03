import 'package:amazon_admin/config/secrets/secrets.dart';
import 'package:amazon_admin/utils/api_utils.dart';

class AccountService {
  static Future<ApiResponse> makeAdmin() async {
    final resp = await ApiUtils.get(url: '$uri/api/make-admin');
    return resp;
  }
}
