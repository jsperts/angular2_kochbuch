# Basisrezepte

In diesem Kapitel befinden sich Basisrezepte, die in späteren Rezepten als Zutaten benötigt werden.
Der Code, der in der Lösung(en) gezeigt wird kann kopiert und angepasst werden, um die Lösung(en) für weitere Rezepte zu implementieren.
Es wird empfohlen dieses Kapitel als Erstes zu lesen, um ein Überblick zu bekommen und sich erst dann mit weiteren Rezepten zu beschäftigen.
Es ist das Ziel des Kapitels den schnellen Einstieg in die Grundlagen und die Hauptbauteile von Angular 2 Anwendungen zu ermöglichen.

## Angular 2 Anwendung {#c02-angular-app}

### Problem

Ich möchte von Null auf eine Angular 2 Anwendung implementieren.

### Zutaten
* Leeres Verzeichnis für unsere Anwendung
* Unterverzeichnis für die TypeScript-Dateien. Wir werden das Verzeichnis "app" benennen
* index.html-Datei, um die nötigen Bibliotheken zu laden und die Anwendung zu starten
* app.component.ts-Datei mit einer [Komponenten](#gl-component)
* Component-Decorator für die Komponentendefinition (@Component)
* main.ts-Datei. Diese Datei initialisiert (bootstrap) die Angular 2 Anwendung
* Webserver, um die index.html-Datei und die Angular Anwendung zu laden

### Lösung

Als Erstes werden wir uns die app.component.ts-Datei anschauen. Diese Datei befindet sich im Unterverzeichnis "app".

{title="app.component.ts", lang=js}
```
import {Component} from 'angular2/core';

@Component({
  selector: 'my-app',
  template: '<div>Hello World!</div>'
})
class MyApp {}

export default MyApp;
```

__Erklärung__:

Diese Datei definiert die Haupt- und in diesem Fall einzige Komponente unserer Anwendung.
Sie ist ein ECMAScript-Modul (ESM).
Jede Datei die das Keyword __import__ bzw. das Keyword __export__ beinhaltet ist ein ESM.

* Zeile 1: Hier importieren wir die nötigen Abhängigkeiten aus dem angular2/core-Paket. Dafür nutzen wir eine ESM [import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
* Zeilen 3-6: Hier definieren wir eine Komponente mittels [TypeScript-Decorator](#gl-decorator)
  * Zeile 4: Die selector-Eigenschaft definiert den Tag in dem die Komponente gerendert werden soll. Hier wird die Komponente im Tag __<my-app>__ gerendert
  * Zeile 5: Der Wert der template-Eigenschaft ist ein Angular-Template und wird später von Angular kompiliert und zwischen __<my-tag>__ und __</my-tag>__ hinzugefügt. Das kompilierte Angular-Template wird als die "View" der Komponente bezeichnet
* Zeile 7: Definiert eine TypeScript-Klasse, die die Logik für die Komponente beinhaltet. In diesem Fall ist die Klasse leer, da wir keine Logik benötigen
* Zeile 9: Hier exportieren wir die Komponente. Dafür nutzen wir eine ESM [export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)

Als nächstes werden wir uns die main.ts-Datei anschauen. Diese Datei befindet sich ebenfalls im Unterverzeichnis "app".

{title="main.ts", lang="js"}
```
import {bootstrap} from 'angular2/platform/browser';

import MyApp from './app.component';

bootstrap(MyApp);
```

__Erklärung__:

* Zeile 1: Importiert die Initialisierungsfunktion die wir brauchen, um die Anwendung im Browser zu initialisieren
* Zeile 3: Importiert unsere Hauptkomponente
* Zeile 5: Die Hauptkomponente wird der Initialisierungsfunktion (bootstrap) übergeben und die Anwendung wird initialisiert. Die Hauptkomponente erkennt man dadurch, dass diese der bootstrap-Funktion als Parameter übergeben wird

Als letztes schauen wir uns die index.html-Datei an. Diese Datei befindet sich im Hauptverzeichnis unserer Anwendung.

{title="index.html", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Angular 2 Hello World</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script src="https://code.angularjs.org/tools/typescript.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.6/Rx.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.6/angular2-polyfills.js"></script>
  <script src="https://code.angularjs.org/2.0.0-beta.6/angular2.dev.js"></script>
  <script>
    System.config({
      transpiler: 'typescript',
        typescriptOptions: {
        emitDecoratorMetadata: true
      }
      package: {app: {defaultExtension: 'ts'}}
    });
    System.import('./app/main');
  </script>
</head>
<body>
  <my-app>Loading...</my-app>
</body>
</html>
```

__Erklärung__:

In dieser Datei laden wir unsere Abhängigkeiten und laden mittels SystemJS das Hauptmodul unserer Anwendung (main.ts).

* Zeile 6: Lade SystemJS. Wird benötigt, um das Hauptmodul und weitere Module wie z. B. Angular 2 zu laden.
* Zeile 7: Lade den TypeScript-Compiler. Der wird benötigt, um on-the-fly die main.ts-Datei in JavaScript umzuwandeln
* Zeilen 8-9: RxJS und angular2-polyfills sind Abhängigkeiten von Angular 2
* Zeile 10: Lade die Entwicklungsversion von Angular 2
* Zeilen 11-20: Konfiguriere SystemJS, so dass es TypeScript-Dateien on-the-fly umwandeln kann
* Zeile 19: Die Hauptdatei unserer Anwendung laden. Diese Datei initialisiert unsere Anwendung (bootstrap)
* Zeile 23: Hier wird unsere Hauptkomponente gerendert. Initial wird "Loading..." angezeigt bis Angular initialisiert wird

Jetzt brauchen wir noch einen Webserver, um unsere Anwendung zu testen.
Das Angular-Team empfiehlt den [live-server](https://www.npmjs.com/package/live-server), der automatisch bei Änderungen die Seite im Browser Neuladen kann.
Wer kein live-reload mag kann auch den [http-server](https://www.npmjs.com/package/http-server) nutzen. Beide Webserver sind über npm installierbar.

Nach der Installation und Start des Webservers, können wir unsere Anwendung testen.
Wenn im Browser Fenster "Hello World!" steht, ist alles gut gelaufen.
Wenn das nicht der Fall ist, muss man wahrscheinlich noch das [es6-shim](https://www.npmjs.com/package/es6-shim) installieren und in der index.html-Datei einbinden.
Angular 2 braucht gewisse ES6-Features, die in ältere Browser darunter auch Internet Explorer 11, nicht vorhanden sind.

### Diskussion

Wie schon im Abschnitt "[TypeScript-Dateien vorkompilieren](#c01-precompile)" erwähnt, ist TypeScript on-the-fly in JavaScript umzuwandeln auf Dauer keine Option.
Wir könnten die TypeScript-Dateien wie im Abschnitt "[TypeScript-Dateien vorkompilieren](#c01-precompile)" gezeigt kompilieren aber der Compiler wird Warnungen anzeigen.
Trotz Warnungen werden die Dateien kompiliert.
Die Warnungen werden angezeigt, weil TypeScript keine Typinformationen über Angular hat und auch nicht weiß wo sich die Module "angular2/core" bzw. "angular2/platform/browser" befinden.
Im Abschnitt "[Angular 2 Anwendung vorkompilieren](#c02-precompile-angular-app)" werden wir sehen, wie wir dieses Problem lösen können.
Um den schnellen Einstieg zu ermöglichen, ohne Abhängigkeiten installieren zu müssen, werden die meiste Code-Beispiele die on-the-fly Variante für das Kompilieren nutzen.

#### Komponentendefinition

Bei der Definition einer Komponente, darf sich kein Code zwischen @Component() und der Klasse befinden.
Da sind nur Kommentare und/oder Leerzeilen erlaubt.
Falls sich da Code befindet, werden wir folgenden Fehler in der Konsole sehen:

{linenos=off}
```text
No Directive annotation found on MyApp
```

Wobei "MyApp" der Namen der Komponenten ist. Das gilt für alle Komponenten unabhängig davon, ob sie Haupt- oder normale Komponenten sind.

#### Bootstrap

Der/die eine oder andere Leser/Lesering mag sich jetzt fragen, warum wir nicht einfach eine TypeScript-Datei mit der Komponentendefinition und die bootstrap-Funktion haben.
Natürlich hätten wir das auch machen können aber die Aufspaltung in zwei Dateien bringt ein paar Vorteile mit sich.
Zum einen vermischen wir nicht die Komponentendefinition und die Initialisierung der Anwendung.
Die Komponentendefinition ist allgemein und könnte auf unterschiedlichen Plattformen verwendet werden.
Die bootstrap-Funktion ist Browser spezifisch, daher auch der Import von "angular2/platform/browser" und nicht "angular2/core".
Das heißt, dass wir theoretisch mehrere Initialisierungsdateien haben könnten z. B. eine für den Browser und eine für den Server, die die gleiche Hauptkomponente verwenden.
Die Aufspaltung erhöht also die Wiederverwendbarkeit unserer Hauptkomponente.
Ein weiterer Vorteil ist die Erhöhung der Testbarkeit unserer Hauptkomponente.
Wenn sich der bootstrap-Aufruf in der gleichen Datei befindet wie unsere Hauptkomponente, wird es bei einem Unit-Test Fehlermeldungen geben, da wir nicht nur die Komponente testen, sondern auch die Anwendung initialisieren.

### Code

Code auf Github: [02-Basic\_Recipes/01-Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/01-Angular_App)

### Weitere Ressourcen

* Informationen über [ECMAScript-Module](http://exploringjs.com/es6/ch_modules.html)
* Decorators werden vermutlich als Teil einer späteren Version des ECMAScript-Standards spezifiziert. Mehr Informationen über Decorators in TypeScript und JavaScript gibt es [hier](https://github.com/wycats/javascript-decorators)
* Weitere Informationen über die Angular-Templates gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Komponente definieren {#c02-component-definition}

### Problem

Ich möchte weitere Komponenten nutzen, um meine Anwendung modularer zu gestalten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Datei für die neue Komponente (second.component.ts)
* Anpassungen an der Hauptkomponente (app.component.ts), die wir im Rezepte "Angular 2 Anwendung" definiert haben

### Lösung

{title="second.component.ts", lang=js}
```
import {Component} from 'angular2/core';

@Component({
    selector: 'my-component',
    template: '<div>My Name is ...</div>'
})
class MyComponent {}

export default MyComponent;
```

__Erklärung__:

Diese Datei ist auch ein ESM und beinhaltet die Komponentendefinition für eine Komponente namens "MyComponent".
Genau wie unsere Hauptkomponente, definiert diese die selector- und die template-Eigenschaften.

{title="Anpassungen ad der app.component.ts-Datei", lang=js}
```
import {Component} from 'angular2/core';

import MyComponent from './component.ts';

@Component({
  selector: 'my-app',
  template: '<div>Hello World!</div> <my-component></my-component>',
  directives: [MyComponent]
})
class MyApp {}

export default MyApp;
```

__Erklärung__:

* Zeile 3: Hier importieren wir unsere Komponente
* Zeile 7: Wir haben den Tag __<my-component></my-component>__ in das Angular-Template hinzugefügt. Zu beachten ist, dass der Tag-Namen gleich dem Selektor in Zeile 4 in der second.component.ts-Datei sein muss
* Zeile 8: Mit der directives-Eigenschaft definieren wir welche Direktiven bzw. Komponenten im Template benutzt werden können

### Diskussion

Es ist sehr wichtig, dass wir alle Komponenten die wir im Angular-Template nutzen auch in dem directives-Array definieren. Tags die zu keiner Komponente gehören werden von Angular ignoriert und bleiben leer.

Die Komponente "MyComponent" ist jetzt eine Unterkomponente (auf Englisch child component) von unsere Hauptkomponente.
Indem wir Komponenten importieren und dann im Template nutzen, können wir beliebig große Komponentenbäume erzeugen.
Tatsächlich ist eine Angular 2 Anwendung nur ein Baum von Komponenten mit der Hauptkomponente an der Spitze und beliebig viele Unterkomponenten.

### Code

Code auf Github: [02-Basic\_Recipes/02-Define\_Component](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/02-Define_Component)

## Angular 2 Anwendung vorkompilieren {#c02-precompile-angular-app}

### Problem

Ich möchte meine Angular 2 Anwendung vorkompilieren, so dass die im Browser schneller lädt.
Zusätzlich sollen alle Abhängigkeiten lokal installiert sein.

### Zutaten
* Node.js, npm und TypeScript-Compiler. Siehe [TypeScript-Dateien vorkompilieren](#c01-precompile)
* [Angular 2 Anwendung](#c02-angular-app)
* package.json, um die Abhängigkeiten zu definieren
* Anpassungen an der main.ts-Datei von der Angular 2 Anwendung
* Anpassungen an der index.html-Datei von der Angular 2 Anwendung

### Lösung

{title="package.json", lang=json}
```
{
  "name": "Angular2Kochbuch",
  "dependencies": {
    "angular2": "2.0.0-beta.6",
    "es6-shim": "0.33.13",
    "reflect-metadata": "0.1.2",
    "rxjs": "5.0.0-beta.0",
    "systemjs": "0.19.21",
    "zone.js": "0.5.14"
  },
  "private": true
}
```

__Erklärung__:

Wir haben hier eine minimale package.json-Datei die wir benutzen, um Abhängigkeiten für unser Anwendung zu definieren.

* Zeile 2: Der Namen unserer Anwendung
* Zeilen 3-10: Abhängigkeiten die wir entweder direkt in unserer Anwendung brauchen oder die wir installieren damit der TypeScript-Compiler die Typen für die verschiedene Klassen, Methoden usw. finden kann
* Zeile 11: Mit der Eigenschaft "private" verhindern wir, dass unser Anwendung aus Versehen in das npm-Registery hoch geladen werden kann

Die Abhängigkeiten können jetzt installiert werden mit:

{lang=bash}
```
npm install
```

{title="Anpassungen an der main.ts-Datei", lang=js}
```
///<reference path="../node_modules/angular2/typings/browser.d.ts"/>

...
```

__Erklärung__:

Die hinzugefügte Zeile wird gebraucht, um dem TypeScript-Compiler zu sagen wo er Typinformationen für gewisse Konstrukte wie z. B. Promise, Map und Set finden kann.
Wir können unseren Code auch ohne diese Zeile kompilieren aber der Compiler wird Warnungen ausgeben, da ihm Typinformationen fehlen.

{title="Anpassungen an der index.html-Datei", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Angular 2 Precompiled</title>
  <script src="node_modules/systemjs/dist/system.js"></script>
  <script src="node_modules/rxjs/bundles/Rx.js"></script>
  <script src="node_modules/angular2/bundles/angular2-polyfills.js"></script>
  <script src="node_modules/angular2/bundles/angular2.dev.js"></script>
  <script>
    System.config({
      packages: {'app': {defaultExtension: 'js'}}
    });
    System.import('./app/main');
  </script>
</head>
<body>
  <my-app>Loading...</my-app>
</body>
</html>
```

__Erklärung__:

* Zeilen 6-9: SystemJS, Angular und weitere Abhängigkeiten aus dem node\_modules-Verzeichnis laden

Nachdem wir die index.html-Datei angepasst und die Abhängigkeiten mittels npm installiert haben, können wir die Anwendung mit dem TypeScript-Compiler so wie im Rezept "[TypeScript-Dateien vorkompilieren](#c01-precompile)" kompilieren.
Im Beispiel-Code auf Github befindet sich auch eine tsconfig.json-Datei, die das Kompilieren erleichtert.

### Diskussion

Statt der angular2-polyfills.js-Datei (index.html-Datei Zeile 8), hätten wir auch "reflect-metadata" und "zone.js" (packege.json-Datei Zeilen 6 und 7) einzeln laden können.
Es ist aber einfacher die Abhängigkeiten direkt über die angular2-polyfills.js-Datei zu laden.
Es ist auch sicherer, dass die Versionen von "reflect-metadata" und "zone.js" kompatible zu der Version von Angular sind.
Trotzdem müssen wir beide Module über npm laden, damit der TypeScript-Compiler keine Typ-Fehler meldet.

I> #### On-the-fly Kompilierung
I>
I> Die meisten Rezepte in diesem Buch nutzen die on-the-fly Kompilierung wie diese im Rezept "[Angular 2 Anwendung](#c02-angular-app)" zu sehen ist. Der Grund dafür, ist dass wir damit schneller starten können ohne erst Abhängigkeiten zu installieren und Dateien zu kompilieren. Natürlich funktionieren alle Rezepte auch mit der index.html-Datei die hier zu sehen ist und mit der tsconfig.json-Datei die im Beispiel-Code für dieses Rezept zu finden ist. Damit der Compiler ohne Warnungen kompilieren kann, müssen wir in der main.ts-Datei jedes Rezeptes die Typinformationen hinzufügen wie wir es hier für in der main.ts-Datei getan haben.

### Code

Code auf Github: [02-Basic\_Recipes/03-Precompile\_Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/03-Precompile_Angular_App)

### Weitere Ressourcen

* Weitere Eigenschaften der package.json-Datei werden in der [Online-Doku](https://docs.npmjs.com/files/package.json) erwähnt

## Ein Service definieren {#c02-define-service}

### Problem

Ich möchte einen Service definieren und nutzen, damit ich so Teile meiner Logik und Daten aus der Komponente entfernen kann.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* Eine Datei für unseren Service (data.service.ts)
* Injectable-Decorator (@Inject)

### Lösung

Was wir in der Angular-Welt ein Service nennen, ist im Grunde genommen nur eine TypeScript-Klasse.
Services werden benutzt, um Daten und Logik außerhalb von Komponenten zu bewahren.
Somit können wir die Methoden und die Daten eines Service in mehreren Komponenten wiederverwenden.

{title="data.service.ts", lang=js}
```
import {Injectable} from 'angular2/core';

const data = ['a', 'b', 'c'];

@Injectable()
class DataService {
  data: Array<string>;
  constructor() {
    this.data = data;
  }

  getData() {
    return this.data;
  }
}

export default DataService;
```

__Erklärung__:

* Zeile 5: Hier nutzen wir den Injectable-Decorator, um den Service als "Injectable" zu definieren
* Zeilen 6-15: Die Klasse, die unseren Service repräsentiert
* Zeile 17: Den Service exportieren, so dass wir den in Komponenten und weitere Services nutzen können

Wir haben jetzt einen Service definiert und den werden wir jetzt in unsere Komponente nutzen.

{title="app.component.ts", lang=js}
```
import {Component} from 'angular2/core';
import DataService from './data.service';

@Component({
    selector: 'my-app',
    providers: [DataService],
    template: '<div>Hello Data!</div>'
})
class MyApp {
    constructor(dataService: DataService) {
        console.log(dataService.getData());
    }
}

export default MyApp;
```

__Erklärung__:

* Zeile 2: DataService importieren
* Zeile 6: Die providers-Eigenschaft sagt Angular welche Services der Komponente und ihre Unterkomponenten zur Verfügung stehen. Nur Services die hier definiert sind können als Konstruktorparameter benutzt werden (Siehe auch Zeile 10)
* Zeile 10: Hier definieren wir den "DataService" als Abhängigkeit unserer Komponente. Zur Laufzeit wird die Konstruktorfunktion eine Instanz des "DataService bekommen
* Zeile 11: Hier nutzen wir die getData-Methode der dataService-Instanz

### Diskussion

Es ist anzunehmen, dass nach unsere kurze Erklärung in der Lösung noch einige Fragen offen sind.
Wir haben erwähnt, dass wir den Service als "Injectable" definieren.
Aber was heißt das?
Warum brauchen wir kein "new", um den DataService zu instantiieren?
Was genau sind "providers"?
Wir werden jetzt diese Fragen beantworten.

#### Dependency Injection

Angular nutzt Dependency Injection (DI), um Abhängigkeiten zu verwalten.
Alle Providers von Komponenten werden mit dem sogenannten "Injector" registriert und dieser weiß dann zur Laufzeit was er tun muss, wenn z. B. eine Komponente ein Service im Konstruktor als Abhängigkeit definiert hat.
Die Information, dass die Komponente einen Service braucht wird in den Metadaten der Komponente gespeichert.
Bei der Komponentendefinition stehen uns diese Metadaten zur Verfügung, da wir den Component-Decorator nutzten.

Da Services keine Metadaten besitzen müssen wir den Service mit Hilfe vom Injectable-Decorator als "Injectable" definieren.
Somit bekommt auch unserer Service Metadaten und kann dann auch Abhängigkeiten haben, die in diese Metadaten gespeichert werden.
Wir brauchen also den Injectable-Decorator nur, wenn wir für einen Service einen weiteren Service im Konstruktor als Abhängigkeit definieren wollen.
Kurz gesagt ist ein "Injectable" Service, ein Service der Abhängigkeiten als Konstruktorparameter haben kann.
Obwohl unser Service keine Abhängigkeiten hat, haben wir den Decorator benutzt, damit alle Services einheitlich sind und, um Fehler zu vermeiden falls wir später doch eine Abhängigkeit brauchen.
Wir wissen jetzt also was es bedeutet ein Service als "Injectable" zu definieren und warum wir das machen.

Die Frage "Warum brauchen wir kein 'new', um den DataService zu instantiieren?" ist einfach zu beantworten.
Der Injector übernimmt die Instantiierung für uns.
Das hat den Vorteil, dass wir als Nutzer des Services gar nicht wissen müssen wie wir diesen instantiieren müssen.

Jetzt wollen wir noch die letzte Frage beantworten.
Kurz gesagt ist ein "Provider" ein Rezept, um ein Service zu instantiieren.
Unsere Komponente hat nur eine Abhängigkeit und braucht deshalb auch nur ein Provider.
Der Provider ist die Klasse, die den Service repräsentiert und der Injector weiß, dass eine Klasse mit "new" zu instantiieren ist und die Instanz als Konstruktorparameter zu übergeben ist.
Um genau zu wissen welche Klasse zur welcher Instanz gehört, nutzt der Injector die Typdefinition der Konstruktorparameter.
Alternativ können wir statt eine Typdefinition auch den Inject-Decorator (@Inject) nutzen:

{title="Inject-Decorator statt Typ, lang=js}
```
...

import {Inject} from 'angular2/core';
import DataService from './data.service';

...

class MyApp(@Inject(DataService) dataService) { ... }

...
```

Wir haben unsere Diskussion möglichst kurz gehalten.
Eine ausführlichere Erklärung wie Dependency Injection in Angular funktioniert würde den Rahmen eines Rezepts sprenden.
Eine vollständige Erklärung wie Dependency Injection funktioniert und was wir alles damit machen können gibt es auf der Angular 2 Webseite: [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html).
Da wird auch beschrieben wie wir komplexere Provider-Rezepte nutzen können und was wir außer Services als Abhängigkeiten definieren können.

### Code

Code auf Github: [02-Basic\_Recipes/04-Define\_Service](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/04-Define_Service)

