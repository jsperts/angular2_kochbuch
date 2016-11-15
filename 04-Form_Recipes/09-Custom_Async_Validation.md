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

