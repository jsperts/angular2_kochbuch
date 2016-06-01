## Komponente und CSS trennen {#c07-styleurls}

### Problem

Ich hab viele CSS-Klassen und ich möchte diese nicht in der Komponente haben, sondern in eine separate CSS-Datei.

### Zutaten

* [Eine Komponente](#c02-component-definition)
* Eine Datei für das CSS. Hier my\_app.css

### Lösung

Statt die CSS-Klassen in der Komponente zu haben, können wir diese in eine separate CSS-Datei aufbewahren.

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app',
  styleUrls: ['./app/my_app.css'],
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

* Zeile 5: Wir nutzen die styleUrls-Eigenschaft, um Angular zu sagen, wo sich die Datei mit dem CSS befindet

### Diskussion

Die styleUrls-Eigenschaft einer Komponente erwartet ein Array von Strings.
Jeder String ist ein relativer Pfad zur einer CSS-Datei.
Absolute Pfade werden derzeit nicht unterstützt (siehe [#6905](https://github.com/angular/angular/issues/6905)).
Relativ bedeutet in diesem Fall: relativ zu der index.html-Datei der Anwendung.
Zur Laufzeit wird mittels XMLHttpRequest die Datei von Server geholt und der Inhalt der Datei wird als style-Tag in den DOM gesetzt.
In unserem Beispiel wird ein style-Tag in den Head des Dokuments hinzugefügt.

Wenn wir in Komponenten CSS-Styles definieren, können die definierte CSS-Styles standardmäßig nur in der Komponente verwendet werden in der diese definiert worden sind.
Es ist dabei egal, ob wir die CSS-Styles als inline-styles mittels style-Tag, über die styles-Eigenschaft der Komponente oder über die styleUrls-Eigenschaft der Komponente definieren.
Dieses Verhalten kann uns von Fehlern schützen und meidet Konflikte in den CSS-Styles, wenn wir z. B. Komponenten wiederverwenden. Die Kapselung von Styles und Komponenten wird in Angular "View Encapsulation" genannt.

### Code

Code auf Github: [07-Component\_Recipes/03-Separation\_of\_Component\_and\_Styles](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/04-Separation_of_Component_and_Styles)

### Weitere Ressourcen

* Informationen zur View Encapsulation gibt es in [unserem Blog](https://jsperts.de/blog/angular2-view-kapselung/)
* Wie die styles-Eigenschaft benutzt wird, wird im Rezept "[Das Template der Komponente vom CSS trennen](#c07-styles)" gezeigt

