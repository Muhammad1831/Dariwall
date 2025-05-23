import 'package:dariwall/core/constant/app_api.dart';
import 'package:dariwall/core/constant/app_keys.dart';
import 'package:dariwall/core/services/api_client_service.dart';
import 'package:dio/dio.dart';

class ParaxMissionsDataSource {
  final ApiClientService _apiClientService;

  ParaxMissionsDataSource(this._apiClientService);

  Future<void> followParaxInTwitter({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.followParaxInTwitter,
      data: formData,
    );
  }

  Future<void> likeParaxTwitterPost({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.likeParaxTwitterPost,
      data: formData,
    );
  }

  Future<void> retweetParaxTwitterPost({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.retweetParaxTwitterPost,
      data: formData,
    );
  }

  Future<void> commentOnParaxTwitterPost({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );
    await _apiClientService.post(
      AppApi.commentOnParaxTwitterPost,
      data: formData,
    );
  }

  Future<void> checkJoinParaxTelegramChannel() async {
    await _apiClientService.post(
      AppApi.checkJoinParaxTelegramChannel,
    );
  }

  Future<void> likeParaxInCoinmarketcap({required MultipartFile imageFile}) async {
    final formData = FormData.fromMap(
      {
        AppKeys.keyImage: imageFile,
      },
    );

    await _apiClientService.post(
      AppApi.likeParaxInCoinmarketcap,
      data: formData,
    );
  }

  // Future<void> likeCoinGeckoMission({required MultipartFile imageFile}) async {
  //   final formData = FormData.fromMap(
  //     {
  //       AppKeys.keyImage: imageFile,
  //     },
  //   ); 

  //   await _apiClientService.post(
  //     AppApi.likeCoinGecko,
  //     data: formData,
  //   );
  // }

  // Future<List<ProvinceModel>> getProvinces() async {
  //   final response = await _apiClientService.get(AppApi.provinces);
  //   return (response.data as List).map((e) => ProvinceModel.fromJson(e)).toList();
  // }

  // Future<List<MissionModel>> getMissions() async {
  //   final response = await _apiClientService.get(AppApi.missions);
  //   return (response.data as List).map((e) => MissionModel.fromJson(e)).toList();
  // }
}
