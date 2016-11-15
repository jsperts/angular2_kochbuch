## MDF: Eigene Validatoren definieren {#c04-custom-validation}

### Problem

Ich möchte überprüfen, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet. Wenn kein Großbuchstabe vorhanden ist, soll das Eingabefeld ungültig sein.

### Zutaten

* [MDF: Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* Validierungsfunktion, die überprüft, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet
* Anpassungen an der app.component.ts-Datei

### Lösung

Wir werden hier die gleichen Validierungsfunktionen wie im Rezept "MDF: Formular mit dem FormBuilder und Validierung" nutzen. Wir werden zusätzlich eine eigene Validierungsfunktion namens "containsCapital" implementieren.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    FormGroup,
    Validators,
    FormControl
} from '@angular/forms';

...

export class AppComponent {
  myForm: FormGroup;

  constructor(builder: FormBuilder) {
    this.myForm = builder.group({
      username: builder.control('', Validators.required),
      password: builder.control('', Validators.compose([
        Validators.required,
        Validators.minLength(10),
        function containsCapital(control: FormControl) {
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
    if (this.myForm.valid) {
      console.log(this.myForm.value)
    }
  }
}
```

__Erklärung__:

* Zeilen 20-29: Unsere Validierungsfunktion
  * Zeile 20: Als Parameter erhält die Validierungsfunktion eine Instanz der FormControl-Klasse. In diesem Fall ist die Instanz unser password-Control
  * Zeile 22: Überprüfung, ob der Wert (__control.value__) des Controls einen Großbuchstaben beinhaltet
  * Zeile 23: Wenn das Eingabefeld einen gültigen Wert besitzt, geben wir __null__ zurück
  * Zeilen 25-27: Wenn das Eingabefeld einen ungültigen Wert besitzt, geben wir ein Objekt zurück

### Diskussion

Wenn die Validierung fehlschlägt, muss die Validierungsfunktion ein nicht leeres Objekt zurückgeben.
Wir erhalten auf dieses Objekt über das errors-Objekt des FormControls Zugriff.
Dieses Objekt haben wir im Rezept "[MDF: Fehlermeldungen für einzelne Formular-Felder anzeigen](#c04-input-field-errors-formbuilder)" gesehen.
Solange das Passwort-Feld keinen Großbuchstaben enthält, hat das errors-Objekt eine Eigenschaft namens "containsCapital" mit Wert __true__.
Wir hätten auch ein komplexeres Objekt zurückgeben können, genauso wie es die minLength-Validierungsfunktion tut.
Wenn der Wert des Eingabefelds gültig ist, geben wir __null__ zurück.
Andere Werte wie z. B. __undefined__ haben den gleichen Effekt. Da aber die Angular-Validierungsfunktionen auch __null__ nutzen, um die Ungültigkeit zu kennzeichen, tun wir es hier auch.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/08-Custom_Validation)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/08-Custom_Validation/index.html)

