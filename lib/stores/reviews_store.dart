import 'package:flutter/foundation.dart';
import 'package:gamematch/models/review_view.dart';

import '../models/review.dart';
import '../services/reviews_service.dart';

class ReviewStore {
  final service = ReviewsService();

  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<List<ReviewView>> reviews = ValueNotifier<List<ReviewView>>([]);

  Future<bool> addReview(Review review) async {
    final x = await service.addReview(review);

    if (x == true) {
      getReviews(review.jogo);
    }

    return x;
  }

  Future<void> getReviews(int gameId) async {
    isLoading.value = true;

    final reviewsFromAPI = await service.getReviews(gameId: gameId);

    reviews.value = reviewsFromAPI;

    isLoading.value = false;
  }
}
