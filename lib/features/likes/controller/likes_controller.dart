import 'package:tiutiu/core/local_storage/local_storage_keys.dart';
import 'package:tiutiu/features/likes/services/likes_service.dart';
import 'package:tiutiu/features/posts/services/post_service.dart';
import 'package:tiutiu/core/local_storage/local_storage.dart';
import 'package:tiutiu/core/controllers/controllers.dart';
import 'package:tiutiu/features/posts/model/post.dart';
import 'package:tiutiu/core/pets/model/pet_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LikesController extends GetxController {
  LikesController({
    required LikesService likesService,
    required PostService postsServices,
  })  : _likesService = likesService,
        _postsService = postsServices;

  final LikesService _likesService;
  final PostService _postsService;

  final RxList<Post> _LikedPosts = <Post>[].obs;
  List<Post> get LikedPosts => _LikedPosts;

  Future<void> like(Post post, {bool wasLiked = false}) async {
    if (wasLiked) {
      await _unlike(post);
      await unSaveLikeOnLocal(post.uid!);
    } else {
      if (authController.userExists) {
        _likesService.likedsCollection().doc(post.uid).set(post.toMap());
      }

      _incrementLikes(post.uid!);

      debugPrint('TiuTiuApp: Post liked');
    }
  }

  Future<void> _unlike(Post post) async {
    debugPrint('TiuTiuApp: Post unliked');
    _likesService.likedsCollection().doc(post.uid).delete();
    _decrementLikes(post.uid!);
  }

  Future<void> saveLikeOnLocal(String postId) async {
    final likesSavedOnLocal = await LocalStorage.getValueUnderLocalStorageKey(LocalStorageKey.unloggedLikesMap);
    Map<String, dynamic> savedLikes = {};

    if (likesSavedOnLocal == null) {
      savedLikes.putIfAbsent(postId, () => postId);
    } else {
      savedLikes.addAll(likesSavedOnLocal);
      savedLikes.putIfAbsent(postId, () => postId);
    }

    await LocalStorage.setValueUnderLocalStorageKey(key: LocalStorageKey.unloggedLikesMap, value: savedLikes);
  }

  Future<void> unSaveLikeOnLocal(String postId) async {
    final likesSavedOnLocal = await LocalStorage.getValueUnderLocalStorageKey(LocalStorageKey.unloggedLikesMap);
    Map<String, dynamic> savedLikes = {};

    if (likesSavedOnLocal != null) {
      savedLikes.addAll(likesSavedOnLocal);

      if (savedLikes.containsKey(postId)) {
        savedLikes.remove(postId);
        await LocalStorage.setValueUnderLocalStorageKey(key: LocalStorageKey.unloggedLikesMap, value: savedLikes);
      }
    }
  }

  void _incrementLikes(String postId) {
    _postsService.pathToPost(postId).set({PostEnum.likes.name: FieldValue.increment(1)}, SetOptions(merge: true));
  }

  void _decrementLikes(String postId) {
    _postsService.pathToPost(postId).set({PostEnum.likes.name: FieldValue.increment(-1)}, SetOptions(merge: true));
  }

  Stream<bool> postIsLiked(Post post) {
    if (authController.userExists) {
      return _likesService
          .likedsCollection()
          .snapshots()
          .asyncMap((event) => event.docs.firstWhereOrNull((e) => e.get(PostEnum.uid.name) == post.uid) != null);
    } else {
      return LocalStorage.getValueUnderLocalStorageKey(LocalStorageKey.unloggedLikesMap)
          .asStream()
          .asyncMap((event) => (event as Map).containsKey(post.uid));
    }
  }

  Stream<int> postLikes(String postId) {
    return _postsService.pathToPost(postId).snapshots().asyncMap((snapshot) {
      return Pet.fromSnapshot(snapshot).likes;
    });
  }
}
