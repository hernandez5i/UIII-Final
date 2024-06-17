import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ZapatosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Zapatos',
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
            ProductoDatos(),
            ZapatosFormulario(),
          ],
        ),
      ),
    );
  }
}

class ZapatosFormulario extends StatefulWidget {
  const ZapatosFormulario({Key? key}) : super(key: key);

  @override
  _ZapatosFormularioState createState() => _ZapatosFormularioState();
}

class _ZapatosFormularioState extends State<ZapatosFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idzapatoController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
  final TextEditingController _fechalanzaController = TextEditingController();
  final TextEditingController _clasificacionController =
      TextEditingController();
  final TextEditingController _proveedoresController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('zapatos').add({
        'idzapato': _idzapatoController.text,
        'nombre': _nombreController.text,
        'descripcion': _descripcionController.text,
        'precio': double.tryParse(_precioController.text) ?? 0.0,
        'genero': _generoController.text,
        'fechalanza': _fechalanzaController.text,
        'clasificacion': _clasificacionController.text,
        'proveedores': _proveedoresController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto añadido exitosamente')),
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
              controller: _idzapatoController,
              decoration: InputDecoration(
                labelText: 'ID Producto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID del producto';
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
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripcion Producto',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la descripcion del producto';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _precioController,
              decoration: InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el precio del producto';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _generoController,
              decoration: InputDecoration(
                labelText: 'genero',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechalanzaController,
              decoration: InputDecoration(
                labelText: 'Fecha Lanzamiento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _clasificacionController,
              decoration: InputDecoration(
                labelText: 'Clasificacion',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _proveedoresController,
              decoration: InputDecoration(
                labelText: 'Proveedores',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Producto'),
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

class ProductoDatos extends StatelessWidget {
  const ProductoDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('zapatos').snapshots(),
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
                doc['nombre'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('Id: ${doc['idzapato']} - Precio: \$${doc['precio']}'),
              trailing: Text(doc['genero']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
