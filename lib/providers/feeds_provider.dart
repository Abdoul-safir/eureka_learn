import 'package:eureka_learn/models/models.dart';
import 'package:eureka_learn/providers/database_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final feedsProvider = StreamProvider.autoDispose<List<PostModel>>((ref) {
  final stream = ref.read(fireStoreProvider).collection('posts').snapshots();
  return stream.map((snapshot) => snapshot.docs
      .map((doc) => PostModel.fromDocumentSnapshot(doc.data()))
      .toList());
});

final papersProvider =
    FutureProvider.autoDispose.family<List<PaperModel>, Student>(((ref, user) {
  return ref.read(databaseProvider).getUserPapers(user);
}));
