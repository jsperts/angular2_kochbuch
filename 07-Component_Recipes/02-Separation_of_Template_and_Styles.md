## Das Template der Komponente vom CSS trennen {#c07-styles}

### Problem

Ich möchte meine CSS-Styles getrennt von meinem Template und nicht in einem style-Tag im Template halten.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* CSS-Klassen, die im Template verwendet werden

### Lösung

Statt die CSS-Klassen im Template zu halten, können wir die styles-Eigenschaft der Komponente nutzen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  styles: [
    '.box {width: 100px; height: 100px; background-color: red; margin: 10px}',
    '.box-blue {background-color: blue;}'
  ],
  template: `
    <div class="box"></div>
    <div class="box"></div>
    <div class="box box-blue"></div>
    <div class="box"></div>
  `
})
export class AppComponent {}
```

__Erklärung__:

* Zeilen 5-8: CSS-Styles für unsere Komponente

### Diskussion

Die styles-Eigenschaft einer Komponente erwartet ein Array von Strings.
Ein String kann CSS-Styles für eine oder mehrere Klassen, Tags, etc. beinhalten.
Jeder String wird dann zur Laufzeit als style-Tag in den DOM gesetzt.
In unserem Beispiel werden zwei style-Tags im Head des Dokuments hinzugefügt.

Wenn wir in Komponenten CSS-Styles definieren, können die definierten CSS-Styles standardmäßig nur in der Komponente verwendet werden, in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns vor Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View Encapsulation" genannt.

### Code

Code auf Github: [07-Component\_Recipes/02-Separation\_of\_Template\_and\_Styles](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/02-Separation_of_Template_and_Styles)

### Weitere Ressourcen

* Informationen zur View Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styleUrls-Eigenschaft benutzt wird, wird im Rezept "[Komponente und CSS trennen](#c07-styleurls)" gezeigt

