import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/features/auth/pages/login/reset_password_page.dart';

import 'package:otp_pin_field/otp_pin_field.dart';

class OtpCode extends StatefulWidget {
  const OtpCode({super.key});

  @override
  State<OtpCode> createState() => _OtpCodeState();
}

class _OtpCodeState extends State<OtpCode> {
    final _otpPinFieldController = GlobalKey<OtpPinFieldState>();
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
              
              child: SizedBox(
                height: 30,
                width: 30,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Image.asset(
                    'assets/imgs/back.png', 
                    height: 16,
                    width: 16,
                    
                    
                    
                    ),
                ),
              ),
            ), 
            
         
        
           
        
        
        
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:20, right: 20, ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
          
          
            SizedBox(height: 16,) ,
            BigTitle(title: 'Otp code'),
            SizedBox(height: 8,),
            DescriptionText(title: 'Enter the otp code we sent you via email'),
            SizedBox(height: 32,),



            OtpPinField(
            key: _otpPinFieldController,

            ///in case you want to enable autoFill
            autoFillEnable: true,

            ///for Ios it is not needed as the SMS autofill is provided by default, but not for Android, that's where this key is useful.
            textInputAction: TextInputAction.done,

            ///in case you want to change the action of keyboard
            /// to clear the Otp pin Controller
            onSubmit: (text) {
             
              /// return the entered pin
            },
            onChange: (text) {
              
              /// return the entered pin
            },
            onCodeChanged: (code) {
              
            },

            /// to decorate your Otp_Pin_Field
            otpPinFieldStyle: OtpPinFieldStyle(
              fieldBorderRadius: 15,
            
              /// bool to show hints in pin field or not
                showHintText: true,

              /// to set the color of hints in pin field or not
              // hintTextColor: Colors.red,

              /// To set the text  of hints in pin field
              // hintText: '1',
                hintText: '*',
              /// border color for inactive/unfocused Otp_Pin_Field
              // defaultFieldBorderColor: Colors.red,

              /// border color for active/focused Otp_Pin_Field
              // activeFieldBorderColor: Colors.indigo,

              /// Background Color for inactive/unfocused Otp_Pin_Field
              // defaultFieldBackgroundColor: Colors.yellow,

              /// Background Color for active/focused Otp_Pin_Field
              // activeFieldBackgroundColor: Colors.cyanAccent,

              /// Background Color for filled field pin box
              // filledFieldBackgroundColor: Colors.green,

              /// border Color for filled field pin box
              
              // filledFieldBorderColor: Colors.green,
              //
              /// gradient border Color for field pin box
              defaultFieldBackgroundColor: AppColor.fieldBg,
              activeFieldBackgroundColor: AppColor.fieldBg,
              activeFieldBorderColor: AppColor.apptheme,
              defaultFieldBorderColor: AppColor.fieldBg,
            ),
            maxLength: 4,

            /// no of pin field
            showCursor: true,

            /// bool to show cursor in pin field or not
            cursorColor: AppColor.apptheme,

            /// to choose cursor color
            upperChild: Column(
              children: [
                SizedBox(height: 20),
                Icon(Icons.flutter_dash_outlined, size: 150),
                SizedBox(height: 20),
              ],
            ),
            middleChild: Column(
              children: [
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      _otpPinFieldController.currentState
                          ?.clearOtp(); // clear controller
                    },
                    child: Text('clear OTP')),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ResetPasswordPage())),
                    child: Text('Next ')),
                SizedBox(height: 30),
              ],
            ),

            ///bool which manage to show custom keyboard
            showCustomKeyboard: false,

            /// Widget which help you to show your own custom keyboard in place if default custom keyboard
            // customKeyboard: Container(),
            ///bool which manage to show default OS keyboard
            // showDefaultKeyboard: true,

            /// to select cursor width
            cursorWidth: 3,

            /// place otp pin field according to yourself
            mainAxisAlignment: MainAxisAlignment.center,
            

            /// predefine decorate of pinField use  OtpPinFieldDecoration.defaultPinBoxDecoration||OtpPinFieldDecoration.underlinedPinBoxDecoration||OtpPinFieldDecoration.roundedPinBoxDecoration
            ///use OtpPinFieldDecoration.custom  (by using this you can make Otp_Pin_Field according to yourself like you can give fieldBorderRadius,fieldBorderWidth and etc things)
            otpPinFieldDecoration:
            
                OtpPinFieldDecoration.custom,  
            fieldWidth: 70,
            fieldHeight: 70,

 
          ),

          SizedBox(height: 32,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DescriptionText(title: "Didn't receive code?"),
              SizedBox(width: 3,),
          
              Text('Resend',
               style: TextStyle(
                 color: AppColor.apptheme,
                 fontWeight: FontWeight.w600,
                 fontSize: 16,
          
              ),)
            ],
          ),
          SizedBox(height: 32,),



          Button(onClicked: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => ResetPasswordPage(),));
          }, 
          color: AppColor.apptheme, 
          title: 'Send', 
          fontColor: AppColor.white, 
          isborder: false)
            ],
          ),
        ),
      ),
    );
  }
}