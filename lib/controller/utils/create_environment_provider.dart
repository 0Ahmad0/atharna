import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import '../../model/models.dart' as models;
import '../../model/models.dart';

import '../../view/resources/consts_manager.dart';

class CreateEnvironmentProvider with ChangeNotifier{


  onError(error){
    print(false);
    print(error);
    return {
      'status':false,
      'message':error,
      //'body':""
    };
  }
}
