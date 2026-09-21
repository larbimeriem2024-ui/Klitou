import 'package:flutter/material.dart';
import 'package:flutter_application_9_klitou/core/constants/app_color.dart';
import 'package:flutter_application_9_klitou/features/auth/errors/auth_error_message.dart';
import 'package:flutter_application_9_klitou/features/auth/state/providers/signup_provider.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/big_title.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/button.dart';
import 'package:flutter_application_9_klitou/shared/common_widgets/description_text.dart';
import 'package:flutter_application_9_klitou/features/auth/widgets/textfield.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool isPWHidden = true;

  final _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(
  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',);

  
  

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController phonencontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  late FocusNode nameFocus;
  late FocusNode emailFocus;
  late FocusNode phonenFocus;
  late FocusNode passwordFocus;

  

  @override
  void initState() {
    nameFocus = FocusNode();
    emailFocus = FocusNode();
    phonenFocus =FocusNode();
    passwordFocus = FocusNode();
    super.initState();
    
  }

  @override
  void dispose() {
    
    
    namecontroller.dispose();
    emailcontroller.dispose();
    phonencontroller.dispose();
    passwordcontroller.dispose();

    nameFocus.dispose();
    emailFocus.dispose();
    phonenFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(signupNotifierProvider);
    final isLoading = authState.isLoading;
    ref.listen(signupNotifierProvider, (previous, next) {
  next.whenOrNull(
    error: (error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(getAuthErrorMessage(error))),
      );
    },

    

  );
});
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
            
            Text(
              'klitou ',
              style: TextStyle(
                color: AppColor.apptheme, 
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),
              ),

              SizedBox(),
        
           
        
        
        
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, ),
          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                

                BigTitle(title: 'Create an Account'),
                SizedBox(height: 8,),

                DescriptionText(
                  title: 'sign up to start your ordering journey',
                ),
                SizedBox(height: 20),
                SizedBox(height: 10),
                Textfield(
                  controller: namecontroller,
                  title: 'Name',
                  icon: 'assets/imgs/person.png',
                  description1: 'Enter your Name',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'name is required';
                    }
                    if(value.length < 3){
                      return 'name must be at least 3 characters';
                    }
                    return null;
                  },
                  somethingFocusNode: nameFocus,
                ),
                SizedBox(height: 16),
                Textfield(
                  controller: emailcontroller,
                  title: 'Email',
                  icon: 'assets/imgs/email_icon.png',
                  description1: 'Enter your Email',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if(!emailRegex.hasMatch(value)){
                      return "Invalid email";
                    }
                    return null;
                  },
                  somethingFocusNode: emailFocus,


                ),
                SizedBox(height: 16),
                Textfield(
                  controller: phonencontroller,
                  title: 'Phone Number',
                  icon: 'assets/imgs/phone_icon.png',
                  description1: 'Enter your Phone Number',
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'phone number is required';
                    }
                     if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'Only digits are allowed';
                    }
                    if(value.length !=10) {
                      return 'invalid phone number';
                    }
                    return null;
                  },
                  somethingFocusNode: phonenFocus,
                ),
                SizedBox(height: 16),
                
                Column(
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

        Center(
          child: TextFormField(
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
                'Enter your Password, ',
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
      ],
    ),
                SizedBox(height: 32),

                Button(
                  onClicked: () async {
                    FocusScope.of(context).unfocus();
                    

                    
                    
                      final isValid = _formKey.currentState!.validate();
                      

                      if (!isValid) {
                        return;
                      }
                    
                      await ref.read(signupNotifierProvider.notifier).signup(
                       email:  emailcontroller.text,
                       password:  passwordcontroller.text,
                       name:  namecontroller.text,
                       phone:  phonencontroller.text,
                      );
                      
                      
                    
                       
                      
                    
                  },

                  color: AppColor.apptheme,
                  title: isLoading? 'loading ...':'Sign up ',
                  fontColor: AppColor.white,
                  isborder: false,
                ),

                SizedBox(height: 48),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DescriptionText(title: 'Already have an account?'),
                    SizedBox(width: 2),
                    InkWell(
                      onTap: () {
                        context.push('/login');
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: AppColor.apptheme,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
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
