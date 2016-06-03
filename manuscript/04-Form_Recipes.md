# Rezepte für Formulare

Angular bietet uns mehrere Möglichkeiten, um Formulare zu implementieren.
Grob können wir in Angular 2 zwischen zwei Arten von Formularen unterscheiden: "Template Driven Forms" und "Model Driven Forms".

Bei den "Template Driven Forms" ist ein Großteil der Logik wie z. B. die Validierung im Template.
Auch die Synchronisation zwischen den Daten, die der Nutzer sieht und den Daten in der Klasse der Komponente (dem Modell) wird im Template definiert.
So werden Formulare in Angular 1.x implementiert, wo wir direkt im Template z. B. mit dem required-Attribut definieren, dass das Feld ein Pflichtfeld ist.
Da "Template Driven Forms" einfacher und in der Regel mit weniger Code zu implementieren sind, werden wir uns zuerst damit beschäftigen.
Allerdings haben diese Formulare auch Nachteile.
Da die Logik im Template ist, ist es schwer bis unmöglich diese in Unit-Tests zu testen.
Des Weiteren kann das Template bei Formulare mit komplexe Validierung sehr schnell unübersichtlich werden.

Bei den "Model Driven Forms" befindet sich die meiste Logik in der Klasse der Komponente.
Das Template hat nur die nötigen Informationen, um die Formular-Felder mit dem Formular-Modell zu verbinden.
Als Formular-Modell bezeichnen wir in diesem Zusammenhang die Implementierung des Formulars in der Klasse der Komponente.
"Model Driven Forms" benötigen in der Regel mehr Code.
Wir müssen das Formular im Template implementieren und dann die Logik in der Klasse.
Da die Logik sich in der Klasse befindet, können wir die Komponente gut Unit-testen.

Wir werden jetzt mit einem einfachen "Template Driven" Formular anfangen und werden nach und nach komplexere "Model Driven" Formulare implementieren.

## Ein einfaches Formular implementieren {#c04-simple-form}

### Problem

Ich möchte Daten vom Benutzer bekommen und dafür brauche ich ein einfaches Formular.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* NgModel-Direktive
* NgForm-Direktive mit dem ngSubmit-Event

