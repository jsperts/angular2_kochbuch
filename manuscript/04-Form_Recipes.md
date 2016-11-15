# Rezepte für Formulare

Angular bietet uns mehrere Möglichkeiten, Formulare zu implementieren.
Wir können in Angular 2 zwischen zwei Arten von Formularen unterscheiden: "Template-Driven Forms" und "Model-Driven Forms" auch bekannt als "Reactive Forms".
Beide Formulararten bieten die gleichen Funktionalität an.
Nur der Weg, den wir gehen müssen, um die Funktionalität zu implementieren ist anders.
Die Art des Formulars steht im Titel des Rezepts.
TDF für "Template-Driven" und MDF für "Model-Driven".

Bei den "Template-Driven Forms" befindet sich ein Großteil der Logik, wie z. B. die Validierung, im Template.
Auch die Synchronisation zwischen den Daten, die der Nutzer sieht und den Daten in der Klasse der Komponente (dem Modell) wird im Template definiert.
So werden Formulare auch bereits in Angular 1.x implementiert, wo wir direkt im Template z. B. mit dem required-Attribut definieren, dass das Feld ein Pflichtfeld ist.
Da "Template-Driven Forms" einfacher und in der Regel mit weniger Code zu implementieren sind, werden wir uns zuerst mit diesen beschäftigen.
Allerdings haben diese Formulare auch Nachteile.
Da sich die Logik im Template befindet, ist es schwer bis unmöglich, diese in Unit-Tests zu testen.
Des Weiteren kann das Template bei Formularen mit komplexer Validierung sehr schnell unübersichtlich werden.

Bei den "Model-Driven Forms" befindet sich die meiste Logik in der Klasse der Komponente.
Das Template hat nur die nötigen Informationen, um die Formular-Felder mit dem Formular-Modell zu verbinden.
Als Formular-Modell bezeichnen wir in diesem Zusammenhang die Implementierung des Formulars in der Klasse der Komponente.
"Model-Driven Forms" benötigen in der Regel mehr Code.
Wir müssen das Formular im Template implementieren und dann die Logik in der Klasse.
Da die Logik sich in der Klasse befindet, können wir die Komponente gut Unit-testen.

Wir werden jetzt mit einem einfachen "Template-Driven" Formular anfangen und werden uns danach "Model-Driven" Formulare anschauen.

## TDF: Ein einfaches Formular implementieren {#c04-simple-form}

### Problem

Ich möchte Daten vom Benutzer bekommen und brauche dafür ein einfaches Formular.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Forms-Modul von Angular
* NgModel-Direktive
* NgForm-Direktive mit dem ngSubmit-Event
* Anpassungen an der app.module.ts-Datei
* Anpassungen an der package.json-Datei

### Lösung

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <form (ngSubmit)="onSubmit()">
      <label>Username
        <input type="text"
          [(ngModel)]="user.username"
          name="username" />
      </label>
      <label>Password
        <input type="password"
          [(ngModel)]="user.password"
          name="password" />
      </label>
      <button type="submit">Submit</button>
    </form>
  `
})
export class AppComponent {
  user = {
    username: '',
    password: ''
  };

  onSubmit() {
    console.log(this.user);
  }
}
```

__Erklärung__:

* Zeilen 6-18: Das Formular
  * Zeile 6: Wir binden das ngSubmit-Event des Formulars an unsere onSubmit-Methode
  * Zeilen 8-10: Eingabefeld für den Benutzernamen
    * Zeile 9: Hier nutzen wir die NgModel-Direktive, um die View mit den Daten (dem Modell) der Komponente zu verbinden. Konkreter reden wir hier von einer beidseitigen Bindung zwischen dem Wert des Eingabefeldes und der username-Eigenschaft des user-Objekts (siehe Zeilen 22-25)
    * Zeile 10: Hier definieren wir einen Namen für das Eingabefeld
  * Zeile 13-15: Ähnlich wie Zeilen 8-10, aber für das Passwort-Feld
* Zeilen 22-25: Ein Objekt, in welchem die Daten, die der Nutzer in das Formular eingibt, gespeichert werden. Die leeren Strings für die Eigenschaften "username" und "password" sind die Default-Werte für die Eingabefelder
* Zeilen 27-29: Methode, die aufgerufen wird, wenn der Nutzer ein submit-Event auslöst, z. B. durch ein Klick auf den Button (siehe auch Zeile 6)

Da sich Formular-Direktiven wie z. B. "NgModel" in einem eigenen Angular-Modul befinden, müssen wir dieses Modul in unser "AppModule" importieren.

