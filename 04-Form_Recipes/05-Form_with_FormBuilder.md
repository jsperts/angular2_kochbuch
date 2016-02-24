## Formular mit dem FormBuilder implementieren {#c04-formbuilder}

### Problem

Ich möchte, dass sich die Logik für mein Formular in der Klasse der Komponente befindet. Somit ist mein Template nicht überladen und ich kann auch die Logik besser Testen.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* HTML für ein Formular
* Den FormBuilder-Service von Angular
* Die NgControlName-Direktive von Angular
* Die NgFormModel-Direktive von Angular

### Lösung

Wir nutzen hier ein "Model Driven" Formular. Wir definieren das Modell für das Formular und dessen Controls in der Klasse der Komponente.
Im Template nutzen wir den form-Tag und input-Tags die wir mit Hilfe von der NgControlName- und der NgFormModel-Direktive mit dem Modell in der Klasse verbinden.

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';
import {FormBuilder, ControlGroup} from 'angular2/common';

@Component({
  selector: 'my-app'
})
@View({
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
class MyApp {
  form: ControlGroup;
  constructor(builder: FormBuilder) {
    this.form = builder.group({
      username: builder.control(''),
      password: builder.control('')
    })
  }

  onSubmit() {
    console.log(this.form.value)
  }
}

export default MyApp;
```

Erklärung:

* Zeile 2: Hier importieren wir unsere Abhängigkeiten die wir in der Klasse benötigen
* Zeilen 9-15: Das HTML für unser Formular
  * Zeile 9: Nutzung der NgFormModel-Direktive. Damit verbinden wir das Formular in der Klasse (Zeile 21), mit dem Formular im DOM. Das __ngSubmit__ wird in [Ein einfaches Formular implementieren](#c04-simple-form) erklärt
  * Zeile 11: Nutzung der NgControlName-Direktive (__ngControl__). Damit verbinden wir das username-Control in der Klasse (Zeile 22), mit dem Eingabefeld im DOM
  * Zeile 13: Nutzung der NgControlName-Direktive. Damit verbinden wir das password-Control in der Klasse (Zeile 23), mit dem Eingabefeld im DOM
* Zeile 19: Typdefinition für die form-Eigenschaft
* Zeile 20: Konstruktor der Klasse mit eine Instanz des FormBuilder-Services als Parameter
* Zeilen 21-24: Das Modell für unser Formular
  * Zeile 21: Hier rufen wir die group-Methode auf die eine Instanz der ControlGroup-Klasse erzeugt
  * Zeile 22: Hier rufen wir die control-Methode auf die eine Instanz der Control-Klasse erzeugt. Default-Wert für das Eingabefeld wird ein leerer String sein
  * Zeile 23: Gleiches wie oben aber für das Passwort-Feld
* Zeile 28: Hier greifen wir auf die Werte die sich im Formular befinden

### Diskussion

Der FormBuilder ist ein Service (im Grunde genommen eine Klasse) den Angular uns zur Verfügung stellt.
Dieser Service erlaubt es uns mit relativ wenig Code komplexe Formulare zu definieren.
Wie schon erwähnt, arbeiten wir hier mit "Model Driven Forms".
Das Modell für das Formular wird in der Klasse definiert und dann an den DOM gebunden.
Mit __[ngFormModel]="form"__ binden wir das Modell an das DOM-Formular an.
Ohne diese Bindung würde Angular für das Formular eine neue Instanz der NgForm-Direktive erzeugen und wir hätten keine Verbindung zu unserem Modell.
Da ein Formular nutzlos ist ohne Eingabefelder, haben wir bei Aufruf der group-Methode ein Objekt mit zwei Controls übergeben.
Die Eigenschaftsnamen im Objekt definieren die Namen der Controls (hier "username" und "password") und die Werte sind Instanzen der Control-Klasse.
Natürlich müssen wir unsere Controls auch an die eigentlichen Eingabefelder im DOM binden.
Dies tun wir mit Hilfe der NgControlName-Direktive.
Da wir hier die NgFormModel- statt der NgForm-Direktive nutzen werden mit __ngControl__ keine neue Controls erzeugt.
Der Namen den wir mit __ngControl="controlName"__ übergeben referenziert ein existierendes Control in unserem Modell.
Hier referenziert __ngControl="username"__ in Zeile 11, das Control in Zeile 21.

Natürlich wollen wir auch Zugriff auf die Daten, die der Nutzer in das Formular eingegeben hat.
Im Rezept [Ein einfaches Formular implementieren](#c04-simple-form) haben wir dafür die NgModel-Direktive mit einem Objekt in der Klasse benutzt.
Da wir hier die NgModel-Direktive nicht nutzen, brauchen wie einen anderen Weg, um auf die Daten zuzugreifen.
Zum Glück beinhaltet auch unser Formular-Modell alle Daten die in die jeweiligen Eingabefelder geschrieben worden sind.
Die Daten befinden sich in der value-Eigenschaft des Formular-Modells.
Diese Eigenschaft ist ein Objekt und beinhaltet alle Eingabefelder.
Das value-Objekt hat als Eigenschaftsnamen die Namen der Controls die wir im Formular-Modell definiert haben.
Die Werte sind dann das was der Nutzer in den Eingabefeldern geschrieben hat.
In unserem Beispiel besteht das value-Objekt aus zwei Eigenschaften mit Namen "username" und "password".

Wenn wir dieses Rezept mit dem [Ein einfaches Formular implementieren](#c04-simple-form) Rezept vergleichen, sehen wir, dass das Endresultat gleich ist.
Beide Formulare haben zwei Eingabefelder und bei Submit greifen wir auf die Daten, die der Nutzer im Formular eingegeben hat.
Der Unterschied zwischen den beiden Rezepten ist der Weg den wir gewählt haben, um das Problem zu lösen.

Ein Detail hatten wir bis jetzt ignoriert.
Wie wusste Angular überhaupt, dass wir den FormBuilder-Service brauchten?
Anhand der Typinformation die wir bei der Parameterdefinition im Konstruktor gegeben haben und mittels Dependency Injection (DI) kann Angular uns eine Instanz eines Services bei der Initialisierung der Komponente übergeben.
Die Typinformation befindet sich auf Zeile 20 und ist der Teil nach dem Doppelpunkt.
Wir haben __builder: FormBuilder__ geschrieben. In diesem Fall ist "builder" der Parameternamen und "FormBuilder" die Typinformation.
Mit Hilfe des Typs schaut Angular welche Services zur Verfügung stehen und gibt uns zurück eine Instanz mit dem richtigen Typ.
Dependency Injection in Angular und Services ist ein relativ komplexes Thema und eine vollständige Erklärung würde den Rahmen eines Rezeptes sprengen.
Wer mehr über dieses Thema lesen möchte, kann einige Informationen auf der Angular 2 Webseite finden.

### Code

Code auf Github: [04-Form\_Recipes/05-Form\_with\_FormBuilder](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/05-Form_with_FormBuilder)

### Weitere Ressourcen

* Offizielle [FormBuilder](https://angular.io/docs/ts/latest/api/common/FormBuilder-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [Control](https://angular.io/docs/ts/latest/api/common/Control-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [ControlGroup](https://angular.io/docs/ts/latest/api/common/ControlGroup-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgFormModel](https://angular.io/docs/ts/latest/api/common/NgFormModel-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgControlName](https://angular.io/docs/ts/latest/api/common/NgControlName-directive.html) Dokumentation auf der Angular 2 Webseite
* Weiter Informationen zur [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html) gibt es auf der Angular 2 Webseite

