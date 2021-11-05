import 'package:flutter/material.dart';
import 'package:flutter_chat_cod3r/components/auth_form.dart';
import 'package:flutter_chat_cod3r/core/models/auth_form_data.dart';


class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool _isLoading = false;

  Future<void> _handleDubmit(AuthFormData formData) async{

    try{
      setState(() => _isLoading = true);

      if(formData.isLogin){
        //Login
      }else{
        //Signup
      }

    }catch(error){
      //TRATAR ERRO!!
    }finally{
      setState(() => _isLoading = false);
    }

    debugPrint(formData.email);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleDubmit),
            ),
          ),

          if(_isLoading)
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, .5),
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      ),
    );
  }
}
