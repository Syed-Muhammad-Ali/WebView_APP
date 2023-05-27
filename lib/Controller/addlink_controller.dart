// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_app/Model/add_link_model.dart';
import 'package:webview_app/localDB/local_DB.dart';

class AddLinkController extends GetxController {


   Future addReportMethod(
      {@required AddLinkModel? addLinkModel,
      @required String? tableName}) async {
    var result = await DBHelper.insert(addLinkModel, tableName!);
    debugPrint('insert result: ${result.toString()}');
    update();
    await getReportMethod(tableName);
  }

  List<AddLinkModel>? AddLinkModelList = [];
  List<String>? AddLinkList = [];
  Future<List<AddLinkModel>?> getReportMethod(String tableName) async {
    AddLinkModelList!.clear();
    AddLinkList!.clear();
    List<Map<String, dynamic>> addLinkMapData =
        await DBHelper.query(tableName);

    if (addLinkMapData.isNotEmpty) {
      debugPrint("map data: ${addLinkMapData.toString()}");
      AddLinkModelList!.addAll(addLinkMapData
          .map((data) => AddLinkModel.fromJson(data))
          .toList());
      for (AddLinkModel? reportGuns in AddLinkModelList!) {
        log(reportGuns!.url!);
        AddLinkList!.add(reportGuns.url!);
      }
      debugPrint("list data: ${AddLinkModelList.toString()}");
      debugPrint("URL name data: ${AddLinkList.toString()}");

      update();
    } else {
      debugPrint(' add URL is empty');
    }
    update();
    return AddLinkModelList;
  }

}
