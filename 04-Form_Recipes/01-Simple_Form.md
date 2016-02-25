## Ein einfaches Formular implementieren {#c04-simple-form}

### Problem

Ich möchte Daten vom Benutzer bekommen und dafür brauche ich ein einfaches Formular.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* NgModel-Direktive
* NgForm-Direktive mit dem ngSubmit-Event

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
  * Zeile 10: Eingabefeld für den Benutzernamen. Hier nutzen wir die NgModel-Direktive, um die View mit den Daten (dem Modell) der Komponente zu verbinden. Konkreter, reden wir hier von einer beidseitige-Bindung zwischen den Wert des Eingabefeldes und der username-Eigenschaft des user-Objekts (siehe Zeile 18-21)
  * Zeile 12: Ähnlich wie Zeile 10 aber für das Passwort-Feld
* Zeile 18-21: Ein Objekt wo die Daten, die der Nutzer in das Formular eingibt gespeichert werden. Die leere Strings für die Eigenschaften "username" und "password", sind die Default-Werte für unsere Eingabefelder
* Zeile 24-26: Methode die Aufgerufen wird, wenn der Nutzer ein submit-Event auslöst (siehe auch Zeile 8) z. B. durch ein Klick auf den Button

### Diskussion

Jedes form-Tag bekommt automatisch eine Instanz der NgForm-Direktive.
Ein Formular hat von sich aus kein ngSubmit-Event, sondern ein submit-Event.
Da aber unser Formular auch eine Instanz der NgForm-Direktive ist, haben wir Zugriff auf das ngSubmit-Event der Direktive.
Das ngSubmit-Event ist also eine output-Eigenschaft der NgForm-Direktive.
Im Grunde genommen bindet die NgForm-Direktive, das submit-Event des Formulars und leitet es an das ngSubmit-Event weiter.
Wir hätten in unserem Code auch direkt das submit-Event nutzen können.

Wie schon erwähnt nutzen wir in den Zeilen 10 und 12 eine beidseitige-Bindung.
Wir hätten die beidseitige-Bindung auch in eine Eigenschafts- und eine Event-Bindung aufspalten können.
Wie das aussieht wird in Appendix A gezeigt.
Da die Nutzung der beidseitige-Bindung einfacher ist, werden wir sie auch in weiteren Formular-Rezepten nutzen.

### Code

Code auf Github: [04-Form\_Recipes/01-Simple\_Form](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/01-Simple_Form)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/01-Simple_Form/index.html)

### Weitere Ressourcen

* Offizielle [NgModel](https://angular.io/docs/ts/latest/api/common/NgModel-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgForm](https://angular.io/docs/ts/latest/api/common/NgForm-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Event-, Eigenschafts- und beidseitige-Bindung gibt es im [Appendix A: Template-Syntax](#appendix-a)

