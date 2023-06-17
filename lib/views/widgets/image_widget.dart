import 'package:flutter/material.dart';
import 'package:image_showcase/models/image_model.dart';
import 'package:image_showcase/view_models/image_view_model.dart';
import 'package:image_showcase/views/animation/text_slide_animation.dart';
import 'package:provider/provider.dart';

class ImageWidget extends StatelessWidget {
  final Hit? item;
  final bool isFav;

  const ImageWidget(this.item, {this.isFav = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            "${item?.webformatUrl}",
            height: 130,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextSlideAnimation(
                  textWidget: Text(
                    "${item?.user}",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                TextSlideAnimation(
                  textWidget: Text(
                    "${_getImageSize()} MB",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            isFav
                ? const Icon(Icons.favorite, color: Colors.deepPurple,)
                : InkWell(
                    onTap: () =>
                        Provider.of<ImageViewModel>(context, listen: false)
                            .addToFavorite(item),
                    child: const Icon(Icons.favorite_border_outlined))
          ],
        )
      ],
    );
  }

  _getImageSize() {
    final bytes = item?.imageSize ?? 0;
    final kb = bytes / 1024;
    final mb = kb / 1024;
    return mb.toStringAsFixed(2);
  }
}
