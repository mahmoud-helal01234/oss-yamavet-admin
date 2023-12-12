import 'package:get/get.dart';

class LocalTranslations extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en': {"login": "Login"},
        'ar': {"login": "تسجيل الدخول"}
      };
}
