## Komponente und HTML-Template trennen {#c07-split-html-template}

### Problem

Ich hab ein langes Angular-Template und ich möchte das HTML getrennt von meiner Komponente halten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das HTML. Hier demo.component.html

### Lösung 1

Statt der template-Eigenschaft können wir die templateUrl-Eigenschaft nutzen und dort angeben, wo sich unsere HTML-Datei befindet.

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  templateUrl: './app/demo.component.html'
})

...
```

__Erklärung__:

* Zeile 5: Pfad zur demo.component.html-Datei. Hier ist der Pfad relativ zur index.html-Datei der Anwendung angegeben. Wir können aber auch einen absoluten Pfad angeben

### Lösung 2

In der ersten Lösung hatten wir den Pfad relativ zur index.html-Datei angegeben.
Es gibt auch die Möglichkeit den Pfad relativ zur demo.component.ts-Datei zu definieren.

{title="demo.component.ts", lang=js}
```
...

@Component({
  moduleId: module.id,
  selector: 'demo-app',
  templateUrl: 'demo.component.html'
})

...
```

__Erklärung__:

* Zeile 4: "module.id" wird von commonjs und dem Modul-Loader zur Verfügung gestellt. Diese Lösung funktioniert nur mit commonjs Modulen und wird standardmäßig von angular-cli benutzt, wenn wir darüber eine Komponente generieren
* Zeile 6: Der Pfad zur demo.component.html-Datei ist jetzt relativ zur demo.component.ts-Datei

### Diskussion

Wichtig zu beachten ist, dass wir nur entweder die template-Eigenschaft oder die templateUrl-Eigenschaft verwenden können.
Beide gleichzeitig gehen nicht.
Zur Laufzeit wird die Datei mittels XMLHttpRequest vom Server geholt und der Inhalt der Datei kompiliert und in den DOM gesetzt.

#### templateUrl- vs. template-Eigenschaft

Beide Ansätze haben Vor- und Nachteile.
Wir werden uns diese kurz anschauen.

__templateUrl-Eigenschaft__

| Vorteile                  | Nachteile                              |
|---------------------------|----------------------------------------|
| Übersichtlicher           | Extra Server-Aufruf                    |
|---------------------------|----------------------------------------|
| Logik und Markup sind     | Zwei offene Dateien                    |
| getrennt                  | um eine Komponente zu implementieren   |
|---------------------------|----------------------------------------|
| Code-Highlighting         | Das Angeben von Pfaden hat eigene      |
|                           | Nachteile (siehe Lösung 1 vs. Lösung 2 |
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

#### Lösung 1 vs. Lösung 2

Beide Lösungen sind nicht wirklich dazu geeignet, Komponenten zu schreiben, die in mehreren Anwendungen verwendet werden.
Für die erste Lösung müssen wir immer wieder den Pfad anpassen, da sich die Komponente vermutlich nicht immer im gleichen Verzeichnis befinden wird.
Das ist auch problematisch, wenn wir unsere Anwendung umstrukturieren möchten.

Es ist vielleicht auf den ersten Blick nicht zu erkennen, weshalb die zweite Lösung nicht dazu geeignet ist, wiederverwendbare Komponenten zu schreiben.
Diese Lösung ist wegen "module.id" an commonjs und einen Modul-Loader, der diese Eigenschaft nutzt, gebunden.
Es gibt zwar Möglichkeiten diese Lösung auch mit anderen Modul-Systemen/-Loadern zu nutzen aber auch dort werden wir an ein bestimmtes Modul-System/einen bestimmten Modul-Loader gebunden sein.

### Code

Code auf Github für die erste Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-01)

Code auf Github für die zweite Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-02)

### Weitere Ressourcen

* Eine ausführlichere Diskussion zu komponentenrelativen Pfaden gibt es in [Component-Relative Paths](https://angular.io/docs/ts/latest/cookbook/component-relative-paths.html)

