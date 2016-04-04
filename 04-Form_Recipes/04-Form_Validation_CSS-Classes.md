## Formular-Felder und CSS-Klassen {#c04-form-css-classes}

### Problem

Ich möchte ein ungültiges Formular-Feld farblich hervorheben.

### Zutaten
* [Gültigkeit eines Formulars überprüfen](#c04-form-validation)
* Styles für die CSS-Klassen, die von Angular gesetzt werden

### Lösung

Jedes Eingabefeld bekommt von Angular gewisse CSS-Klassen gesetzt.
Um diese zu nutzen, müssen wir nur entsprechende Styles definieren.

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app',
  template: `
    <style>
      .ng-invalid {
        border-color: red;
      }

      .ng-valid {
        border-color: green;
      }
    </style>
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username</label>
      <input type="text" [(ngModel)]="user.username" required ngControl="username"/>
      <label>Password</label>
      <input type="password" [(ngModel)]="user.password" required minlength="10" ngControl="password"/>
      <button type="submit" [disabled]="!form.valid">Submit</button>
    </form>
  `
})

...
```

__Erklärung__:

* Zeilen 6-14: CSS-Styles für die "ng-invalid" und "ng-valid" CSS-Klassen

### Diskussion

Beim Laden der Anwendung sieht Angular die Attribute "required" und "minlength" und setzt die CSS-Klasse "ng-invalid", da die Eingabefelder leer und somit ungültig sind.
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

### Code

Code auf Github: [04-Form\_Recipes/04-Form\_Validation\_CSS-Classes](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Form_Validation_CSS-Classes)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/04-Form_Validation_CSS-Classes/index.html)