### Lösung

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
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
export class DemoAppComponent {
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

__Erklärung__:

* Zeilen 6-12: Das Formular
  * Zeile 6: Wir binden das ngSubmit-Event des Formulars an unsere onSubmit-Methode
  * Zeile 8: Eingabefeld für den Benutzernamen. Hier nutzen wir die NgModel-Direktive, um die View mit den Daten (dem Modell) der Komponente zu verbinden. Konkreter, reden wir hier von einer beidseitige-Bindung zwischen den Wert des Eingabefeldes und der username-Eigenschaft des user-Objekts (siehe Zeilen 16-19)
  * Zeile 10: Ähnlich wie Zeile 8 aber für das Passwort-Feld
* Zeilen 16-19: Ein Objekt, wo die Daten, die der Nutzer in das Formular eingibt gespeichert werden. Die leere Strings für die Eigenschaften "username" und "password", sind die Default-Werte für die Eingabefelder
* Zeilen 22-24: Methode die Aufgerufen wird, wenn der Nutzer ein submit-Event auslöst z. B. durch ein Klick auf den Button (siehe auch Zeile 6)

### Diskussion

Jedes form-Tag bekommt automatisch eine Instanz der NgForm-Direktive.
Ein Formular hat von sich aus kein ngSubmit-Event, sondern ein submit-Event.
Da aber das Formular auch eine Instanz der NgForm-Direktive ist, haben wir Zugriff auf das ngSubmit-Event der Direktive.
Das ngSubmit-Event ist also eine [output-Eigenschaft](#gl-output-property) der NgForm-Direktive.
Im Grunde genommen bindet die NgForm-Direktive das submit-Event des Formulars und leitet es an das ngSubmit-Event weiter.
Wir hätten in unserem Code auch direkt das submit-Event nutzen können.

Wie schon erwähnt nutzen wir in den Zeilen 8 und 10 eine beidseitige-Bindung.
Wir hätten die beidseitige-Bindung auch in eine Eigenschafts- und eine Event-Bindung aufspalten können.
Wie das aussieht wird in "[Appendix A](#appendix-a)" gezeigt.
Da die Nutzung der beidseitige-Bindung einfacher ist, werden wir sie auch in weiteren Formular-Rezepten nutzen.

### Code

Code auf Github: [04-Form\_Recipes/01-Simple\_Form](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/01-Simple_Form)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/01-Simple_Form/index.html)

### Weitere Ressourcen

* Offizielle [NgModel](https://angular.io/docs/ts/latest/api/common/NgModel-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgForm](https://angular.io/docs/ts/latest/api/common/NgForm-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Event-, Eigenschafts- und beidseitige-Bindung gibt es im [Appendix A: Template-Syntax](#appendix-a)

## Gültigkeit eines Formulars überprüfen {#c04-form-validation}

### Problem

Ich möchte, dass ein Submit nur dann möglich ist, wenn das Formular gültig ist. Ein Formular ist nur dann gültig, wenn alle seine Eingabefelder gültig sind.

### Zutaten
* [Ein Formular](#c04-simple-form)
* NgControlName-Direktive von Angular
* Validierungs-Attribute
* Anpassungen an dem Formular
* Lokale (Template-) Variable, die das Formular referenziert

### Lösung 1

In dieser Lösung werden wir sehen wie wir die Gültigkeit des Formulars im Template überprüfen können.
Wir werden den Submit-Button deaktivieren, wenn das Formular ungültig ist.
Das wird das Submit-Event unterbinden, wenn nicht alle Formular-Felder gültig sind.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username</label>
      <input type="text" [(ngModel)]="user.username"
          ngControl="username"
          required />
      <label>Password</label>
      <input type="password" [(ngModel)]="user.password"
          ngControl="password"
          required
          minlength="10" />
      <button type="submit" [disabled]="!form.valid">Submit</button>
    </form>
  `
})

...
```

__Erklärung__:

* Zeile 6: Mit __#form=`"`ngForm`"`__ definieren wir eine lokale Variable namens "form". Die Variable ist eine Referenz auf die Instanz der NgForm-Direktive für unser Formular. Wir nutzen auch das novalidate-Attribut, damit der Browser keine Fehlermeldungen für ungültige Eingabefelder anzeigt. Dies ist kein Angular-spezifisches Attribut
* Zeilen 8-10: Eingabefeld für den Benutzernamen
  * Zeile 9: Mittels __ngControl=`"`username`"`__ definieren wir ein Control namens "username"
  * Zeile 10: Mittels __required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeilen 12-15: Eingabefeld für das Passwort
  * Zeile 13: Mittels __ngControl=`"`password`"`__ definieren wir ein Control namens "password"
  * Zeile 14: Mittels __required__ definieren wir das Eingabefeld als Pflichtfeld
  * Zeile 15: Mittels __minlength=`"`10`"`__ definieren wir, dass das Passwort mindestens zehn Zeichen lang sein muss
* Zeile 16: Hier binden wir die disabled-Eigenschaft an den Ausdruck __!form.valid__. Wenn das Formular ungültig ist, wird der Button deaktiviert sein

### Lösung 2

In dieser Lösung werden wir sehen wie wir die gültigkeit des Formulars in der Klasse überprüfen können.
Wir nutzen das Formular von der ersten Lösung mit zwei Änderungen:
Wir übergeben die lokale Variable "form" der onSubmit-Methode und wir nutzen nicht mehr die disabled-Eigenschaft des Buttons.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <form (ngSubmit)="onSubmit(form)" #form="ngForm" novalidate>
      <label>Username</label>
      <input type="text" [(ngModel)]="user.username" required ngControl="username"/>
      <label>Password</label>
      <input type="password" [(ngModel)]="user.password" required minlength="10" ngControl="password"/>
      <button type="submit">Submit</button>
    </form>
  `
})
export class DemoAppComponent {
  user = {
    username: '',
    password: ''
  };

  onSubmit(form) {
    if (form.valid) {
      console.log(this.user);
    }
  }
}
```

__Erklärung__:

* Zeile 6: Die lokale Variable "form" wird bei dem Aufruf der onSubmit-Methode übergeben
* Zeile 23: Die onSubmit-Methode hat jetzt ein Parameter namens "form"
* Zeile 24: Wir nutzen __form.valid__, um zu überprüfen, ob das Formular gültig ist

### Diskussion

Wie schon im Rezept "[Ein einfaches Formular implementieren](#c04-simple-form)" erwähnt, bekommt jedes form-Tag eine Instanz der NgForm-Direktive.
Diese Instanz beinhaltet verschiedene Informationen über das Formular wie z. B. dessen Gültigkeitsstatus, dessen Controls und die Werte der Eingabefelder des Formulars.
Die Direktive hat eine exportAs-Eigenschaft mit dem Wert __`'`ngForm`'`__ (ein String).
Den Wert der exportAs-Eigenschaft können wir im Template nutzen, um die Instanz der Direktive im Template zu referenzieren.

Ein Formular ist nur dann gültig, wenn alle seine Eingabefelder gültig sind.
Die NgForm-Direktive überprüft also die einzelnen Eingabefelder und setzt die valid-Eigenschaft auf __true__, wenn jedes Eingabefeld gültig ist.
Damit die NgForm-Direktive weiß welche Eingabefelder überprüft werden müssen, müssen die Eingabefelder als Controls definiert sein.
Wir definieren, dass ein Eingabefeld zu dem Formular gehört, indem man __ngControl=`"`controlName`"`__ nutzen.
Im Hintergrund wird von Angular eine neue Instanz der NgControlName-Direktive erzeugt.
Diese Instanz registriert sich dann mit dem gegebenen Namen als Control für das Formular.
Die NgForm-Direktive wird dann für unser Control eine Instanz der Control-Klasse erzeugen.
Wir können auch Eingabefelder haben die kein __ngControl__ nutzen.
Diese werden allerdings bei der Validierung des Formulars nicht mit einbezogen.

Von Haus aus unterstützt Angular derzeit vier Validierungs-Attribute:

* required,
* pattern,
* minlength und
* maxlength.

Vermutlich wird es mit der Zeit noch mehr eingebaute Validierungs-Attribute bzw. Validierungs-Typen wie z. B. "email" und "url" geben. Siehe hierzu Github-Issues [#2961](https://github.com/angular/angular/issues/2961) und [#2962](https://github.com/angular/angular/issues/2962).

### Code

Code auf Github für die erste Lösung: [04-Form\_Recipes/04-Check\_Form\_Validity\_in\_Template/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-01/index.html)

Code auf Github für die zweite Lösung: [04-Form\_Recipes/04-Check\_Form\_Validity\_in\_Template/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-02/index.html)

### Weitere Ressourcen

* Offizielle [NgControlName](https://angular.io/docs/ts/latest/api/common/NgControlName-directive.html) Dokumentation auf der Angular 2 Webseite
* Eine Instanz der NgForm-Direktive beinhaltet auch die Eigenschaften der [AbstractControlDirective](https://angular.io/docs/ts/latest/api/common/AbstractControlDirective-class.html)
* Weitere Informationen zu lokale Variablen und die exportAs-Eigenschaft gibt es im [Appendix A: Template-Syntax](#appendix-a)

## Fehlermeldungen für einzelne Formular-Felder anzeigen {#c04-input-field-errors}

### Problem

Ich möchte für jedes ungültige Eingabefeld eine Fehlermeldung anzeigen. Je nachdem weshalb das Eingabefeld ungültig ist, soll auch die dazugehörige Fehlermeldung angezeigt werden.

### Zutaten
* [Gültigkeit eines Formulars überprüfen](#c04-form-validation)
* [Teile der View konditional Anzeigen mit NgIf](#c03-ngif)
* Elvis-Operator (?.)
* Lokale (Template-) Variable, die die Instanz der NgControlName-Direktive für das jeweilige Eingabefeld referenziert (nur Lösung 2)

### Lösung 1

In der ersten Lösung werden wir die Gültigkeit des jeweiligen Eingabefeldes überprüfen, indem wir auf das Control über die lokale Variable für das Formular zugreifen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username</label>
      <input type="text" [(ngModel)]="user.username" required ngControl="username"/>
      <div *ngIf="!form.controls.username?.valid">
        This field is required!
      </div>
      <label>Password</label>
      <input type="password" [(ngModel)]="user.password" required minlength="10" ngControl="password"/>
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

* Zeilen 9-11: Nutzung von __ngIf__ mit Kondition __!form.controls.username?.valid__. Damit greifen wir auf die valid-Eigenschaft des Controls zu. Diese Eigenschaft ist __true__, wenn das Eingabefeld gültig ist
* Zeilen 14-16: Nutzung von __ngIf__ mit Kondition __form.controls.password?.errors?.required__. Die Kondition ist wahr, wenn das Eingabefeld leer ist
* Zeilen 17-19: Nutzung von __ngIf__ mit Kondition __form.controls.password?.errors?.minlength__. Die Kondition ist wahr, wenn das Eingabefeld nicht leer ist und weniger als zehn Zeichen beinhaltet

### Lösung 2

Hier werden wir lokale Variable für jedes Eingabefeld definieren.
Über die lokale Variable werden wir Zugriff auf die Gültigkeit des Eingabefeldes bekommen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username</label>
      <input type="text" [(ngModel)]="user.username" required ngControl="username" #username="ngForm"/>
      <div *ngIf="!username.valid">
        This field is required!
      </div>
      <label>Password</label>
      <input type="password" [(ngModel)]="user.password" required minlength="10" ngControl="password" #password="ngForm"/>
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

* Zeile 8: Mit __#username=`"`ngForm`"`__ definieren wir eine lokale Variable namens "username". Die Variable ist eine Referenz auf die Instanz der NgControlName-Direktive für das Eingabefeld
* Zeilen 9-11: Nutzung von __ngIf__ mit Kondition __!username?.valid__. Damit greifen wir auf die valid-Eigenschaft des Controls zu. Diese Eigenschaft ist __true__, wenn das Eingabefeld gültig ist
* Zeile 13: Mit __#password=`"`ngForm`"`__ definieren wir eine lokale Variable namens "password". Die Variable ist eine Referenz auf die Instanz der NgControlName-Direktive für das Eingabefeld
* Zeilen 14-16: Nutzung von __ngIf__ mit Kondition __password.errors?.required__. Die Kondition ist wahr, wenn das Eingabefeld leer ist
* Zeilen 17-19: Nutzung von __ngIf__ mit Kondition __password.errors?.minlength__. Die Kondition ist wahr, wenn das Eingabefeld nicht leer ist und weniger als zehn Zeichen beinhaltet

### Diskussion

Bei der Erklärung der Lösung haben wir einige Details weggelassen. Nun möchten wir auch diese Details erklären. Wir fangen mit dem Elvis-Operator (?.) an.

#### Elvis-Operator

Den Elvis-Operator haben wir in beide Lösungen verwendet.
Dieser kann uns helfen, wenn wir im Template mit Objekten arbeiten die __null__ oder __undefined__ sein könnten.
Da das controls-Objekt des Formulars leer ist (__undefined__) am Anfang, nutzen wir den Elvis-Operator, um Exceptions zu vermeiden.
Wenn ein Eingabefeld gültig ist, ist das errors-Objekt des Controls __null__.
Darum haben wir in beiden Lösungen den Elvis-Operator bei der Überprüfung der Gültigkeit des Passwort-Feldes verwendet.

#### errors-Objekt

In beiden Lösungen haben wir das errors-Objekt benutzt, um Konditionen für die NgIf-Direktive zu definieren.
Dieses beinhaltet die Gründe weshalb ein Eingabefeld ungültig ist.
Wenn z. B. das required-Attribut eines Eingabefeldes definiert ist und das Feld leer ist, beinhaltet das errors-Objekt die Eigenschaft "required" mit dem Wert __true__.
Der Namen der Eigenschaft, in unserem Beispiel "required" zeigt an welche Validierung fehlschlägt.
Dieser Fehlschlag ist der Grund für die Ungültigkeit des Eingabefeldes.
Als zweite Kondition für das Passwort-Feld, haben wir "minlength" benutzt.
Die Wahrheit ist, dass "minlength" keine boolesche Eigenschaft ist, sondern ein Objekt.
Wenn das Eingabefeld genügend Zeichen beinhaltet, ist die minlength-Eigenschaft des errors-Objektes __undefined__.
Wenn das Eingabefeld nicht genügend Zeichen beinhaltet, ist der Wert der Eigenschaft ein Objekt mit den Eigenschaften "actualLength" und "requiredLength".
Die erste Eigenschaft zeigt an wie viele Zeichen im Eingabefeld enthalten sind.
Die zweite Eigenschaft zeigt an wie viele Zeichen wir mindestens brauchen bevor das Eingabefeld gültig wird.
In der Lösung die wir oben gezeigt haben wäre der Wert für die requiredLength-Eigenschaft __10__.

#### Lösung 2

Genau so wie die NgForm-Direktive, hat auch die NgControlName-Direktive die exportAs-Eigenschaft mit dem Wert __`'`ngForm`'`__.
Somit können wir im Template Zugriff auf das Control und dessen Eigenschaften wie z. B. "valid" und "errors" bekommen.
Im übrigen können wir diese Lösung auch ohne Formular und __ngControl__ anwenden.
Die NgModel-Direktive hat auch __`'`ngForm`'`__ als exportAs-Eigenschaft und gibt uns auch Zugriff auf das Control.
Vom Interface her ist das Control von der NgControlName- und der NgModel-Direktive gleich nur, dass wir für die NgModel-Direktive und deren Control kein Formular benötigen.
Das Control der NgModel-Direktive registriert sich nicht mit dem Formular auch, wenn wir eins haben.
Darum brauchen wir die NgControlName-Direktive, um die Gültigkeit eines Formulars zu überprüfen.
Wenn wir nur einzelne Eingabefelder überprüfen möchten, reicht die NgModel-Direktive aus.

### Code

Code auf Github für die erste Lösung: [04-Form\_Recipes/03-Form\_Show\_Error\_for\_Field/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-01/index.html)

Code auf Github für die zweite Lösung: [04-Form\_Recipes/03-Form\_Show\_Error\_for\_Field/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-02/index.html)

### Weitere Ressourcen

* Eine Instanz der NgControlName-Direktive beinhaltet auch die Eigenschaften der [AbstractControlDirektive](https://angular.io/docs/ts/latest/api/common/AbstractControlDirective-class.html)
* Weitere Informationen zu lokale Variablen und die exportAs-Eigenschaft gibt es im [Appendix A: Template-Syntax](#appendix-a)

## Formular-Felder und CSS-Klassen {#c04-form-css-classes}

### Problem

Ich möchte ein ungültiges Formular-Feld farblich hervorheben.

### Zutaten
* [Gültigkeit eines Formulars überprüfen](#c04-form-validation)
* Styles für die CSS-Klassen, die von Angular gesetzt werden
  * Siehe auch [Das Template der Komponente vom CSS trennen](#c07-styles)

### Lösung

Jedes Eingabefeld bekommt von Angular gewisse CSS-Klassen gesetzt.
Um diese zu nutzen, müssen wir nur entsprechende Styles definieren.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  styles: [
    '.ng-invalid { border-color: red; }',
    '.ng-valid { border-color: green; }'
  ],
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username</label>
      <input type="text" [(ngModel)]="user.username" required ngControl="username"/>
      <label>Password</label>
      <input type="password" [(ngModel)]="user.password" required minlength="10" ngControl="password"/>
      <button type="submit" [disabled]="!form.valid">Submit</button>
    </form>`
})

...
```

__Erklärung__:

* Zeilen 6-7: CSS-Styles für die "ng-invalid" und "ng-valid" CSS-Klassen

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

## Formular mit dem FormBuilder implementieren {#c04-formbuilder}

### Problem

Ich möchte, dass sich die Logik für mein Formular in der Klasse der Komponente befindet. Somit ist mein Template nicht überladen und ich kann auch die Logik besser Testen.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* HTML für ein Formular
* Den FormBuilder-Service von Angular
* Die NgControlName-Direktive von Angular
* Die NgFormModel-Direktive von Angular

### Lösung

Wir nutzen hier ein "Model Driven" Formular. Wir definieren das Modell für das Formular und dessen Controls in der Klasse der Komponente.
Im Template nutzen wir das form-Tag und input-Tags, die wir mit Hilfe von der NgControlName- und der NgFormModel-Direktive mit dem Modell in der Klasse verbinden.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { FormBuilder, ControlGroup } from '@angular/common';

@Component({
  selector: 'demo-app',
  template: `
    <form (ngSubmit)="onSubmit()" [ngFormModel]="form" novalidate>
      <label>Username</label>
      <input type="text" ngControl="username"/>
      <label>Password</label>
      <input type="password" ngControl="password"/>
      <button type="submit">Submit</button>
    </form>
  `
})
export class DemoAppComponent {
  form: ControlGroup;
  constructor(builder: FormBuilder) {
    this.form = builder.group({
      username: builder.control(''),
      password: builder.control('')
    });
  }

  onSubmit() {
    console.log(this.form.value);
  }
}
```

__Erklärung__:

* Zeile 2: Hier importieren wir unsere Abhängigkeiten, die wir in der Klasse benötigen
* Zeilen 7-13: Das HTML für unser Formular
  * Zeile 7: Nutzung der NgFormModel-Direktive. Damit verbinden wir das Formular in der Klasse (Zeile 19), mit dem Formular im DOM. Das __ngSubmit__ wird im Rezept "[Ein einfaches Formular implementieren](#c04-simple-form)" erklärt
  * Zeile 9: Nutzung der NgControlName-Direktive (__ngControl__). Damit verbinden wir das username-Control in der Klasse (Zeile 20), mit dem Eingabefeld im DOM
  * Zeile 11: Nutzung der NgControlName-Direktive. Damit verbinden wir das password-Control in der Klasse (Zeile 21), mit dem Eingabefeld im DOM
* Zeile 17: Typdefinition für die form-Eigenschaft
* Zeile 18: Konstruktor der Klasse mit eine Instanz des FormBuilder-Services als Parameter
* Zeilen 19-22: Das Modell für unser Formular
  * Zeile 19: Hier rufen wir die group-Methode auf, die eine Instanz der ControlGroup-Klasse erzeugt
  * Zeile 20: Hier rufen wir die control-Methode auf, die eine Instanz der Control-Klasse erzeugt. Der default-Wert für das Eingabefeld ist ein leerer String
  * Zeile 21: Gleiches wie oben aber für das Passwort-Feld
* Zeile 26: Hier greifen wir auf die Werte, die sich im Formular befinden

### Diskussion

Der FormBuilder ist ein [Service](#gl-service) den Angular uns zur Verfügung stellt.
Dieser Service erlaubt es uns mit relativ wenig Code komplexe Formulare zu definieren.
Wie schon erwähnt, arbeiten wir hier mit "Model Driven Forms".
Das Modell für das Formular wird in der Klasse definiert und dann an den DOM gebunden.
Mit __[ngFormModel]=`"`form`"`__ binden wir das Modell an das DOM-Formular an.
Ohne diese Bindung würde Angular für das Formular eine neue Instanz der NgForm-Direktive erzeugen und wir hätten keine Verbindung zu unserem Modell.
Da ein Formular nutzlos ist ohne Eingabefelder, haben wir bei dem Aufruf der group-Methode ein Objekt mit zwei Controls übergeben.
Die Eigenschaftsnamen im Objekt definieren die Namen der Controls (hier "username" und "password") und die Werte sind Instanzen der Control-Klasse.
Natürlich müssen wir unsere Controls auch an die eigentlichen Eingabefelder im DOM binden.
Dies tun wir mit Hilfe der NgControlName-Direktive.
Da wir hier die NgFormModel- statt der NgForm-Direktive nutzen, werden mit __ngControl__ keine neue Controls erzeugt.
Der Namen den wir mit __ngControl=`"`controlName`"`__ übergeben referenziert ein existierendes Control in unserem Modell.
Hier referenziert __ngControl=`"`username`"`__ in Zeile 9, das Control in Zeile 20.

Natürlich wollen wir auch Zugriff auf die Daten, die der Nutzer in das Formular eingegeben hat.
Im Rezept "[Ein einfaches Formular implementieren](#c04-simple-form)" haben wir dafür die NgModel-Direktive benutzt.
Da wir hier die NgModel-Direktive nicht nutzen, brauchen wir einen anderen Weg, um auf die Daten zuzugreifen.
Zum Glück beinhaltet auch unser Formular-Modell alle Daten, die in die jeweiligen Eingabefelder geschrieben worden sind.
Die Daten befinden sich in der value-Eigenschaft des Formular-Modells.
Diese Eigenschaft ist ein Objekt und beinhaltet alle Eingabefelder.
Das value-Objekt hat als Eigenschaftsnamen die Namen der Controls, die wir im Formular-Modell definiert haben.
Die Werte sind dann das was der Nutzer in den Eingabefeldern geschrieben hat.
In unserem Beispiel besteht das value-Objekt aus zwei Eigenschaften mit Namen "username" und "password".

Wenn wir dieses Rezept mit dem "[Ein einfaches Formular implementieren](#c04-simple-form)" Rezept vergleichen, sehen wir, dass das Endresultat gleich ist.
Beide Formulare haben zwei Eingabefelder und bei Submit greifen wir auf die Daten, die der Nutzer im Formular eingegeben hat.
Der Unterschied zwischen den beiden Rezepten ist der Weg den wir gewählt haben, um das Problem zu lösen.

Ein Detail hatten wir bis jetzt ignoriert.
Wie wusste Angular überhaupt, dass wir den FormBuilder-Service brauchten?
Anhand der Typinformation, die wir bei der Parameterdefinition im Konstruktor angegeben haben und mittels [Dependency Injection (DI)](#gl-di) kann Angular uns eine Instanz eines Services bei der Initialisierung der Komponente übergeben.
Die Typinformation befindet sich auf Zeile 18 und ist der Teil nach dem Doppelpunkt.
Wir haben __builder: FormBuilder__ geschrieben. In diesem Fall ist "builder" der Parameternamen und "FormBuilder" die Typinformation.
Mit Hilfe des Typs schaut Angular welche Services zur Verfügung stehen und gibt uns zurück eine Instanz mit dem richtigen Typ.
Dependency Injection in Angular und Services ist ein relativ komplexes Thema und eine vollständige Erklärung würde den Rahmen eines Rezeptes sprengen.
Wer mehr über dieses Thema lesen möchte, kann einige Informationen auf der Angular 2 Webseite finden.

### Code

Code auf Github: [04-Form\_Recipes/05-Form\_with\_FormBuilder](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/05-Form_with_FormBuilder)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/05-Form_with_FormBuilder/index.html)

### Weitere Ressourcen

* Offizielle [FormBuilder](https://angular.io/docs/ts/latest/api/common/FormBuilder-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [Control](https://angular.io/docs/ts/latest/api/common/Control-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [ControlGroup](https://angular.io/docs/ts/latest/api/common/ControlGroup-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgFormModel](https://angular.io/docs/ts/latest/api/common/NgFormModel-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgControlName](https://angular.io/docs/ts/latest/api/common/NgControlName-directive.html) Dokumentation auf der Angular 2 Webseite
* Eine kurze Diskussion über Dependency Injection gibt es im Rezept [Service definieren](#c02-define-service)
* Weiter Informationen zur [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html) gibt es auf der Angular 2 Webseite

## Formular mit dem FormBuilder und Validierung {#c04-formbuilder-validation}

### Problem

Ich möchte ein Formular mit dem FormBuilder bauen und zusätzlich möchte ich auch in der Lage sein zu erkennen, wann das Formular gültig ist.

### Zutaten
* [Formular mit dem FormBuilder implementieren](#c04-formbuilder)
* Die Validierungs-Funktionen von Angular (Validators-Klasse)
* Anpassungen an der Komponente von "Formular mit dem FormBuilder implementieren"

### Lösung

In dieser Lösung werden wir dasselbe Problem lösen wie im Rezept "[Gültigkeit eines Formulars überprüfen](#c04-form-validation)".
Nur werden wir hier mit Validierungs-Funktionen statt mit Validierungs-Attribute arbeiten.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    ControlGroup,
    Validators
} from '@angular/common';

...

export class DemoAppComponent {
  form: ControlGroup;

  constructor(builder: FormBuilder) {
    this.form = builder.group({
      username: builder.control('', Validators.required),
      password: builder.control('', Validators.compose([
        Validators.required,
        Validators.minLength(10)
      ]))
    });
  }

  onSubmit() {
    if (this.form.valid) {
      console.log(this.form.value);
    }
  }
}
```

__Erklärung__:

* Zeile 5: Hier importieren wir alle Validatoren, die uns Angular zur Verfügung stellt
* Zeile 15: Control für das Benutzername-Feld definieren. Mit __Validators.required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeile 16: Ein Control erwartet als zweiten Parameter eine Validierungs-Funktion. Wenn wir mehrere Funktionen gleichzeitig nutzen möchten, müssen wir die compose-Funktion nutzen
* Zeile 17: Hier definieren wir das Passwort-Feld als Pflichtfeld
* Zeile 18: Das Feld muss mindestens zehn Zeichen beinhalten, damit es gültig ist

### Code

Code auf Github: [04-Form\_Recipes/06-Form\_Validation\_with\_FormBuilder](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/06-Form_Validation_with_FormBuilder)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/06-Form_Validation_with_FormBuilder/index.html)

### Weitere Ressourcen

* Offizielle [Validators](https://angular.io/docs/ts/latest/api/common/Validators-class.html) Dokumentation auf der Angular 2 Webseite

## Eigene Validatoren definieren {#c04-custom-validation}

### Problem

Ich möchte überprüfen, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet. Wenn kein Großbuchstabe vorhanden ist, soll das Eingabefeld ungültig sein.

### Zutaten
* [Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* Validierungs-Funktion die überprüft, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet
* Anpassungen an der Komponente von "Formular mit dem FormBuilder und Validierung"

### Lösung

Wir werden hier die gleiche Validierungs-Funktionen wie im "Formular mit dem FormBuilder und Validierung" Rezept nutzen. Wir werden zusätzlich eine eigene Validierungs-Funktion namens "containsCapital" implementieren.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    ControlGroup,
    Validators,
    Control
} from '@angular/common';

...

export class DemoAppComponent {
  form: ControlGroup;

  constructor(builder: FormBuilder) {
    this.form = builder.group({
      username: builder.control('', Validators.required),
      password: builder.control('', Validators.compose([
        Validators.required,
        Validators.minLength(10),
        function containsCapital(control: Control) {
          const reg = /[A-Z]/;
          if (reg.test(control.value)) {
            return null;
          } else {
            return {
              containsCapital: true
            };
          }
        }
      ]))
    });
  }

  onSubmit() {
    if (this.form.valid) {
      console.log(this.form.value)
    }
  }
}
```

__Erklärung__:

* Zeile 6: Hier importieren wir die Control-Klasse. Wir nutzen diese für die Typdefinition in Zeile 19
* Zeilen 20-29: Unsere Validierungs-Funktion
  * Zeile 20: Als Parameter bekommt eine Validierungs-Funktion immer eine Instanz der Control-Klasse. In diesem Fall ist die Instanz unser password-Control
  * Zeile 22: Überprüfung, ob der Wert (__control.value__) des Controls einen Großbuchstaben beinhaltet
  * Zeile 23: Wenn das Eingabefeld einen gültigen Wert beinhaltet, geben wir __null__ zurück
  * Zeile 25: Wenn das Eingabefeld einen ungültigen Wert beinhaltet, geben wir ein Objekt zurück

### Diskussion

Wenn die Validierung fehlschlägt, muss die Validierungs-Funktion ein Objekt zurück geben.
Wir bekommen Zugriff auf dieses Objekt über das errors-Objekt des Controls.
Dieses Objekt haben wir im Rezept "[Fehlermeldungen für einzelne Formular-Felder anzeigen](#c04-input-field-errors)" gesehen.
Solang das Passwort-Feld kein Großbuchstabe enthält, hat das errors-Objekt eine Eigenschaft namens "containsCapital" mit Wert __true__.
Wir hätten auch ein komplexeres Objekt zurückgeben können genau so wie es die minLength-Validierungs-Funktion tut.
Wenn der Wert im Eingabefeld gültig ist, geben wir __null__ zurück.
Andere Werte wie z. B. __undefined__ haben den gleichen Effekt, da aber die Angular-Validierungs-Funktionen auch __null__ nutzen, um die Ungültigkeit zu kennzeichen tun wir es hier auch.

### Code

Code auf Github: [04-Form\_Recipes/07-Custom\_Validation](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/07-Custom_Validation)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/07-Custom_Validation/index.html)

## Eigene asynchrone Validatoren definieren

### Problem

Ich möchte überprüfen, ob der gegebene Benutzername schon existiert. Dafür muss ich den Server kontaktieren und auf die Antwort warten bevor ich weiß, ob das Eingabefeld gültig oder ungültig ist.

### Zutaten
* [Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* Validierungs-Funktion die asynchron überprüft, ob ein Benutzername schon existiert
* Anpassungen an der Komponente von "Formular mit dem FormBuilder und Validierung"

### Lösung

Um die Lösung möglichst einfach zu halten, werden wir die Server-Anfrage mit einem Timeout simulieren. Für eine echte Server-Anfrage brauchen wir einen Server, der auf die Anfrage antworten kann und Code, der die Anfrage schicken kann.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    ControlGroup,
    Validators,
    Control
} from '@angular/common';

...

export class DemoAppComponent {
  form: ControlGroup;

  constructor(builder: FormBuilder) {
    this.form = builder.group({
      username: builder.control('', Validators.required,
          function usernameExists(control: Control) {
            return new Promise((resolve) => {
              setTimeout(() => {
                if (control.value === 'Max') {
                  resolve({
                    usernameExists: true
                  });
                } else {
                  resolve(null);
                }
              }, 1000);
            });
          }),
      password: builder.control('', Validators.compose([Validators.required, Validators.minLength(10)]))
    });
  }

  onSubmit() {
    if (!this.form.pending && this.form.valid) {
      console.log(this.form.value);
    }
  }
}
```

__Erklärung__:

* Zeile 6: Hier importieren wir die Control-Klasse. Wir nutzen diese für die Typdefinition in Zeile 17
* Zeilen 17-29: Unsere asynchrone Validierungs-Funktion
  * Zeile 17: Als Parameter bekommt eine Validierungs-Funktion immer eine Instanz der Control-Klasse. In diesem Fall ist die Instanz unser username-Control
  * Zeile 18: Asynchrone Validierungs-Funktionen haben einen Promise als Rückgabewert
  * Zeile 19: Wir simulieren eine Server-Anfrage mit der setTimeout-Funktion
  * Zeile 20: Überprüfung, ob der Wert (__control.value__) des Controls gleich dem String __Max__ ist
  * Zeilen 21-23: Wenn der Wert gleich __Max__ ist, ist das Eingabefeld ungültig und wir teilen das Angular mit, indem wir der resolve-Funktion ein Objekt übergeben
  * Zeile 25: Wenn der Wert ungleich __Max__ ist, ist das Eingabefeld gültig und wir teilen das Angular mit, indem wir der resolve-Funktion __null__ übergeben
* Zeile 35: Hier wird überprüft (__this.form.pending__), ob alle asynchrone Validierungs-Funktionen eine Antwort bekommen haben

### Diskussion

Eine asynchrone Validierungs-Funktion ist sehr ähnlich zu einer synchrone Validierungs-Funktion wie wir diese im Rezept "[Eigene Validatoren definieren](#c04-custom-validation)" gesehen haben.
Beide Funktionen bekommen eine Instanz der Control-Klasse als Funktionsparameter.
Beide signalisieren die Gültigkeit des Eingabefelds, indem sie __null__ zurückgeben und die Ungültigkeit des Eingabefelds, indem sie ein Objekt zurückgeben.
Es gibt aber auch Unterschiede zwischen synchrone und asynchrone Validierungs-Funktionen.
Wir nutzen den dritten Parameter der control-Methode für asynchrone Validierungs-Funktionen.
Um mehrere asynchrone Validierungs-Funktionen für ein Control zu definieren, müssen wir die composeAsync-Methode statt der compose-Methode nutzen.
Sie haben ein Promise als Rückgabewert. Die Gültigkeit wird durch den Aufruf der resolve-Funktion zurückgegeben.

Asynchrone Validierungs-Funktionen haben noch weitere Besonderheiten.
Sie werden nur dann aufgerufen, wenn das Eingabefeld gültig ist nach dem Aufruf der synchronen Validierungs-Funktionen. Wenn es ungültig ist, werden die asynchrone Validierungs-Funktionen nicht aufgerufen.
Da wir auf die asynchrone Funktionen warten müssen vor wir die Gültigkeit des Eingabefelds und des Formulars prüfen können, wird von Angular die pending-Eigenschaft des Controls und des Formulars auf __true__ gesetzt bis wir eine Antwort haben.
Wir haben schon im Code gesehen (Zeile 35) wie wir die pending-Eigenschaft nutzen können.

Es ist vermutlich bekannt, dass Promises zwei Funktionen haben.
Die resolve- und die reject-Funktion.
Asynchrone Validierungs-Funktionen brauchen die reject-Funktion nicht.
Im Gegenteil, wenn wir "reject" nutzen wird die pending-Eigenschaft __true__ bleiben bis die resolve-Funktion aufgerufen wird.
Es ist also wichtig, dass wir Fehler in der Validierungs-Funktion abfangen und in der Fehlerbehandlungsroutine die resolve-Funktion aufrufen.

### Code

Code auf Github: [04-Form\_Recipes/08-Custom\_Async\_Validation](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/08-Custom_Async_Validation)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/08-Custom_Async_Validation/index.html)

### Weitere Ressourcen

* Weitere Informationen über [Promises](https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Global_Objects/Promise) auf der Mozilla Developer Network Webseite

