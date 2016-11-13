## Code ausführen bei der Zerstörung (destroy) einer Komponente {#c07-on-destroy}

### Problem

Ich möchte informiert werden bevor eine Komponente von Angular zerstört wird, so dass ich z. B. die unsubscribe-Methode von einem Observable aufrufen kann.

### Zutaten

* [Eine Komponente definieren](#c02-component-definition)
* OnDestroy-Hook von Angular-Core
* Anpassungen an der second.component.ts-Datei

### Lösung

{title="app.component.ts", lang=js}
```
import { Component, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-second',
  template: '<div>My Name is ...</div>'
})
export class SecondComponent implements OnDestroy {
  ngOnDestroy() {
    console.log('Destroy');
  }
}
```

__Erklärung__:

* Zeile 7: Hier nutzen wir das OnDestroy-Interface und sagen, dass unsere Komponente dieses Interface implementiert
* Zeilen 8-10: Die ngOnDestroy-Methode wird bei der Zerstörung der Komponente von Angular aufgerufen. Sie ist Teil des OnDestroy-Interfaces

### Diskussion

Angular bietet uns sogenannte "Lifecycle Hooks" an.
Diese sind Methoden, die unsere Komponente implementieren kann und werden automatisch zu bestimmten Zeitpunkten von Angular aufgerufen.
Der OnDestroy-Hook, den wir hier nutzen wird z. B. aufgerufen, wenn die Komponente aus dem DOM entfernt wird.
Der `implements OnDestroy` Teil ist eigentlich optional, es wird aber empfohlen diesen zu nutzen, weil dann der Compiler eine Fehlermeldung ausgeben kann, falls wir den Namen der Methode falsch schreiben.

Die ngOnDestroy-Methode ist der ideale Ort, um Cleanup-Code zu schreiben.
Z. B. können wir hier eigene Callback-Funktionen entfernen, um Memory-Leaks zu vermeiden.
Hier haben wir nur den Code für die SecondComponent gezeigt.
Im Beispiel-Code auf Github wird auch die app.component.ts-Datei angepasst, so dass diese die SecondComponent aus dem DOM entfernen kann, damit die ngOnDestroy-Methode auch aufgerufen wird.

### Code

Code auf Github [07-Component\_Recipes/07-Execute\_Code\_on\_Component\_Destroy](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/07-Execute_Code_on_Component_Destroy)

### Weitere Ressourcen

* Mehr Informationen über [Lifecycle Hooks](https://angular.io/docs/ts/latest/guide/lifecycle-hooks.html) gibt es auf der Angular 2 Webseite

