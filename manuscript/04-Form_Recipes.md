# Rezepte für Formulare

In diesem Kapitel geht es um Formularen und was wir damit machen können.
Wir fangen mit einem einfachen Formular an und werden später komplexere Formulare mit Validierung implementieren.
Wir werden dann als Erstes mit der eingebaute Validierung arbeiten und später werden wir auch eigenen Validatoren arbeiten.

## Ein einfaches Formular implementieren {#c04-simple-form}

### Problem

Ich möchte ein einfaches Formular implementieren, um Daten vom Benutzer zu bekommen.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* NgModel-Direktive
* NgSubmit-Event (Gehört zu der NgForm-Direktive)

### Lösung

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';

@Component({
  selector: 'my-component'
})
@View({
  template: `
    <form (ngSubmit)="onSubmit()">
      <label>Username</label>
      <input type="text" [(ngModel)]="user.username">
      <label>Password</label>
      <input type="password" [(ngModel)]="user.password">
      <button type="submit">Submit</button>
    </form>
  `
})
class MyApp {
  user = {
    username: '',
    password: ''
  };

  constructor() {}
  onSubmit() {
    console.log(this.user);
  }
}
```

Erklärung:

* Zeile 8-14: Unser Formular
  * Zeile 8: Wir binden das ngSubmit-Event des Formulars an unsere onSubmit-Methode
  * Zeile 10: Eingabefeld für den Benutzernamen. Hier nutzen wir die NgModel-Direktive, um die View mit den Daten der Komponente zu verbinden. Konkreter, reden wir hier von einer beidseitige-Bindung zwischen den Wert des Eingabefeldes und der username-Eigenschaft des user-Objekts (siehe Zeile 18-21)
  * Zeile 12: Ähnlich wie Zeile 10 aber für die password-Eigenschaft
* Zeile 18-21: Ein Objekt wo die Daten, die der Nutzer in das Formular eingibt gespeichert werden. Die leere Strings für die Eigenschaften "username" und "password", sind die Default-Werte für unsere Eingabefelder
* Zeile 24-26: Methode die Aufgerufen wird wenn der Nutzer ein submit-Event auslöst (siehe auch Zeile 8). Wenn der Nutzer auf den Submit-Button klickt, wird ein submit-Event ausgelöst.

### Diskussion

Ein Formular hat von sich aus kein ngSubmit-Event, sondern ein submit-Event.
Das ngSubmit-Event wird von der NgForm-Direktive bereitgestellt und diese Direktive wird von Angular automatisch verwendet, wenn wir in unser HTML ein form-Tag benutzen.
Im Grunde genommen bindet die NgForm-Direktive, das submit-Event des Formulars und leitet es an das ngSubmit-Event weiter.
Wir hätten in unserem Code auch direkt das submit-Event nutzen können.

In Zeile 10 und 12 hätten wir, statt eine beidseitige-Bindung, eine Eigenschafts- und eine Event-Bindung nutzten können.
Da die Nutzung der beidseitige-Bindung einfacher ist, werden wir sie auch in weiteren Formular-Rezepten nutzen.

### Code

Code auf Github: [04-Form\_Recipes/01-Simple\_Form](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/01-Simple_Form)

### Weitere Ressourcen

* Offizielle [NgModel](https://angular.io/docs/ts/latest/api/common/NgModel-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgForm](https://angular.io/docs/ts/latest/api/common/NgForm-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Event-, Eigenschafts und beidseitige-Bindung gibt es im [Appendix A: Template-Syntax](#appendix-a)

## Formular-Felder und CSS-Klassen

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

