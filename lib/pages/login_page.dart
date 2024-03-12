import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      // SafeArea para bajar un poco si tiene algo arriba
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            //* Para que tome todo el valor del alto de la pantalla
            height: MediaQuery.of(context).size.height * 0.9,
            child: const Column(
              // Separacion en todos los widgets
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(text: 'Messenger'),
                _Form(),
                Labels(
                  ruta: 'register',
                  titulo: '¿No tienes cuenta?',
                  subTitulo: 'Crea una ahora',
                ),
                Text(
                  'Terminos y condiciones de uso',
                  style: TextStyle(fontWeight: FontWeight.w200),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();
  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          //* Email
          CustomInput(
            icon: Icons.email_outlined,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),

          //* Passowrd
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            isPassword: true,
            textController: passCtrl,
          ),
          //* crear boton
          BotonAzul(
            text: 'Ingresa',
            onPressed: authService.autenticando
                ? null
                : () async {
                    // Quitar el foco del teclado, se quita el teclado
                    FocusScope.of(context).unfocus();
                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                      //! Connectar al Socket server

                      //!Navegar a otra pantalla
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      // ignore: use_build_context_synchronously
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus credenciales nuevamente');
                    }
                  },
          )
        ],
      ),
    );
  }
}
