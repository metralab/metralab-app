import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';

void main() => runApp(
      EasyLocalization(
        supportedLocales: [const Locale('en'), const Locale('it')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const ProviderScope(child: MetralabApp()),
      ),
    );
