## Formular mit dem FormBuilder und Validierung {#c04-formbuilder-validation}

### Problem

Ich möchte ein Formular mit dem FormBuilder bauen und zusätzlich möchte ich auch in der Lage sein, zu erkennen, wann das Formular gültig ist.

### Zutaten
* [Formular mit dem FormBuilder implementieren](#c04-formbuilder)
* Die Validierungsfunktionen von Angular (Validators-Klasse)
* Anpassungen an der Komponente aus "Formular mit dem FormBuilder implementieren"

### Lösung

In dieser Lösung werden wir dasselbe Problem lösen wie im Rezept "[Gültigkeit eines Formulars überprüfen](#c04-form-validation)".
Nur werden wir hier mit Validierungsfunktionen anstelle von Validierungs-Attributen arbeiten.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    FormGroup,
    Validators
} from '@angular/forms';

...

export class AppComponent {
  myForm: FormGroup;

  constructor(builder: FormBuilder) {
    this.myForm = builder.group({
      username: builder.control('', Validators.required),
      password: builder.control('', Validators.compose([
        Validators.required,
        Validators.minLength(10)
      ]))
    });
  }

  onSubmit() {
    if (this.myForm.valid) {
      console.log(this.myForm.value);
    }
  }
}
```

__Erklärung__:

* Zeile 15: Control für das Benutzernamefeld definieren. Mit __Validators.required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeile 16: Ein Control erwartet als zweiten Parameter eine Validierungsfunktion. Wenn wir mehrere Funktionen gleichzeitig nutzen möchten, müssen wir die compose-Funktion nutzen
* Zeile 17: Hier definieren wir das Passwortfeld als Pflichtfeld
* Zeile 18: Das Feld muss mindestens zehn Zeichen beinhalten, damit es gültig ist

### Code

Code auf Github: [04-Form\_Recipes/06-Form\_Validation\_with\_FormBuilder](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/06-Form_Validation_with_FormBuilder)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/06-Form_Validation_with_FormBuilder/index.html)

### Weitere Ressourcen

* Offizielle [Validators](https://angular.io/docs/ts/latest/api/common/Validators-class.html)-Dokumentation auf der Angular 2 Webseite

