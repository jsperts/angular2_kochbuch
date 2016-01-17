## Ein einfaches Formular implementieren

### Problem

Ich möchte ein einfaches Formular implementieren, um Daten vom Benutzer zu bekommen.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* NgModel-Direktive
* NgSubmit-Event (Teil der NgForm-Direktive)

### Lösung

{title="component.ts", lang=js}
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
Da die Nutzung der beidseitige-Bindung einfacher ist, werden wir sie auch in weitere Formular-Rezepte nutzen.

### Code

Code auf Github: [04-Form\_Recipes/01-Simple\_Form](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/01-Simple_Form)

### Weitere Ressourcen

* Offizielle [NgModel](https://angular.io/docs/ts/latest/api/common/NgModel-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgForm](https://angular.io/docs/ts/latest/api/common/NgForm-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Event-, Eigenschafts und beidseitige-Bindung gibt es im [Appendix A: Template-Syntax](#appendix-a)

