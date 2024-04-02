import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController tituloControler = TextEditingController();
  TextEditingController detalleControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          TextField(
            controller: tituloControler,
            decoration: InputDecoration(hintText: 'Titulo'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: detalleControler,
            decoration: InputDecoration(hintText: 'Detalles'),
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            minLines: 5,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            clipBehavior: Clip.antiAlias,
            onPressed: submintData,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> submintData() async {
    // Obtener los datos del formulario
    final texto = tituloControler.text;
    final detalle = detalleControler.text;
    final body = {
      "title": texto,
      "description": detalle,
      "is_completed": false
    };
    // Enviar datos al server
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    // Mostrar si fue exitosos o no y porque

    if (response.statusCode == 201) {
      tituloControler.text = '';
      detalleControler.text = '';
      print('Creacion Success');
      showSuccesMessage('Creacion Success');
    } else {
      print('Failed Creacion Success');
      showErrorSuccesMessage('Failed Creacion Success');
      print(response.body);
    }
  }

  void showSuccesMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorSuccesMessage(String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