{title="app.module.ts", lang=js}
```
import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AppComponent }  from './app.component';

@NgModule({
  imports: [ BrowserModule, FormsModule ],
  declarations: [ AppComponent ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 8: Hier importieren wir das "FormsModule" in unser Modul. In diesem Modul befinden sich alle Direktiven, die wir für Template-Driven Forms brauchen

Da sich das "FormsModule" in einem eigenen npm-Paket befindet, müssen wir dieses auch in der package.json deklarieren.

{title="package.json", lang=js}
```
{
  ...
  "dependencies": {
    ...
    "@angular/forms": "2.1.2"
    ...
  }
  ...
}
```

Wenn eine Angular-Anwendung mit angular-cli initialisiert wird, wird das "FormsModule" automatisch von angular-cli importiert und das entsprechende npm-Paket in der package.json-Datei deklariert.

### Diskussion

Jedes form-Tag bekommt automatisch eine Instanz der NgForm-Direktive.
Ein Formular hat von sich aus kein ngSubmit-Event, sondern ein submit-Event.
Da aber das Formular auch eine Instanz der NgForm-Direktive ist, haben wir Zugriff auf das ngSubmit-Event der Direktive.
Das ngSubmit-Event ist also eine [output-Eigenschaft](#gl-output-property) der NgForm-Direktive.
Im Grunde genommen bindet die NgForm-Direktive das submit-Event des Formulars und leitet es an das ngSubmit-Event weiter.
Der einzige Unterschied zwischen den zwei Events ist, dass ngSubmit die submitted-Eigenschaft des Formulars (NgForm-Instanz) auf __true__ setzt.

Die NgModel-Direktive definiert ein sogenanntes "Control" und bindet ein Modell in der Komponenten-Klasse mit einem Eingabefeld/Select usw. in der View.
Ein Control kann dann entweder innerhalb eines form-Tags oder ohne form-Tag (standalone Control) benutzt werden.
Wenn wir die NgModel-Direktive innerhalb eines form-Tags nutzen, müssen wir für das Element mit der Direktive auch das name-Attribut definieren.
Das name-Attribut wird benutzt, um das Control mit der Instanz der ngForm-Direktive zu registieren.

Wie schon erwähnt, nutzen wir in den Zeilen 9 und 14 eine beidseitige Bindung.
Wir hätten die beidseitige Bindung auch in eine Eigenschaft- und eine Event-Bindung aufspalten können.
Wie das aussieht wird in [Appendix A](#appendix-a) gezeigt.
Da die Nutzung der beidseitigen Bindung einfacher ist, werden wir sie auch in weiteren Formular-Rezepten nutzen.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/01-Simple_Form)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/01-Simple_Form/index.html)

### Weitere Ressourcen

* Offizielle [NgModel](https://angular.io/docs/ts/latest/api/forms/index/NgModel-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [NgForm](https://angular.io/docs/ts/latest/api/forms/index/NgForm-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Event-, Eigenschafts- und beidseitigen Bindungen gibt es in [Appendix A: Template-Syntax](#appendix-a)

## TDF: Gültigkeit eines Formulars überprüfen {#c04-form-validation}

### Problem

Ich möchte, dass ein Submit nur dann möglich ist, wenn das Formular gültig ist. Ein Formular ist nur dann gültig, wenn alle seine Eingabefelder gültig sind.

### Zutaten
* [Ein Formular](#c04-simple-form)
* Validierungs-Attribute
* Anpassungen am Formular
* Lokale (Template-) Variable, die das Formular referenziert

### Lösung 1

In dieser Lösung werden wir sehen, wie wir die Gültigkeit des Formulars im Template überprüfen können.
Wir werden den Submit-Button deaktivieren, wenn das Formular ungültig ist.
Dadurch wird das Submit-Event unterbunden, solange nicht alle Formular-Felder gültig sind.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <form (ngSubmit)="onSubmit()" #form="ngForm" novalidate>
      <label>Username
        <input name="username" type="text" [(ngModel)]="user.username"
          required />
      </label>
      <label>Password
        <input name="password" type="password" [(ngModel)]="user.password"
          required
          minlength="10" />
      </label>
      <button type="submit" [disabled]="form.invalid">Submit</button>
    </form>
  `
})

...
```

__Erklärung__:

* Zeile 6: Mit __#form=`"`ngForm`"`__ definieren wir eine lokale (Referenz-) Variable namens "form". Die Variable ist eine Referenz auf die Instanz der NgForm-Direktive unseres Formulars. Wir nutzen auch das novalidate-Attribut, damit der Browser keine Fehlermeldungen für ungültige Eingabefelder anzeigt. Dies ist kein Angular-spezifisches Attribut
* Zeilen 8-9: Eingabefeld für den Benutzernamen
  * Zeile 9: Mittels __required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeilen 12-14: Eingabefeld für das Passwort
  * Zeile 13: Mittels __required__ definieren wir das Eingabefeld als Pflichtfeld
  * Zeile 14: Mittels __minlength=`"`10`"`__ definieren wir, dass das Passwort mindestens zehn Zeichen lang sein muss
* Zeile 16: Hier binden wir die disabled-Eigenschaft an den Ausdruck __form.invalid__. Wenn das Formular ungültig ist, wird der Button deaktiviert sein

### Lösung 2

In dieser Lösung werden wir sehen, wie wir die Gültigkeit des Formulars in der Klasse überprüfen können.
Wir nutzen das Formular aus der ersten Lösung mit zwei Änderungen:
Wir übergeben der onSubmit-Methode die lokale Variable "form" und wir nutzen nicht mehr die disabled-Eigenschaft des Buttons.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-root',
  template: `
    <form (ngSubmit)="onSubmit(form)" #form="ngForm" novalidate>
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
      <button type="submit">Submit</button>
    </form>
  `
})
export class AppComponent {
  user = {
    username: '',
    password: ''
  };

  onSubmit(form: NgForm) {
    if (form.valid) {
      console.log(this.user);
    }
  }
}
```

