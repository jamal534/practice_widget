import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/asset_path.dart';
import '../../../core/global/custom_botton.dart';
import '../../../core/global/custom_text.dart';
import '../../../core/global/password_field.dart';
import '../../../core/global/profile_field.dart';
import '../../../core/helper/from_validation.dart';

class ProfileDetailsScreen extends StatelessWidget {
  ProfileDetailsScreen({super.key});

  // final EditeProfleController controller = Get.put(EditeProfleController());
  final userFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: CustomTextInter(
          text: "profile".tr,
          color: Color(0xFF20222C),
          fontWeight: FontWeight.w600,
          size: 20.sp,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Form(
          key: userFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h,),
              Center(child: Image.asset(AssetPath.profile)),
              SizedBox(height: 30.h,),
              CustomTextInter(
                text: 'fullName'.tr,
                fontWeight: FontWeight.w400,
                size: 16.sp,
                color: Color(0xFF4A5568),
              ),
              SizedBox(height: 10.h),
              ProfileField(
                validator: FormValidation.validateUsername,
                hintStyle: TextStyle(
                  color: Color(0xFF20222C),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
                imagePath: AssetPath.profile,
                // editingController: controller.usernameText,
                hintText: 'mdafi'.tr,
              ),
              SizedBox(height: 10.h),
              CustomTextInter(
                text: 'phoneText'.tr,
                fontWeight: FontWeight.w400,
                size: 16.sp,
                color: Color(0xFF4A5568),
              ),
              SizedBox(height: 10.h),
              ProfileField(
                validator: FormValidation.validatePhone,
                hintStyle: TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
                imagePath: AssetPath.contact,
                // editingController: controller.phoneNoText,
                hintText: 'phone'.tr,
              ),
              SizedBox(height: 10.h),
              CustomTextInter(
                text: 'password'.tr,
                fontWeight: FontWeight.w400,
                size: 16.sp,
                color: Color(0xFF4A5568),
              ),
              SizedBox(height: 10.h),
              UserpasswordField(
                validator: FormValidation.validatePassword,
                // controller: controller.passwordText,
                hints: 'password'.tr,
              ),
              Spacer(),
              // Obx(()=> controller.isLoading.value ? Center(
              //   child: CircularProgressIndicator(
              //     color: Colors.green,
              //   ),
              // ):
              // CustomButton(
              //   text: 'saveChange'.tr,
              //   onPressed: () async {
              //     if (userFormKey.currentState!.validate()) {
              //       if(controller.selectedImage.value!=null){
              //         controller.updateProfile();
              //       }
              //
              //     }
              //   },
              // ),
              // ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
