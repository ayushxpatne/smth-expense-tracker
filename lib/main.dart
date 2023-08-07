import 'package:flutter/material.dart';
import 'package:smth_prototype_2/expenses_home.dart';
//todo : editing the existing entries from swiping from left
//todo : show respective month above the entries for entries on a particular month

//* If in future, this is connected to a database, then all the filtering will
//* done on the database side.

//! after the app is built, (using flutter run), and then stopped,
//! it works as a normal app on phone
//! but when one adds entries --> closes the app from app switcher --> added entries are deleted

Color background = Colors.black;
const Color onBackground = Color.fromARGB(255, 199, 187, 254); //title etc
const Color backgroundContainer =
    Color.fromARGB(255, 8, 8, 8); //cards etc //on cards etc

const ligthThemeAccent = Color.fromARGB(255, 129, 101, 255);
void main() {
  runApp(const MainApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: ligthThemeAccent,
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Colors.purple,
).copyWith(
  surface: backgroundContainer,
  onPrimary: backgroundContainer,
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: background,
          appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: background, foregroundColor: onBackground),
          colorScheme: kDarkColorScheme,
          useMaterial3: true,
          textTheme: ThemeData.dark().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                backgroundColor: kDarkColorScheme.primary,
                foregroundColor: kDarkColorScheme.onPrimary,
                textStyle: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          dialogBackgroundColor: backgroundContainer,
          datePickerTheme: const DatePickerThemeData().copyWith(
            backgroundColor: backgroundContainer,
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          useMaterial3: true,
          appBarTheme:
              const AppBarTheme().copyWith(foregroundColor: ligthThemeAccent),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                backgroundColor: kColorScheme.primary,
                foregroundColor: kColorScheme.onPrimary,
                textStyle: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontWeight: FontWeight.w900,
                ),
              ),
        ),
        home: const ExpensesHomeScreen());
  }
}
