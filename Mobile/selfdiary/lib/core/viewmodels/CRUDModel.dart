import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:selfdiary/core/models/dayInfoModel.dart';

import '../../locator.dart';
import '../services/api.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<DayInfo> dayInfos = [];

  Future<List<DayInfo>> fetchProducts() async {
    var result = await _api.getDataCollection();
    dayInfos = result.docs
        .map((doc) => DayInfo.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
    return dayInfos;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<DayInfo> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  DayInfo.fromMap(doc.data() as Map<String, dynamic>, doc.id) ;
  }

  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(DayInfo data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(DayInfo data) async{
    var result  = await _api.addDocument(data.toJson()) ;
    return ;
  }
}