## Code ausführen bei der Initialisierung einer Komponente {#c07-on-init}

### Problem

Ich möchte bei der Initialisierung meiner Komponente Code ausführen z. B. um Daten vom Server zu holen.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* OnInit-Hook von Angular-Core
* Anpassungen an der app.component.ts-Datei

### Lösung

{title="app.component.ts", lang=js}
```
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-root',
  template: '<div>Hello World!</div>'
})
export class AppComponent implements OnInit {
  ngOnInit() {
    console.log('Initialization');
  }
}
```

__Erklärung__:

* Zeile 7: Hier nutzen wir das OnInit-Interface und sagen, dass unsere Komponente dieses Interface implementiert
* Zeilen 8-10: Die ngOnInit-Methode wird bei der Initialisierung der Komponente von Angular aufgerufen. Sie ist Teil des OnInit-Interfaces

### Diskussion

Angular bietet uns sogenannte "Lifecycle Hooks" an.
Diese sind Methoden, die unsere Komponente implementieren kann und werden automatisch zu bestimmten Zeitpunkten von Angular aufgerufen.
Der OnInit-Hook, den wir hier nutzen wird bei der Initialisierung der Komponente, nach der Konstruktorfunktion aufgerufen.
Der `implements OnInit` Teil ist eigentlich optional, es wird aber empfohlen diesen zu nutzen, weil dann der Compiler eine Fehlermeldung ausgeben kann, falls wir den Namen der Methode falsch schreiben.

#### OnInit vs. Konstruktorfunktion

Auf den ersten Blick könnte man meinen, dass die zwei äquivalent sind bzw. dass wir Initialisierungscode genau so gut in den Konstruktor schreiben können.
Das stimmt nur bedingt.

Die Nutzung von __ngOnInit__ hat gewisse Vorteile.
Als Erstes ist es einfacher Unit-Tests dafür zu schreiben, weil wir da besser den Zeitpunkt des Aufrufs kontrollieren können.
Die Konstruktorfunktion wird bei Unit-Tests meistens von Angular automatisch aufgerufen.
Die ngOnInit-Methode hingegen nicht.

Ein weiterer Vorteil von __ngOnInit__ ist, dass diese Methode erst dann aufgerufen wird nach dem die Eigenschaft-Bindungen (@Input) der Komponente ihre Werte erhalten haben.
In der Konstruktorfunktion sind die Eigenschaft-Bindungen noch __undefined__.
Wenn wir also Zugriff auf Werte von Eigenschaft-Bindungen brauchen, müssen wir __ngOnInit__ nutzen.

Im Allgemeinen wird empfohlen den OnInit-Hook für Initialisierungscode und die Konstruktorfunktion für Dependency Injection zu nutzen.

### Code

Code auf Github [07-Component\_Recipes/06-Execute\_Code\_on\_Component\_Init](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/06-Execute_Code_on_Component_Init)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/06-Execute_Code_on_Component_Init/index.html)

### Weitere Ressourcen

* Mehr Informationen über [Lifecycle Hooks](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html) gibt es auf der Angular 2 Webseite

