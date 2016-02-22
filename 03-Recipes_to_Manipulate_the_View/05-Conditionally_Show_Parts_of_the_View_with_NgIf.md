## Teile der View konditional anzeigen mit NgIf {#c03-ngif}

### Problem

Ich möchte teile der View nur dann anzeigen, wenn eine bestimmte Kondition erfüllt ist.

### Zutaten
* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Die NgIf-Direktive von Angular
* Eine Instanzeigenschaft vom Typ "boolean"

### Lösung

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@View({
  template: `
    <div>Hello world!</div>
    <div *ngIf="isConditionTrue">
      <p>The condition is true, so I can show myself</p>
    </div>
  `
})
class MyApp {
  isConditionTrue: boolean;
  constructor() {
    this.isConditionTrue = true;
  }
}

...
```

Erklärung:

* Zeile 6: Nutzung der NgIf-Direktive, um den div-Tag nur dann im DOM zu haben, wenn __isConditionTrue__ den Wert __true__ hat
* Zeile 12: Definition der isConditionTrue-Eigenschaft mit Typ "boolean"
* Zeile 14: Standardmäßig soll die isConditionTrue-Eigenschaft den Wert __true__ haben (div-Tag ist im DOM)

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes für die isConditionTrue-Eigenschaft verzichtet. Im Github Code-Beispiel wird gezeigt wie man mittels "click" den Wert verändern können. Da können wir auch sehen wie sich die View verändert je nachdem, ob __isConditionTrue__ den Wert __true__ oder __false__ hat.

Es gibt noch weiter mögliche Schreibweisen für das konditionale Anzeigen Teile der View mittels NgIf. Die hier ist die kürzeste und vermutlich die einfachste. Weitere Schreibweisen sind im Github Code-Beispiel zu finden. Von der Funktionalität her sind alle Varianten gleich.

#### Erklärung zu der ngIf-Syntax:

Der Stern (\*) vor dem __ngIf__ ist essentiell und Teil der Syntax. Er zeigt an, dass der div-Tag und alle Elemente, die der Tag beinhaltet, als Template für das ngIf benutzt werden sollen. Nach "\*ngIf=" kommt ein Angular-Template-Ausdruck, der die Kondition angibt. Wenn die Evaluation des Ausdruckes __true__ zurückgibt, ist die Kondition wahr und das Template wird angezeigt. Andernfalls wird das Template aus dem DOM entfernt. Wir haben hier ein sehr einfachen Ausdruck benutzt. Wir hätten auch einen komplexeren Ausdruck nutzen können z. B. einen der ein Vergleich mit __===__ beinhaltet.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/05-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgIf](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgIf)

### Weitere Ressourcen

* Offizielle [NgIf](https://angular.io/docs/ts/latest/api/common/NgIf-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zur Template-Ausdrücke gibt es in [Appendix A: Template-Syntax](#appendix-a)

