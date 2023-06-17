import 'package:flutter/material.dart';
import 'package:image_showcase/models/image_model.dart';
import 'package:image_showcase/utils/status_enum.dart';
import 'package:image_showcase/view_models/image_view_model.dart';
import 'package:image_showcase/views/widgets/image_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  ImageViewModel? _imageViewModel;

  @override
  void didChangeDependencies() {
    _imageViewModel = Provider.of<ImageViewModel>(context, listen: false);
    if (_imageViewModel?.imageList?.isEmpty ?? true) {
      _imageViewModel?.init();
      _imageViewModel?.getImages("all");
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32)),
                  // Add border to the TextFormField
                  labelText: 'Search',
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                  suffixIcon: const Icon(Icons.search)),
              textInputAction: TextInputAction.done,
              // Set the input action to "done"
              onFieldSubmitted: (String value) {
                if (value.isNotEmpty) _imageViewModel?.getImages(value.trim());
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Consumer<ImageViewModel>(
              builder: (ctx, imageViewModel, child) {
                if (imageViewModel.status == Status.loading) {
                  return const CircularProgressIndicator();
                } else if (imageViewModel.status == Status.error) {
                  return Text("${imageViewModel.dataError?.message}");
                }
                List<Hit>? imageList = imageViewModel.imageList;
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 212,
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1 / 1,
                        crossAxisSpacing: 10, // Number of columns in the grid
                      ),
                      itemCount: imageList?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ImageWidget(
                          imageList?[index],
                          isFav: imageViewModel.isFavItem(imageList?[index]),
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
