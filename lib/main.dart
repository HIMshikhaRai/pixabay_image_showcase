import 'package:flutter/material.dart';
import 'package:image_showcase/utils/theme_helper.dart';
import 'package:image_showcase/view_models/home_view_model.dart';
import 'package:image_showcase/view_models/image_view_model.dart';
import 'package:image_showcase/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImageViewModel>(
            create: (context) => ImageViewModel()),
        ChangeNotifierProvider<HomeViewModel>(
            create: (context) => HomeViewModel()),
      ],
      child: MaterialApp(
        title: 'Image Showcase',
        navigatorKey: navigatorKey,
        theme: ThemeHelper.lightTheme,
        darkTheme: ThemeHelper.darkTheme,
        home: const HomePage(),
      ),
    );
  }
}
