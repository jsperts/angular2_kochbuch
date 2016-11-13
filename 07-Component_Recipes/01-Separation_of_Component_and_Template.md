## Komponente und HTML-Template trennen {#c07-split-html-template}

### Problem

Ich hab ein langes Angular-Template und ich möchte das HTML getrennt von meiner Komponente halten.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das HTML. Hier app.component.html

### Lösung

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html'
})

...
```

__Erklärung__:

* Zeile 5: Statt der template-Eigenschaft, die wir in anderen Rezepten benutzt haben, nutzen wir jetzt die templateUrl-Eigenschaft. Der angegebene Pfad ist relativ zu der app.component.ts-Datei

### Diskussion

Wichtig zu beachten ist, dass wir nur entweder die template-Eigenschaft oder die templateUrl-Eigenschaft verwenden können.
Beide gleichzeitig gehen nicht.
Da wir in diesem Buch angular-cli mit Webpack nutzen wird die Zeile 5 oben beim Kompilieren durch `template: require('./app.component.html')` ersetzt und Angular wird sich zur Laufzeit so verhalten als ob wir selbst das Template in der Komponente geschrieben haben.
Falls andere Build-Tools benutzt werden, die die templateUrl-Eigenschaft nicht ersetzen, wird zur Laufzeit die Datei von Angular mittels XMLHttpRequest vom Server geholt und der Inhalt der Datei kompiliert und in das DOM gesetzt.
Im allgemeinen ist es Toolabhängig, ob wir einen relativen Pfaden angeben können und wie dieser genau aussieht.
Wer mehr über relative Pfade für Templates erfahren möchte, kann den Artikel [Component-Relative Paths](https://angular.io/docs/ts/latest/cookbook/component-relative-paths.html) lesen.

#### templateUrl- vs. template-Eigenschaft

Beide Ansätze haben Vor- und Nachteile.
Wir werden uns diese kurz anschauen.

__templateUrl-Eigenschaft__

| Vorteile                  | Nachteile                              |
|---------------------------|----------------------------------------|
| Übersichtlicher           | Extra Server-Aufruf                    |
|                           | (Gilt in unserem Fall nicht)           |
|---------------------------|----------------------------------------|
| Logik und Markup sind     | Zwei offene Dateien                    |
| getrennt                  | um eine Komponente zu implementieren   |
|---------------------------|----------------------------------------|
| Code-Highlighting         | Wie genau der Pfad aussieht ist        |
|                           | Toolabhängig                           |
|---------------------------|----------------------------------------|
| Auto-Vervollständigung    |                                        |

__template-Eigenschaft__

| Vorteile                     | Nachteile                        |
|------------------------------|----------------------------------|
| Die gesamte Komponente wird  | Unübersichtlich, wenn wir viel   |
| in einer Datei definiert     | HTML haben                       |
|------------------------------|----------------------------------|
| Kein extra Server-Aufruf     | Codehighlighting und             |
|                              | Autovervollständigung sind       |
|                              | editorabhängig                   |
|------------------------------|----------------------------------|
| Keine Probleme mit Pfaden    |                                  |

Ich persönlich versuche immer kleine Komponenten mit wenig HTML (10-15 Zeilen) zu schreiben und nutze dabei die template-Eigenschaft.

### Code

Code auf Github für die erste Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-01)

Code auf Github für die zweite Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-02)

