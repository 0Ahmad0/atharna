import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/const.dart';

class FutureNetwork{
  static streamBuilderNetwork({
  required var streamData,
    required Widget waitData,
     Widget emptyData=const Text('Empty data'),
    required Widget widgetData,
      Widget errorData=const Text('error data'),
    required var functionISData
  }){
    return
      StreamBuilder<QuerySnapshot>(
        //prints the messages to the screen0
          stream: streamData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return waitData;
                ///Const.SHOWLOADINGINDECATOR();
              //Const.CIRCLE(context);
            }
            else if (snapshot.connectionState ==
                ConnectionState.active) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                waitData;
                /*print("streame ${snapshot.data!.docs.length}");
                chatProvider.group.chat =
                    Chat.fromJsonWithFilterIdUser({
                      'id': chatProvider.group.id,
                      'messages': snapshot.data!.docs
                    }, idUser: profileProvider.user.id);

                convertListMessagesToListUsers(chatProvider.group.chat);*/

                return widgetData;

                /// }));
              } else {
                return emptyData;
              }
            }
            else {
              return Text('State: ${snapshot.connectionState}');
            }
          });
  }
}