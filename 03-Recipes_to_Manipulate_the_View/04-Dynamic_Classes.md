## CSS-Klassen auf Basis von booleschen Werten setzen/entfernen {#c03-dynamic-classes}

### Problem

Ich möchte anhand eines booleschen Wertes definieren wann eine CSS-Klasse gesetzt wird und wann nicht.

### Zutaten
* [Daten einer Komponente in der View anzeigen](#c03-show-data)
* CSS-Klassen die gesetzt bzw. entfernt werden sollen
* NgClass-Direktive von Angular

### Lösung 1

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';

@Component({
  selector: 'my-app'
})
@View({
  template: `
    <style>
      .box {
        width: 100px;
        height: 100px;
        border: 1px solid black;
      }
      .red {
        background-color: red;
      }
      .green {
        background-color: green;
      }
    </style>
    <div class="box" [ngClass]="{red: box.isRed}"></div>
    <div class="box green" [ngClass]="{green: box.isGreen}"></div>
  `
})
class MyApp {
  box = {
    isRed: true,
    isGreen: false
  };
  constructor() {}
}

export default MyApp;
```

Erklärung:

* Zeile 9-21: Definition der CSS-Klassen die wir benötigen
* Zeile 22-23: Zwei divs mit CSS-Klassen. Initiale CSS-Klassen werden über das class-Attribut gesetzt. Dynamische CSS-Klassen werden mit der ngClass-Eigenschaft gesetzt. Die Keys im ngClass-Objekt sind die CSS-Klassen die entfernt/hinzugefügt werden
  * Zeile 22: Durch ngClass wird die CSS-Klasse "red" gesetzt. Die isRed-Eigenschaft des box-Objektes ist __true__
  * Zeile 23: Durch ngClass wird die CSS-Klasse "green" entfernt. Die isGreen-Eigenschaft des box-Objektes ist __false__
* Zeile 27-30: Objekt mit boolesche Werte die benutzt werden, um CSS-Klassen im Template hinzuzufügen bzw. zu entfernen

### Lösung 2

Wir haben schon in Lösung 1 gesehen, dass die ngClass-Eigenschaft ein Objekt bekommt mit CSS-Klassen als Keys und true/false als Werte für die Keys. Statt das Objekt im Template zu definieren, können wir es auch in unsere Klasse definieren.

{title="Ausschnitt aus der app.component.ts", lang=js}
```
...

@View({
  template: `
    <style>
      .box {
        width: 100px;
        height: 100px;
        border: 1px solid black;
      }
      .red {
        background-color: red;
      }
    </style>
    <div [ngClass]="classes"></div>
  `
})
class MyApp {
  classes = {
    red: true
    box: true
  };
  constructor() {}
}

bootstrap(MyApp);
```

Erklärung:

* Zeile 5-14: Definition der CSS-Klassen die wir benötigen
* Zeile 15: Div mit ngClass-Eigenschaft die auf das classes-Objekt in unsere Klasse zugreift
* Zeile 19-22: Objekt mit CSS-Klassen als Keys und boolesche Werte die angeben, ob die CSS-Klasse gesetzt wird oder nicht

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern der CSS-Klassen verzichtet. Im Github Code-Beispiel wird gezeigt wie man mittels "click" die CSS-Klassen für unsere divs entfernen und hinzufügen kann. Um das Code-Beispiel zu verstehen wird das Rezept "[Auf Nutzer-Input reagieren](#c03-user-input)" auch benötigt.

Wir haben hier eine neue Schreibweise für Templates gesehen und zwar [Daten-Bindung](#gl-data-binding) mit eckigen Klammern ([...]).
Diese Art von Daten-Bindung wird Eigenschafts-Bindung genannt.
Falls wir nur eine einzige Klasse nutzen, können wir auch eine Klassen-Bindung dafür nutzen.

I> #### Inline-styles
I>
I> Wenn wir inline-styles in einer Komponente nutzen, können die definierte CSS-Klassen standardmäßig nur in dieser Komponente benutzt werden in der sie definiert worden sind. Dieses Verhalten kann uns von Fehlern schützen und meidet Konflikte in CSS-Klassen, wenn man Komponente wiederverwendet. Die Kapselung von CSS-Klassen und Komponenten wird in Angular _View Encapsulation_ genannt.

### Code

Code auf Github für die erste Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-01)

Code auf Github für die zweite Lösung: [03-Recipes\_to\_Manipulate\_the\_View/04-Dynamic\_Classes/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/04-Dynamic_Classes/Solution-02)

### Weitere Ressourcen

* Offizielle Dokumentation für die [NgClass-Direktive](https://angular.io/docs/ts/latest/api/common/NgClass-directive.html)
* Weitere Informationen zu Eigenschafts- und Klassen-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)
* Informationen zur View Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)

