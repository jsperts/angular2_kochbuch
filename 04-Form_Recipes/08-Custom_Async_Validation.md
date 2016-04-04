## Eigene asynchrone Validatoren definieren

### Problem

Ich möchte überprüfen, ob der gegebene Benutzername schon existiert. Dafür muss ich den Server kontaktieren und auf die Antwort warten bevor ich weiß, ob das Eingabefeld gültig oder ungültig ist.

### Zutaten
* [Formular mit dem FormBuilder und Validierung](#c04-formbuilder-validation)
* Validierungs-Funktion die asynchron überprüft, ob ein Benutzername schon existiert
* Anpassungen an der Komponente von "Formular mit dem FormBuilder und Validierung"

### Lösung

Um die Lösung möglichst einfach zu halten, werden wir die Server-Anfrage mit einem Timeout simulieren. Für eine echte Server-Anfrage brauchen wir einen Server, der auf die Anfrage antworten kann und Code, der die Anfrage schicken kann.

{title="Ausschnitt aus einer Komponente", lang=js}
```
import {Component} from 'angular2/core';
import {
    FormBuilder,
    ControlGroup,
    Validators,
    Control
} from 'angular2/common';

...

class MyApp {
  form:ControlGroup;

  constructor(builder:FormBuilder) {
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
      console.log(this.form.value)
    }
  }
}

...
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

