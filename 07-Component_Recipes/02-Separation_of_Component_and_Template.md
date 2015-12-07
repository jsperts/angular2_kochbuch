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

