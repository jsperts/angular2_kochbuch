## Teile der View konditional mit NgSwitch anzeigen

### Problem

Ich möchte unterschiedliche Teile der View anzeigen, je nach Wert eines Angular-Ausdrucks.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Die NgSwitch-Direktive von Angular
* Die NgSwitchCase-Direktive von Angular
* Die NgSwitchDefault-Direktive von Angular

### Lösung

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <div [ngSwitch]="color">
      <p>What color are you?</p>
      <p *ngSwitchCase="'blue'">I am blue</p>
      <p *ngSwitchCase="'red'">I am red</p>
      <p *ngSwitchDefault>Color not known</p>
    </div>
  `
})
export class AppComponent {
  color: string;

  constructor() {
    this.color = 'blue';
  }
}
```

__Erklärung__:

* Zeile 6: Nutzung der NgSwitch-Direktive mit der color-Eigenschaft der Komponente
* Zeilen 7-10: Inhalt der NgSwitch-Direktiven
  * Zeile 7: Wird immer angezeigt unabhängig vom Wert von "color"
  * Zeile 8: Wird nur dann angezeigt, wenn "color" den Wert __`'`blue`'`__ hat
  * Zeile 9: Wird nur dann angezeigt, wenn "color" den Wert __`'`red`'`__ hat
  * Zeile 10: Wird nur dann angezeigt, wenn "color" irgendeinen Wert außer __`'`blue`'`__ und __`'`red`'`__ hat
* Zeile 18: Standardmäßig ist der Wert von "color" __`'`blue`'`__

### Diskussion

Die NgSwitch-Direktive ist vergleichbar mit einer JavaScript switch-Anweisung.
Bei der Nutzung im Template erhält sie über __ngSwitch__ ([input-Eigenschaft](#gl-input-property) der NgSwitch-Direktive) einen Angular-Template-Ausdruck, der dann ausgewertet wird.
In unserem Beispiel besteht der Ausdruck aus der color-Eigenschaft.
Diese Auswertung wird dann mit jedem Ausdruck der NgSwitchWhen-Direktiven verglichen.
Angular nutzt für den Vergleich __===__.
In unserem Beispiel haben wir __`'`blue`'`__ und __`'`red`'`__ als Ausdrücke für NgSwitchCase benutzt.
Wenn der Vergleich den Wert __true__ zurück gibt, wird der Tag mit der Direktiven und dessen Inhalt angezeigt.
Wenn kein Vergleich __true__ zurück gibt, wird der Tag mit der NgSwitchDefault-Direktiven und dessen Inhalt angezeigt.
Tags, die weder eine NgSwitchCase- noch eine NgSwitchDefault-Direktive nutzen, werden immer angezeigt.

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern des Wertes der color-Eigenschaft verzichtet.
Im Github Code-Beispiel wird gezeigt, wie wir mittels "click" den Wert verändern können.
Dort können wir auch sehen, wie sich die View in Abhängigkeit des Wertes der color-Eigenschaft verändert.

Es gibt noch eine weitere mögliche Schreibweise für die NgSwitchCase- und NgSwitchDefault-Direktiven. Diese hier ist die kürzeste und vermutlich die einfachste. Die zweite Schreibweise ist im Github Code-Beispiel zu finden. Von der Funktionalität her sind beide Schreibweisen gleich.

#### Erklärung zur ngSwitchWhen- und ngSwitchDefault-Syntax

Der Stern (__\*__) vor dem __ngSwitchWhen__ und __ngSwitchDefault__ ist essentiell und Teil der Syntax.
Er zeigt an, dass die p-Tags und alle Elemente, die die Tags beinhalten, als Template für die jeweilige Instanz der NgSwitchCase- bzw. der NgSwitchDefault-Direktiven benutzt werden sollen.
Nach __\*ngSwitchCase=__ kommt ein Angular-Template-Ausdruck.
Dieser Ausdruck verglichen mit der Auswertung des NgSwitch-Ausdrucks gibt an, wann das Template angezeigt werden soll.
Wenn der Vergleich __true__ ergibt, wird das Template angezeigt.
Wenn der __false__ ergibt, wird das Template aus dem DOM entfernt.
Das NgSwitchDefault-Template wird nur dann angezeigt, wenn alle Vergleiche __false__ ergeben.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/06-Conditionally\_Show\_Parts\_of\_the\_View\_with\_NgSwitch](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/05-Conditionally_Show_Parts_of_the_View_with_NgSwitch)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/06-Conditionally_Show_Parts_of_the_View_with_NgSwitch/index.html)

### Weitere Ressourcen

* Offizielle [NgSwitch](https://angular.io/docs/ts/latest/api/common/index/NgSwitch-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchCase](https://angular.io/docs/ts/latest/api/common/index/NgSwitchCase-directive.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [NgSwitchDefault](https://angular.io/docs/ts/latest/api/common/index/NgSwitchDefault-directive.html)-Dokumentation auf der Angular 2 Webseite
* Weitere Informationen zur Template-Ausdrücke gibt es in [Appendix A: Template-Syntax](#appendix-a)

