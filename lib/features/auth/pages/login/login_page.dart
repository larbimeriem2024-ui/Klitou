import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/auth/errors/auth_error_message.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/auth_provider.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/login_provider.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/features/auth/widgets/textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {

  bool isPWHidden = true;

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _keyForm = GlobalKey <FormState>();
  final emailRegex = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',);

  late FocusNode emailFocus;
  late FocusNode passwordFocus;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();


  }

  @override
  void dispose() {
    

    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(loginNotifierProvider);
    final isLoading = authState.isLoading;
    ref.listen(loginNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getAuthErrorMessage(error)))),
        
      );
    },);
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
                context.go('/onboarding');
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
            
              
            
            BigTitle(title: 'Log in'),
            DescriptionText(title: 'Login now to get started your ordering journey'),
            SizedBox(height: 32,),
            Textfield(controller: emailcontroller , title: 'Email', icon: 'assets/imgs/email_icon.png', description1: 'Enter your Email', validate: (value) {
                if(value == null || value.isEmpty){
                  return 'Email is required';
                }
                if(!emailRegex.hasMatch(value)){
                      return "Invalid email";
                }


                return null;
              },
              somethingFocusNode: emailFocus,),
            SizedBox(height: 16,),
            Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
          'Password',
          style: TextStyle(
            color: AppColor.fontColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 3),

              TextFormField(
                controller:passwordcontroller ,
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
                      color: AppColor.description,
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
            ],
          ),
        ),
            SizedBox(height: 16,),
            Align(
              alignment: AlignmentGeometry.centerRight,
              child: InkWell(
                
                    onTap: () {
                      context.push('/forgetpassword');
                    },
                    child: Text('forget Password?',
                    style: TextStyle(
                      color: AppColor.apptheme,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),),
                  ),
            ),
            
            SizedBox(height: 32,),
            Button(onClicked: () async{
             final isValid = _keyForm.currentState!.validate();
          

         if (!isValid) {
        return;
                 }
             
               await ref.read(loginNotifierProvider.notifier).login(
               email: emailcontroller.text, 
               password:  passwordcontroller.text);
              
             
              
            }, 
            color: AppColor.apptheme, 
            title: isLoading ? 'Loading': 'Login', 
            fontColor:AppColor.white , 
            isborder: false),
            
            SizedBox(height: 32,),
              Center(child: DescriptionText(title: 'Or')),
              SizedBox(height: 16,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await ref.read(authNotifierProvider.notifier).signInWithGoogle();
                        
                       
                          
                        
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            'assets/imgs/google.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColor.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 2,
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Image.asset(
                          'assets/imgs/apple-logo.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    GestureDetector(
                      onTap: () {
                        ref.read(authNotifierProvider.notifier).signInWithFacebook();
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColor.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Image.asset(
                            'assets/imgs/facebook.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                
            
            
            SizedBox(height: 48,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DescriptionText(title: 'Do not have an account ?'),
                SizedBox(width: 2,),

                InkWell(
                  onTap: () {
                    context.push('/signup');
                  },
                  child: Text('Sign Up',
                  style: TextStyle(
                    color: AppColor.apptheme,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),),
                )
              ],
            ),
            
            
            SizedBox(height: 100,)
            
            
            ],
            ),
          ),
        ),
      ),
    );
  }
}