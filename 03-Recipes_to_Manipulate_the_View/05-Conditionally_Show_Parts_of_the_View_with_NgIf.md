## Teile der View konditional mit NgIf anzeigen {#c03-ngif}

### Problem

Ich möchte Teile der View nur dann anzeigen, wenn eine bestimmte Bedingung erfüllt ist.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Die NgIf-Direktive von Angular
* Eine Eigenschaft vom Typ "boolean"

### Lösung

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <div>Hello World!</div>
    <div *ngIf="showName">
      <p>My name is Max</p>
    </div>
  `
})
export class AppComponent {
  showName: boolean;

  constructor() {
    this.showName = true;
  }
}
```

__Erklärung__:

* Zeile 7: Nutzung der NgIf-Direktiven, um den div-Tag nur dann im DOM zu haben, wenn "showName" den Wert __true__ hat
* Zeile 13: Definition der showName-Eigenschaft mit Typ "boolean"
* Zeile 16: Standardmäßig soll die showName-Eigenschaft den Wert __true__ besitzen (div-Tag ist im DOM)

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes der showName-Eigenschaft verzichtet.
Im Github Code-Beispiel wird gezeigt wie wir mittels "click" den Wert verändern können.
Dort können wir auch sehen, wie sich die View verändert, je nachdem, ob "showName" den Wert __true__ oder __false__ hat.

Es gibt noch weitere mögliche Schreibweisen für das konditionale Anzeigen von Teilen der View mittels der NgIf-Direktive.
Die hier verwendete ist die kürzeste und vermutlich die einfachste.
Weitere Schreibweisen sind im Github Code-Beispiel zu finden.
Von der Funktionalität her sind alle Varianten gleich.

#### Erklärung zu der ngIf-Syntax

Der Stern (__\*__) vor dem __ngIf__ ist essentiell und Teil der Syntax.
Er zeigt an, dass der div-Tag und alle Elemente, die der Tag beinhaltet, als Template für die Instanz der NgIf-Direktiven benutzt werden sollen.
Nach __\*ngIf=__ kommt ein Angular-Template-Ausdruck, der die Bedingung angibt.
Wenn die Evaluation des Ausdruckes __true__ zurückgibt, ist die Bedingung wahr und das Template wird angezeigt.
Andernfalls wird das Template aus dem DOM entfernt.
Wir haben hier einen sehr einfachen Ausdruck benutzt.
Wir hätten auch einen komplexeren Ausdruck nutzen können, z. B. einen, der einen Vergleich mit __===__ beinhaltet.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/05-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgIf](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgIf)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgIf/index.html)

### Weitere Ressourcen

* Offizielle [NgIf](https://angular.io/docs/ts/latest/api/common/index/NgIf-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zu Template-Ausdrücken gibt es in [Appendix A: Template-Syntax](#appendix-a)

