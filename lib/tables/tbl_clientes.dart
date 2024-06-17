import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Clientes',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff5d5d5d),
          bottom: const TabBar(
            labelColor: Colors.white,
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Tabla', icon: Icon(Icons.list, color: Colors.white)),
              Tab(
                  text: 'Datos',
                  icon: Icon(Icons.list_alt, color: Colors.white)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ClienteDatos(),
            ClienteFormulario(),
          ],
        ),
      ),
    );
  }
}

class ClienteFormulario extends StatefulWidget {
  const ClienteFormulario({Key? key}) : super(key: key);

  @override
  _ClienteFormularioState createState() => _ClienteFormularioState();
}

class _ClienteFormularioState extends State<ClienteFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _cuentaController = TextEditingController();
  final TextEditingController _paisController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();
  final TextEditingController _fechaREgistroController =
      TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('clientes').add({
        'id_cliente': _idController.text,
        'nombre': _nombreController.text,
        'edad': _edadController.text,
        'cuenta': _cuentaController.text,
        'pais': _paisController.text,
        'contrasenia': _contraseniaController.text,
        'fecha_registro': _fechaREgistroController.text,
        'correo': _correoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cliente añadido exitosamente')),
      );

      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'ID Cliente',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del cliente';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre del cliente';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _edadController,
              decoration: InputDecoration(
                labelText: 'edad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _cuentaController,
              decoration: InputDecoration(
                labelText: 'cuenta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _paisController,
              decoration: InputDecoration(
                labelText: 'pais',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _contraseniaController,
              decoration: InputDecoration(
                labelText: 'contrasenia',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechaREgistroController,
              decoration: InputDecoration(
                labelText: 'Fecha de registro',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _correoController,
              decoration: InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Cliente'),
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff000000),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ClienteDatos extends StatelessWidget {
  const ClienteDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('clientes').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return ListView.builder(
          itemCount: data.size,
          itemBuilder: (context, index) {
            final doc = data.docs[index];
            return ListTile(
              title: Text(
                '${doc['nombre']} ${doc['edad']}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('ID: ${doc['id_cliente']}'),
              trailing: Text(doc['pais']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
