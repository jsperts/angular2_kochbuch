## MDF: Fehlermeldungen für einzelne Formular-Felder anzeigen {#c04-input-field-errors-formbuilder}

### Problem

Ich möchte für jedes ungültige Eingabefeld eine Fehlermeldung anzeigen. Je nachdem weshalb das Eingabefeld ungültig ist, soll die entsprechende Fehlermeldung angezeigt werden.

### Zutaten

* [MDF: Gültigkeit eines Formulars überprüfen](#c04-formbuilder-validation)
* [Teile der View konditional Anzeigen mit NgIf](#c03-ngif)
* Elvis-Operator (?.)

### Lösung

Wir werden die Gültigkeit des jeweiligen Eingabefeldes überprüfen, indem wir im Template über das Formular auf das jeweilige Control zugreifen.

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
      <div *ngIf="myForm.controls.username.invalid">
        This field is required!
      </div>
      <label>Password
        <input type="password" formControlName="password"/>
      </label>
      <div *ngIf="myForm.controls.password.errors?.required">
        This field is required!
      </div>
      <div *ngIf="myForm.controls.password.errors?.minlength">
        This field must have at least 10 characters
      </div>
      <button type="submit" [disabled]="myForm.invalid">Submit</button>
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

* Zeilen 15-17: Nutzung von __ngIf__ mit Bedingung __myForm.controls.username.invalid__. Damit greifen wir auf die invalid-Eigenschaft des Controls zu. Diese Eigenschaft ist __true__, wenn das Eingabefeld ungültig ist
* Zeilen 21-23: Nutzung von __ngIf__ mit Bedingung __myForm.controls.password.errors?.required__. Die Bedingung ist wahr, wenn das Eingabefeld leer ist
* Zeilen 24-26: Nutzung von __ngIf__ mit Bedingung __myForm.controls.password.errors?.minlength__. Die Bedingung ist wahr, wenn das Eingabefeld nicht leer ist und weniger als zehn Zeichen beinhaltet

### Diskussion

Natürlich setzt Angular auch für Model-Driven Formulare entsprechende CSS-Klassen, die den Zustand eines Eingabefeldes kennzeichnen.
Welche CSS-Klassen uns zur Verfügung stehen, steht im Diskussionsteil des Rezeptes "[TDF: Formular-Felder und CSS-Klassen](#c04-form-css-classes)".

Bei der Erklärung der Lösung haben wir einige Details weggelassen. Nun möchten wir auch diese Details erklären. Wir fangen mit dem Elvis-Operator (?.) an.

#### Elvis-Operator

Der Elvis-Operator kann uns helfen, wenn wir im Template mit Objekten arbeiten, die __null__ oder __undefined__ sein könnten.
Wenn ein Eingabefeld gültig ist, ist das errors-Objekt des Controls __null__.
Darum haben wir Elvis-Operator bei der Überprüfung der Gültigkeit des Passwort-Felds verwendet.

#### controls-Objekt

Das controls-Objekt der ngForm-Instanz beinhaltet alle Controls des Formulars. Wir können die einzelne Controls über ihren Namen (name-Attribut) referenzieren.

#### errors-Objekt

Das errors-Objekt beinhaltet die Gründe weshalb ein Eingabefeld ungültig ist.
Wenn z. B. das required-Attribut eines Eingabefeldes definiert und das Feld leer ist, beinhaltet das errors-Objekt die Eigenschaft "required" mit dem Wert __true__.
Der Name der Eigenschaft, in unserem Beispiel "required", zeigt an, welche Validierung fehlschlägt.
Dieser Fehlschlag ist der Grund für die Ungültigkeit des Eingabefeldes.
Als zweite Bedingung für das Passwort-Feld haben wir "minlength" benutzt.
Die Wahrheit ist, dass "minlength" keine boolesche Eigenschaft ist, sondern ein Objekt.
Wenn das Eingabefeld genügend Zeichen beinhaltet, ist die minlength-Eigenschaft des errors-Objektes __undefined__.
Wenn das Eingabefeld nicht genügend Zeichen beinhaltet, ist der Wert der Eigenschaft ein Objekt mit den Eigenschaften "actualLength" und "requiredLength".
Die erste Eigenschaft zeigt an, wie viele Zeichen im Eingabefeld enthalten sind.
Die zweite Eigenschaft zeigt an, wie viele Zeichen wir mindestens brauchen bevor das Eingabefeld gültig wird.
In der Lösung, die wir oben gezeigt haben, wäre der Wert für die requiredLength-Eigenschaft __10__.

### Code

Code auf Github: [04-Form\_Recipes/07-Form\_Show\_Error\_for\_Field\_with\_FormBuilder](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/07-Form_Show_Error_for_Field_with_FormBuilder)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/07-Form_Show_Error_for_Field_with_FormBuilder/index.html)

