import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VentasPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ventas',
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
            VentasDatos(),
            VentasFormulario(),
          ],
        ),
      ),
    );
  }
}

class VentasFormulario extends StatefulWidget {
  const VentasFormulario({Key? key}) : super(key: key);

  @override
  _VentasFormularioState createState() => _VentasFormularioState();
}

class _VentasFormularioState extends State<VentasFormulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idVentasController = TextEditingController();
  final TextEditingController _idZapatoController = TextEditingController();
  final TextEditingController _idusuarioController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _cantController = TextEditingController();
  final TextEditingController _ingresosController = TextEditingController();
  final TextEditingController _estadoEntregaController =
      TextEditingController();
  final TextEditingController _metodoPagoController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      await FirebaseFirestore.instance.collection('ventas').add({
        'id_Ventas': _idVentasController.text,
        'id_Zapato': _idZapatoController.text,
        'id_usuario': _idusuarioController.text,
        'fecha': _fechaController.text,
        'cant_ven': _cantController.text,
        'Ingresos Generados': _ingresosController.text,
        'Estado de entrega': _estadoEntregaController.text,
        'metodo_pago': _metodoPagoController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Venta añadida exitosamente')),
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
              controller: _idVentasController,
              decoration: InputDecoration(
                labelText: 'ID Ventas',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID de los Ventas';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idZapatoController,
              decoration: InputDecoration(
                labelText: 'ID Zapato',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el ID de los Zapato';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _idusuarioController,
              decoration: InputDecoration(
                labelText: 'ID usuario',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _cantController,
              decoration: InputDecoration(
                labelText: 'cant_ven',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese la cantidad';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _ingresosController,
              decoration: InputDecoration(
                labelText: 'Ingresos Generados',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _estadoEntregaController,
              decoration: InputDecoration(
                labelText: 'Estado de Entrega',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese el estado del producto';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _metodoPagoController,
              decoration: InputDecoration(
                labelText: 'Método de Pago',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Añadir Venta'),
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

class VentasDatos extends StatelessWidget {
  const VentasDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('ventas').snapshots(),
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
                doc['id_Ventas'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Fecha: ${doc['fecha']}'),
              trailing: Text(doc['metodo_pago']),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            );
          },
        );
      },
    );
  }
}
