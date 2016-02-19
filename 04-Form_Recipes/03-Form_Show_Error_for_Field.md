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

