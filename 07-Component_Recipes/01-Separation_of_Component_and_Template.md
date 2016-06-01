## Komponente und HTML-Template trennen {#c07-split-html-template}

### Problem

Ich hab ein langes Angular-Template und ich möchte das HTML getrennt von meine Komponente halten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für das HTML. Hier demo.component.html

### Lösung 1

Statt der template-Eigenschaft können wir die templateUrl-Eigenschaft nutzen und dort angeben, wo unsere HTML-Datei sich befindet.

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

* Zeile 5: Pfad zu der demo.component.html-Datei. Hier ist der Pfad relativ zu der index.html-Datei der Anwendung. Wir können aber auch einen absoluten Pfad angeben

### Lösung 2

In der ersten Lösung hatten wir den Pfad relativ zu der index.html-Datei angegeben.
Es gibt auch die Möglichkeit den Pfad relativ zu der demo.component.ts-Datei zu definieren.

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

* Zeile 4: "module.id" wird von commonjs und dem Modul-Loader zur Verfügung gestellt. Diese Lösung funktioniert nur mit commonjs Module und wird standardmäßig von angular-cli benutzt, wenn wir damit eine Komponente generieren
* Zeile 6: Der Pfad zu der demo.component.html-Datei ist jetzt relative zu der demo.component.ts-Datei

### Diskussion

Wichtig zu beachten ist, dass wir entweder die template-Eigenschaft oder die templateUrl-Eigenschaft verwenden können.
Beide gleichzeitig geht nicht.
Zur Laufzeit wird mittels XMLHttpRequest die Datei von Server geholt und der Inhalt der Datei wird kompiliert und in den DOM gesetzt.

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
| in eine Datei definiert      | HTML haben                       |
|------------------------------|----------------------------------|
| Kein extra Server-Aufruf     | Code-Highlighting und            |
|                              | Auto-Vervollständigung sind      |
|                              | Editor abhängig                  |
|------------------------------|----------------------------------|
| Keine Probleme mit Pfade     |                                  |

Ich persönlich versuche immer kleine Komponenten mit wenig HTML (10-15 Zeilen) zu schreiben und nutze dabei die template-Eigenschaft.

#### Lösung 1 vs. Lösung 2

Beide Lösungen sind nicht wirklich geeignet, um Komponenten zu schreiben die in mehrere Anwendungen benutzt werden.
Für die erste Lösung müssen wir immer wieder den Pfad anpassen, da vermutlich die Komponente nicht immer im gleichen Verzeichnis sein wird.
Das ist auch problematisch, wenn wir unsere Anwendung umstrukturieren möchten.

Es ist vielleicht auf den ersten Blick nicht zu erkennen weshalb die zweite Lösung nicht geeignet ist um wiederverwendbare Komponenten zu schreiben.
Diese Lösung ist wegen "module.id" an commonjs und eine Modul-Loader, der diese Eigenschaft nutzt gebunden.
Es gibt zwar Möglichkeiten diese Lösung auch mit andere Modul-System/-Loader zu nutzen aber auch da werden wir an einem bestimmten Modul-System/-Loader gebunden sein.

### Code

Code auf Github für die erste Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-01](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-01)

Code auf Github für die zweite Lösung: [07-Component\_Recipes/01-Separation\_of\_Component\_and\_Template/Solution-02](https://github.com/jsperts/angular2_kochbuch_code/tree/master/07-Component_Recipes/01-Separation_of_Component_and_Template/Solution-02)

### Weitere Ressourcen

* Eine ausführlichere Diskussion zu Komponent-relative Pfade gibt es in [Component-Relative Paths](https://angular.io/docs/ts/latest/cookbook/component-relative-paths.html)

