import 'package:flutter/material.dart';
import 'package:requenes0397/main.dart';
import 'conclusiones.dart';
import 'package:requenes0397/tables/tbl_clientes.dart';
import 'package:requenes0397/tables/tbl_zapatos.dart';
import 'package:requenes0397/tables/tbl_marca.dart';
import 'package:requenes0397/tables/tbl_proveedores.dart';
import 'package:requenes0397/tables/tbl_ventas.dart';
import 'perfil.dart';
import 'contacto.dart';
import 'images.dart';

class PaginaInicio extends StatelessWidget {
  final String _email;

  const PaginaInicio(this._email, {Key? key}) : super(key: key);

  void _cerrarSesion(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PaginaSesion()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Tienda de Zapatería',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontSize: 22,
            ),
          ),
          backgroundColor: const Color(0xff898989),
          elevation: 8,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color(0xffFF69B4),
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://i.ytimg.com/vi/Ll2rA7IpeNI/maxresdefault.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Text(
                  'Menú',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: const Text('Inicio'),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaginaInicio(_email)),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: const Text('Zapatos'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ZapatosPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: const Text('Clientes'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClientesPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.receipt),
                title: const Text('Ventas'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VentasPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('Marca'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MarcaPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: const Text('Proveedores'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProveedorPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: const Text('Conclusiones'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ConclusionesPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: const Text('Cerrar sesión'),
                onTap: () {
                  _cerrarSesion(context);
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '¡Bienvenido a la Tienda de Zapatería!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
            ImagesPage(),
            PerfilPage(),
            ContactoPage(),
          ],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home, color: Color(0xff666666)),
            ),
            Tab(
              icon: Icon(Icons.shopping_bag, color: Color(0xff6d6d6d)),
            ),
            Tab(
              icon: Icon(Icons.person, color: Color(0xff5f5f5f)),
            ),
            Tab(
              icon: Icon(Icons.contact_mail, color: Color(0xff7f7f7f)),
            ),
          ],
          labelColor: Color(0xff878787),
          unselectedLabelColor: Color(0xff5c5c5c),
          indicatorColor: Color(0xff7a7a7a),
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }
}
