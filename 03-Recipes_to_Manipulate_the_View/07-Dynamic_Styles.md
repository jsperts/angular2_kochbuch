## Styles eines Elements dynamisch verändern

### Problem

Ich möchte die Größe (height/width) eines Elements durch Werte in meiner Komponente definieren. Eine Änderung der Werte in der Komponente soll auch die Größe des Elements verändern.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eigenschaften in der Komponente, die wir im Template referenzieren
* NgStyle-Direktive von Angular

### Lösung 1

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: `
    <div [ngStyle]="{'width': elemWidth, 'height': elemHeight}"
        style="background-color: red"></div>
  `
})
export class DemoAppComponent {
  elemWidth: string;
  elemHeight: string;
  constructor() {
    this.elemWidth = '100px';
    this.elemHeight = '100px';
  }
}
```

__Erklärung__:

* Zeilen 6-7: div-Tag mit Styles. Statische Styles werden über das style-Attribut gesetzt. Dynamische Styles werden mit Hilfe der ngStyle-Eigenschaft, einer [input-Eigenschaft](#gl-input-property) der NgStyle-Direktive, gesetzt. Die Eigenschaft erhält als Wert ein Objekt dessen Keys die style-Eigenschaften sind, die gesetzt werden (hier width und height). Die Werte für die Styles sind in der Klasse der Komponente definiert (siehe Zeilen 14 und 15)
* Zeile 14: Der Wert für die Breite des Elements
* Zeile 15: Der Wert für die Höhe des Elements

### Lösung 2

Wir haben bereits in Lösung 1 gesehen, dass die ngStyle-Eigenschaft ein Objekt mit style-Eigenschaften als Keys und Werten für die Styles als Werte für die Keys bekommt.
Statt Werte individuell in der Klasse zu definieren, können wir auch direkt das Objekt für die ngStyle-Eigenschaft definieren.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

interface IDimensions {
  width: string;
  height: string;
}

@Component({
  selector: 'demo-app',
  template: `
    <div [ngStyle]="dimensions" style="background-color: red"></div>
  `
})
export class DemoAppComponent {
  dimensions: IDimensions;
  constructor() {
    this.dimensions = {
      width: '100px',
      height: '100px'
    };
  }
}
```

__Erklärung__:

* Zeile 11: div-Tag mit ngStyle-Eigenschaft, die auf die dimensions-Eigenschaft der Klasse zugreift
* Zeilen 17-20: Objekt mit style-Eigenschaften als Keys und Werten, die die Werte für die Styles definieren

### Diskussion

Um das Beispiel möglichst klein zu halten, haben wir hier auf das dynamische Verändern der Werte der style-Eigenschaften verzichtet.
Im Github-Code-Beispiel wird gezeigt, wie wir mittels "click" die Werte der styles-Eigenschaften verändern können.
Um das Code-Beispiel zu verstehen, wird auch das Rezept "[Auf Nutzer-Input reagieren](#c03-user-input)" benötigt.

Wir nutzen hier eine [Daten-Bindung](#gl-data-binding) mit eckigen Klammern ([...]).
Diese Art der Daten-Bindung wird Eigenschafts-Bindung genannt.
Falls wir nur eine einzige styles-Eigenschaft setzen, können wir auch eine Style-Bindung dafür nutzen.

### Code

Code auf Github für die erste Lösung: [03-Recipes\_to\_Manipulate\_the\_View/07-Dynamic\_Styles/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-01)

Live Demo für die erste Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-01/index.html)

Code auf Github für die zweite Lösung: [03-Recipes\_to\_Manipulate\_the\_View/07-Dynamic\_Styles/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-02)

Live Demo für die zweite Lösung auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/03-Recipes_to_Manipulate_the_View/07-Dynamic_Styles/Solution-02/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation der [NgStyle-Direktiven](https://angular.io/docs/ts/latest/api/common/NgStyle-directive.html)
* Weitere Informationen zur Eigenschaften- und Klassen-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)

