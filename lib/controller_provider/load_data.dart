import 'dart:convert';
import 'dart:developer';

import 'package:clone_edspert_soal/helpers/preference_helper.dart';
import 'package:clone_edspert_soal/helpers/user_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../constants/api_url.dart';
import '../models/banner_list.dart';
import '../models/kerjakan_soal_list.dart';
import '../models/mapel_list.dart';
import '../models/paket_soal_list.dart';

class LoadData extends ChangeNotifier{

  String? email = UserEmail.getUserEmail();
  String jurusan = 'IPA';

  BannerList? bannerList;
  getBanner() async {
    String url = ApiUrl.baseUrl+ApiUrl.banner;

    log('message : $url ${ApiUrl.apiKey}');

    Map<String, String> requestHeaders = {
      'x-api-key' : ApiUrl.apiKey
    };

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    try{

      if(response.statusCode == 200) {
        log('GET_BANNER_DATA: ${json.decode(response.body)['data']}');

        final jsonBannerList = jsonDecode(response.body);

        notifyListeners();
        return bannerList = BannerList.fromJson(jsonBannerList);
      } else {

      }

    } on Exception catch (e){
      log('ERROR_BANNER: $e');
    }
  }

  MapelList? mapelList;
  getMapel() async {
    String url = ApiUrl.baseUrl+ApiUrl.latihanMapel+'?major_name=IPA&user_email=linux96mint@gmail.com';

    log('message : $url ${ApiUrl.apiKey}');

    Map<String, String> requestHeaders = {
      'x-api-key' : ApiUrl.apiKey
    };

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    try{

      if(response.statusCode == 200) {
        log('GET_MAPEL_DATA: ${json.decode(response.body)['data']}');

        final jsonBannerList = jsonDecode(response.body);

        notifyListeners();
        return mapelList = MapelList.fromJson(jsonBannerList);
      } else {

      }

    } on Exception catch (e){
      log('ERROR_BANNER: $e');
    }
  }

  PaketSoalList? paketSoalList;
  getPaket(String courseId) async {
    String url = ApiUrl.baseUrl+ApiUrl.latihanPaketSoal+'?course_id=$courseId&user_email=$email';

    log('message : $url ${ApiUrl.apiKey}');

    Map<String, String> requestHeaders = {
      'x-api-key' : ApiUrl.apiKey
    };

    final response = await http.get(Uri.parse(url), headers: requestHeaders);

    try{

      if(response.statusCode == 200) {
        log('GET_MAPEL_DATA: ${json.decode(response.body)['data']}');

        final jsonBannerList = jsonDecode(response.body);
        paketSoalList = PaketSoalList.fromJson(jsonBannerList);
        notifyListeners();
      } else {

      }

    } on Exception catch (e){
      log('ERROR_BANNER: $e');
    }
  }

  KerjakanSoalList? kerjakanSoalList;
  getSoal(String exercise_id) async {
    String url = ApiUrl.baseUrl+ApiUrl.latihanKerjakanSoal;

    log('message : $url ${ApiUrl.apiKey}');

    Map<String, String> requestHeaders = {
      'x-api-key' : ApiUrl.apiKey
    };

    Map<String, String> bodyParams = {
      'exercise_id' : exercise_id,
      'user_email' : email.toString()
    };

    log('message_email: $email');

    final response = await http.post(Uri.parse(url), headers: requestHeaders, body: bodyParams);

    try{

      if(response.statusCode == 200) {
        log('GET_SOAL_DATA: ${json.decode(response.body)['data']}');

        final jsonBannerList = jsonDecode(response.body);
        kerjakanSoalList = KerjakanSoalList.fromJson(jsonBannerList);
        notifyListeners();
      } else {

      }

    } on Exception catch (e){
      log('ERROR_SOAL: $e');
    }
  }

}