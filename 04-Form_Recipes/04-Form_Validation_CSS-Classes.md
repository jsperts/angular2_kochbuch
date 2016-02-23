## Formular-Felder und CSS-Klassen {#c04-form-css-classes}

### Problem

Ich möchte ein ungültiges Formular-Feld farblich hervorheben.

### Zutaten
* [Ein Formular](#c04-simple-form)
* Eingabefeld mit Validierungs-Eigenschaften
* Anpassungen an den Eingabefeldern im Formular
* Styles für die CSS-Klassen die von Angular gesetzt werden

### Lösung

{title="Template as app.component.ts plus Anpassungen", lang=html}
```
<style>
  .ng-invalid {
    border-color: red;
  }

  .ng-valid {
    border-color: green;
  }
</style>
<form (ngSubmit)="onSubmit()" novalidate>
  <label>Username</label>
  <input type="text" [(ngModel)]="user.username" required/>
  <label>Password</label>
  <input type="password" [(ngModel)]="user.password" required minlength="10"/>
  <button type="submit">Submit</button>
</form>
```

Erklärung:

* Zeile 1-9: CSS-Styles für die __ng-invalid__ und __ng-valid__ CSS-Klassen
* Zeile 10-16: Unser Formular
  * Zeile 10: Da nutzen wir das validate-Attribut, damit der Browser keine Fehlermeldungen für ungültige Eingabefelder anzeigt. Dieses Attribut ist nicht Angular spezifisch
  * Zeile 11: Eingabefeld für den Benutzernamen. Durch das required-Attribut wird das Eingabefeld zu einem Pflichtfeld
  * Zeile 13: Eingabefeld für das Passwort. Durch das required-Attribut wird das Eingabefeld zu einem Pflichtfeld. Da wir hier noch das minlength-Attribut gesetzt haben, muss das Passwort mindestens 10 Zeichen lang sein

### Diskussion

Beim Laden der Anwendung sieht Angular die Attribute __required__ und __minlength__ und setzt die CSS-Klasse __ng-invalid__, da die Eingabefelder leer und somit ungültig sind. Sobald wir mindestens einen Buchstaben in das Benutzername-Eingabefeld schreiben, wird das Eingabefeld gültig und Angular entfernt die ng-invalid-Klasse und setzt stattdesen die ng-valid-Klasse. Beim Eingabefeld für das Passwort wird die ng-valid-Klasse erst dann gesetzt, wenn wir mindestens 10 Zeichen eingeben.

Von Haus aus unterstützt Angular derzeit drei Validierungs-Attribute:
* required
* minlength
* maxlength

Vermutlich wird es mit der Zeit noch mehr eingebaute Validierungs-Attribute bzw. Validierungs-Typen wie z. B. "email" und "url" geben. Siehe hierzu Github-Issues [#2962](https://github.com/angular/angular/issues/2962) und [#2961](https://github.com/angular/angular/issues/2961).

Außer __ng-valid__ und __ng-invalid__ werden von Angular noch vier weitere CSS-Klassen gesetzt. Die sind: __ng-touched__, __ng-untouched__, __ng-dirty__ und __ng-pristine__. Die ng-touched-Klasse wird gesetzt, wenn der Nutzer einmal in einem Eingabefeld drin war und danach raus gesprungen ist. Beim Laden der Anwendung ist die ng-untouched-Klasse gesetzt. Die ng-dirty-Klasse wird gesetzt, sobald der Nutzer in ein Eingabefeld etwas geschrieben hat. Beim Laden der Anwendung ist die ng-pristine-Klasse gesetzt. Wir haben also drei CSS-Klassen Paare die Informationen über den Zustand eines Eingabefelds geben.

### Code

Code auf Github: [04-Form\_Recipes/02-Form\_Validation\_CSS-Classes](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/02-Form_Validation_CSS-Classes)

