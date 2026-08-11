import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/common/app_color.dart';
import 'package:flutter_application_9_klitou/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/services/authentication.dart';

class ForgetPasswordPassword extends StatefulWidget {
  const ForgetPasswordPassword({super.key});

  @override
  State<ForgetPasswordPassword> createState() => _ForgetPasswordPasswordState();
}

class _ForgetPasswordPasswordState extends State<ForgetPasswordPassword> {

  bool isPWHidden = true;
  final TextEditingController newpassowrdcontroller = TextEditingController();
  final TextEditingController repeatnewpasswordcontroller = TextEditingController();
  final _keyForm = GlobalKey <FormState>();

  late FocusNode passwordFocus;
  late FocusNode confirmPasswordFocus;

  @override
  void initState() {
    super.initState();
    passwordFocus = FocusNode();
    confirmPasswordFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
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
          padding:  EdgeInsets.only(left:20, right: 20, ),
          child: Form(
            key: _keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
            BigTitle(title: 'Reset Password'),
            SizedBox(height: 8,),
            DescriptionText(title: 'Create a strong new password to secure your account.'),
            SizedBox(height: 32,),
            
                Center(
          child: TextFormField(
            controller: newpassowrdcontroller ,
            obscureText: isPWHidden,
            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is required';
                    }
                    if( value.characters.length <8 ){
                      return 'Password must be minimum 8 characters';
                    }
                    return null;
                  },

            focusNode: passwordFocus,
            textInputAction: TextInputAction.next,
            autocorrect: false,
            style: TextStyle(
              color: AppColor.fontColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              
              
        
            ),
        
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset('assets/imgs/ps_icon.png',
                                width: 8,
                                height: 8,),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPWHidden = !isPWHidden;
                      });
                    },
                    child: Image.asset(isPWHidden? 'assets/imgs/pw_hidden.png': 'assets/imgs/show_pw_icon.png', width: 8, height: 8,)),
                ),
              filled: true,
              fillColor: AppColor.fieldBg,
            
              hint: Text(
                'Confirm your New Passwrod, ',
                style: TextStyle(
                  color: AppColor.fieldText,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.fieldBg,
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.red
                )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)

              )
            ),
            
            
          ),
        ),
            SizedBox(height: 16,),
            Center(
          child: TextFormField(
            controller: repeatnewpasswordcontroller ,
            obscureText: isPWHidden,
            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'password is required';
                    }
                    if( value.characters.length <8 ){
                      return 'Password must be minimum 8 characters';
                    }
                    return null;
                  },

            focusNode: passwordFocus,
            autocorrect: false,
            style: TextStyle(
              color: AppColor.fontColor,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              
              
        
            ),
        
            decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Image.asset('assets/imgs/ps_icon.png',
                                width: 8,
                                height: 8,),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isPWHidden = !isPWHidden;
                      });
                    },
                    child: Image.asset(isPWHidden? 'assets/imgs/pw_hidden.png': 'assets/imgs/show_pw_icon.png', width: 8, height: 8,)),
                ),
              filled: true,
              fillColor: AppColor.fieldBg,
            
              hint: Text(
                'Enter your Passwrod, ',
                style: TextStyle(
                  color: AppColor.fieldText,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.fieldBg,
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColor.red
                )
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12)

              )
            ),
            
            
          ),
        ),
            SizedBox(height: 48,),
            Button(
              onClicked: () async{
                if(!_keyForm.currentState!.validate()){
                   return ;
                

                }

                if(newpassowrdcontroller.text != repeatnewpasswordcontroller.text){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match'))
                  );
                return;
                }
                
                await Authentication().resetPassword(newpassowrdcontroller.text);
                
              } , 
              color: AppColor.apptheme, 
              title: 'Send', 
              fontColor: AppColor.white, 
              isborder: false)
            ]),
          ),
        )
      ),
    );
  }
}