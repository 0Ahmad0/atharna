import 'package:atharna/controller/add_ruin_provider.dart';
import 'package:atharna/model/sizer.dart';
import 'package:atharna/view/resources/style_manager.dart';
import 'package:atharna/view/widgets/custome_button.dart';
import 'package:atharna/view/widgets/custome_textfiled.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../resources/values_manager.dart';

class CreateActivityScreen extends StatelessWidget {
  final activityName = TextEditingController();
  final activityLocation = TextEditingController();
  final activityDescription = TextEditingController();
  final activityDate = TextEditingController();
  final activityTime = TextEditingController();
  final activityPhone = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  _selectDate(BuildContext context) async {
    var newSelectedDate = await showDatePicker(
      builder: (context, child) {
        return child!;
      },
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _selectedDate= newSelectedDate;
      activityDate
        ..text = DateFormat.yMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: activityDate.text.length,
            affinity: TextAffinity.upstream));
    }
  }
  _selectTime(TimeOfDay time,BuildContext context) async {
    _selectedTime = time;
    activityTime.text=  _selectedTime.format(context);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p14),
          children: [
            Text(
              "Create Activity",
              style: getBoldStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Sizer.getW(context) / 14
              ),),
              const SizedBox(height: AppSize.s20,),
              CustomTextFiled(
                  controller: activityName,
                  validator: (String? val){
                    if(val!.trim().isEmpty){
                      return "This filed is required!";
                    }else{
                      return null;
                    }
                  },
                  onChange: null,
                  prefixIcon: Icons.drive_file_rename_outline,
                  hintText: "Activity Name"
              ),
              const SizedBox(height: AppSize.s20,),
            CustomTextFiled(
              readOnly: true,
                onTap: ()async{
                var location =await Provider.of<AddRuinProvider>(context,listen: false).pickLocation(context);
                print(location);
                },
                controller: activityLocation,
                validator: (String? val){
                  if(val!.trim().isEmpty){
                    return "This filed is required!";
                  }else{
                    return null;
                  }
                },
                onChange: null,
                prefixIcon: Icons.location_on_sharp,
                hintText: "Activity Location"
            ),
            const SizedBox(height: AppSize.s20,),
            CustomTextFiled(
                controller: activityDescription,
                validator: (String? val){
                  if(val!.trim().isEmpty){
                    return "This filed is required!";
                  }else{
                    return null;
                  }
                },
                onChange: null,
                prefixIcon: Icons.chat_sharp,
                hintText: "Activity Description"
            ),
            const SizedBox(height: AppSize.s20,),
            CustomTextFiled(
              onTap: ()async{
                await _selectDate(context);
              },
              readOnly: true,
                controller: activityDate,
                validator: (String? val){
                  if(val!.trim().isEmpty){
                    return "This filed is required!";
                  }else{
                    return null;
                  }
                },
                onChange: null,
                prefixIcon: Icons.date_range,
                hintText: "Activity Date"
            ),

            const SizedBox(height: AppSize.s20,),
            CustomTextFiled(
                onTap: ()async{
                  await _selectTime(_selectedTime,context);
                },
                readOnly: true,
                controller: activityTime,
                validator: (String? val){
                  if(val!.trim().isEmpty){
                    return "This filed is required!";
                  }else{
                    return null;
                  }
                },
                onChange: null,
                prefixIcon: Icons.access_time,
                hintText: "Activity Time"
            ),

            const SizedBox(height: AppSize.s20,),
            CustomTextFiled(
                controller: activityPhone,
                validator: (String? val){
                  if(val!.trim().isEmpty){
                    return "This filed is required!";
                  }else{
                    return null;
                  }
                },
                onChange: null,
                prefixIcon: Icons.phone_android,
                hintText: "Activity Phone"
            ),
            const SizedBox(height: AppSize.s20,),
            ButtonApp(text: "Create Activity", onTap: ()=>Navigator.pop(context))

          ],
        ),
      ),
    );
  }
}
