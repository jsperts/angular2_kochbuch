## Daten einer Komponente in der View anzeigen {#c03-show-data}

### Problem

Ich möchte Daten die in meinem TypeScript-Code sind, in der View anzeigen damit der Nutzer die sieht.

### Zutaten
* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Dummy Daten in der Komponente

### Lösung 1

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: `
    <div>Hello World!</div>
    <div>My name is {{name}}</div>
  `
})
class MyApp {
  name: string;

  constructor() {
    this.name = 'Max';
  }
}

...
```

Erklärung:

Um Daten anzuzeigen müssen wir zwei Sachen machen. Erstens müssen wir dem Template sagen welche Variablen es anzeigen soll und zweitens müssen wir diese Variablen in unsere Klasse definieren.
Um den Code übersichtlicher zu gestalten, nutzen wir hier Backticks (\`) für die template-Eigenschaft statt Anführungszeichen ('). Das ermöglicht uns das HTML in mehreren Zeilen aufzuspalten ohne mehrere Strings mit Hilfe von Pluszeichen konkatenieren zu müssen.

* Zeile 9: Hier sagen wir Angular das "name" [interpoliert](#gl-interpolation) werden soll. Instanzvariablen die in doppelte geschweifte Klammern sind, werden evaluiert und im DOM durch deren Wert ersetzt
* Zeile 13: [Typdefinition](#c01-basic-types) für die Instanzvariable
* Zeile 16: Wert Zuweisung für die Instanzvariable "name". Wichtig ist, dass der Name der Variable genau so im Template geschrieben wird wie in der Klasse

### Lösung 2


{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: `
    <div>Hello World!</div>
    <div>My name is {{name}}</div>
  `
})
class MyApp {
  name = 'Max';
}

...
```

Erklärung:

In dieser Lösung wird "name" nicht im Konstruktor initialisiert sondern als Variable in der Klasse.
Für die Schreibweise in Lösung 2 brauchen wir weniger Code, es ist aber Geschmackssache welche von den beiden Schreibweisen man benutzt. Von der Funktionalität her sind beide gleich.
Siehe auch [TypeScript-Klassen](#c01-classes).

### Diskussion

Zur Vergleich zu Angular 1.x mit der controllerAs-Schreibweise hat sich hier kaum etwas geändert. Alles was in Angular 1.x möglich war ist auch jetzt noch möglich.
Das Beispiel ist sehr einfach gehalten. Ein Beispiel mit beide Schreibweisen und mit eine Instanzvariable vom Typ "object" gibt es in den Code-Beispielen auf Github.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/01-Displaying\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/01-Displaying_Data)

### Weitere Ressourcen

* Backticks statt Anführungszeichen für Strings: ECMAScript 6 (2015) [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings)
* [controllerAs-Schreibweise](https://jsperts.de/blog/ng-ctrl-as-syntax/) in Angular 1.x

