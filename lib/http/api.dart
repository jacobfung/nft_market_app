
import 'package:nft_market/http/request.dart';

class Api {
  static login(data) {
    return Request.post(
      '/login',
      data: data,
    );
  }
  static register(String name, String email, String password) {
    return Request.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'password': password
      },
    );
  }
  static getBidingList() async {
    return Request.get(
      '/liveBidingList',
    );
  }
}