import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dariwall/core/di/locator_service.dart';
import 'package:dariwall/core/constant/app_message.dart';
import 'package:dariwall/core/services/snack_bar_service.dart';
import 'package:dariwall/features/missions/presentation/provider/ostad_provider/get_missions_provider.dart';
import 'package:dariwall/features/missions/domain/usecase/parax_usecase/comment_on_parax_twitter_post_usecase.dart';

enum CommentOnParaxTwitterPostStatus {
  initial,
  loading,
  success,
  error,
}

class CommentOnParaxTwitterPostProvider extends ChangeNotifier {
  final CommentOnParaxTwitterPostUsecase commentOnParaxTwitterPostUsecase;

  CommentOnParaxTwitterPostProvider({required this.commentOnParaxTwitterPostUsecase});

  CommentOnParaxTwitterPostStatus _status = CommentOnParaxTwitterPostStatus.initial;

  CommentOnParaxTwitterPostStatus get status => _status;

  Future<void> commentOnParaxTwitterPost({required MultipartFile imageFile}) async {
    _status = CommentOnParaxTwitterPostStatus.loading;
    notifyListeners();
    final result = await commentOnParaxTwitterPostUsecase.call(imageFile: imageFile);
    result.fold(
      (l) {
        _status = CommentOnParaxTwitterPostStatus.error;
        SnackBarService.show(
          status: SnackBarStatus.error,
          message: l.message,
        );
      },
      (r) async {
        _status = CommentOnParaxTwitterPostStatus.success;
        SnackBarService.show(
          status: SnackBarStatus.success,
          message: AppMessage.missionSuccess,
        );
        await getIt<GetMissionsProvider>().getMissions();
      },
    );
    notifyListeners();
  }
}
