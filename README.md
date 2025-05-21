#Explicacion de las mejoras del proyecto

- Implementacion del patron MODELO-VISTA-CONTROLADOR
- Implementacion riverpod para gestion de estado
- Se estrucuuro de manera adecuada las carpetas
- Clara separacion de responsabilidades

La estructura original contenia todo en lib/main.dart. La nueva estructura separa todo de manera mas clara:

lib/
  main.dart
  models/
    pokemon.dart
  controller/
    pokemon_controller.dart
  views/
    home_page.dart
    pokemon_list_screen.dart
  providers/
    pokemon_povider.dart

Ahora los estados no se gestionan con variables, se utiliza el patron copyWith

Antes todo estaba mezclado, ahora los controladores manejan la logica de estado, las vistas solo muestran la UI, los modelos definen las estructuras de datos  y los proveedores conectan controladores con vistas