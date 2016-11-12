## MDF: Abhängige Eingabefelder validieren

### Problem

Ich möchte sicherstellen, dass zwei von einander abhängige Eingabefelder den gleichen Wert beinhalten. Z. B. ein Passwort und ein Passwort wiederholen Feld.

### Zutaten

TODO: fix zutaten
TODO: probably don't base off of this recipe
* [MDF: Eigene Validatoren definieren](#c04-custom-validation)
* Anpassungen an der Komponente aus "MDF: Eigene Validatoren definieren"

### Lösung

Wie werden hier eine neue Validierungsfunktion definieren, die zwei Eingabefelder gleichzeitig validieren kann.
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
          console.log(group);
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

* Zeilen 15 und 18: Hier sagen wir Angular, dass die zwei Password-Eingabefelder zu der FormGroup mit name "passwords" gehören
* Zeilen 21-23: Nutzung von __ngIf__ mit der Bedingung __myForm.controls.passwords.hasError('passwordsNotEqual')__. Damit fragen wir die FormGroup, ob sie einen Fehler namens "passwordsNotEqual" hat. Wenn die zwei Eingabefelder der FormGroup nicht den gleichen Wert haben, wird die Bedingung __true__ sein
* Zeilen 34-50: Definition einer FormGroup namens "passwords"
  * Zeilen 35-39: Die Controls der FormGroup
  * Zeilen 41-48: Unsere Validierungsfunktion

### Diskussion

asyncValidator
compose/composeAsync
can't just use invalid for the group since an invalid control in the group makes the group invalid

### Code

