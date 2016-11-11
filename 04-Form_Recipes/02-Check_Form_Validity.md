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
Dadurch wird das Submit-Event unterbunden, wenn nicht alle Formular-Felder gültig sind.

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
      <button type="submit" [disabled]="!form.valid">Submit</button>
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
* Zeile 16: Hier binden wir die disabled-Eigenschaft an den Ausdruck __!form.valid__. Wenn das Formular ungültig ist, wird der Button deaktiviert sein

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

Wie schon im Rezept "[Ein einfaches Formular implementieren](#c04-simple-form)" erwähnt, erhält jedes form-Tag eine Instanz der NgForm-Direktive.
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

Code auf Github für die erste Lösung: [04-Form\_Recipes/04-Check\_Form\_Validity\_in\_Template/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-01)

Live Demo der ersten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-01/index.html)

Code auf Github für die zweite Lösung: [04-Form\_Recipes/04-Check\_Form\_Validity\_in\_Template/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/04-Form_Recipes/04-Check_Form_Validity_in_Template/Solution-02)

Live Demo der zweiten Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/04-Form_Recipes/02-Check_Form_Validity/Solution-02/index.html)

### Weitere Ressourcen

* Weitere Informationen zu lokalen Variablen und zur exportAs-Eigenschaft gibt es in [Appendix A: Template-Syntax](#appendix-a)

