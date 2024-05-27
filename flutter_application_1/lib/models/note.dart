class Note {
  int? id;
  String title;
  String fecha;
  String detalle;
 
  Note({
    this.id,
    this.title = '',
    this.fecha = '',
    this.detalle = '',
     // Por defecto, la tarea no está completada
  });

  Note.empty()
      : title = '',
        fecha = '',
        detalle = '';

  Map<String, dynamic> toMap({bool excludeId = false}) {
    if (excludeId) {
      return {
        'title': title,
        'fecha': fecha,
        'detalle': detalle,
        
      };
    } else {
      return {
        'id': id,
        'title': title,
        'fecha': fecha,
        'detalle': detalle,
        
      };
    }
  }
}
