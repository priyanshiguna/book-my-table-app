import 'package:get/get.dart';

import 'translations/en_us.dart';
import 'translations/es_es.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUs,
        'es_ES': esEs,
      };
}
