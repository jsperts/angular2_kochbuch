## Daten einer Komponente in der View anzeigen {#c03-show-data}

### Problem

Ich möchte Daten, die sich in meinem TypeScript-Code befinden, in der View anzeigen, damit der Nutzer diese sehen kann.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Dummy Daten in der Klasse der Komponente

### Lösung 1

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  template: `
    <div>Hello World!</div>
    <div>My name is {{name}}</div>
  `
})
export class DemoAppComponent {
  name: string;

  constructor() {
    this.name = 'Max';
  }
}
...
```

__Erklärung__:

Um Daten anzuzeigen, müssen wir zwei Sachen machen:
Erstens müssen wir dem Angular-Template sagen, welche Variablen es anzeigen soll. Zweitens müssen wir diese Variablen in unserer Klasse als Eigenschaften definieren.
Um den Code übersichtlicher zu gestalten, nutzen wir hier für die template-Eigenschaft Backticks (`` ` ``) statt Anführungszeichen (`'`).
Das ermöglicht uns, das Template in mehrere Zeilen aufzuspalten, ohne mehrere Strings mittels Pluszeichen konkatenieren zu müssen.

* Zeile 7: Hier teilen wir Angular mit, das "name" [interpoliert](#gl-interpolation) werden soll
* Zeile 11: [Typdefinition](#c01-basic-types) der Komponenten-Eigenschaft
* Zeile 14: Wertzuweisung der name-Eigenschaft. Wichtig ist, dass der Name der Eigenschaft im Template genauso wie in der Klasse geschrieben wird

### Lösung 2

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  template: `
    <div>Hello World!</div>
    <div>My last name is {{lastname}}</div>
  `
})
export class DemoAppComponent {
  lastname = 'Mustermann';
}
```

__Erklärung__:

In dieser Lösung wird "lastname" nicht im Konstruktor initialisiert, sondern in der Klasse (Zeile 11).
Siehe auch [TypeScript-Klassen](#c01-classes).

### Diskussion

Das Beispiel ist sehr einfach gehalten.
Die zweite Lösung benötigt weniger Code aber es ist Geschmackssache welche der beiden Varianten wir benutzen.
Von der Funktionalität her sind beide gleich.
Ein Beispiel mit beiden Schreibweisen gibt es im Code-Beispiel auf Github.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/01-Displaying\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/01-Displaying_Data)

### Weitere Ressourcen

* Backticks statt Anführungszeichen für Strings: ECMAScript 6 (2015) [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings)
* Weitere Informationen zur Interpolation und der Template-Syntax befinden sich in [Appendix-A: Template-Syntax](#appendix-a)

