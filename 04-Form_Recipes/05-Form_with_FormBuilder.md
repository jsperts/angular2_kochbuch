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
  * Zeile 7: Nutzung der FormGroupDirective-Direktiven (__formGroup__). Damit verbinden wir das Formular in der Klasse (Zeile 21) mit dem Formular im DOM. __ngSubmit__ wird im Rezept "[Ein einfaches Formular implementieren](#c04-simple-form)" erklärt
  * Zeile 9: Nutzung der FormControlName-Direktiven. Damit verbinden wir das username-Control in der Klasse (Zeile 22) mit dem Eingabefeld im DOM
  * Zeile 11: Nutzung der FormControlName-Direktiven. Damit verbinden wir das password-Control in der Klasse (Zeile 23) mit dem Eingabefeld im DOM
* Zeile 19: Typdefinition für die form-Eigenschaft
* Zeile 20: Konstruktor der Klasse mit einer Instanz des FormBuilder-Services als Parameter
* Zeilen 21-24: Das Modell für unser Formular
  * Zeile 21: Hier rufen wir die group-Methode auf, die eine Instanz der FormGroup-Klasse erzeugt
  * Zeile 22: Hier rufen wir die control-Methode auf, die eine Instanz der FormControl-Klasse erzeugt. Der default-Wert des Eingabefelds ist ein leerer String
  * Zeile 23: Gleiches wie oben, aber für das Passwort-Feld
* Zeile 28: Hier greifen wir auf die Werte zu, die sich im Formular befinden

Da sich Formular-Direktiven wie z. B. "FormGroupName" in einem eigenen Angular-Modul befinden, müssen wir dieses Modul in unser "AppModule" importieren

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

### Diskussion

FormBuilder ist ein [Service](#gl-service), den Angular uns zur Verfügung stellt.
Dieser Service erlaubt es uns, mit relativ wenig Code komplexe Formulare zu definieren.
Wie schon erwähnt, arbeiten wir hier mit "Model-Driven Forms".
Das Modell für das Formular wird in der Klasse definiert und dann an das DOM gebunden.
Mit __[formGroup]=`"`form`"`__ binden wir das Modell an das DOM-Formular an.
Ohne diese Bindung würde Angular für das Formular eine neue Instanz der NgForm-Direktive erzeugen und wir hätten keine Verbindung zu unserem Modell.
Da ein Formular ohne Eingabefelder nutzlos ist, haben wir beim Aufruf der group-Methoden ein Objekt mit zwei Controls übergeben.
Die Eigenschaftsnamen im Objekt definieren die Namen der Controls (hier "username" und "password") und die Werte sind Instanzen der FormControl-Klasse.
Natürlich müssen wir unsere Controls auch an die eigentlichen Eingabefelder im DOM binden.
Dies tun wir mit Hilfe der FormControlName-Direktiven.

Ein Detail hatten wir bis jetzt ignoriert.
Wie wusste Angular überhaupt, dass wir den FormBuilder-Service brauchten?
Anhand der Typinformation, die wir bei der Parameterdefinition im Konstruktor angegeben haben und mittels [Dependency Injection (DI)](#gl-di) kann Angular uns eine Instanz eines Services bei der Initialisierung der Komponente übergeben.
Die Typinformation befindet sich auf Zeile 20 und ist der Teil nach dem Doppelpunkt.
Wir haben __builder: FormBuilder__ geschrieben. In diesem Fall ist "builder" der Parametername und "FormBuilder" die Typinformation.
Mit Hilfe des Typs schaut Angular nach, welche Services zur Verfügung stehen und gibt uns eine Instanz mit dem richtigen Typ zurück.
Dependency Injection in Angular mit Services ist ein relativ komplexes Thema und eine vollständige Erklärung würde den Rahmen eines Rezeptes sprengen.
Wer mehr über dieses Thema lesen möchte, kann einige Informationen auf der Angular 2 Webseite finden.

Natürlich wollen wir auch Zugriff auf die Daten erhalten, die der Nutzer in das Formular eingegeben hat.
Im Rezept "[Ein einfaches Formular implementieren](#c04-simple-form)" haben wir dafür die NgModel-Direktive benutzt.
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
Die Restlichen Direktiven, Klassen und Services gehören zu den Model-Driven Formularen oder können von beiden Arten benutzt werden.

### Code

Code auf Github: [04-Form\_Recipes/05-Form\_with\_FormBuilder](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/05-Form_with_FormBuilder)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/05-Form_with_FormBuilder/index.html)

### Weitere Ressourcen

* Offizielle [FormBuilder](https://angular.io/docs/ts/latest/api/forms/index/FormBuilder-class.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormGroup](https://angular.io/docs/ts/latest/api/forms/index/FormGroup-class.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormGroupDirective](https://angular.io/docs/ts/latest/api/forms/index/FormGroupDirective-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormControl](https://angular.io/docs/ts/latest/api/forms/index/FormControl-class.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [FormControlName](https://angular.io/docs/ts/latest/api/forms/index/FormControlName-directive.html)-Dokumentation auf der Angular 2 Webseite
* Eine kurze Diskussion über Dependency Injection gibt es im Rezept [Service definieren](#c02-define-service)
* Weitere Informationen zu [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html) gibt es auf der Angular 2 Webseite

