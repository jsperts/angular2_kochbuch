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

Code auf Github: [04-Form\_Recipes/01-Simple\_Form](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/01-Simple_Form)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/01-Simple_Form/index.html)

### Weitere Ressourcen

* Offizielle [NgModel](https://angular.io/docs/ts/latest/api/forms/index/NgModel-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [NgForm](https://angular.io/docs/ts/latest/api/forms/index/NgForm-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Event-, Eigenschafts- und beidseitigen Bindungen gibt es in [Appendix A: Template-Syntax](#appendix-a)

