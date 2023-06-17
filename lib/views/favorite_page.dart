import 'package:flutter/material.dart';
import 'package:image_showcase/models/image_model.dart';
import 'package:image_showcase/view_models/image_view_model.dart';
import 'package:image_showcase/views/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Consumer<ImageViewModel>(
          builder: (ctx, imageViewModel, child) {
            List<Hit>? favList = imageViewModel.favImageList;
            if (favList?.isEmpty ?? true) {
              return Center(
                child: Text(
                  "Add to favourite to see your items",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            }
            return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1 / 1,
                  crossAxisSpacing: 10, // Number of columns in the grid
                ),
                itemCount: favList?.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onLongPress: () => _showDialog(favList?[index]),
                      child: ImageWidget(
                        favList?[index],
                        isFav: true,
                      ));
                });
          },
        ),
      ),
    );
  }

  _showDialog(Hit? item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text(
                'Are you sure you want remove this item from favourite?'),
            actionsPadding: EdgeInsets.zero,
            actions: <Widget>[
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    Provider.of<ImageViewModel>(context, listen: false)
                        .removeFrmFavorite(item);
                    Navigator.of(context).pop();
                    _showSnackBar();
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }

  _showSnackBar() {
    const snackBar = SnackBar(
      content: Text('Item successfully removed from favorite'),
      duration: Duration(seconds: 1),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
