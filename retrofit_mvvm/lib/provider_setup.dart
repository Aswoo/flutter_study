import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'core/api/post_api.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[
  ...apiServices,
];

List<SingleChildWidget> apiServices = <SingleChildWidget>[
  Provider.value(
    value: PostApi(
      Dio(
        BaseOptions(
          contentType: "application/json",
          baseUrl: 'https://jsonplaceholder.typicode.com',
        ),
      ),
    ),
  ),
];
