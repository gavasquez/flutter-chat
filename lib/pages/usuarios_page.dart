import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    final usuarios = [
      Usuario(
          online: true,
          email: 'test1@gmail.com',
          nombre: 'Andres Vasquez',
          uid: '1'),
      Usuario(
          online: false,
          email: 'test2@gmail.com',
          nombre: 'Gustavo Vasquez',
          uid: '2'),
    ];

    _cargarUsuarios() async {
      // monitor network fetch
      await Future.delayed(const Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Mi Nombre',
            style: TextStyle(color: Colors.black54),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.exit_to_app),
            color: Colors.black54,
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: const Icon(
                Icons.offline_bolt,
                color: Colors.red,
                /* Icons.check_circle,
              color: Colors.blue, */
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
            waterDropColor: Colors.blue,
          ),
          child: _listViewUsuarios(usuarios),
          onRefresh: _cargarUsuarios,
        ));
  }

  ListView _listViewUsuarios(List<Usuario> usuarios) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final usuario = usuarios[index];
          return _usuarioLisTile(usuario);
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: usuarios.length);
  }

  ListTile _usuarioLisTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: usuario.online ? Colors.green[300] : Colors.red),
      ),
    );
  }
}
