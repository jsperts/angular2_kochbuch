# Appendix B: angular-cli {#appendix-b}

In den Rezepten nutzen wir angular-cli hauptsächlich, um einen Webserver für den Beispiel-Code zu starten. Das Tool kann aber noch einiges mehr.
Wir wollen uns hier angular-cli ein bisschen genauer anschauen.
Konkreter werden wir uns die wichtigsten Kommandos anschauen und uns einen groben Überblick über die Verzeichnisstruktur, die angular-cli generiert, verschaffen.

Der Hauptvorteil von angular-cli ist, dass wir damit mit wenig Aufwand einen Entwicklungsprozess für Angular 2 Anwendungen komplett mit Linting, Konfigurationsdateien für Tests, einem Webserver mit Live-Reload, einem Build-Prozess, um die TypeScript-Dateien zu kompilieren, und mehr, aufbauen können.
Würden wir das alles manuell machen, wären wir sicherlich mehrere Stunden damit beschäftigt.

I> angular-cli basiert auf [ember-cli](http://ember-cli.com/), es kann also sein, dass hier und da noch "ember-cli" anstelle von "angular-cli" steht.

## Installation

Als Erstes müssen wir __Node.js__ und __npm__ installieren, damit wir im zweiten Schritt __angular-cli__ installieren können.
Am einfachsten können wir Node.js installieren, indem wir es von der [offiziellen Webseite](https://nodejs.org/en/download/) herunterladen.
Bei der Installation von Node.js wird npm mitinstalliert.
Jetzt können wir angular-cli installieren mit:

```bash
npm install -g angular-cli@1.0.0-beta.19
```

Wir installieren angular-cli global und können es in jedem Angular 2 Projekt nutzen.

I> #### Node.js/npm Versionen
I>
I> angular-cli braucht eine relativ neue Version von Node.js und npm. Laut der Dokumentation soll die Version von Node.js ≥ 4 sein. Für das Buch wurde angular-cli mit der Version 6.9.1 von Node.js und Version 3.10.8 von npm getestet.

I> #### Fehler bei der Installation/Projekt-Initialisierung
I>
I> Bei Fehlern hilft es, angular-cli zu löschen und neu zu installieren. Fehler können vor allem auftreten, wenn eine alte Version von angular-cli schon installiert ist. Die Github-Seite von angular-cli beinhaltet Informationen, wie angular-cli [aktualisiert](https://github.com/angular/angular-cli#updating-angular-cli) werden kann.

Jetzt können wir das Tool für unsere Projekte nutzen.

## Kommandos

Folgende Kommandos werden wir uns detaillierter anschauen:

* new
* init
* serve
* build
* lint
* test
* generate

Das sind zwar nicht alle Kommands, sie sollten aber für die meisten Projekte reichen.
Mit dem help-Kommando können wir uns alle Kommandos von angular-cli inklusive der unterstützten Optionen anschauen.

```bash
ng help
```

Um mehr Informationen über ein Kommando zu bekommen, können wir die `--help` Option nutzen:

```bash
ng --help kommandoName
```

Wir werden uns nicht jede Option für jedes Kommando anschauen.
Wer mehr erfahren möchte, kann die help-Option nutzen oder im Github-Repository von [angular-cli](https://github.com/angular/angular-cli) nachschauen.
Allerdings sind nicht alle Kommandos bzw. Optionen gleich gut dokumentiert.

### new

```bash
ng new projektName
```

Dieses Kommando wird ein Verzeichnis mit dem Namen "projektName" erzeugen, darin die nötigen Verzeichnisse/Dateien anlegen und alle Abhängigkeiten mittels npm installieren.
Standardmäßig wird das neue Verzeichnis als git-Repository initialisiert.
Das können wir mit der `--skip-git`-Option verhindern.
Falls wir uns schon in einem git-Repository befinden, wird angular-cli kein neues Repository initialisieren.

W> #### Projektnamen
W>
W> Derzeit wird nicht jeder beliebige Name als Projektname unterstützt. Z. B. ist "test" kein gültiger Projektname. Das Tool gibt eine Fehlermeldung aus, falls der Projektname nicht zulässig ist.

### init

Das init-Kommando macht das gleiche wie das new-Kommando, aber es initialisiert die Anwendung im aktuellen Verzeichnis.

```bash
ng init --name projektName
```

Falls `--name projektName` nicht angegeben wird, wird der Name des Verzeichnisses als Projektname benutzt.

### build

Das build-Kommando kompiliert/baut die Anwendung und schreibt die JavaScript-Dateien und SourceMaps in das dist-Verzeichnis.

```bash
ng build
```

Die gebaute Version der Anwendung ist für die Entwicklung gedacht.
Diese ist also nicht minimiert.

```bash
ng build --prod
```

Baut eine minimierte Version der Anwendung, die wir später auch für das Produktivsystem nutzen können.

### serve

Das serve-Kommando kompiliert/baut die Anwendung und startet einen Webserver mit Live-Reload.

```bash
ng serve
```

Standardmäßig nutzt der Webserver Port 4200 und hört auf alle Interfaces.
Mit den Optionen `--port` und `--host` können wir das ändern.

### lint

Das [tslint](https://www.npmjs.com/package/tslint)-Tool ist in angular-cli integriert und ermöglicht uns das Testen des Codes auf mögliche Verletzungen von Best Practices und Code-Konventionen.
Tslint überprüft den TypeScript-Code.
Es gibt aber auch spezielle Regeln für Angular 2. Diese werden von [codelyzer](https://github.com/mgechev/codelyzer) zur Verfügung gestellt.

```bash
ng lint
```

Falls nötig, können wir die Regeln für tslint und codelyzer in der tslint.json-Datei anpassen bzw. ergänzen.
Beide Tools unterstützen noch weitere Regeln, die sich nicht in der tslint.json-Datei befinden.
Es ist ggf. lohnenswert, sich die Webseiten der Tools anzuschauen, um zu sehen was es sonst noch an Regeln gibt und ob es sinnvoll wäre, diese zu nutzen.

### test

Das test-Kommando startet die Unit-Tests für das Projekt.
Bei der Initialisierung wurden schon die nötigen Konfigurationsdateien angelegt und die Abhängigkeiten installiert.
Wir brauchen also nur Tests zu schreiben und dann:

```bash
ng test
```

aufzurufen.

Bevor die Tests aufgerufen werden, wird die Anwendung gebaut.
Nach dem Bauen startet [karma](https://karma-runner.github.io/1.0/index.html) Chrome und führt die Unit-Tests aus.
Diese werden standardmäßig mit [Jasmine](http://jasmine.github.io/) geschrieben.
Wenn die Tests durchgelaufen sind, bleibt der Browser offen und wartet auf Änderungen.
Bei jeder Änderung führt karma die Tests erneut aus.
Die Konfiguration für karma befindet sich in der karma.conf.js-Datei im config-Verzeichnis.

### generate

Mit dem generate-Kommando können wir Komponenten, Direktiven, Services usw. generieren.
Dabei erzeugt angular-cli alle nötige Dateien mit dem angegebenen Namen und befüllt diese mit dem richtigen boilerplate-Code.

Um eine neue Komponente zu generieren, können wir folgenden Befehl nutzen:

```bash
ng generate component komponenten-name
```

Standardmäßig wird für jede Komponente ein Verzeichnis angelegt.
Mit der `--flat` Option können wir das verhindern.
Die Komponente wird in dem Verzeichnis generiert, in dem wir den Befehl aufrufen oder in "./src/app", falls der Befehl außerhalb des app-Verzeichnises ausgeführt wird.

Für die Komponente wird eine .ts-, eine .spec.ts-, eine .css- und eine .html-Datei generiert.
Wenn wir lieber inline-HTML bzw. -CSS nutzen möchten, können wir die Optionen `--inline-template` bzw. `--inline-style` nutzen.
Dann werden die .html- und .css-Dateien nicht generiert.
Die neu generierte Komponente wird auch automatisch im AppModule deklariert.

Im Allgemeinen sieht das Kommando so aus:

```bash
ng generate blueprint name
```

Oben haben wir "blueprint" durch "component" ersetzt.
Es gibt weiter blueprint für Services, Direktiven, Routes, usw.
Um es kurz zu halten, werden wir uns diese hier nicht anschauen.
Der Aufruf für die weiteren Blueprints ist ähnlich zu dem für die Komponenten, allerdings haben die meisten anderen Blueprints weniger Optionen.
Am besten ist es, ein Dummy-Projekt zu initialisieren und die verschiedenen Kommandos von angular-cli zu testen.

W> #### Namen
W>
W> Derzeit wird nicht jeder beliebige Name vom generate-Kommando unterstützt. Namen mit Unterstriche und camelCase Namen werden durch Bindestriche ersetzt was in manchen Fällen zu Fehlern führen kann.

## Verzeichnisstruktur

Die Verzeichnisstruktur, die von angular-cli generiert wird, folgt den Best Practices aus dem [Angular Style Guide](https://angular.io/styleguide).
Wir verschaffen uns jetzt eine grobe Übersicht.

{title="angular-cli Verzeichnisstruktur", lang=js}
```
|- dist/
|- e2e/
|- node_modules/
|- src/
|----- app/
|---------- shared/
|---------------- index.ts
|---------- index.ts
|---------- app.component.css|html|spec.ts|ts
|---------- app.module.ts
|----- assets/
|----- environments/
|----- favicon.ico
|----- index.html
|----- main.ts
|----- polyfills.ts
|----- styles.css
|----- test.ts
|----- tsconfig.json
|----- typings.d.ts
|- .editorconfig
|- .gitignore
|- angular-cli.json
|- karma.conf.js
|- package.json
|- protractor.conf.js
|- README.md
|- tslint.json
```

### /

Das Hauptverzeichnis für das Angular 2 Projekt.
Außer Verzeichnissen beinhaltet es Konfigurationsdateien für verschiedene Tools wie angular-cli, tslint und npm.

### dist/

Wird erst generiert nachdem wir die Anwendung gebaut haben. Dort befindet sich die kompilierte Anwendung.

### e2e/

Verzeichnis für die End-to-End-Tests.

### node\_modules/

Hier befinden sich alle Abhängigkeiten, die mittels npm installiert worden sind.

### src/

In diesem Verzeichnis befindet sich der Code für unsere Anwendung und Konfigurationsdateien, die vom TypeScript-Compiler (tsconfig.json, typings.d.ts) gebraucht werden.

#### src/app/

Das Verzeichnis für unseren Code. Hier werden wir bei der Entwicklung die meiste Zeit verbringen.
Standardmäßig wird eine Komponente und ein Verzeichnis namens "shared" generiert.
In dieses Verzeichnis gehört Code, den wir in mehreren Komponenten nutzen wollen.

#### src/assets

In dieses Verzeichnis gehören alle Ressourcen, die wir für unsere Anwendung brauchen, die aber nicht Teil des Build-Prozesses sind, wie z. B. Bilder und Fonts.

#### src/environments

Die Dateien in diesem Verzeichnis werden für den Build-Prozess benötigt.
Wenn wir die `--prod` Option nutzen, wird die environment.prod.ts-Datei mit der environment.js-Datei benutzt.
Standardmäßig wird die environment.ts-Datei benutzt.

#### src/styles.css

In dieser Datei können wir globale Styles für die Anwendung definieren.

