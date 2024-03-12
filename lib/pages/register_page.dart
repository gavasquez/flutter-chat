import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                Logo(text: 'Registro'),
                _Form(),
                Labels(
                    ruta: 'login',
                    titulo: '¿Ya tienes una cuenta?',
                    subTitulo: 'Ingresa ahora'),
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
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          //* Nombre
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.emailAddress,
            textController: nameCtrl,
          ),
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
            text: 'Crear',
            onPressed: authService.autenticando
                ? null
                : () async {
                    final registerOk = await authService.register(
                        nombre: nameCtrl.text.trim(),
                        email: emailCtrl.text.trim(),
                        password: passCtrl.text.trim());
                    if (registerOk == true) {
                      //! Conectar al Socket server
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      // ignore: use_build_context_synchronously
                      mostrarAlerta(context, 'Registro incorrecto', registerOk);
                    }
                  },
          )
        ],
      ),
    );
  }
}