__Erklärung__:

* Zeile 7: Die lokale Variable "form" wird beim Aufruf der onSubmit-Methode übergeben
* Zeile 30: Die onSubmit-Methode hat jetzt einen Parameter namens "form" vom Typ "NgForm"
* Zeile 31: Wir nutzen __form.valid__, um zu überprüfen, ob das Formular gültig ist

### Diskussion

Wie schon im Rezept "[TDF: Ein einfaches Formular implementieren](#c04-simple-form)" erwähnt, erhält jedes form-Tag eine Instanz der NgForm-Direktive.
Diese Instanz beinhaltet verschiedene Informationen über das Formular wie z. B. dessen Gültigkeitsstatus, dessen Controls und die Werte der Controls.
Die Direktive hat eine exportAs-Eigenschaft mit dem Wert __`'`ngForm`'`__ (ein String).
Den Wert der exportAs-Eigenschaft können wir im Template nutzen, um die Instanz der Direktive im Template zu referenzieren.

Ein Formular ist nur dann gültig, wenn alle seine Controls gültig sind.
Die NgForm-Direktive überprüft also die einzelnen Controls und setzt die valid-Eigenschaft auf __true__, wenn jedes Control gültig ist.

Von Haus aus unterstützt Angular derzeit vier Validierungs-Attribute:

* required,
* pattern,
* minlength und
* maxlength.

Vermutlich wird es mit der Zeit noch mehr eingebaute Validierungs-Attribute bzw. Validierungs-Typen wie z. B. "email" und "url" geben.
Siehe hierzu Github-Issues [#2961](https://github.com/angular/angular/issues/2961) und [#2962](https://github.com/angular/angular/issues/2962).

### Code

Code auf Github für die [erste Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-01)

Live Demo der ersten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-01/index.html)

Code auf Github für die [zweite Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-02)

