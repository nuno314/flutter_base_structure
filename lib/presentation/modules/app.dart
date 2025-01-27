import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../common/components/navigation/navigation_observer.dart';
import '../../common/constants/app_locale.dart';
import '../../domain/entities/app_data.dart';
import '../common_bloc/app_data_bloc.dart';
import '../common_widget/text_scale_fixed.dart';
import '../route/route.dart';
import '../theme/theme_data.dart';
import 'contact/bloc/contact_bloc.dart';
import 'contact/views/contact_list_screen.dart';
import 'welcome/splash/bloc/splash_bloc.dart';
import 'welcome/splash/splash_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  final AppDataBloc _appDataBloc = AppDataBloc();

  @override
  void initState() {
    _appDataBloc.initial();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _appDataBloc),
      ],
      child: BlocBuilder<AppDataBloc, AppData?>(
        builder: (context, appData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: appData?.themeData ?? buildLightTheme().data,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocale.supportedLocales,
            locale: appData?.locale ?? AppLocale.vi,
            onGenerateRoute: RouteGenerator.generateRoute,
            home: BlocProvider(
              create: (_) => ContactBloc(),
              child: const ContactListScreen(),
            ),
            navigatorObservers: [myNavigatorObserver],
            builder: EasyLoading.init(
              builder: (_, child) {
                return TextScaleFixed(
                  child: child ?? const SizedBox(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
