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

## Fehlermeldungen für einzelne Formular-Felder anzeigen

### Problem

Ich möchte für jedes ungültige Eingabefeld eine Fehlermeldung anzeigen. Je nachdem weshalb das Eingabefeld ungültig ist, soll auch die dazugehörige Fehlermeldung angezeigt werden.

### Zutaten
* Ein Formular mit Validierungs-Attribute wie z. B. in [Formular-Felder und CSS-Klassen](#c04-form-css-classes)
* [Teile der View konditional Anzeigen mit NgIf](#c03-ngif)
* Elvis-Operator (?.)
* Lokale (Template) Variable die das NgModel für das jeweilige Eingabefeld referenziert

### Lösung

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

View({
  template: `
    <form (ngSubmit)="onSubmit()" novalidate>
      <div>
        <label>Username</label>
        <input type="text" [(ngModel)]="user.username" required #username="ngForm"/>
        <div *ngIf="!username.valid">
          This field is required!
        </div>
      </div>
      <div>
        <label>Password</label>
        <input type="password"  [(ngModel)]="user.password" required minlength="10" #password="ngForm"/>
        <div *ngIf="password.errors?.required">
          This field is required!
        </div>
        <div *ngIf="password.errors?.minlength">
          This field must have at least 10 characters
        </div>
      </div>
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

...
```

Erklärung:

Wir haben das Formular aus [Formular-Felder und CSS-Klassen](#c04-form-css-classes) genommen und es so angepasst, dass wir Zugriff auf das NgModel für jedes Eingabefeld bekommen und Fehlermeldung anzeigen können.

* Zeile 8: Mit __#username="ngForm"__ definieren wir eine lokale Variable namens "username". Die Variable ist eine Referenz auf das NgModel des Eingabefeldes
* Zeile 9-11: Nutzung von __ngIf__ mit Kondition __!username.valid__. Die valid-Eigenschaft wird von der NgModel-Direktive bereitgestellt und ist __true__ wenn das Eingabefeld gültig ist
* Zeile 15: Mit __#password="ngForm"__ definieren wir eine lokale Variable namens "password". Die Variable ist eine Referenz auf das NgModel des Eingabefeldes
* Zeile 16-18: Nutzung von __ngIf__ mit Kondition __password.errors?.required__. Die Kondition ist wahr, wenn das Eingabefeld leer ist
* Zeile 19-21: Nutzung von __ngIf__ mit Kondition __password.errors?.minlength__. Die Kondition ist wahr, wenn das Eingabefeld nicht leer ist und noch keine 10 Zeichen beinhaltet (wir haben definiert, dass __minlength=10__ sein muss)

### Diskussion

Bei der Erklärung der Lösung haben wir einige Details weggelassen. Nun möchten wir auch diese Details erklären. Als Erstes schauen wir uns __#username="ngForm"__ an und dann werden wir uns detailierter mit dem error-Objekt beschäftigen.

Direktiven haben eine optionale Eigenschaft namens "exportAs" vom Typ "string". Wenn diese Eigenschaft definiert ist, können wir in unserem Template die Direktiveninstanz referenzieren. Um Zugriff auf die Referenz zu bekommen, definieren wir eine lokale (Template) Variable. Die linke Seite (vor dem Gleichheitszeichen) der Definition ist der Name der lokalen Variable und die rechte Seite (nach dem Gleichheitszeichen) der Wert der exportAs-Eigenschaft. Im Falle von NgModel ist der Wert der exportAs-Eigenschaft __ngForm__ und mit __#username="ngForm"__ definieren wir die lokale Variable "username" und die Referenziert das NgModel des Eingabefeldes.

Wir haben das error-Objekt benutzt, um Konditionen für die NgIf-Direktive zu definieren.
Dieses beinhaltet die Gründe weshalb ein Eingabefeld ungültig ist.
Wenn z. B. das required-Attribut eines Eingabefeldes definiert ist aber das Feld leer ist, beinhaltet das error-Objekt die Eigenschaft "required" mit Wert __true__.
Der Namen der Eigenschaft, in unserem Beispiel "required" zeigt an welche Validierung fehlschlägt.
Dieser Fehlschlag ist der Grund für die Ungültigkeit des Eingabefeldes.
Es war vermutlich zu erwarten, dass wir einfach __password.errors.required__ benutzt hätten statt __password.errors?.required__.
In der zweiten Variante nutzen wir den sogenannten Elvis-Operator (?.).
Dieser kann uns helfen, wenn wir im Template mit Objekten arbeiten die __null__ oder __undefined__ sein könnten.
Wenn das Eingabefeld gültig ist, ist das error-Objekt __null__ und wir brauchen den Elvis-Operator, um Exceptions zu vermeiden.

Als zweite NgIf-Kondition für das Passwort-Feld, haben wir "minlength" benutzt.
Die Wahrheit ist, dass "minlength" keine boolesche Eigenschaft ist, sondern ein Objekt.
Wenn das Eingabefeld genügend Zeichen beinhaltet, ist die minlength-Eigenschaft des error-Objektes __undefined__.
Wenn das Eingabefeld nicht genügend Zeichen beinhaltet, ist der Wert der Eigenschaft ein Objekt mit den Eigenschaften "actualLength" und "requiredLength".
Die erste Eigenschaft zeigt an wie viele Zeichen im Eingabefeld enthalten sind.
Die zweite Eigenschaft zeigt an wie viele Zeichen wir mindestens brauchen bevor das Eingabefeld gültig wird.
In der Lösung die wir oben gezeigt haben wäre der Wert für die requiredLength-Eigenschaft __10__.

### Code

Code auf Github: [04-Form\_Recipes/03-Form\_Show\_Error\_for\_Field](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/03-Form_Show_Error_for_Field)

