import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/widgets/custome_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchScreen extends StatelessWidget {
  final SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Column(children: [
        SafeArea(
          child: CustomTextFiled(controller: SearchController,
           validator: null,
           maxLength: null,
            onChange: null,
            suffixIcon: IconButton(onPressed: (){},icon: Icon(Icons.search),),
             prefixIcon: Icons.no_accounts,
              hintText: "search here"
              ),
        ),
                   const SizedBox(height: AppSize.s10,),
Expanded(
  child:   ListView.separated(itemCount: 10,itemBuilder: (context,index){
  
    return InkWell(onTap: () {
      
    },child: Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text("Data ${index+1}",style: TextStyle(fontSize: Sizer.getW(context) / 24),),
    ));
  
  },
  
  separatorBuilder: (context, index) => Divider(),
  
  ),
)
      ],),
    );
  }
}