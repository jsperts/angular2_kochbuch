## Eigene Validatoren definieren {#c04-custom-validation}

### Problem

Ich möchte überprüfen, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet. Wenn kein Großbuchstabe vorhanden ist, soll das Eingabefeld ungültig sein.

### Zutaten
* [Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* Validierungs-Funktion die überprüft, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet
* Anpassungen an der Komponente von "Formular mit dem FormBuilder und Validierung"

### Lösung

Wir werden hier die gleiche Validierungs-Funktionen wie im "Formular mit dem FormBuilder und Validierung" Rezept nutzen. Wir werden zusätzlich eine eigene Validierungs-Funktion namens "containsCapital" implementieren.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    ControlGroup,
    Validators,
    Control
} from '@angular/common';

...

export class DemoAppComponent {
  form: ControlGroup;

  constructor(builder: FormBuilder) {
    this.form = builder.group({
      username: builder.control('', Validators.required),
      password: builder.control('', Validators.compose([
        Validators.required,
        Validators.minLength(10),
        function containsCapital(control: Control) {
          const reg = /[A-Z]/;
          if (reg.test(control.value)) {
            return null;
          } else {
            return {
              containsCapital: true
            };
          }
        }
      ]))
    });
  }

  onSubmit() {
    if (this.form.valid) {
      console.log(this.form.value)
    }
  }
}
```

__Erklärung__:

* Zeile 6: Hier importieren wir die Control-Klasse. Wir nutzen diese für die Typdefinition in Zeile 19
* Zeilen 20-29: Unsere Validierungs-Funktion
  * Zeile 20: Als Parameter bekommt eine Validierungs-Funktion immer eine Instanz der Control-Klasse. In diesem Fall ist die Instanz unser password-Control
  * Zeile 22: Überprüfung, ob der Wert (__control.value__) des Controls einen Großbuchstaben beinhaltet
  * Zeile 23: Wenn das Eingabefeld einen gültigen Wert beinhaltet, geben wir __null__ zurück
  * Zeile 25: Wenn das Eingabefeld einen ungültigen Wert beinhaltet, geben wir ein Objekt zurück

### Diskussion

Wenn die Validierung fehlschlägt, muss die Validierungs-Funktion ein Objekt zurück geben.
Wir bekommen Zugriff auf dieses Objekt über das errors-Objekt des Controls.
Dieses Objekt haben wir im Rezept "[Fehlermeldungen für einzelne Formular-Felder anzeigen](#c04-input-field-errors)" gesehen.
Solang das Passwort-Feld kein Großbuchstabe enthält, hat das errors-Objekt eine Eigenschaft namens "containsCapital" mit Wert __true__.
Wir hätten auch ein komplexeres Objekt zurückgeben können genau so wie es die minLength-Validierungs-Funktion tut.
Wenn der Wert im Eingabefeld gültig ist, geben wir __null__ zurück.
Andere Werte wie z. B. __undefined__ haben den gleichen Effekt, da aber die Angular-Validierungs-Funktionen auch __null__ nutzen, um die Ungültigkeit zu kennzeichen tun wir es hier auch.

### Code

Code auf Github: [04-Form\_Recipes/07-Custom\_Validation](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/07-Custom_Validation)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/07-Custom_Validation/index.html)

