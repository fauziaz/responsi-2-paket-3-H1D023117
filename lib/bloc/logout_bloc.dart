import 'package:responsi_2_mobile_paket_3_h1d023117/helpers/user_info.dart';

class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}