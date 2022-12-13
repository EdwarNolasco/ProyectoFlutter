import 'package:flutter/material.dart';
import 'package:listatareas/main.dart';
import 'package:listatareas/tarea.dart';

class nuevaTarea extends StatefulWidget {
  //nos sirve para establecer la interfaz de usuarios

  final Tarea tarea;
  final String appBarTitle;
  ListaTareasState listaTareasState;
  int posicion;

  nuevaTarea(this.tarea, this.appBarTitle, this.listaTareasState,
      [this.posicion = -1]);

  @override
  State<StatefulWidget> createState() {
    //creamos el estado del widget en una ubicación dada
    return NuevaTareaState(
        this.tarea, this.appBarTitle, this.listaTareasState, this.posicion);
  }
}

class NuevaTareaState extends State<nuevaTarea> {
  ListaTareasState listaTareasState;
  String titulo;
  Tarea tarea;
  int posicion;
  bool marcado = false;

  NuevaTareaState(
      this.tarea, this.titulo, this.listaTareasState, this.posicion);

  TextEditingController tareaController = new TextEditingController();
  //controlador de texto, que cada modificacion de un campo actualiza su valor y notifica en la app
  @override
  Widget build(BuildContext context) {
    //localizador del widget y su posición
    tareaController.text = tarea.nombre;

    return Scaffold(
        //estrctura de diseño
        key: GlobalKey<ScaffoldState>(),
        appBar: AppBar(
          //parte superior de la app
          leading: new GestureDetector(
              child: Icon(Icons.close),
              onTap: () {
                Navigator.pop(context); //Regresa a la primera ruta
                listaTareasState.actualizarListView();
              }),
          title: Text(titulo),
        ),
        body: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 50.0),
                child: _estaEditando()
                    ? CheckboxListTile(
                        title: Text("Completada"),
                        value: marcado,
                        onChanged: (bool valor) {
                          //para cuando finalizamos lo que escribimos
                          setState(() {
                            marcado = valor;
                          });
                        },
                      )
                    : Container(
                        height: 2,
                      )),
            Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: tareaController,
                  decoration: InputDecoration(
                    labelText: "Tarea",
                    hintText: "Ej. Aprender Flutter",
                  ),
                  onChanged: (value) {
                    actualizaTarea();
                  },
                )),
            Padding(
                padding: EdgeInsets.all(15.0),
                child: ElevatedButton(
                  child: Text("Guardar"),
                  onPressed: () {
                    setState(() {
                      _guardar();
                    });
                  },
                ))
          ],
        ));
  }

  void _guardar() {
    tarea.estado = "";
    if (_estaEditando()) {
      if (marcado) {
        tarea.estado = "Completada";
      }
    }
    tarea.nombre = tareaController.text;

    if (_comprobarNoNull()) {
      if (!_estaEditando())
        listaTareasState.listaTareas.add(tarea);
      else
        listaTareasState.listaTareas[posicion] = tarea;
      listaTareasState.actualizarListView();
      Navigator.pop(context);
      mostrarSnackBar("Tarea guardada correctamente");
    }
  }

  bool _comprobarNoNull() {
    bool res = true;
    if (tareaController.text.isEmpty) {
      mostrarSnackBar("La tarea es obligatoria");
      res = false;
    }
    return res;
  }

  void mostrarSnackBar(String mensaje) {
    final snackBar = SnackBar(
        content: Text(mensaje),
        duration: Duration(seconds: 1, milliseconds: 500));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void actualizaTarea() {
    tarea.nombre = tareaController.text;
  }

  bool _estaEditando() {
    bool editando = true;
    if (this.posicion == -1) editando = false;
    return editando;
  }
}
