## Komponente und CSS trennen {#c07-styleurls}

### Problem

Ich hab viele CSS-Klassen und ich möchte diese nicht in der Komponente haben, sondern in eine separate CSS-Datei.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das CSS. Hier demo.component.css

### Lösung 1

Statt die CSS-Klassen in der Komponente zu haben, können wir diese in eine separate CSS-Datei aufbewahren.

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  styleUrls: ['./app/demo.component.css'],
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

* Zeile 5: Wir nutzen die styleUrls-Eigenschaft, um Angular zu sagen, wo sich die Datei mit dem CSS befindet. Der Pfad zu der CSS-Dateien ist relativ zu der index.html-Datei der Anwendung. Absolute Pfade sind zumindest derzeit nicht zulässig (siehe [#6905](https://github.com/angular/angular/issues/6905)).

### Lösung 2

In der ersten Lösung hatten wir den Pfad relativ zu der index.html-Datei angegeben.
Es gibt auch die Möglichkeit den Pfad relativ zu der demo.component.ts-Datei zu definieren.

{title="demo.component.ts", lang=js}
```
...

@Component({
  moduleId: module.id,
  selector: 'demo-app',
  styleUrls: ['demo.component.ts'],
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

* Zeile 4: "module.id" wird von commonjs und dem Modul-Loader zur Verfügung gestellt. Diese Lösung funktioniert nur mit commonjs Module und wird standardmäßig von angular-cli benutzt, wenn wir damit eine Komponente generieren
* Zeile 6: Der Pfad zu der demo.component.css-Datei ist jetzt relative zu der demo.component.ts-Datei

### Diskussion

Die styleUrls-Eigenschaft einer Komponente erwartet ein Array von Strings.
Zur Laufzeit wird mittels XMLHttpRequest die Datei vom Server geholt und der Inhalt der Datei wird als style-Tag in den DOM gesetzt.
In unserem Beispiel wird ein style-Tag in den Head des Dokuments hinzugefügt.

Wenn wir in Komponenten CSS-Styles definieren, können die definierte CSS-Styles standardmäßig nur in der Komponente verwendet werden in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft der Komponente oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns von Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View Encapsulation" genannt.

Die Diskussion styles- vs. stuleUrls-Eigenschaft ist analog zu der template- vs. templateUrl-Eigenschaft Diskussion in [Komponente und HTML-Template trennen](#c07-split-html-template).
Ebenfalls analog ist die Diskussion Lösung 1 vs. Lösung 2 und die darin beschriebene Probleme.

### Code

Code auf Github für die erste Lösung: [07-Component\_Recipes/03-Separation\_of\_Component\_and\_Styles/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/03-Separation_of_Component_and_Styles/Solution-01)

Code auf Github für die zweite Lösung: [07-Component\_Recipes/03-Separation\_of\_Component\_and\_Styles/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/03-Separation_of_Component_and_Styles/Solution-02)

### Weitere Ressourcen

* Informationen zur View Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styles-Eigenschaft benutzt wird, wird im Rezept "[Das Template der Komponente vom CSS trennen](#c07-styles)" gezeigt

