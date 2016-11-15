## TDF: Formular-Felder und CSS-Klassen {#c04-form-css-classes}

### Problem

Ich möchte ein ungültiges Formular-Feld farblich hervorheben.

### Zutaten
* [TDF: Gültigkeit eines Formulars überprüfen](#c04-form-validation)
* Styles für die CSS-Klassen, die von Angular gesetzt werden
  * Siehe auch [Das Template der Komponente vom CSS trennen](#c07-styles)

### Lösung

Jedes Eingabefeld bekommt von Angular gewisse CSS-Klassen gesetzt.
Um diese zu nutzen, müssen wir nur entsprechende Styles definieren.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  styles: [
    '.ng-invalid { border-color: red; }',
    '.ng-valid { border-color: green; }'
  ],
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username
        <input type="text"
          name="username"
          [(ngModel)]="user.username"
          required />
      </label>
      <label>Password
        <input type="password"
          name="password"
          [(ngModel)]="user.password"
          required minlength="10" />
      </label>
      <button type="submit" [disabled]="form.invalid">Submit</button>
    </form>`
})

...
```

__Erklärung__:

* Zeilen 6-7: CSS-Styles für die "ng-invalid" und "ng-valid" CSS-Klassen

### Diskussion

Beim Laden der Anwendung sieht Angular die Attribute "required" und "minlength" und setzt dann die CSS-Klasse "ng-invalid", da die Eingabefelder leer und somit ungültig sind.
Sobald wir mindestens einen Buchstaben in das Benutzername-Eingabefeld eingeben, wird das Eingabefeld gültig und Angular entfernt die ng-invalid-Klasse und setzt stattdessen die ng-valid-Klasse.
Beim Eingabefeld für das Passwort wird die ng-valid-Klasse erst dann gesetzt, wenn wir mindestens zehn Zeichen eingeben.

Außer "ng-valid" und "ng-invalid" werden von Angular noch vier weitere CSS-Klassen gesetzt.
Diese sind:

* ng-touched/ng-untouched und
* ng-dirty/ng-pristine.

Die ng-touched-Klasse wird gesetzt, wenn der Nutzer einmal in einem Eingabefeld drin war und danach raus gesprungen ist (focus dann blur).
Beim Laden der Anwendung ist die ng-untouched-Klasse gesetzt.
Die ng-dirty-Klasse wird gesetzt, sobald der Nutzer in ein Eingabefeld etwas geschrieben hat.
Beim Laden der Anwendung ist die ng-pristine-Klasse gesetzt.
Wir haben also drei CSS-Klassen Paare die Informationen über den Zustand eines Eingabefelds geben.
Für das Formular (form-Tag) werden die gleiche CSS-Klassen gesetzt.
Die ng-dirty-Klasse wird gesetzt sobald mindestens ein Eingabefeld die ng-dirty-Klasse bekommt.
Die ng-touched-Klasse wird gesetzt sobald mindestens ein Eingabefeld die ng-touched-Klasse bekommt.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Form_Validation_CSS-Classes)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/04-Form_Validation_CSS-Classes/index.html)

