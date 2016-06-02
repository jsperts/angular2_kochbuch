# Basisrezepte

In diesem Kapitel befinden sich Basisrezepte, die in späteren Rezepten als Zutaten benötigt werden.
Der Code, der in der Lösung(en) gezeigt wird kann kopiert und angepasst werden, um die Lösung(en) für weitere Rezepte zu implementieren.
Es wird empfohlen dieses Kapitel als Erstes zu lesen, um ein Überblick zu bekommen und sich erst dann mit weiteren Rezepten zu beschäftigen.
Es ist das Ziel des Kapitels den schnellen Einstieg in die Grundlagen und die Hauptbauteile von Angular 2 Anwendungen zu ermöglichen.

## Entwicklungs-Prozess für Angular 2 Projekte {#c02-angular-cli}

### Problem

Ich möchte ein möglichst einfachen Weg haben, um ein Angular 2 Projekt zu initialisieren, bauen und das Resultat im Browser anzuschauen.

### Zutaten

* Node.js
* npm
* angular-cli

### Lösung

Der derzeit einfachste Weg, um ein Angular 2 Projekt zu starten, bauen und sich das Resultat im Browser anzuschauen ist ein Tool namens "angular-cli".
Das Tool ist noch im beta-Stadium nicht desto trotz werden wir es nutzten, da die alternative (alles selbst einzurichten) sehr aufwendig ist.