Live Demo der zweiten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-02/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen und zur exportAs-Eigenschaft gibt es in [Appendix A: Template-Syntax](#appendix-a)

## TDF: Fehlermeldungen für einzelne Formular-Felder anzeigen {#c04-input-field-errors}

### Problem

Ich möchte für jedes ungültige Eingabefeld eine Fehlermeldung anzeigen. Je nachdem weshalb das Eingabefeld ungültig ist, soll die entsprechende Fehlermeldung angezeigt werden.

### Zutaten

* [TDF: Gültigkeit eines Formulars überprüfen](#c04-form-validation)
* [Teile der View konditional Anzeigen mit NgIf](#c03-ngif)
* Elvis-Operator (?.)
* Lokale (Referenz-) Variable, die die Instanz der NgModel-Direktiven des jeweiligen Eingabefelds referenziert (nur Lösung 2)

### Lösung 1

In der ersten Lösung werden wir die Gültigkeit des jeweiligen Eingabefeldes überprüfen, indem wir über die lokale (Referenz-) Variable des Formulars auf das Control zugreifen.

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
      <div *ngIf="form.controls.username?.invalid">
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
      <button type="submit" [disabled]="form.invalid">Submit</button>
    </form>
  `
})

...
```

__Erklärung__:

* Zeilen 13-15: Nutzung von __ngIf__ mit Bedingung __form.controls.username?.invalid__. Damit greifen wir auf die invalid-Eigenschaft des Controls zu. Diese Eigenschaft ist __true__, wenn das Eingabefeld ungültig ist
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
      <div *ngIf="username.invalid">
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
* Zeilen 14-16: Nutzung von __ngIf__ mit Bedingung __username?.invalid__. Damit greifen wir auf die invalid-Eigenschaft des Controls zu. Diese Eigenschaft ist __true__, wenn das Eingabefeld ungültig ist
* Zeile 22: Mit __#password=`"`ngModel`"`__ definieren wir eine lokale Variable namens "password". Die Variable ist eine Referenz auf die Instanz der NgModel-Direktiven des Eingabefelds
* Zeilen 24-26: Nutzung von __ngIf__ mit Bedingung __password.errors?.required__. Die Bedingung ist wahr, wenn das Eingabefeld leer ist
* Zeilen 27-29: Nutzung von __ngIf__ mit Bedingung __password.errors?.minlength__. Die Bedingung ist wahr, wenn das Eingabefeld nicht leer ist und weniger als zehn Zeichen beinhaltet

### Diskussion

Bei der Erklärung der Lösungen haben wir einige Details weggelassen. Nun möchten wir auch diese Details erklären. Wir fangen mit dem Elvis-Operator (?.) an.

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

Code auf Github für die [erste Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-01)

Live Demo der ersten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-01/index.html)

Code auf Github für die [zweite Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-02)

Live Demo der zweiten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/03-Form_Show_Error_for_Field/Solution-02/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen und zur exportAs-Eigenschaft gibt es in [Appendix A: Template-Syntax](#appendix-a)

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

## MDF: Formular mit dem FormBuilder implementieren {#c04-formbuilder}

### Problem

Ich möchte, dass sich die Logik für mein Formular in der Klasse der Komponente befindet. Somit ist mein Template nicht überladen und ich kann auch die Logik besser testen.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* HTML für ein Formular
* Das ReactiveForms-Modul von Angular
* Der FormBuilder-Service von Angular
* Die FormControlName-Direktive von Angular
* Die FormGroupDirective-Direktive von Angular
* Anpassungen an der app.module.ts-Datei
* Anpassungen an der package.json-Datei

### Lösung

Wir nutzen hier ein "Model-Driven" Formular. Wir definieren das Modell für das Formular und dessen Controls in der Klasse der Komponente.
Im Template nutzen wir das form-Tag und mehrere input-Tags, die wir mit Hilfe der FormControlName- und der FormGroup-Direktiven mit dem Modell in der Klasse verbinden.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';

@Component({
  selector: 'app-root',
  template: `
    <form (ngSubmit)="onSubmit()" [formGroup]="myForm" novalidate>
      <label>Username
        <input type="text" formControlName="username"/>
      </label>
      <label>Password
        <input type="password" formControlName="password"/>
      </label>
      <button type="submit">Submit</button>
    </form>
  `
})
export class AppComponent {
  myForm: FormGroup;
  constructor(builder: FormBuilder) {
    this.myForm = builder.group({
      username: builder.control(''),
      password: builder.control('')
    });
  }

  onSubmit() {
    console.log(this.myForm.value);
  }
}
```

__Erklärung__:

* Zeilen 7-15: Das HTML für unser Formular
  * Zeile 7: Nutzung der FormGroupDirective-Direktiven (__formGroup__). Damit verbinden wir das Formular in der Klasse (Zeile 21) mit dem Formular im DOM. __ngSubmit__ wird im Rezept "[TDF: Ein einfaches Formular implementieren](#c04-simple-form)" erklärt
  * Zeile 9: Nutzung der FormControlName-Direktiven. Damit verbinden wir das username-Control in der Klasse (Zeile 22) mit dem Eingabefeld im DOM
  * Zeile 12: Nutzung der FormControlName-Direktiven. Damit verbinden wir das password-Control in der Klasse (Zeile 23) mit dem Eingabefeld im DOM
* Zeile 20: Konstruktor der Klasse mit einer Instanz des FormBuilder-Services als Parameter
* Zeilen 21-24: Das Modell für unser Formular
  * Zeile 21: Hier rufen wir die group-Methode auf, die eine Instanz der FormGroup-Klasse erzeugt
  * Zeile 22: Hier rufen wir die control-Methode auf, die eine Instanz der FormControl-Klasse erzeugt. Der default-Wert des Eingabefelds ist ein leerer String
  * Zeile 23: Gleiches wie oben, aber für das Passwort-Feld
* Zeile 28: Hier greifen wir auf die Werte zu, die sich im Formular befinden

Da sich Formular-Direktiven wie z. B. "FormControlName" in einem eigenen Angular-Modul befinden, müssen wir dieses Modul in unser "AppModule" importieren

{title="app.component.ts", lang=js}
```
import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { ReactiveFormsModule } from '@angular/forms';

import { AppComponent }  from './app.component';

@NgModule({
  imports: [ BrowserModule, ReactiveFormsModule ],
  declarations: [ AppComponent ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 8: Hier importieren wir das "ReactiveFormsModule" in unser Modul. In diesem Modul befinden sich alle Direktiven und Services, die wir für Model-Driven Forms brauchen

Da sich das "ReactiveFormsModule" in einem eigenen npm-Paket befindet, müssen wir dieses auch in der package.json deklarieren.

{title="package.json", lang=js}
```
{
  ...
  "dependencies": {
    ...
    "@angular/forms": "2.1.2"
    ...
  }
  ...
}
```

Wenn eine Angular-Anwendung mit angular-cli initialisiert wird, wird das "@angular/forms"-Paket von angular-cli in der package.json-Datei deklariert.

### Diskussion

FormBuilder ist ein [Service](#gl-service), den Angular uns zur Verfügung stellt.
Dieser Service erlaubt es uns, mit relativ wenig Code komplexe Formulare zu definieren.
Model-Driven Formulare können wir auch ohne den FormBuilder schreiben, indem wir selbst Instanze der FormGroup- bzw. FormControl-Klassen erzeugen und diese an das Template binden.

Wie schon erwähnt, arbeiten wir hier mit "Model-Driven Forms".
Das Modell für das Formular wird in der Klasse definiert und dann an das DOM gebunden.
Mit __[formGroup]=`"`myForm`"`__ binden wir das Modell an das DOM-Formular an.
Ohne diese Bindung würde Angular für das Formular eine neue Instanz der NgForm-Direktive erzeugen und wir hätten keine Verbindung zu unserem Modell.
Da ein Formular ohne Eingabefelder nutzlos ist, haben wir beim Aufruf der group-Methoden ein Objekt mit zwei Controls übergeben.
Die Eigenschaftsnamen im Objekt definieren die Namen der Controls (hier "username" und "password") und die Werte sind Instanzen der FormControl-Klasse.
Natürlich müssen wir unsere Controls auch an die eigentlichen Eingabefelder im DOM binden.
Dies tun wir mit Hilfe der FormControlName-Direktiven.

Ein Detail hatten wir bis jetzt ignoriert.
Wie wusste Angular überhaupt, dass wir den FormBuilder-Service brauchten?
Anhand der Typinformation, die wir bei der Parameterdefinition im Konstruktor angegeben haben und mittels [Dependency Injection (DI)](#gl-di) kann Angular uns eine Instanz eines Services bei der Initialisierung der Komponente übergeben.
Die Typinformation befindet sich auf Zeile 20 (app.component.ts) und ist der Teil nach dem Doppelpunkt.
Wir haben __builder: FormBuilder__ geschrieben. In diesem Fall ist "builder" der Parametername und "FormBuilder" die Typinformation.
Mit Hilfe des Typs schaut Angular nach, welche Services zur Verfügung stehen und gibt uns eine Instanz mit dem richtigen Typ zurück.
Dependency Injection in Angular ist ein relativ komplexes Thema und eine vollständige Erklärung würde den Rahmen eines Rezeptes sprengen.
Wer mehr über dieses Thema lesen möchte, kann einige Informationen auf der Angular 2 Webseite finden.

Natürlich wollen wir auch Zugriff auf die Daten erhalten, die der Nutzer in das Formular eingegeben hat.
Im Rezept "[TDF: Ein einfaches Formular implementieren](#c04-simple-form)" haben wir dafür die NgModel-Direktive benutzt.
Da wir hier die NgModel-Direktive nicht nutzen, brauchen wir einen anderen Weg, um auf die Daten zuzugreifen.
Zum Glück beinhaltet auch unser Formular-Modell alle Daten, die in die jeweiligen Eingabefelder geschrieben worden sind.
Die Daten befinden sich in der value-Eigenschaft des Formular-Modells.
Diese Eigenschaft ist ein Objekt und beinhaltet alle Eingabefelder.
Das value-Objekt hat als Eigenschaftsnamen die Namen der Controls, die wir im Formular-Modell definiert haben.
Die Werte sind dann das was der Nutzer in den Eingabefeldern geschrieben hat.
In unserem Beispiel besteht das value-Objekt aus zwei Eigenschaften mit den Namen "username" und "password".

#### Template-Driven vs. Model-Driven Formulare

Unabhängig von der Formularart, können wir das selbe Ergebnis erzielen.
Wenn wir dieses Rezept mit dem Rezept "[Ein einfaches Formular implementieren](#c04-simple-form)" vergleichen, sehen wir, dass das Endresultat gleich ist.
Beide Formulare besitzen zwei Eingabefelder und bei Submit greifen wir auf die Daten zu, die der Nutzer im Formular eingegeben hat.
Der Unterschied zwischen den beiden Rezepten sind die Mittel, die wir benutzt haben, um das Problem zu lösen.

Für Template-Driven Formulare brauchen wir das "FormsModule" und für Model-Driven Formulare das "ReactiveFormsModule".
Direktiven und Klassen mit "Ng" bzw. "ng" als Präfix gehören zu den Template-Driven Formulare.
Die Restlichen Direktiven, Klassen und Services gehören zu den Model-Driven Formularen oder können von beiden Formulararten benutzt werden.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/05-Form_with_FormBuilder)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/05-Form_with_FormBuilder/index.html)

### Weitere Ressourcen

* Offizielle [FormBuilder](https://angular.io/docs/ts/latest/api/forms/index/FormBuilder-class.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormGroup](https://angular.io/docs/ts/latest/api/forms/index/FormGroup-class.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormGroupDirective](https://angular.io/docs/ts/latest/api/forms/index/FormGroupDirective-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormControl](https://angular.io/docs/ts/latest/api/forms/index/FormControl-class.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormControlName](https://angular.io/docs/ts/latest/api/forms/index/FormControlName-directive.html)-Dokumentation auf der Angular 2 Webseite
* Eine kurze Diskussion über Dependency Injection gibt es im Rezept [Service definieren](#c02-define-service)
* Weitere Informationen zu [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html) gibt es auf der Angular 2 Webseite

## MDF: Gültigkeit eines Formulars überprüfen {#c04-formbuilder-validation}

### Problem

Ich möchte ein Formular mit dem FormBuilder bauen und zusätzlich möchte ich auch in der Lage sein, zu erkennen, wann das Formular gültig ist.

In diesem Rezept lösen wir dasselbe Problem wie im Rezept "[TDF: Gültigkeit eines Formulars überprüfen](#c04-form-validation)".
Nur werden wir hier mit Validierungsfunktionen anstelle von Validierungs-Attributen arbeiten.

### Zutaten

* [MDF: Formular mit dem FormBuilder implementieren](#c04-formbuilder)
* Die Validierungsfunktionen von Angular (Validators-Klasse)
* Anpassungen an der app.component.ts-Datei

### Lösung 1

In dieser Lösung werden wir sehen, wie wir den Submit-Button deaktivieren können, wenn wir ein Model-Driven Formular nutzen.
Diese Lösung ist äquivalent zur Lösung 1 im Rezept "TDF: Gültigkeit eines Formulars überprüfen".

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
      <label>Password
        <input type="password" formControlName="password"/>
      </label>
      <button
        type="submit"
        [disabled]="myForm.invalid"
      >Submit</button>
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

* Zeile 20: Hier binden wir die disabled-Eigenschaft an den Ausdruck __myForm.invalid__
* Zeile 30: Control für das Benutzernamefeld definieren. Mit __Validators.required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeile 31: Ein Control erwartet als zweiten Parameter eine Validierungsfunktion. Wenn wir mehrere Funktionen gleichzeitig nutzen möchten, müssen wir die compose-Funktion nutzen
* Zeile 32: Hier definieren wir das Passwortfeld als Pflichtfeld
* Zeile 33: Das Feld muss mindestens zehn Zeichen beinhalten, damit es gültig ist

### Lösung 2

Diese Lösung ist äquivalent zur Lösung 2 im Rezept "TDF: Gültigkeit eines Formulars überprüfen".
Auch hier überprüfen wir die Gültigkeit des Formulars in der Komponenten-Klasse statt im Template.
Das Template bleibt das gleiche wie im Rezept "MDF: Formular mit dem FormBuilder implementieren".

{title="app.component.ts", lang=js}
```
...

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
    if (this.myForm.valid) {
      console.log(this.myForm.value);
    }
  }
}
```

__Erklärung__:

* Zeile 17: Hier überprüfen wir die Gültigkeit des Formulars, nach dem ein Submit-Event ausgelöst wurden ist durch z. B. ein Klick auf den Submit-Button

### Code

Code auf Github für die [erste Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/06-Form_Validation_with_FormBuilder/Solution-01)

Live Demo der ersten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/06-Form_Validation_with_FormBuilder/Solution-01/index.html)

Code auf Github für die [zweite Lösung](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/06-Form_Validation_with_FormBuilder/Solution-02)

Live Demo der zweiten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/06-Form_Validation_with_FormBuilder/index.html)

### Weitere Ressourcen

* Offizielle [Validators](https://angular.io/docs/ts/latest/api/common/Validators-class.html)-Dokumentation auf der Angular 2 Webseite

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

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/07-Form_Show_Error_for_Field_with_FormBuilder)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/07-Form_Show_Error_for_Field_with_FormBuilder/index.html)

## MDF: Eigene Validatoren definieren {#c04-custom-validation}

### Problem

Ich möchte überprüfen, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet. Wenn kein Großbuchstabe vorhanden ist, soll das Eingabefeld ungültig sein.

### Zutaten

* [MDF: Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* Validierungsfunktion, die überprüft, ob ein Eingabefeld mindestens einen Großbuchstaben beinhaltet
* Anpassungen an der app.component.ts-Datei

### Lösung

Wir werden hier die gleichen Validierungsfunktionen wie im Rezept "MDF: Formular mit dem FormBuilder und Validierung" nutzen. Wir werden zusätzlich eine eigene Validierungsfunktion namens "containsCapital" implementieren.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    FormGroup,
    Validators,
    FormControl
} from '@angular/forms';

...

export class AppComponent {
  myForm: FormGroup;

  constructor(builder: FormBuilder) {
    this.myForm = builder.group({
      username: builder.control('', Validators.required),
      password: builder.control('', Validators.compose([
        Validators.required,
        Validators.minLength(10),
        function containsCapital(control: FormControl) {
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
    if (this.myForm.valid) {
      console.log(this.myForm.value)
    }
  }
}
```

__Erklärung__:

* Zeilen 20-29: Unsere Validierungsfunktion
  * Zeile 20: Als Parameter erhält die Validierungsfunktion eine Instanz der FormControl-Klasse. In diesem Fall ist die Instanz unser password-Control
  * Zeile 22: Überprüfung, ob der Wert (__control.value__) des Controls einen Großbuchstaben beinhaltet
  * Zeile 23: Wenn das Eingabefeld einen gültigen Wert besitzt, geben wir __null__ zurück
  * Zeilen 25-27: Wenn das Eingabefeld einen ungültigen Wert besitzt, geben wir ein Objekt zurück

### Diskussion

Wenn die Validierung fehlschlägt, muss die Validierungsfunktion ein nicht leeres Objekt zurückgeben.
Wir erhalten auf dieses Objekt über das errors-Objekt des FormControls Zugriff.
Dieses Objekt haben wir im Rezept "[MDF: Fehlermeldungen für einzelne Formular-Felder anzeigen](#c04-input-field-errors-formbuilder)" gesehen.
Solange das Passwort-Feld keinen Großbuchstaben enthält, hat das errors-Objekt eine Eigenschaft namens "containsCapital" mit Wert __true__.
Wir hätten auch ein komplexeres Objekt zurückgeben können, genauso wie es die minLength-Validierungsfunktion tut.
Wenn der Wert des Eingabefelds gültig ist, geben wir __null__ zurück.
Andere Werte wie z. B. __undefined__ haben den gleichen Effekt. Da aber die Angular-Validierungsfunktionen auch __null__ nutzen, um die Ungültigkeit zu kennzeichen, tun wir es hier auch.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/08-Custom_Validation)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/08-Custom_Validation/index.html)

## MDF: Eigene asynchrone Validatoren definieren

### Problem

Ich möchte überprüfen, ob der angegebene Benutzername bereits existiert. Dafür muss ich den Server kontaktieren und auf die Antwort warten, bevor ich weiß, ob das Eingabefeld gültig oder ungültig ist.

### Zutaten
* [MDF: Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* Validierungsfunktion, die asynchron überprüft, ob ein Benutzername schon existiert
* Anpassungen an der app.component.ts-Datei

### Lösung

Um die Lösung möglichst einfach zu halten, werden wir die Server-Anfrage mit einem Timeout simulieren. Für eine echte Server-Anfrage brauchen wir einen Server, der auf die Anfrage antworten kann und Code, der die Anfrage schicken kann.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import {
    FormBuilder,
    FormGroup,
    Validators,
    FormControl
} from '@angular/forms';

...

export class AppComponent {
  myForm: FormGroup;

  constructor(builder: FormBuilder) {
    this.myForm = builder.group({
      username: builder.control('', Validators.required,
          function usernameExists(control: FormControl) {
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
      password: builder.control('', Validators.compose([
        Validators.required,
        Validators.minLength(10)
      ]))
    });
  }

  onSubmit() {
    if (!this.myForm.pending && this.myForm.valid) {
      console.log(this.myForm.value);
    }
  }
}
```

__Erklärung__:

* Zeilen 17-29: Unsere asynchrone Validierungsfunktion
  * Zeile 17: Als Parameter erhält die Validierungsfunktion eine Instanz der FormControl-Klasse. In diesem Fall ist die Instanz unser username-Control
  * Zeile 18: Asynchrone Validierungsfunktionen liefern Promises als Rückgabewert zurück
  * Zeile 19: Wir simulieren mit der setTimeout-Funktion eine Server-Anfrage
  * Zeile 20: Überprüfung, ob der Wert (__control.value__) des Controls gleich dem String __Max__ ist
  * Zeilen 21-23: Wenn der Wert gleich __Max__ ist, ist das Eingabefeld ungültig. Eir teilen Angular dies mit, indem wir der resolve-Funktion ein Objekt übergeben
  * Zeile 25: Wenn der Wert ungleich __Max__ ist, ist das Eingabefeld gültig. Wir teilen Angular dies mit, indem wir der resolve-Funktion __null__ übergeben
* Zeile 38: Hier wird überprüft (__this.myForm.pending__), ob alle asynchronen Validierungsfunktionen eine Antwort erhalten haben

### Diskussion

Eine asynchrone Validierungsfunktion ist sehr ähnlich zu einer synchronen Validierungsfunktion, wie wir sie im Rezept "[MDF: Eigene Validatoren definieren](#c04-custom-validation)" gesehen haben.
Beide Funktionen erhalten eine Instanz der FormControl-Klasse als Funktionsparameter.
Beide signalisieren die Gültigkeit des Eingabefelds, indem sie __null__ und die Ungültigkeit des Eingabefelds, indem sie ein Objekt zurückgeben.
Zwischen synchronen und asynchronen Validierungsfunktionen gibt es aber auch Unterschiede.
Wir nutzen den dritten Parameter der control-Methode für asynchrone Validierungsfunktionen.
Um mehrere asynchrone Validierungsfunktionen für ein Control zu definieren, müssen wir die composeAsync-Methode anstelle der compose-Methode nutzen.
Asynchrone Validierungsfunktionen liefern ein Promise (oder ein Observable) als Rückgabewert zurück. Die Gültigkeit wird durch den Aufruf der resolve-Funktion angegeben.

Asynchrone Validierungsfunktionen besitzen noch weitere Besonderheiten.
Sie werden nur dann aufgerufen, wenn das Eingabefeld nach dem Aufruf der synchronen Validierungsfunktionen gültig ist.
Wenn es ungültig ist, werden die asynchronen Validierungsfunktionen nicht aufgerufen.
Da wir auf die asynchronen Funktionen warten müssen, bevor wir die Gültigkeit des Eingabefelds und des Formulars prüfen können, wird von Angular die pending-Eigenschaft des FormControls und des Formulars auf __true__ gesetzt, bis wir eine Antwort erhalten haben.
Wir haben im Code bereits gesehen (Zeile 38), wie wir die pending-Eigenschaft nutzen können.

Es ist vermutlich bekannt, dass Promises zwei Funktionen besitzen:
die resolve- und die reject-Funktion.
Asynchrone Validierungsfunktionen benötigen die reject-Funktion nicht.
Im Gegenteil, wenn wir "reject" nutzen, wird die pending-Eigenschaft __true__ bleiben bis die resolve-Funktion aufgerufen wird.
Es ist also wichtig, dass wir Fehler in der Validierungsfunktion abfangen und in der Fehlerbehandlungsroutine die resolve-Funktion aufrufen.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/09-Custom_Async_Validation)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/09-Custom_Async_Validation/index.html)

### Weitere Ressourcen

* Weitere Informationen über [Promises](https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Global_Objects/Promise) auf der Mozilla Developer Network Webseite

## MDF: Abhängige Eingabefelder validieren

### Problem

Ich möchte sicherstellen, dass zwei voneinander abhängige Eingabefelder den gleichen Wert beinhalten. Z. B. ein Passwort und ein Passwort wiederholen Feld.

### Zutaten

* [MDF: Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* [Teile der View konditional Anzeigen mit NgIf](#c03-ngif)
* Die FormGroupName-Direktive von Angular-Forms
* Anpassungen an der app.component.ts-Datei
* Eine Validierungsfunktion, die überprüft, ob zwei Felder den gleichen Wert beinhalten

### Lösung

Wie werden hier eine Validierungsfunktion definieren, die zwei Eingabefelder gleichzeitig validieren kann.
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

* Zeilen 15 und 18: Hier sagen wir Angular, dass die zwei Password-Eingabefelder zu der "FormGroup" mit Name "passwords" gehören
* Zeilen 21-23: Hier nutzen wir die Bedingung __myForm.controls.passwords.hasError('passwordsNotEqual')__. Damit fragen wir die FormGroup, ob sie einen Fehler namens "passwordsNotEqual" hat. Wenn die zwei Eingabefelder der FormGroup nicht den gleichen Wert haben, wird die Bedingung __true__ sein
* Zeilen 34-49: Definition einer "FormGroup" namens "passwords"
  * Zeilen 35-39: Die Controls der FormGroup
  * Zeilen 41-48: Unsere Validierungsfunktion

### Diskussion

Ein Formular in Angular ist eine "FormGroup" und kann nebst Controls auch weiter FormGroups beinhalten, die wiederum Controls und weitere FormGroups beinhalten können.
In unserem Beispiel haben wir eine FormGroup namens "passwords" definiert, die zwei Controls hat.
Das password- und das passwordRepeat-Control.
Diese FormGroup ist nur dann gültig (valid-Eigenschaft is __true__), wenn die jeweilige Controls gültig sind und, wenn die Validierungsfunktionen der Gruppe __null__ zurückliefern.
Darum nutzen wir __myForm.controls.passwords.hasError('passwordsNotEqual')__ und nicht einfach __myForm.controls.passwords.invalid__ als Bedingung für die NgIf-Direktive.
Alternativ hätten wir auch das errors-Objekt (__myForm.controls.passwords.errors?.passwordsNotEqual__) nutzen können, wie wir es in anderen Rezepten auch getan haben.

Der zweite Parameter der group-Methode (Zeilen 40-49) bekommt ein Objekt mit zwei optionale Eigenschaft.
Die eine Eigenschaft hat den Namen "validator", diese ist die Eigenschaft, die wir auch hier nutzen.
Die andere Eigenschaft hat den Namen "asyncValidator" und wird benutzt, wenn wir für eine FormGroup asynchrone Validierungsfunktionen definieren möchten.
Wichtig ist, dass beide Eigenschaften eine Funktion als Wert haben.
Falls wir mehrere synchrone bzw. asynchrone Validierungsfunktionen brauchen, müssen wir die compose- bzw. die composeAsync-Methode nutzen wie im Rezept "[MDF: Eigene Validatoren definieren](#c04-custom-validation)" gezeigt wird.
Da wird nur das Beispiel mit der compose-Methode gezeigt.
Die composeAsync-Methode funktioniert analog.

In den meisten MDF-Rezepten dieses Buches, war das value-Objekt des Formulars flach.
Es hatte eine Eigenschaft für jedes Control.
Auch in diesem Rezept hat das value-Objekt eine Eigenschaft für jedes Control allerdings sind die Werte für "password" und "passwordRepeat" verschachtelt.
Diese befinden sich in einem Objekt namens "passwords".
Das heißt, dass das value-Objekt die Struktur des Formulars hat, wie wir diese über den FormBuilder definiert haben.
Je nachdem was der Server von uns erwartet, müssen wir Werte, die sich in Untergruppen befinden herausziehen und diese auf der höchste Ebene definieren.
Das value-Objekt sieht in diesem Rezept so aus:

```
{
  username: "Wert im Eingabefeld"
  passwords: {
    password: "Wert im Eingabefeld",
    passwordRepeat: "Wert im Eingabefeld"
  }
}
```

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/10-Validate_Multiple_Fields)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/10-Validate_Multiple_Fields/index.html)

### Weitere Ressourcen

* Offizielle [FormGroupName](https://angular.io/docs/ts/latest/api/forms/index/FormGroupName-directive.html)-Dokumentation auf der Angular 2 Webseite

