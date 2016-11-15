## Komponente und CSS trennen {#c07-styleurls}

### Problem

Ich hab viele CSS-Klassen und ich möchte diese nicht in der Komponente halten, sondern in einer separaten CSS-Datei.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das CSS. Hier: app.component.css

### Lösung

In der ersten Lösung hatten wir den Pfad relativ zur index.html-Datei angegeben.
Es gibt auch die Möglichkeit, den Pfad relativ zur app.component.ts-Datei zu definieren.

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  styleUrls: ['./app.component.ts'],
  template: `
    <div class="box"></div>
    <div class="box"></div>
    <div class="box box-blue"></div>
    <div class="box"></div>
  `
})

...
```

__Erklärung__:

* Zeile 5: Statt der styles-Eigenschaft, die wir in anderen Rezepten benutzt haben, nutzen wir jetzt die styleUrls-Eigenschaft. Der angegebene Pfad ist relativ zu der app.component.ts-Datei

### Diskussion

Die styleUrls-Eigenschaft einer Komponente erwartet ein Array von Strings.
Da wir in diesem Buch angular-cli mit Webpack nutzen wird die Zeile 5 oben beim Kompilieren durch `styles: [require('./app.component.css')]` ersetzt und Angular wird sich zur Laufzeit so verhalten als ob wir selbst die Styles in der Komponente geschrieben haben.
Falls andere Build-Tools benutzt werden, die die styleUrls-Eigenschaft nicht ersetzen, wird zur Laufzeit die Datei von Angular mittels XMLHttpRequest vom Server geholt und der Inhalt der Datei wird als style-Tag in das DOM gesetzt.
Im allgemeinen ist es Toolabhängig, ob wir einen relativen Pfaden angeben können und wie dieser genau aussieht.
Wer mehr über relative Pfade für Styles erfahren möchte, kann den Artikel [Component-Relative Paths](https://angular.io/docs/ts/latest/cookbook/component-relative-paths.html) lesen.

Wenn wir in Komponenten CSS-Styles definieren, können die definierten CSS-Styles standardmäßig nur in der Komponente verwendet werden, in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft der Komponente oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns vor Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View-Encapsulation" genannt.

Die Diskussion styles- vs. stuleUrls-Eigenschaft ist analog zur template- vs. templateUrl-Eigenschaft Diskussion in [Komponente und HTML-Template trennen](#c07-split-html-template).

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/03-Separation_of_Component_and_Styles)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/07-Component_Recipes/03-Separation_of_Component_and_Styles/index.html)

### Weitere Ressourcen

* Informationen zur View-Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styles-Eigenschaft benutzt wird, wird im Rezept "[Das Template der Komponente vom CSS trennen](#c07-styles)" gezeigt