Als Erstes müssen wir __Node.js__ und __npm__ installieren, damit wir im zweiten Schritt __angular-cli__ installieren können.
Am einfachsten können wir Node.js installieren, indem wir es von der [offizielle Webseite](https://nodejs.org/en/download/) herunterladen.
Bei der Installation von Node.js, wird npm mit installiert.
Jetzt können wir angular-cli installieren mit:

```bash
npm install -g angular-cli@1.0.0-beta.5
```

Wir installieren angular-cli global und können es in jedem Angular 2 Projekt nutzen.

I> #### Node.js/npm Versionen
I>
I> angular-cli braucht eine relativ neue Version von Node.js und npm. Laut der Dokumentation soll die Version von Node.js ≥ 4 sein. Für das Buch wurde angular-cli mit der Version 5.3.0 von Node.js und npm Version 3.3.12 getestet.

I> #### Fehler bei der Installation/Projekt-Initialisierung
I>
I> Bei Fehler hilft es angular-cli zu löschen und neu zu installieren. Fehler können vor allem auftreten, wenn eine alte Version von angular-cli schon installiert ist.

Jetzt können wir ein Projekt initialisieren.
Dafür gibt es die Kommandos "new" und "init".

```bash
ng new projektName --skip-git
```

Dieses Kommando wir ein Verzeichnis erzeugen mit Namen "projektName" und wird darin die nötigen Verzeichnisse/Dateien anlegen und alle Abhängigkeiten mittels npm installieren.
Falls `--skip-git` nicht angegeben wird, wird angular-cli auch ein git-Repository anlegen vorausgesetzt, dass wir nicht schon in einem git-Repository sind.

Das init-Kommando macht das gleiche wie das new-Kommando aber für ein existierendes Verzeichnis.

```bash
ng init --name projektName
```

Falls `--name projektName` nicht angegeben wird, wird der Name des Verzeichnisses als Projektname benutzt.

W> #### Namen von Projekten
W>
W> Derzeit wird nicht jeder beliebige Name als Projektname unterstützt. Z. B. ist "test" kein gültiger Projektname. Das Tool wird eine Fehlermeldung ausgeben, falls der Projektname nicht zulässig ist.

#### Anwendung starten

Nach dem alle Abhängigkeiten installiert worden sind, können wir die Anwendung starten.
Angular-cli hat ein eingebauten HTTP-Server den wir dafür nutzen können.
Um den Server zu starten, müssen wir im Projekt-Verzeichnis (das mit der package.json-Datei) folgendes Kommando aufrufen:

```bash
ng serve
```

In der Konsole steht dann zu welche URL wir navigieren müssen, um die Demo-Anwendung von angular-cli zu sehen (Zeile "Serving on http://...").
Das nette an diesem Webserver ist der Live-Reload-Support.
Das heißt, wenn wir Änderungen im Code machen werden diese sofort im Browser sichtbar ohne, dass wir das Projekt selbst erneut kompilieren müssen.

### Diskussion

Alle Rezepte in diesem Buch wurden mit `angular-cli` initialisiert.
Es ist also nicht nötig `ng init` oder `ng new` aufzurufen.
Es reicht, wenn `npm install` aufgerufen wird, um die Abhängigkeiten zu installieren.
Danach können wir wie oben gezeigt mit `ng serve` die Anwendung starten.

Da das Tool eine eigene Meinung hat wie die Verzeichnisstruktur, eine Komponente usw. auszusehen hat, wurden aus den Code-Beispielen ein paar Verzeichnisse/Dateien gelöscht bzw. angepasst.
Wir wollen nicht, dass überflüssige Verzeichnisse, Dateien und Code-Zeilen uns vom eigentlichen Thema eines Rezeptes ablenken.
Wir schauen uns also nur die relevanten Dateien für ein Rezept an und ignorieren den Rest.
Auch gewisse Abhängigkeiten wurden aus der package.json-Datei entfernt, um die Installationszeit zu verkürzen.
Es ist also möglich, dass nicht alle angular-cli Kommandos mit jedem Rezept funktionieren.
Für die meisten Rezepte ist das src-Verzeichnis am wichtigsten.
Darin befindet sich der Code für eine Angular 2 Anwendung.

### Weitere Ressourcen

* Offizielle Webseite von [angular-cli](https://cli.angular.io/)
* Github von [angular-cli](https://github.com/angular/angular-cli)

## Angular 2 Anwendung {#c02-angular-app}

### Problem

Ich möchte von Null auf eine Angular 2 Anwendung implementieren.

### Zutaten

* [angular-cli](#c02-angular-cli)
* demo.component.ts-Datei, die die Haupt-[Komponente](#gl-component) der Anwendung definiert
* Component-Decorator für die Komponentendefinition (@Component)
* main.ts-Datei. Diese Datei initialisiert (bootstrap) die Angular 2 Anwendung
* index.html-Datei, um die nötigen Bibliotheken zu laden und die Anwendung zu starten

### Lösung

Als Erstes werden wir uns die demo.component.ts-Datei anschauen. Diese Datei befindet sich im Unterverzeichnis "src/app".

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'demo-app',
  template: '<div>Hello World!</div>'
})
export class DemoAppComponent {}
```

__Erklärung__:

Diese Datei definiert die Haupt- und in diesem Fall einzige Komponente unserer Anwendung.
Sie ist ein ECMAScript-Modul (ESM).
Jede Datei, die das Keyword __import__ bzw. das Keyword __export__ beinhaltet ist ein ESM.

* Zeile 1: Hier importieren wir die nötigen Abhängigkeiten aus dem @angular/core-Paket. Dafür nutzen wir eine ESM [import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import)
* Zeilen 3-6: Hier definieren wir eine Komponente mittels [TypeScript-Decorator](#gl-decorator)
  * Zeile 4: Die selector-Eigenschaft definiert das Tag in dem die Komponente gerendert werden soll. Hier wird die Komponente im Tag __<demo-app>__ gerendert
  * Zeile 5: Der Wert der template-Eigenschaft ist ein Angular-Template und wird später von Angular kompiliert und zwischen __<demo-app>__ und __</demo-app>__ hinzugefügt. Das kompilierte Angular-Template wird als die "View" der Komponente bezeichnet
* Zeile 7: Definiert eine TypeScript-Klasse, die die Logik für die Komponente beinhaltet. In diesem Fall ist die Klasse leer, da wir keine Logik benötigen
  * Gleichzeitig wird die Klasse exportiert (und somit die Komponente) mit einer ESM [export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export)


Als nächstes werden wir uns die main.ts-Datei anschauen. Diese befindet sich im Unterverzeichnis "app".

{title="main.ts", lang="js"}
```
import { bootstrap } from '@angular/platform-browser-dynamic';
import { DemoAppComponent } from './app/index';

bootstrap(DemoAppComponent);
```

__Erklärung__:

* Zeile 1: Importiert die Initialisierungsfunktion die wir brauchen, um die Anwendung im Browser zu initialisieren
* Zeile 2: Importiert unsere Hauptkomponente. Die index.ts-Datei ist ein sogenanntes [barrel](#gl-barrel). Die Datei wurde von angular-cli automatisch angelegt
* Zeile 4: Die Hauptkomponente wird der Initialisierungsfunktion (bootstrap) übergeben und die Anwendung wird initialisiert. Die Hauptkomponente erkennt man dadurch, dass diese der bootstrap-Funktion als Parameter übergeben wird


Als letztes schauen wir uns die index.html-Datei an. Diese Datei befindet sich ebenfalls im Unterverzeichnis "app".

{title="index.html", lang=html}
```
...

<body>
  <demo-app>Loading...</demo-app>

  ...

</body>
```

__Erklärung__:

Wir schauen uns nur ein Ausschnitt aus der Datei an und zwar den Teil in dem unsere Anwendung gerendert wird (Zeile 4).
Initial wird "Loading..." angezeigt bis Angular initialisiert wird.
Der restliche Inhalt befasst sich größtenteils mit dem Laden der Abhängigkeiten, das Laden unserer Hauptdatei (main.ts) und das Definieren des HTML-head-Tags.
Die Abhängigkeiten werden von [SystemJS](https://github.com/systemjs/systemjs) geladen.

Um den Beispiel-Code aus Github im Browser anzuzeigen, müssen wir mittels `npm install` die Abhängigkeiten installieren und dann mit `ng serve` den Server starten.

### Diskussion

Unser Code-Beispiel nutzt Angular im Entwicklungsmodus.
Darüber informiert uns auch Angular, wenn wir im Browser die Konsole offen haben.
Wir werden in einem weiteren Rezept sehen wie wir Angular 2 in Produktion nutzen können.

#### Komponentendefinition

Bei der Definition einer Komponente, darf sich kein Code zwischen @Component() und der Klasse befinden.
Da sind nur Kommentare und/oder Leerzeilen erlaubt.
Falls sich da Code befindet, wird es beim Aufrufen von `ng serve` ein Fehler geben.

{linenos=off}
```text
Decorators are not valid here
```

#### Bootstrap

Der/die eine oder andere Leser/Lesering mag sich jetzt fragen, warum wir nicht einfach eine TypeScript-Datei mit der Komponentendefinition und die bootstrap-Funktion haben.
Natürlich hätten wir das auch machen können aber die Aufspaltung in zwei Dateien bringt ein paar Vorteile mit sich.
Zum einen vermischen wir nicht die Komponentendefinition und die Initialisierung der Anwendung.
Die Komponentendefinition ist allgemein und könnte auf unterschiedlichen Plattformen verwendet werden.
Die bootstrap-Funktion ist Browser spezifisch, daher auch der Import von "@angular/platform-browser-dynamic" und nicht "@angular/core".
Das heißt, dass wir theoretisch mehrere Initialisierungsdateien haben könnten z. B. eine für den Browser und eine für den Server, die die gleiche Hauptkomponente verwenden.
Die Aufspaltung erhöht also die Wiederverwendbarkeit unserer Hauptkomponente.
Ein weiterer Vorteil ist die Erhöhung der Testbarkeit unserer Hauptkomponente.
Wenn sich der bootstrap-Aufruf in der gleichen Datei befindet wie unsere Hauptkomponente, wird es bei einem Unit-Test Fehlermeldungen geben, da wir nicht nur die Komponente testen, sondern auch die Anwendung initialisieren.

### Code

Code auf Github: [02-Basic\_Recipes/02-Angular\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/02-Angular_App)

### Weitere Ressourcen

* Informationen über [ECMAScript-Module](http://exploringjs.com/es6/ch_modules.html)
* Weitere Eigenschaften des Component-Decorators gibt es auf der Angular 2 Webseite: [ComponentMetadata](https://angular.io/docs/ts/latest/api/core/ComponentMetadata-class.html)
* Decorators werden vermutlich als Teil einer späteren Version des ECMAScript-Standards spezifiziert. Mehr Informationen über Decorators in TypeScript und JavaScript gibt es [hier](https://github.com/wycats/javascript-decorators)
* Weitere Informationen über die Angular-Templates gibt es in [Appendix A: Template-Syntax](#appendix-a)

## Komponente definieren {#c02-component-definition}

### Problem

Ich möchte weitere Komponenten nutzen, um meine Anwendung modularer zu gestalten.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Datei für die neue Komponente (second.component.ts)
* Anpassungen an der Hauptkomponente (demo.component.ts), die wir im Rezepte "Angular 2 Anwendung" definiert haben

### Lösung

{title="second.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
    selector: 'app-second',
    template: '<div>My Name is ...</div>'
})
export class SecondComponent {}
```

__Erklärung__:

Diese Datei ist auch ein ESM und beinhaltet die Komponentendefinition für eine Komponente namens "SecondComponent".
Genau wie unsere Hauptkomponente, definiert diese die selector- und die template-Eigenschaften.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';

import { SecondComponent } from './second.component';

@Component({
  selector: 'demo-app',
  template: '<div>Hello World!</div><app-second></app-second>',
  directives: [SecondComponent]
})
export class DemoAppComponent {}
```

__Erklärung__:

* Zeile 3: Hier importieren wir unsere zweite Komponente
* Zeile 7: Wir haben den Tag __<app-second></app-second>__ in das Angular-Template hinzugefügt. Zu beachten ist, dass der Tag-Namen gleich dem Selektor in Zeile 4 in der second.component.ts-Datei sein muss
* Zeile 8: Mit der directives-Eigenschaft definieren wir welche Direktiven bzw. Komponenten im Template benutzt werden können

### Diskussion

Es ist sehr wichtig, dass wir alle Komponenten, die wir im Angular-Template nutzen auch in dem directives-Array definieren.
Tags die zu keiner Komponente gehören werden von Angular ignoriert und bleiben leer.

Die Komponente "SecondComponent" ist jetzt eine Unterkomponente (auf Englisch child component) von unsere Hauptkomponente.
Indem wir Komponenten importieren und dann im Template nutzen, können wir beliebig große Komponentenbäume erzeugen.
Tatsächlich ist eine Angular 2 Anwendung nur ein Baum von Komponenten mit der Hauptkomponente an der Spitze und beliebig viele Unterkomponenten.

#### Selektoren

Es wird empfohlen ein Präfix für den Selektor von Komponenten zu nutzen.
Deshalb ist der Selektor der "SecondComponent" nicht nur "second", sondern "app-second".
Der Präfix hat zwei Funktionen:

* Einerseits zeigt dieser, dass eine Komponente von uns implementiert worden ist und nicht von externe Quellen importiert wird
* Anderseits wird der Präfix benutzt, um anzugeben zu welchem Teil unserer Anwendung eine Komponente gehört

Bei größeren Anwendungen ist es nicht ungewöhnlich die Anwendung in mehreren Unterverzeichnissen aufzuteilen wobei jedes Verzeichnis ein Feature bezeichnet.
Z. B. kann eine große Anwendung ein Nutzerbereich und ein Adminbereich haben.
In so einem Fall können alle Komponenten des Nutzerbereichs das Präfix "user" haben und alle Komponenten des Adminbereichs das Präfix "admin".

### Code

Code auf Github: [02-Basic\_Recipes/03-Define\_Component](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/03-Define_Component)

### Weitere Ressourcen

* Der [Angular Styleguide](https://angular.io/styleguide) gibt Hintergrundinformationen über Namenskonventionen, die Verzeichnisstruktur von Angular 2 Anwendungen und über andere Best Practices

## Ein Service definieren {#c02-define-service}

### Problem

Ich möchte einen Service definieren und nutzen, damit ich so Teile meiner Logik und Daten aus der Komponente entfernen kann.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* Eine Datei für unseren Service (data.service.ts)
* Injectable-Decorator (@Injectable)

### Lösung

Was wir in der Angular-Welt ein Service nennen, ist im Grunde genommen nur eine TypeScript-Klasse.
Services werden benutzt, um Daten und Logik außerhalb von Komponenten zu bewahren.
Somit können wir die Methoden und die Daten eines Service in mehreren Komponenten wiederverwenden.

{title="data.service.ts", lang=js}
```
import { Injectable } from '@angular/core';

const data = ['a', 'b', 'c'];

@Injectable()
export class DataService {
  data: Array<string>;
  constructor() {
    this.data = data;
  }

  getData() {
    return this.data;
  }
}
```

__Erklärung__:

* Zeile 5: Hier nutzen wir den Injectable-Decorator, um den Service als "Injectable" zu definieren
* Zeilen 6-15: Die Klasse, die unseren Service repräsentiert. Diese wird auch exportiert, so dass wir den Service in Komponenten und anderen Services nutzen können


Wir haben jetzt einen Service definiert und den werden wir jetzt in unsere Komponente nutzen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { DataService } from './data.service';

@Component({
  selector: 'demo-app',
  providers: [DataService],
  template: '<div>Hello World!</div>'
})
export class DemoAppComponent {
  constructor(dataService: DataService) {
    console.log(dataService.getData());
  }
}
```

__Erklärung__:

* Zeile 2: DataService importieren
* Zeile 6: Die providers-Eigenschaft sagt Angular welche Services der Komponente und ihre Unterkomponenten zur Verfügung stehen. Nur Services die hier definiert sind können als Konstruktorparameter benutzt werden (Siehe auch Zeile 10)
* Zeile 10: Hier definieren wir den "DataService" als Abhängigkeit unserer Komponente. Zur Laufzeit wird die Konstruktorfunktion eine Instanz des "DataService" bekommen
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

{title="Inject-Decorator statt Typ", lang=js}
```
...

import { Inject } from '@angular/core';
import { DataService } from './data.service';

...

class DemoAppComponent(@Inject(DataService) dataService) { ... }

...
```

Wir haben unsere Diskussion möglichst kurz gehalten.
Eine ausführlichere Erklärung wie Dependency Injection in Angular funktioniert würde den Rahmen eines Rezepts sprenden.
Eine vollständige Erklärung wie Dependency Injection funktioniert und was wir alles damit machen können gibt es auf der Angular 2 Webseite: [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html).
Da wird auch beschrieben wie wir komplexere Provider-Rezepte nutzen können und was wir außer Services als Abhängigkeiten definieren können.

### Code

Code auf Github: [02-Basic\_Recipes/04-Define\_Service](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/04-Define_Service)

