## Komponente und HTML-Template trennen

### Problem

Ich hab ein langes Angular-Template und ich möchte das HTML getrennt von meine Komponente halten.

### Zutaten
* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Eine Datei für das HTML. Hier my\_app.html

### Lösung

Statt der template-Eigenschaft können wir die templateUrl-Eigenschaft nutzen und dort angeben, wo unsere HTML-Datei sich befindet.

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app',
  templateUrl: './app/my_app.html'
})

...
```

__Erklärung__:

* Zeile 5: Pfad zu der my\_app.html-Datei. Hier ist der Pfad relativ zu der index.html-Datei der Anwendung. Wer möchte kann auch ein absoluten Pfad angeben

### Diskussion

Wichtig zu beachten ist, dass wir entweder die template-Eigenschaft oder die templateUrl-Eigenschaft verwenden können. Beide gleichzeitig geht nicht.
Die templateUrl-Eigenschaft ist vor allem nützlich, wenn wir HTML haben mit mehr als 5-10 Zeilen. Wenn man weniger als 10 Zeilen hat, kann man überlegen, ob man lieber [ES6 Template literals](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings) mit der template-Eigenschaft nutzt. Dadurch kann man sich die Serveranfrage für die HTML-Datei sparen.

### Code

Code auf Github: [07-Component\_Recipes/02-Separation\_of\_Component\_and\_Template](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/02-Separation_of_Component_and_Template)

