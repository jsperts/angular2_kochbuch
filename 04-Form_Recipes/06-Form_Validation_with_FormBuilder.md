## Formular mit dem FormBuilder und Validierung {#c04-formbuilder-validation}

### Problem

Ich möchte ein Formular mit dem FormBuilder bauen und zusätzlich möchte ich auch in der Lage sein zu erkennen wann das Formular gültig ist.

### Zutaten
* [Formular mit dem FormBuilder implementieren](#c04-formbuilder)
* Die Validierungs-Funktionen von Angular (Validators-Klasse)
* Anpassungen an der Komponente von "Formular mit dem FormBuilder implementieren"

### Lösung

In dieser Lösung werden wir dasselbe Problem lösen wie im Rezept [Gültigkeit eines Formulars überprüfen](#c04-form-validation).
Nur werden wir hier mit Validierungs-Funktionen statt mit Validierungs-Attribute arbeiten.

{title="Ausschnitt aus einer Komponente", lang=js}
```
import {Component, View} from 'angular2/core';
import {FormBuilder, ControlGroup} from 'angular2/common';
import {Validators} from 'angular2/common';

...

class MyApp {
  form: ControlGroup;
  constructor(builder: FormBuilder) {
    this.form = builder.group({
      username: builder.control('', Validators.required),
      password: builder.control('', Validators.compose([
          Validators.required,
          Validators.minLength(10)
      ]))
    })
  }

  onSubmit() {
    if (this.form.valid) {
      console.log(this.form.value)
    }
  }
}

...
```

Erklärung:

* Zeile 3: Hier importieren wir alle Validatoren die uns Angular zur Verfügung stellt
* Zeile 11: Control für das Benutzername-Feld definieren. Mit __Validators.required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeile 12: Ein Control erwartet als zweiten Parameter eine Validierungs-Funktion. Wenn wir mehrere Funktionen gleichzeitig nutzen möchten, müssen wir die compose-Funktion nutzen
* Zeile 13: Hier definieren wir das Passwort-Feld als Pflichtfeld
* Zeile 14: Das Feld muss mindestens zehn Zeichen beinhalten, damit es gültig ist

### Code

Code auf Github: [04-Form\_Recipes/06-Form\_Validation\_with\_FormBuilder](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/06-Form_Validation_with_FormBuilder)

### Weitere Ressourcen

* Offizielle [Validators](https://angular.io/docs/ts/latest/api/common/Validators-class.html) Dokumentation auf der Angular 2 Webseite

