import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class TestHarness extends StatelessWidget {
  const TestHarness({
    Key key,
    this.child,
    this.withProviderScope = false,
    this.providerOverrides = const <Override>[],
  }) : super(key: key);

  final Widget child;
  final bool withProviderScope;
  final List<Override> providerOverrides;

  @override
  Widget build(BuildContext context) => EasyLocalization(
        supportedLocales: [const Locale('en'), const Locale('it')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: (withProviderScope || providerOverrides.isNotEmpty)
            ? ProviderScope(
                overrides: providerOverrides,
                child: Builder(
                  builder: (context) => MaterialApp(
                    home: child,
                    locale: const Locale('en'),
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                  ),
                ),
              )
            : Builder(
                builder: (context) => MaterialApp(
                  home: child,
                  locale: const Locale('en'),
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                ),
              ),
      );
}
