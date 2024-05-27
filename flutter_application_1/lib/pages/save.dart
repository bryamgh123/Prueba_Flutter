import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/operation.dart';
import 'package:flutter_application_1/models/note.dart';

class SavePage extends StatefulWidget {
  const SavePage({Key? key}) : super(key: key);
  static const String ROUTE = "/save";

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final fechaController = TextEditingController();
  final detalleController = TextEditingController();
  Note? _note;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_note == null) {
      _note = ModalRoute.of(context)?.settings.arguments as Note?;
      if (_note != null) {
        _init(_note!);
      }
    }
  }

  void _init(Note note) {
    titleController.text = note.title;
    fechaController.text = note.fecha;
    detalleController.text = note.detalle;
  }

  @override
  void dispose() {
    titleController.dispose();
    fechaController.dispose();
    detalleController.dispose();
    super.dispose();
  }

  Future<void> _saveOrUpdateNote() async {
    if (_formKey.currentState?.validate() ?? false) {
      print("Formulario válido");

      if (_note?.id == null) {
        print("Insertando nueva nota");

        // Insertar nueva nota
        await Operation.insert(
          context,
          Note(
            title: titleController.text,
            fecha: fechaController.text,
            detalle: detalleController.text,
          ),
        );
      } else {
        print("Actualizando nota existente");

        // Actualizar nota existente
        await Operation.update(
          context,
          Note(
            id: _note!.id,
            title: titleController.text,
            fecha: fechaController.text,
            detalle: detalleController.text,
          ),
        );
      }

      // Actualizar la lista después de insertar o actualizar la nota
      setState(() {});
      Navigator.pop(context);
    } else {
      print("Formulario inválido");

      // Mostrar los errores de validación del formulario
      setState(() {
        _formKey.currentState?.validate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_note == null ? "Guardar nueva tarea" : "Actualizar tarea"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Complete el nombre de la tarea";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Tarea*",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: fechaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Complete el tiempo de la tarea";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Tiempo límite*",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: detalleController,
                maxLines: 2,
                maxLength: 500,
                decoration: InputDecoration(
                  labelText: "Descripción de la tarea",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                child: Text("Guardar"),
                onPressed: _saveOrUpdateNote,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
