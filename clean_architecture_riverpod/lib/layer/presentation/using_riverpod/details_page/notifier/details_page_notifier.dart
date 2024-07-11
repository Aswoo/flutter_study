


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'details_page_state.dart';

final detailsPageProvider =
NotifierProvider<DetailsPageNotifier, DetailsPageState>(
      () => DetailsPageNotifier(),
);

class DetailsPageNotifier extends Notifier<DetailsPageState> {
  DetailsPageNotifier();

  @override
  DetailsPageState build() => DetailsPageState();
}
