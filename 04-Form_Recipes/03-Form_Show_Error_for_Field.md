## Fehlermeldungen für einzelne Formular-Felder anzeigen {#c04-input-field-errors}

### Problem

Ich möchte für jedes ungültige Eingabefeld eine Fehlermeldung anzeigen. Je nachdem weshalb das Eingabefeld ungültig ist, soll die entsprechende Fehlermeldung angezeigt werden.

### Zutaten
* [Gültigkeit eines Formulars überprüfen](#c04-form-validation)
* [Teile der View konditional Anzeigen mit NgIf](#c03-ngif)
* Elvis-Operator (?.)
* Lokale (Referenz-) Variable, die die Instanz der NgModel-Direktiven des jeweiligen Eingabefelds referenziert (nur Lösung 2)

### Lösung 1

In der ersten Lösung werden wir die Gültigkeit des jeweiligen Eingabefeldes überprüfen, indem wir auf über die lokale (Referenz-) Variable des Formulars auf das Control zugreifen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username
        <input type="text"
          name="username"
          [(ngModel)]="user.username"
          required />
      </label>
      <div *ngIf="!form.controls.username?.valid">
        This field is required!
      </div>
      <label>Password
        <input type="password"
          name="password"
          [(ngModel)]="user.password"
          required minlength="10" />
      </label>
      <div *ngIf="form.controls.password?.errors?.required">
        This field is required!
      </div>
      <div *ngIf="form.controls.password?.errors?.minlength">
        This field must have at least 10 characters
      </div>
      <button type="submit" [disabled]="!form.valid">Submit</button>
    </form>
  `
})

...
```

__Erklärung__:

* Zeilen 13-15: Nutzung von __ngIf__ mit Bedingung __!form.controls.username?.valid__. Damit greifen wir auf die valid-Eigenschaft des Controls zu. Diese Eigenschaft ist __true__, wenn das Eingabefeld gültig ist
* Zeilen 22-24: Nutzung von __ngIf__ mit Bedingung __form.controls.password?.errors?.required__. Die Bedingung ist wahr, wenn das Eingabefeld leer ist
* Zeilen 25-27: Nutzung von __ngIf__ mit Bedingung __form.controls.password?.errors?.minlength__. Die Bedingung ist wahr, wenn das Eingabefeld nicht leer ist und weniger als zehn Zeichen beinhaltet

### Lösung 2

Hier werden wir lokale Variablen für jedes Eingabefeld (Control) definieren.
Über die lokale Variable werden wir Zugriff auf die Gültigkeit des Eingabefelds bekommen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username
        <input type="text"
          name="username"
          [(ngModel)]="user.username"
          required
          #username="ngModel" />
      </label>
      <div *ngIf="!username.valid">
        This field is required!
      </div>
      <label>Password
        <input type="password"
          name="password"
          [(ngModel)]="user.password"
          required minlength="10"
          #password="ngModel" />
      </label>
      <div *ngIf="password?.errors?.required">
        This field is required!
      </div>
      <div *ngIf="password.errors?.minlength">
        This field must have at least 10 characters
      </div>
      <button type="submit" [disabled]="!form.valid">Submit</button>
    </form>
  `
})

...
```

__Erklärung__:

* Zeile 12: Mit __#username=`"`ngModel`"`__ definieren wir eine lokale Variable namens "username". Die Variable ist eine Referenz auf die Instanz der NgModel-Direktiven des Eingabefelds
* Zeilen 14-16: Nutzung von __ngIf__ mit Bedingung __!username?.valid__. Damit greifen wir auf die valid-Eigenschaft des Controls zu. Diese Eigenschaft ist __true__, wenn das Eingabefeld gültig ist
* Zeile 22: Mit __#password=`"`ngModel`"`__ definieren wir eine lokale Variable namens "password". Die Variable ist eine Referenz auf die Instanz der NgModel-Direktiven des Eingabefelds
* Zeilen 24-26: Nutzung von __ngIf__ mit Bedingung __password.errors?.required__. Die Bedingung ist wahr, wenn das Eingabefeld leer ist
* Zeilen 27-29: Nutzung von __ngIf__ mit Bedingung __password.errors?.minlength__. Die Bedingung ist wahr, wenn das Eingabefeld nicht leer ist und weniger als zehn Zeichen beinhaltet

### Diskussion

Bei der Erklärung der Lösung haben wir einige Details weggelassen. Nun möchten wir auch diese Details erklären. Wir fangen mit dem Elvis-Operator (?.) an.

#### Elvis-Operator

Den Elvis-Operator haben wir in beiden Lösungen verwendet.
Dieser kann uns helfen, wenn wir im Template mit Objekten arbeiten, die __null__ oder __undefined__ sein könnten.
Da das controls-Objekt des Formulars am Anfang leer ist (__undefined__), nutzen wir den Elvis-Operator, um Exceptions zu vermeiden.
Wenn ein Eingabefeld gültig ist, ist das errors-Objekt des Controls __null__.
Darum haben wir in beiden Lösungen den Elvis-Operator bei der Überprüfung der Gültigkeit des Passwort-Felds verwendet.

#### controls-Objekt

Das controls-Objekt der ngForm-Instanz beinhaltet alle Controls des Formulars. Wir können die einzelne Controls über ihren Namen (name-Attribut) referenzieren.

#### errors-Objekt

In beiden Lösungen haben wir das errors-Objekt benutzt, um Bedingungen für die NgIf-Direktiven zu definieren.
Dieses beinhaltet die Gründe weshalb ein Eingabefeld ungültig ist.
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

#### Lösung 2

Genau so wie die NgForm-Direktive hat auch die NgModel-Direktive eine exportAs-Eigenschaft mit dem Wert __`'`ngModel`'`__.
Somit können wir im Template Zugriff auf die Instanz der NgModel-Direktive und ihre Eigenschaften wie z. B. "valid" und "errors" erhalten.

### Code

Code auf Github für die erste Lösung: [04-Form\_Recipes/03-Form\_Show\_Error\_for\_Field/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-01)

Live Demo der ersten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-01/index.html)

Code auf Github für die zweite Lösung: [04-Form\_Recipes/03-Form\_Show\_Error\_for\_Field/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-02)

Live Demo der zweiten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-02/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen und zur exportAs-Eigenschaft gibt es in [Appendix A: Template-Syntax](#appendix-a)

