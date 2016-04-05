## Komponente ohne @View-Decorator

### Warnung

Der View-Decorator (@View) wird in eine spätere Version von Angular entfernt. Alle Rezepte wurden angepasst und der View-Decorator wurde entfernt, dadurch ist dieses Rezept nicht mehr nützlich und wird in eine spätere Version des Buches entfernt.

### Problem

Mir gefällt es nicht, dass ich zwei Decorators nutzen muss, um eine Komponente zu definieren. Ich möchte eine alternative Schreibeweise nutzen ohne den @View-Decorator.

### Zutaten
* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein

### Lösung

Angular bietet uns die Möglichkeit alle Attribute die wir normalerweise im @View-Decorator definieren auch direkt in dem @Component-Decorator zu definieren.

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app',
  template: '<div>Hello World!</div>'
})

...
```

Erklärung:

Statt @View zu nutzen, haben wir die View-Eigenschaften die wir brauchen direkt im @Component-Decorator definiert.

### Diskussion

Der @View-Decorator kann folgende Attribute haben:

* templateUrl
* template
* directives
* pipes
* encapsulation
* styles
* styleUrls

Sobald wir auch nur eins von diesen Attributen im @Component-Decorator nutzen, dürfen wir den @View-Decorator nicht mehr benutzen. Falls man das tut, wird eine Exception geworfen. Technisch gesehen besteht keine Unterschied zwischen den @View-Decorator und die Nutzung von @View-Attributen im @Component-Decorator. Es ist Geschmackssache.

### Code

Code auf Github: [07-Component\_Recipes/01-Component\_without\_View](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Component_without_View)

