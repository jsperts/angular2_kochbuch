## Teile der View konditional anzeigen mit NgSwitch

### Problem

Ich möchte unterschiedliche Teile der View anzeigen je nach Wert eines Angular-Ausdrucks.

### Zutaten
* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Die NgSwitch-Direktive von Angular
* Die NgSwitchWhen-Direktive von Angular
* Die NgSwitchDefault-Direktive von Angular

### Lösung

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@View({
  template: `
    <div [ngSwitch]="color">
      <p>What color are you?</p>
      <p *ngSwitchWhen="'blue'">I am blue</p>
      <p *ngSwitchWhen="'red'">I am red</p>
      <p *ngSwitchDefault>Color not known</p>
    </div>
  `
})
class MyApp {
  color: string;

  constructor() {
    this.color = 'blue';
  }
}

...
```

Erklärung:

* Zeile 5: Nutzung der NgSwitch-Direktive mit der color-Eigenschaft der Komponente
* Zeile 6-9: Inhalt der NgSwitch-Direktive
  * Zeile 6: Wird immer angezeigt egal was der Wert von "color" ist
  * Zeile 7: Wird nur dann angezeigt, wenn "color" den Wert __'blue'__ hat
  * Zeile 8: Wird nur dann angezeigt, wenn "color" den Wert __'red'__ hat
  * Zeile 9: Wird nur dann angezeigt, wenn "color" irgend ein Wert außer __'blue'__ und __'red'__ hat
* Zeile 17: Standardmäßig ist der Wert von "color" __'blue'__

### Diskussion

Die NgSwitch-Direktive ist vergleichbar mit eine JavaScript switch-Anweisung.
Bei der Nutzung im Template bekommt sie über __ngSwitch__ (input-Eigenschaft der NgSwitch-Direktive) einen Angular-Template-Ausdruck der dann ausgewertet wird.
In unserem Beispiel besteht der Ausdruck aus der color-Eigenschaft.
Diese Auswertung wird dann mit jedem Ausdruck der NgSwitchWhen-Direktiven verglichen.
Angular nutzt für den Vergleich __===__.
In unserem Beispiel haben wir __'blue'__ und __'red'__ als Ausdrücke für NgSwitchWhen benutzt.
Wenn der Vergleich den Wert __true__ zurück gibt, wird der Tag mit der Direktive und desen Inhalt in der View angezeigt.
Wenn kein Vergleich __true__ zurück gibt, wird der Tag mit der NgSwitchDefault-Direktive und desen Inhalt angezeigt.
Tags die weder eine NgSwitchWhen- noch eine NgSwitchDefault-Direktive nutzen werden immer angezeigt.

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes für die color-Eigenschaft verzichtet. Im Github Code-Beispiel wird gezeigt wie man mittels "click" den Wert verändern können. Da können wir auch sehen wie sich die View verändert je nachdem, was für ein Wert die color-Eigenschaft hat.

Es gibt noch eine weitere mögliche Schreibweise für die NgSwitchWhen- und NgSwitchDefault-Direktiven. Die hier ist die kürzeste und vermutlich die einfachste. Die zweite Schreibweise ist im Github Code-Beispiel zu finden. Von der Funktionalität her sind beide Schreibweisen gleich.

#### Erklärung zu der ngSwitchWhen- und ngSwitchDefault-Syntax

Der Stern (\*) vor dem __ngSwitchWhen__ und __ngSwitchDefault__ ist essentiell und Teil der Syntax. Er zeigt an, dass die p-Tags und alle Elemente, die die Tags beinhalten, als Template für die jeweilige Instanz der NgSwitchWhen bzw. der NgSwitchDefault-Direktiven benutzt werden sollen.
Nach "\*ngSwitchWhen=" kommt ein Angular-Template-Ausdruck.
Dieser Ausdruck verglichen mit der Auswertung des NgSwitch-Ausdruckes gibt an, wann das Template angezeigt werden soll.
Wenn der Vergleich __true__ ergibt, wird das Template in der View angezeigt.
Wenn der __false__ ergibt, wird das Template aus dem DOM entfernt.
Das NgSwitchDefault-Template wird nur dann angezeigt, wenn alle Vergleiche __false__ ergeben.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/06-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgSwitch](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgSwitch)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/06-Conditionally_Show_Parts_of_the_View_with_NgSwitch/index.html)

### Weitere Ressourcen

* Offizielle [NgSwitch](https://angular.io/docs/ts/latest/api/common/NgSwitch-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchWhen](https://angular.io/docs/ts/latest/api/common/NgSwitchWhen-directive.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchDefault](https://angular.io/docs/ts/latest/api/common/NgSwitchDefault-directive.html) Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zur Template-Ausdrücke gibt es in [Appendix A: Template-Syntax](#appendix-a)

