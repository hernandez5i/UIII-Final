import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MarcaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Marca',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff707070),
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
            MarcaDatos(),
            MarcaFormulario(),
          ],
        ),
      ),
    );
  }
}

class MarcaFormulario extends StatefulWidget {
  const MarcaFormulario({Key? key}) : super(key: key);

  @override
  _MarcaFormularioState createState() => _MarcaFormularioState();
}

class _MarcaFormularioState extends State<MarcaFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _marcasController = TextEditingController();
  final TextEditingController _tallaController = TextEditingController();
  final TextEditingController _accesoriosController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _materialController = TextEditingController();
  final TextEditingController _tipozapatoController = TextEditingController();
  final TextEditingController _agujetasController = TextEditingController();
  final TextEditingController _anioestrenoController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('marca').add({
        'marcas': _marcasController.text,
        'talla': _tallaController.text,
        'accesorios': _accesoriosController.text,
        'color': _colorController.text,
        'material': _materialController.text,
        'tipozapato': _tipozapatoController.text,
        'agujetas': _agujetasController.text,
        'anioestreno': _anioestrenoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Producto vendido añadido exitosamente')),
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
              controller: _marcasController,
              decoration: InputDecoration(
                labelText: 'Ingrese marca',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la marca del producto vendido';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _tallaController,
              decoration: InputDecoration(
                labelText: 'Talla de zapatos',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la talla de productos';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _accesoriosController,
              decoration: InputDecoration(
                labelText: 'accesorios',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _colorController,
              decoration: InputDecoration(
                labelText: 'Color',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el color';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _materialController,
              decoration: InputDecoration(
                labelText: 'Material',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el material';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _tipozapatoController,
              decoration: InputDecoration(
                labelText: 'Tipo de zapato',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el tipo';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _agujetasController,
              decoration: InputDecoration(
                labelText: 'Agujetas',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese las agujetas';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Producto Vendido'),
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

class MarcaDatos extends StatelessWidget {
  const MarcaDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('marca').snapshots(),
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
                doc['marcas'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Color: ${doc['color']}'),
              trailing: Text(doc['material']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
