import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_bmi_app/Language_cubit/cubit/language_cubit.dart';
import 'package:iti_bmi_app/cubit/cubit/bmi_cubit.dart';
import 'package:iti_bmi_app/screens/home_screen.dart';
import 'package:iti_bmi_app/screens/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return BlocProvider(
            create: (context) => BmiCubit(),
            child: MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: context.read<LanguageCubit>().local,
              title: 'BMI Calculator App',
              debugShowCheckedModeBanner: false,
              routes: {
                SplashScreen.id: (context) => const SplashScreen(),
                HomeScreen.id: (context) => const HomeScreen(),
              },
              initialRoute: SplashScreen.id,
            ),
          );
        },
      ),
    );
  }
}
