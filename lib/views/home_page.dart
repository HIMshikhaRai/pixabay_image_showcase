import 'package:flutter/material.dart';
import 'package:image_showcase/view_models/home_view_model.dart';
import 'package:image_showcase/views/favorite_page.dart';
import 'package:image_showcase/views/search_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> _pages = [
    const SearchPage(),
    const FavoritePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (ctx, homeViewModel, child) {
        return Scaffold(
          body: _pages[homeViewModel.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search_rounded),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourites',
              ),
            ],
            onTap: (int index) {
              homeViewModel.currentIndex = index;
            },
            currentIndex: homeViewModel.currentIndex,
          ),
        );
      },
    );
  }
}
