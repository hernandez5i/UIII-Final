import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProveedorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Proveedor',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff6e6e6e),
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
            ProveedorDatos(),
            ProveedorFormulario(),
          ],
        ),
      ),
    );
  }
}

class ProveedorFormulario extends StatefulWidget {
  const ProveedorFormulario({Key? key}) : super(key: key);

  @override
  _ProveedorFormularioState createState() => _ProveedorFormularioState();
}

class _ProveedorFormularioState extends State<ProveedorFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreIdController = TextEditingController();
  final TextEditingController _paisorigenController = TextEditingController();
  final TextEditingController _anioController = TextEditingController();
  final TextEditingController _pagprovedorController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('proveedores').add({
        'id_proveedor': _idController.text,
        'id_nombre': _nombreIdController.text,
        'pais_origen': _paisorigenController.text,
        'Año Fundacion': _anioController.text,
        'Pagina Proveedor': _pagprovedorController.text,
        'estado': _descripcionController.text,
        'telefono': _telefonoController.text,
        'correo': _correoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Proveedor añadido exitosamente')),
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
                labelText: 'ID Proveedor',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del proveedor';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nombreIdController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _paisorigenController,
              decoration: InputDecoration(
                labelText: 'País de origen',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el nombre de la empresa';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _anioController,
              decoration: InputDecoration(
                labelText: 'Año Fundacion',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _pagprovedorController,
              decoration: InputDecoration(
                labelText: 'Pagina del Proveedor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'descripcion',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _telefonoController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
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
              child: const Text('Añadir Proveedor'),
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

class ProveedorDatos extends StatelessWidget {
  const ProveedorDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('proveedores').snapshots(),
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
                doc['pais_origen'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('ID: ${doc['id_proveedor']}'),
              trailing: Text(doc['Pagina Proveedor']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
