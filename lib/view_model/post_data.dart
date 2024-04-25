import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_data.g.dart';

@Riverpod(keepAlive: true)
class AllFriendsNotifier extends _$AllFriendsNotifier {
  @override
  Future<Map<String, dynamic>?> build() async {
    return null;
  }

  Future<void> upData(Map<String, dynamic> data) async {
    state = await AsyncValue.guard(() async => data);
  }
}
