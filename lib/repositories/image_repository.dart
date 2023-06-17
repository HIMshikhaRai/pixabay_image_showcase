import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:image_showcase/api/api_call_wrapper.dart';
import 'package:image_showcase/api/result.dart';
import 'package:image_showcase/models/image_model.dart';

class ImageRepository {
  ImageRepository._();

  static final ImageRepository _instance = ImageRepository._();

  factory ImageRepository() {
    return _instance;
  }

  final ApiCallWrapper _apiCallWrapper = ApiCallWrapper();

  Future<Result> getImages(String value) async {
    final url =
        'https://pixabay.com/api/?key=37426691-6369794c2a075a92731300bcf&q=$value&image_type=photo';
    final Result result = await _apiCallWrapper.makeRequest(url: url);

    if (result.isSuccess()) {
      final data =
          await compute(imageModelFromJson, jsonEncode(result.getValue()));
      return Result.success(data);
    } else {
      return Result.error(result.getError());
    }
  }
}
