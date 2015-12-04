## Daten einer Komponente in der View anzeigen {#display_component_data}

### Problem

Ich möchte Daten die in meinem TypeScript-Code sind, in der View anzeigen damit der Nutzer die sieht.

### Zutaten
* Eine Komponente
* Dummy Daten in der Komponente

### Lösung 1

Ausschnitt aus einer Komponente
```js
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
Um den Code übersichtlicher zu gestallten, nutzen wir hier Backticks (\`) für das template-Attribut statt Anführungszeichen ('). Das ermöglicht uns das HTML in mehreren Zeilen aufzuspalten ohne mehrere Strings mit Hilfe von Pluszeichen konkatenieren zu müssen.

* Zeile 9: Hier sagen wir Angular das "name" interpoliert werden soll. Instanzvariablen die in doppelte geschweifte Klammern sind, werden evaluiert und im DOM durch deren Wert ersetzt
* Zeile 13: Typdefinition für die Instanzvariable. Hier sagen wir TypeScript, dass unsere Klasse eine Instanzvariable von Typ String hat. Diese Zeile ist für die Funktionalität optional
* Zeile 16: Wert Zuweisung für die Instanzvariable "name". Wichtig ist, dass der Name der Variable genau so im Template geschrieben wird wie in der Klasse

### Lösung 2


Ausschnitt aus einer Komponente
```js
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

### Diskussion

Zur vergleich zu Angular 1.x mit der controllerAs-Schreibweise hat sich hier kaum etwas geändert. Alles was in Angular 1.x möglich war ist auch jetzt noch möglich.
Das Beispiel ist sehr einfach gehalten. Ein Beispiel mit beide Schreibweisen und mit eine Instanzvariable vom Typ Object gibt es in den Code-Beispielen auf Github.

### Code

Code auf Github: [https://github.com/jsperts/angular2\_kochbuch\_code/tree/master/02-Recipes\_to\_Manipulate\_the\_View/01-Displaying\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Recipes_to_Manipulate_the_View/01-Displaying_Data)

### Ressourcen

Backticks statt Anführungszeichen für Strings: ECMAScript 6 (2015) [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings)
Klassen in TypeScript: [http://www.typescriptlang.org/Handbook#classes](http://www.typescriptlang.org/Handbook#classes)
TypeScript Basistypen: [http://www.typescriptlang.org/Handbook#basic-types](http://www.typescriptlang.org/Handbook#basic-types)

