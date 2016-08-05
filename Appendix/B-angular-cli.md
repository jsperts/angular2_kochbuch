# Appendix B: angular-cli {#appendix-b}

In den Rezepten nutzen wir angular-cli hauptsächlich, um ein Webserver zu starten für den Beispiel-Code aber das Tool kann noch einiges mehr.
Wir wollen uns hier angular-cli ein bisschen genauer anschauen.
Konkreter werden wir uns die wichtigsten Kommandos anschauen und wir verschaffen uns einen groben Überblick über die Verzeichnisstruktur die angular-cli generiert.

Der Hauptvorteil von angular-cli ist, dass es uns erlaubt mit wenig Aufwand ein Entwicklungs-Prozess für Angular 2 Anwendungen aufzubauen komplette mit linting, Konfigurationsdateien für Tests, ein Webserver mit Live-Reload, ein Build-Prozess um die TypeScript-Dateien zu kompilieren und mehr.
Hätten wir das alles manuell gemacht, wären wir sicherlich mehrere Stunden damit beschäftigt.

I> angular-cli basiert auf [ember-cli](http://ember-cli.com/) es kann also sein, dass hier und da noch "ember-cli" statt "angular-cli" steht.

## Installation

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

Das sind zwar nicht alle, sollten aber für die meisten Projekten reichen.
Mit dem help-Kommando, können wir uns alle Kommandos von angular-cli anschauen und welche Optionen diese Unterstützen.

```bash
ng help
```

Um mehr Informationen über ein Kommando zu bekommen, können wir die `--help` Option nutzen:

```bash
ng kommandoName --help
```

Wir werden uns nicht jede Option für jedes Kommando anschauen.
Wer mehr erfahren möchte, kann die help-Option nutzen oder im Github-Repository von [angular-cli](https://github.com/angular/angular-cli) nachschauen.
Allerdings sind nicht alle Kommandos bzw. Optionen gleich gut Dokumentiert.

### new

```bash
ng new projektName
```

Dieses Kommando wird ein Verzeichnis erzeugen mit Namen "projektName" und wird darin die nötigen Verzeichnisse/Dateien anlegen und alle Abhängigkeiten mittels npm installieren.
Standardmäßig wird das neue Verzeichnis als git-Repository initialisiert.
Das können wir mit der `--skip-git` Option verhindern.
Falls wir uns schon in eine git-Repository befinden, wird angular-cli kein neues Repository initialisieren.

W> #### Namen von Projekten
W>
W> Derzeit wird nicht jeder beliebige Name als Projektname unterstützt. Z. B. ist "test" kein gültiger Projektname. Das Tool wird eine Fehlermeldung ausgeben, falls der Projektname nicht zulässig ist.

### init

Das init-Kommando macht das gleiche wie das new-Kommando aber es initialisiert die Anwendung im aktuellen Verzeichnis.

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
ng build -prod
```

Baut eine minimierte Version der Anwendung, die wir später auch für das Produktiv-System nutzen können.
Einige Dateien werden dabei auch konkateniert.
Z. B. wird unsere Code in eine Datei namens "index.js" unter "dist/app/" geschrieben.
Templates und Stylesheets werden derzeit nicht minimiert.

### serve

Das serve-Kommando kompiliert/baut die Anwendung und startet ein Webserver mit Live-Reload.

```bash
ng serve
```

Standardmäßig nutzt der Webserver Port 4200 und hört auf alle Interfaces.
Mit der Optionen `--port` und `--host` können wir das ändern.
Auch "serve" unterstützt die `-prod` Option, um eine minimierte Version der Anwendung zu bauen.
In der Regel wird Live-Reload nicht unterstützt, wenn wir `-prod` nutzen.

### lint

Das [tslint](https://www.npmjs.com/package/tslint) Tool ist in angular-cli integriert und ermöglicht uns das Testen des Codes auf mögliche Verletzungen von Best Practices und Code-Konventionen.
Tslint überprüft den TypeScript-Code.
Es gibt aber auch spezielle Regel für Angular 2, diese werden von [codelyzer](https://github.com/mgechev/codelyzer) zur Verfügung gestellt.

```bash
ng lint
```

Falls nötig, können wir die Regeln für tslint und codelyzer in der tslint.json-Datei anpassen bzw. ergänzen.
Beide Tools haben noch weitere Regel die nicht in der tslint.json-Datei sind.
Es ist ggf. lohnenswert sich die Webseiten von den Tools anzuschauen, um zu sehen was es sonst noch an Regeln gibt und, ob es sinnvoll wäre diese zu nutzen.

W> #### Aktuelle Version (1.0.0-beta.5) funktioniert nicht
W>
W> Die tslint Konfigurationsdatei die mit angular-cli geliefert wird nutzt noch alte Name für codelyzer-Regel. Diese müssen wir anpassen, um `ng lint` nutzen zu können

Die Regeln in der tslint.json-Datei:

```json
"host-parameter-decorator": true,
"input-parameter-decorator": true,
"output-parameter-decorator": true,
"attribute-parameter-decorator": true,
"input-property-directive": true,
"output-property-directive": true
```

Müssen durch:

```json
"use-host-property-decorator": true,
"use-input-property-decorator": true,
"use-output-property-decorator": true,
"no-attribute-parameter-decorator": true,
"no-input-rename": true,
"no-output-rename": true
```
ersetzt werden. Für den Code in diesem Buch wurde das schon gemacht.

### test

Das test-Kommando startet die Unit-Tests für das Projekt.
Bei der Initialisierung wurden schon die nötigen Konfigurationsdateien angelegt und die Abhängigkeiten installiert.
Wir brauchen also nur Tests zu schreiben und dann:

```bash
ng test
```

aufzurufen.

Vor die Tests aufgerufen werden, wird die Anwendung gebaut.
Nach dem Bauen startet [karma](https://karma-runner.github.io/0.13/index.html) Chrome und geht durch die Unit-Tests.
Diese werden standardmäßig mit [Jasmine](http://jasmine.github.io/) geschrieben.
Wenn die Tests durchgelaufen sind, bleibt der Browser offen und wartet auf Änderungen.
Bei jede Änderung geht karma erneut durch die Tests.
Die Konfiguration für karma befindet sich in der karma.conf.js-Datei im config-Verzeichnis.

### generate

Mit dem generate-Kommando können wir Komponenten, Direktiven, Services usw. generieren.
Dabei erzeugt angular-cli alle nötige Dateien mit dem gegebenen Namen und befüllt diese mit dem richtigen boilerplate-Code.

Um eine neue Komponente zu generieren können wir folgenden Befehl nutzen:

```bash
ng generate component komponentenName
```

Standardmäßig wird für jede Komponente ein Verzeichnis angelegt.
Mit der `--flat` Option können wir das verhindern.
Die Komponente wird in dem Verzeichnis generiert in dem wir den Befehl aufrufen.

Für die Komponente wird eine .ts-, eine .spec.ts-, eine .css- und eine .html-Datei generiert.
Wenn wir lieber inline-HTML bzw. -CSS nutzen möchten, können wir die Optionen `--inline-template` bzw. `--inline-style` nutzen.
Dann werden die .html- und .css-Dateien nicht generiert.

Im Allgemeinen sieht das Kommando so aus:

```bash
ng generate blueprint name
```

Oben haben wir "blueprint" durch "component" ersetzt.
Es gibt weiter blueprint für Services, Direktiven, Routes, usw.
Um es kurz zu halten, werden wir uns diese hier nicht anschauen.
Der Aufruf für die weitere blueprints ist ähnlich zu dem für die Komponente allerdings haben die meisten anderen blueprints weniger Optionen.
Am besten ist es ein dummy-Projekt zu initialisieren und die verschiedene Kommandos von angular-cli zu testen.

## Verzeichnisstruktur

Die Verzeichnisstruktur, die von angular-cli generiert wird, folgt die Best Practices die im [Angular Style Guide](https://angular.io/styleguide) definiert sind.
Wir verschaffen uns jetzt eine grobe Übersicht.

{title="angular-cli Verzeichnisstruktur", lang=js}
```
|- config/
|----- environment.dev.ts
|----- environment.js
|----- environment.prod.ts
|----- karma-test-shim.js
|----- karma.conf.js
|----- protractor.conf.js
|- dist/
|- e2e/
|----- app.e2e.ts
|----- app.po.ts
|----- tsconfig.json
|----- typings.d.ts
|- node_modules/
|- public/
|----- .npmignore
|- src/
|----- app/
            |----- shared/
                        |----- index.ts
            |----- environment.ts
            |----- index.ts
            |----- projektName.component.css|html|spec.ts|ts
|----- favicon.ico
|----- index.html
|----- main.ts
|----- system-config.ts
|----- tsconfig.json
|----- typings.d.ts
|- tmp/
|- typings/
|- .clang-format
|- .editorconfig
|- .gitignore
|- angular-cli-build.js
|- angular-cli.json
|- package.json
|- tslint.json
|- typings.json
```

### /

Das Hauptverzeichnis für das Angular 2 Projekt.
Außer Verzeichnisse beinhaltet es Konfigurationsdateien für verschiedene Tools wie angular-cli, typings, tslint und npm.

### config/

Konfigurationsdateien für den Build-Prozess und Tests.
Die environment.\*-Dateien werden für den Build-Prozess benötigt.
Wenn wir die `-prod` Option nutzen, wird die environment.prod.ts-Datei mit der environment.js-Datei benutzt.
Diese ersetzen dann die environment.ts-Datei unter dem Verzeichnis "src/app/".
Standardmäßig wird die environment.dev.ts- und die environment.js-Dateien benutzt.
Die karma-test-shim.js-Datei wird benutzt von karma benutzt, um die Test-Dateien zu laden.
Die karma.conf.js- und die protractor.conf.js-Dateien konfigurieren karma und protractor.

### dist/

Wird erst generiert nach dem wir die Anwendung gebaut haben. Da befindet sich die kompilierte Anwendung.

### e2e/

Verzeichnis für die End-to-End-Tests.

### node\_modules/

Hier befinden sich alle Abhängigkeiten die mittels npm installiert worden sind.

### public/

In dieses Verzeichnis gehören alle Ressourcen die wir für unsere Anwendung brauchen, die aber nicht Teil des Build-Prozesses sind wie z. B. Bilder und Fonts.

### src/

In diesem Verzeichnis befindet sich der Code für unsere Anwendung und Konfigurationsdateien die von SystemJS (system-config.ts) und dem TypeScript-Compiler (tsconfig.json, typings.d.ts) gebraucht werden.

#### src/app/

Das Verzeichnis für unseren Code. Hier werden wir bei der Entwicklung die meiste Zeit verbringen.
Standardmäßig wird eine Komponente mit dem Namen des Projekts generiert und ein Verzeichnis namens "shared".
In diesem Verzeichnis gehört Code den wir in mehrere Komponenten nutzen wollen.
Die environment.ts-Datei wird nur benötigt, damit wir bei der Entwicklung keine Fehler bei den Imports sehen.
Beim Bauen wird diese durch die entsprechende Datei aus dem config-Verzeichnis ersetzt.

### tmp/

Wird beim Bauen und vom Webserver benötigt.
Wenn der Webserver nicht gestartet ist, ist das Verzeichnis in der Regel leer.

### typings/

Hier werden Dateien mit Typ-Informationen gespeichert.
Diese werden hauptsächlich vom Compiler beim Bauen benutzt.

