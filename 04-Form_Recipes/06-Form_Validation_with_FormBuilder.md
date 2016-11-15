## MDF: Gültigkeit eines Formulars überprüfen {#c04-formbuilder-validation}

### Problem

Ich möchte ein Formular mit dem FormBuilder bauen und zusätzlich möchte ich auch in der Lage sein, zu erkennen, wann das Formular gültig ist.

In diesem Rezept lösen wir dasselbe Problem wie im Rezept "[TDF: Gültigkeit eines Formulars überprüfen](#c04-form-validation)".
Nur werden wir hier mit Validierungsfunktionen anstelle von Validierungs-Attributen arbeiten.

### Zutaten

* [MDF: Formular mit dem FormBuilder implementieren](#c04-formbuilder)
* Die Validierungsfunktionen von Angular (Validators-Klasse)
* Anpassungen an der app.component.ts-Datei

### Lösung 1

In dieser Lösung werden wir sehen, wie wir den Submit-Button deaktivieren können, wenn wir ein Model-Driven Formular nutzen.
Diese Lösung ist äquivalent zur Lösung 1 im Rezept "TDF: Gültigkeit eines Formulars überprüfen".

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    FormGroup,
    Validators
} from '@angular/forms';

@Component({
  selector: 'app-root',
  template: `
    <form (ngSubmit)="onSubmit()" [formGroup]="myForm" novalidate>
      <label>Username
        <input type="text" formControlName="username"/>
      </label>
      <label>Password
        <input type="password" formControlName="password"/>
      </label>
      <button
        type="submit"
        [disabled]="myForm.invalid"
      >Submit</button>
    </form>
  `
})
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
    console.log(this.myForm.value);
  }
}
```

__Erklärung__:

* Zeile 20: Hier binden wir die disabled-Eigenschaft an den Ausdruck __myForm.invalid__
* Zeile 30: Control für das Benutzernamefeld definieren. Mit __Validators.required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeile 31: Ein Control erwartet als zweiten Parameter eine Validierungsfunktion. Wenn wir mehrere Funktionen gleichzeitig nutzen möchten, müssen wir die compose-Funktion nutzen
* Zeile 32: Hier definieren wir das Passwortfeld als Pflichtfeld
* Zeile 33: Das Feld muss mindestens zehn Zeichen beinhalten, damit es gültig ist

### Lösung 2

Diese Lösung ist äquivalent zur Lösung 2 im Rezept "TDF: Gültigkeit eines Formulars überprüfen".
Auch hier überprüfen wir die Gültigkeit des Formulars in der Komponenten-Klasse statt im Template.
Das Template bleibt das gleiche wie im Rezept "MDF: Formular mit dem FormBuilder implementieren".

{title="app.component.ts", lang=js}
```
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

* Zeile 17: Hier überprüfen wir die Gültigkeit des Formulars, nach dem ein Submit-Event ausgelöst wurden ist durch z. B. ein Klick auf den Submit-Button

### Code

Code auf Github für die [erste Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/06-Form_Validation_with_FormBuilder/Solution-01)

Live Demo der ersten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/06-Form_Validation_with_FormBuilder/Solution-01/index.html)

Code auf Github für die [zweite Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/06-Form_Validation_with_FormBuilder/Solution-02)

Live Demo der zweiten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/06-Form_Validation_with_FormBuilder/index.html)

### Weitere Ressourcen

* Offizielle [Validators](https://angular.io/docs/ts/latest/api/common/Validators-class.html)-Dokumentation auf der Angular 2 Webseite

