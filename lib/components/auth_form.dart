import 'package:flutter/material.dart';
import 'package:flutter_chat_cod3r/models/auth_form_data.dart';


class AuthForm extends StatefulWidget {

  final void Function(AuthFormData) onSubmit;

  const AuthForm({
        Key? key,
        required this.onSubmit
      }) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submit(){
    final isValid = _formKey.currentState?.validate() ?? false;
    if(!isValid) return;

    widget.onSubmit(_formData);

  }


  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              if(_formData.isSignup)
                TextFormField(
                  key: const ValueKey("name"),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name ,
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (_name){
                    final name = _name ?? '';
                    if(name.trim().length < 5){
                      return 'Nome deve ter no minimo 5 caracteres';
                    }
                    return null;

                  },
                ),

              TextFormField(
                key: const ValueKey("email"),
                initialValue: _formData.email,
                onChanged: (email) => _formData.email = email ,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (_email){
                  final email = _email ?? '';
                  if(!email.contains("@")){
                    return 'Email Invalido.';
                  }
                  return null;

                },
              ),

              TextFormField(
                key: const ValueKey("password"),
                initialValue: _formData.password,
                onChanged: (password) => _formData.password = password ,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Senha"),
                validator: (_password){
                  final password = _password ?? '';
                  if(password.trim().length < 6){
                    return 'Nome deve ter no minimo 6 caracteres';
                  }
                  return null;

                },
              ),

              SizedBox(height: 12,),


              ElevatedButton(
                  onPressed: _submit,
                  child: Text(_formData.isLogin? "Entrar" : "Cadastrar"),
              ),

              TextButton(
                  child:  Text(_formData.isLogin
                      ? "Criar uma nova conta?"
                      : "Jã possui conta?"),
                  onPressed: (){
                    setState(() {

                      _formData.toggleAuthMode();
                    });
                  },
              )

            ],
          ),
        ),
      ),
    );
  }
}