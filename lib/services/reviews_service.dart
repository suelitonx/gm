import 'package:gamematch/models/review.dart';
import 'package:gamematch/services/pocketbase_service.dart';

import '../models/review_view.dart';

abstract class IReviewsService {
  Future<List<ReviewView>> getReviews({required int gameId});
}

class ReviewsService implements IReviewsService {
  @override
  Future<List<ReviewView>> getReviews({required int gameId}) async {
    List<ReviewView> reviews = [];

    final pbService = PocketbaseService.instance;

    await pbService.pb.collection('reviewsjogos').getList(filter: "jogo = '$gameId'").then((lista) {
      if (lista.items.isNotEmpty) {
        reviews.addAll(lista.items.map((r) => ReviewView.fromRM(r)).toList());
      }
    });

    return reviews;
  }

  Future<bool> addReview(Review review) async {
    final pbService = PocketbaseService.instance;

    bool sucess = false;

    if (review.usuario == '') {
      review.usuario = pbService.pb.authStore.model.id;
    }

    await pbService.pb.collection('reviews').create(body: review.toMap()).then((value) {
      sucess = true;
    }).catchError((e) {
      sucess = false;
    });

    return sucess;
  }

  Future<bool> updateReview(Review review) async {
    final pbService = PocketbaseService.instance;

    bool sucess = false;

    await pbService.pb.collection('reviews').update(review.id, body: review.toMap()).then((value) {
      sucess = true;
    });

    return sucess;
  }

  Future<bool> deleteReview(String id) async {
    final pbService = PocketbaseService.instance;

    bool sucess = false;

    await pbService.pb.collection('reviews').delete(id).then((value) {
      sucess = true;
    });

    return sucess;
  }
}
