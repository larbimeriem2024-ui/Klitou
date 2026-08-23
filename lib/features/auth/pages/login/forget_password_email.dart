import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/core/common_widgets/textfield.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ForgetPasswordEmail extends ConsumerStatefulWidget {
  const ForgetPasswordEmail({super.key});

  @override
  ConsumerState<ForgetPasswordEmail> createState() => _ForgetPasswordEmailState();
}

class _ForgetPasswordEmailState extends ConsumerState<ForgetPasswordEmail> {

  final TextEditingController emailcontroller = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  final emailRegex = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',);

  late FocusNode emailFocus;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.backgroundColor , 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/imgs/back.png', 
                height: 20,
                width: 20,
                ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:20, right: 20, ),
          child: Form(
            key: _keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
            BigTitle(title: 'Verify Email'),
            SizedBox(height: 8,),
            DescriptionText(title: 'Enter your email address and we will send you a link to verify your account.' ),
            SizedBox(height: 32,),
            Textfield(controller: emailcontroller , title: 'Email',icon: 'assets/imgs/ps_icon.png', description1: 'Enter your Email' , validate: (value) {
                if(value == null || value.isEmpty){
                  return 'Email is required';
                }
                if(!emailRegex.hasMatch(value)){
                      return "Invalid email";
                }

                return null;
              },
              somethingFocusNode: emailFocus,),
            SizedBox(height: 48,),
            Button(
              onClicked: () async{
                if(_keyForm.currentState!.validate()){
                  return;
                  

                }
                
            
                await ref.read(authProvider).verifyEmailForRestPassword(emailcontroller.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('CHECK YOUR Inbox To Reset Your Password')),
                  
                );
                
              } , 
              color: AppColor.apptheme, 
              title: 'Send', 
              fontColor: AppColor.white, 
              isborder: false)
            
            
            
            
            
            
            
            
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}