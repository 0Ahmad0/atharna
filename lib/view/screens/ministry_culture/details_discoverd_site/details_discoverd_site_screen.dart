import 'package:atharna/view/resources/values_manager.dart';
import 'package:atharna/view/widgets/custome_button.dart';
import 'package:flutter/material.dart';

class DetailsDiscoverCheck extends StatelessWidget {
  const DetailsDiscoverCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p10),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: ButtonApp(text: "Under Review",onTap: (){},)),
                    SizedBox(width: AppSize.s10,),
                    Expanded(child: ButtonApp(text: "Confirm",onTap: (){},)),
                    SizedBox(width: AppSize.s10,),
                    Expanded(child: ButtonApp(text: "Decline",onTap: (){},)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
