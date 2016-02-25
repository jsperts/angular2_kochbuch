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

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@View({
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

* Zeile 5: Mit __#form="ngForm"__ definieren wir eine lokale Variable namens "form". Die Variable ist eine Referenze auf die Instanz der NgForm-Direktive für unser Formular. Wir nutzen auch das novalidate-Attribut, damit der Browser keine Fehlermeldungen für ungultige Eingabefelder anzeigt. Dies ist kein Angular-spezifisches Attribut
* Zeilen 7-9: Eingabefeld für den Benutzernamen
  * Zeile 8: Mittels __ngControl="username"__ definieren wir ein Control namens "username". Dieses Control wird dem Formular automatisch hinzugefügt
  * Zeile 9: Mittels __required__ definieren wir das Eingabefeld als Pflichtfeld
* Zeilen 11-14: Eingabefeld für das Passwort
  * Zeile 12: Mittels __ngControl="password"__ definieren wir ein Control namens "password". Dieses Control wird dem Formular automatisch hinzugefügt
  * Zeile 13: Mittels __required__ definieren wir das Eingabefeld als Pflichtfeld
  * Zeile 14: Mittels __minlength="10"__ definieren wir, dass das Passwort mindestens zehn Zeichen lang sein muss
* Zeile 15: Hier binden wir die disabled-Eigenschaft an den Ausdruck __!form.valid__. Wenn das Formular ungültig ist, wird der Button deaktiviert sein

### Lösung 2

In dieser Lösung werden wir sehen wie wir die gültigkeit des Formulars in der Klasse überprüfen können.
Wir nutzen das Formular von der ersten Lösung mit zwei Änderungen.
Als Erstes übergeben wir die lokale Variable "form" der onSubmit-Methode und als Zweites nutzen wir nicht mehr die disabled-Eigenschaft des Buttons.

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@View({
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
class MyApp {
  user = {
    username: '',
    password: ''
  };

  constructor() {}

  onSubmit(form) {
    if (form.valid) {
      console.log(this.user);
    }
  }
}
...
```

Erklärung:

* Zeile 5: Die lokale Variable "form" wird bei dem Aufruf der onSubmit-Methode übergeben
* Zeile 22: Die onSubmit-Methode hat jetzt ein Parameter namens "form"
* Zeile 23: Wir nutzen __form.valid__, um zu überprüfen, ob das Formular gültig ist

### Diskussion

Wie schon im Rezept [Ein einfaches Formular implementieren](#c04-simple-form) erwähnt, bekommt jedes form-Tag eine Instanz der NgForm-Direktive.
Diese Instanz beinhaltet verschiedene Informationen über das Formular wie z. B. dessen Gültigkeitsstatus, dessen Controls und die Werte der Eingabefelder des Formulars.
Die Direktive hat eine exportAs-Eigenschaft mit dem Wert __'ngForm'__ (ein String).
Den Wert der exportAs-Eigenschaft können wir im Template nutzen, um die Instanz der Direktive im Template zu referenzieren.

Ein Formular ist nur dann gültig, wenn alle seine Eingabefelder gültig sind.
Die NgForm-Direktive überprüft also die einzelne Eingabefelder und setzt die valid-Eigenschaft auf __true__, wenn jedes Eingabefeld gültig ist.
Damit die Direktive weiß welche Eingabefelder überprüft werden müssen, müssen die Eingabefelder als Controls definiert sein.
Wir definieren, dass ein Eingabefeld zu dem Formular gehört, indem man __ngControl="controlName"__ nutzen.
Im Hintergrund wird von Angular eine neue Instanz der NgControlName-Direktive erzeugt.
Diese Instanz registriert sich dann mit dem gegebenen Namen als Control für das Formular.
Die NgForm-Direktive wird dann für unser Control eine Instanz der Control-Klasse erzeugen.
Wir können auch Eingabefelder haben die kein __ngControl__ nutzen. Diese werden allerdings nicht bei der Validierung des Formulars mit einbezogen.

Von Haus aus unterstützt Angular derzeit drei Validierungs-Attribute:
* required,
* minlength und
* maxlength.
Vermutlich wird es mit der Zeit noch mehr eingebaute Validierungs-Attribute bzw. Validierungs-Typen wie z. B. "email" und "url" geben. Siehe hierzu Github-Issues [#2962](https://github.com/angular/angular/issues/2962) und [#2961](https://github.com/angular/angular/issues/2961).

### Code

Code auf Github für die erste Lösung: [04-Form\_Recipes/04-Check\_Form\_Validity\_in\_Template/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-01/index.html)

Code auf Github für die zweite Lösung: [04-Form\_Recipes/04-Check\_Form\_Validity\_in\_Template/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-02/index.html)

### Weitere Ressourcen

* Offizielle [NgControlName](https://angular.io/docs/ts/latest/api/common/NgControlName-directive.html) Dokumentation auf der Angular 2 Webseite
* Eine Instanz der NgForm-Direktive beinhaltet auch die Eigenschaften der [AbstractControlDirective](https://angular.io/docs/ts/latest/api/common/AbstractControlDirective-class.html)
* Weitere Informationen zu lokale Variablen und die exportAs-Eigenschaft gibt es im [Appendix A: Template-Syntax](#appendix-a)

