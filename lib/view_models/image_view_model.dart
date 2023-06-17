import 'package:flutter/material.dart';
import 'package:image_showcase/api/result.dart';
import 'package:image_showcase/main.dart';
import 'package:image_showcase/models/image_model.dart';
import 'package:image_showcase/repositories/image_repository.dart';
import 'package:image_showcase/utils/status_enum.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageRepository _imageRepository = ImageRepository();
  Status _status = Status.success;
  List<Hit>? _imageList, _favImageList = [];
  DataError? _dataError;

  init() {
    _status = Status.loading;
  }

  Future<void> getImages(String value) async {
    _imageList?.clear();
    if (status != Status.loading) status = Status.loading;
    var result = await _imageRepository.getImages(value);
    if (result.isSuccess()) {
      ImageModel response = result.getValue();
      _imageList = response.hits;
      status = Status.success;
    } else {
      _dataError = result.getError();
      status = Status.error;
    }
  }

  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  bool isFavItem(Hit? item) {
    List<Hit> image =
        favImageList?.where((element) => element.id == item?.id).toList() ?? [];
    return image.isEmpty ? false : true;
  }

  addToFavorite(Hit? item) {
    if (!isFavItem(item)) {
      favImageList?.add(item!);
      notifyListeners();
      _showSnackBar("Item successfully added to favorite");
    }
  }

  removeFrmFavorite(Hit? item) {
    if (isFavItem(item)) {
      favImageList?.remove(item);
      notifyListeners();
      _showSnackBar("Item successfully removed from favorite");
    }
  }

  DataError? get dataError => _dataError;

  List<Hit>? get imageList => _imageList;

  List<Hit>? get favImageList => _favImageList;

  _showSnackBar(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 1),
    );

    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }
}
