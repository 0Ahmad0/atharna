import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/widgets/custome_textfiled.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../controller/heritage_provider.dart';
import '../../../controller/utils/firebase.dart';
import '../../../model/const.dart';
import '../../../model/models.dart';
import '../../resources/consts_manager.dart';
import '../details_discover/details_discover_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController = TextEditingController();
  var getListHeritageSearch,getListHeritages,getListHeritagesCategory;
  HeritageProvider heritageProvider = HeritageProvider();
  @override
  void initState() {
    getListHeritagesSearchFuc();
    super.initState();
  }

  getListHeritagesSearchFuc() async {
     getListHeritagesCategory=await FirebaseFun.fetchHeritagesCategory() ;
    getListHeritages = FirebaseFirestore.instance
        .collection(AppConstants.collectionHeritage)
    /// .orderBy("date")
        .snapshots();
    getListHeritageSearch=getListHeritages;
    //getListHeritageSearch.addAll(getListHeritagesCategory);
    return getListHeritageSearch;
  }
  @override
  Widget build(BuildContext context) {
    heritageProvider = Provider.of<HeritageProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Column(children: [
        SafeArea(
          child: CustomTextFiled(controller: SearchController,
           validator: null,
           maxLength: null,
            onChange: null,
            suffixIcon: IconButton(onPressed: (){
              setState(() {
              });
            },icon: Icon(Icons.search),),
             prefixIcon: Icons.search,
              hintText: "search here"
              ),
        ),
                   const SizedBox(height: AppSize.s10,),
Expanded(
  child: StreamBuilder<QuerySnapshot>(
    //prints the messages to the screen0
      stream: getListHeritageSearch,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return
            Const.SHOWLOADINGINDECATOR();
            ///waitListCategory(context);
        }
        else if (snapshot.connectionState ==
            ConnectionState.active) {
          if (snapshot.hasError) {
            return const Text('Error');
          } else if (snapshot.hasData) {
            Const.SHOWLOADINGINDECATOR();
            heritageProvider.listHeritagesSearch=Heritages.fromJson(snapshot.data!.docs);
           // print(getListHeritagesCategory['status']);
           // heritageProvider.listHeritagesCategory=Heritages.fromJson(getListHeritagesCategory);
            print("Heritage : ${snapshot.data!.docs.length}");
            heritageProvider.listHeritagesSearch.heritages=heritageProvider.searchHeritagesByCity(SearchController.text, heritageProvider.listHeritagesSearch.heritages);

            return buildListSearch(context);
            /// }));
          } else {
            return const Text('Empty data');
          }
        }
        else {
          return Text('State: ${snapshot.connectionState}');
        }
      }),
)
      ],),
    );
  }
  buildListSearch(context){
    return ListView.separated(itemCount: heritageProvider.listHeritagesSearch.heritages.length,itemBuilder: (context,index){

      return InkWell(onTap: () {
        heritageProvider.heritage=heritageProvider.listHeritagesSearch.heritages[index];
        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>DetailsDiscoverScreen()));
      },child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          (heritageProvider.listHeritagesSearch.heritages[index].phone!=null)?
          '${heritageProvider.listHeritagesSearch.heritages[index].title}'
          :'${heritageProvider.listHeritagesSearch.heritages[index].firstName} ${heritageProvider.listHeritagesSearch.heritages[index].lastName}'
            /*"Data ${index+1}"*/,style: TextStyle(fontSize: Sizer.getW(context) / 24),),
      ));

    },

      separatorBuilder: (context, index) => Divider(),

    );
  }
}