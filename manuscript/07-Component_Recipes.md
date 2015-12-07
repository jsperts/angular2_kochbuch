# Rezepte für Komponenten

In diesem Kapitel befinden sich verschiedene Rezepte die Komponenten betreffen. Hier kann man z. B. alternative Schreibweisen für Komponenten finden oder Wege die wir nutzen können um die Kommunikation zwischen Komponenten zu ermöglichen.

## Komponente ohne @View-Decorator

### Problem

Mir gefällt nicht, dass ich zwei Decorators nutzen muss, um eine Komponente zu definieren und möchte eine alternative Schreibeweise nutzen ohne den @View-Decorator.

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

## Komponente und HTML-Template trennen

### Problem

Ich hab ein langes HTML-Template und ich möchte das HTML getrennt von meine Komponente halten.

### Zutaten
* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Eine HTML-Datei für das HTML

### Lösung

Statt das template-Attribut können wir das templateUrl-Attribut nutzen und dort angeben wo unsere HTML-Datei sich befindet.

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  templateUrl: 'my_app.html'
})

...
```

### Diskussion

Wichtig zu beachten ist, dass wir entweder das template-Attribut oder das templateUrl-Attribut verwenden können. Beide gleichzeitig geht nicht.
Das templateUrl-Attribut ist sehr nützlich wenn wir HTML haben mit mehr als 5-10 Zeilen. Wenn man weniger als 10 Zeilen hat, kann man sich überlegen, ob man lieber [ES6 template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings) mit dem template-Attribut nutzt. Dadurch kann man sich die Serveranfrage nach der HTML-Datei sparen.

### Code

Code auf Github: [07-Component\_Recipes/02-Separation\_of\_Component\_and\_Template](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/02-Separation_of_Component_and_Template)

