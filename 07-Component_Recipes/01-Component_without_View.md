## Komponente ohne @View-Decorator

### Problem

Mir gefällt nicht, dass ich zwei Decorators nutzen muss, um eine Komponente zu definieren und möchte eine alternative Schreibeweise nutzen ohne den @View-Decorator.

### Zutaten
* Eine Komponente

### Lösung

Angular bietet uns die Möglichkeit alle Attribute die wir normalerweise im @View-Decorator definieren auch direkt in dem @Component-Decorator zu definieren.

Ausschnitt aus einer Komponente
```js
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

sobald wir auch nur eins von diesen Attributen im @Component-Decorator nutzen, dürfen wir den @View-Decorator nicht mehr benutzen. Falls man das tut, wird eine Exception geworfen. Technisch gesehen besteht keine Unterschied zwischen den @View-Decorator und die Nutzung von @View-Attributen im @Component-Decorator. Es ist Geschmackssache.

### Code

Code auf Github: [https://github.com/jsperts/angular2\_kochbuch\_code/tree/master/06-Component\_Recipes/01-Component\_without\_View](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Component_Recipes/01-Component_without_View)

