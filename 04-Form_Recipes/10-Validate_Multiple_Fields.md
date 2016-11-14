## MDF: Abhängige Eingabefelder validieren

### Problem

Ich möchte sicherstellen, dass zwei voneinander abhängige Eingabefelder den gleichen Wert beinhalten. Z. B. ein Passwort und ein Passwort wiederholen Feld.

### Zutaten

* [MDF: Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* [Teile der View konditional Anzeigen mit NgIf](#c03-ngif)
* Anpassungen an der app.component.ts-Datei
* Eine Validierungsfunktion, die überprüft, ob zwei Felder den gleichen Wert beinhalten

### Lösung

Wie werden hier eine Validierungsfunktion definieren, die zwei Eingabefelder gleichzeitig validieren kann.
Wir werden auch einen Fehler anzeigen, wenn nicht beide Eingabefelder den gleichen Wert haben.

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
      <label formGroupName="passwords">Password
        <input type="password" formControlName="password"/>
      </label>
      <label formGroupName="passwords">Repeat Password
        <input type="password" formControlName="passwordRepeat"/>
      </label>
      <div *ngIf="myForm.controls.passwords.hasError('passwordsNotEqual')">
        Passwords are not equal
      </div>
      <button type="submit">Submit</button>
    </form>
  `
})
export class AppComponent {
  myForm: FormGroup;

  constructor(builder: FormBuilder) {
    this.myForm = builder.group({
      username: builder.control('', Validators.required),
      passwords: builder.group({
        password: builder.control('', Validators.compose([
          Validators.required,
          Validators.minLength(10)
        ])),
        passwordRepeat: builder.control('')
      }, {
        validator(group: FormGroup) {
          if (group.value.password !== group.value.passwordRepeat) {
            return {
              passwordsNotEqual: true
            };
          }
          return null;
        }
      })
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

* Zeilen 15 und 18: Hier sagen wir Angular, dass die zwei Password-Eingabefelder zu der "FormGroup" mit Name "passwords" gehören
* Zeilen 21-23: Nutzung von __ngIf__ mit der Bedingung __myForm.controls.passwords.hasError('passwordsNotEqual')__. Damit fragen wir die FormGroup, ob sie einen Fehler namens "passwordsNotEqual" hat. Wenn die zwei Eingabefelder der FormGroup nicht den gleichen Wert haben, wird die Bedingung __true__ sein
* Zeilen 34-49: Definition einer "FormGroup" namens "passwords"
  * Zeilen 35-39: Die Controls der FormGroup
  * Zeilen 41-48: Unsere Validierungsfunktion

### Diskussion

Ein Formular in Angular ist eine "FormGroup" und kann nebst Controls auch weiter FormGroups beinhalten, die wiederum Controls und weitere FormGroups beinhalten können.
In unserem Beispiel haben wir eine "FormGroup" namens "passwords" definiert, die zwei Controls hat.
Das password- und das passwordRepeat-Control.
Diese "FormGroup" ist nur dann gültig (valid-Eigenschaft is __true__), wenn die jeweilige Controls gültig sind und, wenn die Validierungsfunktionen der Gruppe __null__ zurückliefern.
Das ist auch der Grund weshalb wir, __myForm.controls.passwords.hasError('passwordsNotEqual')__ und nicht einfach __myForm.controls.passwords.invalid__ als Bedingung für die NgIf-Direktive benutzt haben.
Alternativ hätten wir auch das errors-Objekt (__myForm.controls.passwords.errors?.passwordsNotEqual__) nutzen können, wie wir es in anderen Rezepten auch getan haben.

Der zweite Parameter der group-Methode (Zeilen 40-49) bekommt ein Objekt mit zwei optionale Eigenschaft.
Die eine Eigenschaft hat den Namen "validator", diese ist die Eigenschaft, die wir auch hier nutzen.
Die andere Eigenschaft hat den Namen "asyncValidator" und wird benutzt, wenn wir für eine FormGroup asynchrone Validierungsfunktionen definieren möchten.
Wichtig ist, dass beide Eigenschaften eine Funktion als Wert haben.
Falls wir mehrere synchrone bzw. asynchrone Validierungsfunktionen brauchen, müssen wir die compose- bzw. die composeAsync-Methode nutzen wie im Rezept "[MDF: Eigene Validatoren definieren](#c04-custom-validation)" gezeigt wird.
Da wird nur das Beispiel mit der compose-Methode gezeigt.
Die composeAsync-Methode funktioniert analog.

In den meisten MDF-Rezepten dieses Buches, war das value-Objekt des Formulars flach.
Es hatte eine Eigenschaft für jedes Control.
Auch in diesem Rezept hat das value-Objekt eine Eigenschaft für jedes Control allerdings sind die Werte für "password" und "passwordRepeat" verschachtelt.
Diese befinden sich in einem Objekt namens "passwords".
Das heißt, dass das value-Objekt die Struktur des Formulars hat, wie wir diese über den FormBuilder definiert haben.
Je nachdem was der Server von uns erwartet, müssen wir Werte, die sich in Untergruppen befinden herausziehen und diese auf der höchste Ebene definieren.
Das value-Objekt sieht in diesem Rezept so aus:

```
{
  username: "Wert im Eingabefeld"
  passwords: {
    password: "Wert im Eingabefeld",
    passwordRepeat: "Wert im Eingabefeld"
  }
}
```

### Code

Code auf Github: [04-Form\_Recipes/10-Validate\_Multiple\_Fields](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/10-Validate_Multiple_Fields)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/10-Validate_Multiple_Fields/index.html)

