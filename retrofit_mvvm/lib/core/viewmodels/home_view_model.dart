import 'package:retrofit/dio.dart';

import '../api/post_api.dart';
import '../models/post.dart';
import 'base_view_model.dart';


class HomeViewModel extends BaseModel {
  HomeViewModel({
    required this.postApi,
  });

  final PostApi postApi;

  List<Post> posts = <Post>[];

  @override
  Future<void> initModel() async {
    setBusy(true);

    await fetchPosts();

    setBusy(false);
  }

  Future<void> fetchPosts() async {
    final HttpResponse<List<Post>> response = (await postApi.getPosts()) as HttpResponse<List<Post>>;

    final int responseCode = response.response.statusCode ?? 0;
    if (responseCode < 200 || responseCode > 299) {
      return;
    }

    posts = response.data;
  }
}
