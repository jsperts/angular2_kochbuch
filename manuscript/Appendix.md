# Appendix A: Template-Syntax {#appendix-a}

Angular 2 nutzt Templates die uns erlauben die View von Komponenten zu definieren.
Diese Templates unterstützen den Großteil der HTML-Syntax und sie unterstützen auch eine spezielle Syntax die uns z. B. ermöglicht Daten, die sich in Komponenten befinden dem Nutzer anzuzeigen.
Wir werden gleich sehen wie die spezielle Angular-Syntax für Templates aussieht und, was wir damit machen können.
Hier handelt es sich nur um eine Kurzfassung mit den wichtigsten Informationen.
Die offizielle Angular Dokumentation gibt weitere Details über die [Template-Syntax](https://angular.io/docs/ts/latest/guide/template-syntax.html).

## Template-Ausdruck

Angular erlaubt die Nutzung von Ausdrücken in den Templates.
Diese sind ähnlich zur JavaScript Ausdrücken allerdings sind in Template-Ausdrücken nicht alle JavaScript-Konstrukte erlaubt.
Z. B. sind Konstrukte mit Nebeneffekten nicht erlaubt.
Es ist also nicht möglich Zuweisungen, "new", "++", usw. zu nutzen.
Des Weiteren hat der Operator "|" eine andere Bedeutung in Angular-Templates als in JavaScript.
Hier wird er benutzt, um das Resultat eines Ausdrucks zu transformieren bevor dieses in der View benutzt wird.
Angular bezeichnet den Operator als "Pipe-Operator".
Wie der funktioniert, wird in den entsprechenden Rezepten gezeigt.
Eine weitere Besonderheit von Template-Ausdrücken, ist die Existenz des sogenannten "Elvis-Operators" (?.).
Dieser kann uns helfen, wenn wir im Template mit Objekten arbeiten die __null__ oder __undefined__ sein könnten.
Da Methodenaufrufe erlaubt sind, müssen wir als Entwickler selbst achten, dass der Aufruf keine Nebeneffekte hat.
Wichtig zu beachten ist der Kontext in dem die Template-Ausdrücke evaluiert werden.
Wir können nur Eigenschaften der Komponente zu, der die View gehört und lokale Variablen, die im Template definiert sind nutzen.

## Template-Anweisung

Template-Anweisungen erlauben uns das Aktualisieren des Zustands unserer Anwendung.
Sie werden bei Event-Bindungen benutzt und können Nebeneffekte haben.
Sie sind also eine Reaktion auf Events, die durch den Nutzer ausgelöst werden z. B. click-Event.
Wie auch Template-Ausdrücken, nutzen Template-Anweisungen in eine JavaScript-ähnliche Syntax.
Aber auch hier ist nicht alles erlaubt, was in eine JavaScript-Anweisung erlaubt ist.
Z. B. sind "new" "++" und bit-Operationen nicht erlaubt.
Auch die Nutzung von globalen Variablen ist nicht erlaubt.
Nur Eigenschaften der Komponente zu, der die View gehört und lokale Variablen, die im Template definiert sind können benutzt werden.

## Daten-Bindung

Angular bietet verschiedene Möglichkeiten, um Daten die sich in einer Komponente befinden in der dazugehörige View zu nutzen.
Damit man die Daten nutzen kann, müssen diese als Eigenschaften der Komponente definiert sein.
Das heißt für uns, sie müssen Eigenschaften des this-Wertes der Komponenten-Klasse sein.

Wir unterscheiden zwischen "einweg-Daten-Bindung" und "beidseitige-Daten-Bindung".
Bei der einweg-Daten-Bindung fließen die Daten entweder von der View in die Komponente oder von der Komponente in die View.
Bei der beidseitige-Daten-Bindung fließen die Daten mit nur einem Bindungskonstrukt in beide Richtungen.
Unter Bindungskonstrukt verstehen wir die Syntax, die wir brauchen, um Angular zu signalisieren, dass hier Daten gebunden werden sollen.
Jetzt werden wir sehen wie wir die verschiedene Bindungskonstrukte nutzen können und was diese bewirken.

### Daten nutzen mittels Interpolation

Wir können Template-Ausdrücken interpolieren, indem wir doppelte geschweifte Klammern __{{...}}__ nutzen.
Der Template-Ausdruck wird zwischen den Klammern geschrieben.
Vor der Ausdruck angezeigt oder eine HTML-Attribut zugewiesen werden kann wird er evaluiert.
Das Resultat der Evaluation wird in einem String umgewandelt und zuletzt mit den Strings, die sich links und rechts von den Klammern befinden konkateniert.
Bei der String-Umwandlung, nutzt Angular die toString-Methode.
Darum ist es selten sinnvoll einer Referenz zu einem Objekt bei der Interpolation zu nutzen.
Wenn man Daten von Objekten anzeigen möchte, muss man im Template auf die einzelnen Eigenschaften des Objekts zugreifen.

Angenommen wir haben eine Komponenten-Eigenschaft namens "data" mit einem String-Wert von "test data" können wir Interpolation nutzen, um den Wert anzuzeigen.
So geht das:

{line-numbers=off, lang=html}
```
<div>My data: {{data}}</div>
```

Was der Nutzer auf seinem Bildschirm sehen wird ist "My data: test data".
Komplexere Ausdrücke sind auch möglich:

{line-numbers=off, lang=html}
```
<div> 1 + 2 is {{1 + 2}}</div>
```

Hier wird dem Nutzer "1 + 2 is 3" angezeigt.
Das Resultat der Interpolation, kann auch als Wert für ein HTML-Attribut benutzt werden:

{line-numbers=off, lang=html}
```
<img src="{{url}}" />
```

Hier wird angenommen, dass unsere Komponente eine Eigenschaft namens "url" besitzt, die eine URL für das src-Attribut als Wert hat.
Die Interpolation ist eine einweg-Bindung bei der die Daten aus der Komponente in die View fließen.

### Eigenschaft-Bindung

Diese Art von Bindung wird mit Eigenschaften von (Unter-) Komponenten, Direktiven und DOM-Elementen benutzt.
Der Namen der Eigenschaft wird als Ziel der Bindung bezeichnet.

W> #### Bindungs-Ziel
W>
W> Wichtig zu beachten ist, dass wir bei Direktiven und Komponenten nicht jede Eigenschaft als Ziel einer Bindung nutzen können. Wir können nur spezielle Eigenschaften, die als "inputs" definiert worden sind binden. Solche Eigenschaften sind auch als input-Eigenschaften bekannt.

Bei der Eigenschafts-Bindung reden wir von eine einweg-Bindung, wobei die Daten aus einem Template-Ausdruck in das Ziel der Bindung fließen.
Eigenschaft-Bindungen können wir mit eckigen Klammern __[...]__ definieren.
Hier ein Beispiel:

{line-numbers=off, lang=html}
```
<img [src]="url"/>
```

Der Namen zwischen der Klammern (hier "src") ist das Ziel der Bindung.
Auf der rechten Seite der Eigenschafts-Bindung befindet sich ein Template-Ausdruck, der evaluiert wird und dann als Wert der src-Eigenschaft gesetzt wird.
Alternativ können wir auch die Eigenschaft-Bindung mit der bind-Syntax realisieren:

{line-numbers=off, lang=html}
```
<img bind-src="url"/>
```

Hier wird "bind-" als Präfix, statt eckigen Klammern benutzt.
Das Resultat ist dasselbe egal welche Syntax wir nutzen.
Es ist also Geschmackssache, ob man Klammern oder "bind-" nutzt.

W> #### HTML-Attribut vs. DOM-Eigenschaft
W>
W> Wir müssen hier zwischen HTML-Attribute und DOM-Eigenschaften unterscheiden. Oft gibt es Attribute die den gleichen Namen haben wie DOM-Eigenschaften z. B. "src". In Angular werden Attribute benutzt, um initiale Werte zu setzen und diese Werte sind statisch. Sobald wir Daten-Bindungen nutzen, nutzen wir automatisch DOM-Eigenschaften. Streng genommen haben wir also bei der Interpolation die src- und die textContent-Eigenschaft der Elemente gesetzt. Da es gewisse Attribute gibt, die zu keiner DOM-Eigenschaft gehören, bietet Angular auch eine spezielle Syntax an, um Attribute zu binden. Diese werden wir später sehen.

### Event-Bindung

Bis jetzt haben wir uns mit Bindungen beschäftigt, die uns erlaubt haben Daten der Komponente in der View zu nutzen.
Jetzt geht es um eine Art der Bindung, die zwar auch eine einweg-Bindung ist, die aber in die andere Richtung geht.
Hier fließen Daten von der View in die Komponente.
Dafür nutzen wir eine spezielle Syntax mit Klammern __(...)__.
Zwischen den Klammern kommt der Name eines Events.
Wir können DOM-Events nutzen wie z. B. "click", "change", etc. oder wir können eigene Events definieren.
Eigene Events werden in Komponenten und Direktiven definiert.
Hier ein Beispiel für das click-Event:

{line-numbers=off, lang=html}
```
<button type="button" (click)="doSomething()">Do</button>
```

Der Namen zwischen den Klammern wird als das Ziel-Event bezeichnet.
In unserem Beispiel ist "click" das Ziel-Event.
Wenn also der Nutzer auf den Button klickt, wird die doSomething-Methode der Komponenten aufgerufen.
Alternativ können wir auch folgende Syntax verwenden:

{line-numbers=off, lang=html}
```
<button type="button" on-click="doSomething()">Do</button>
```

Das "on-" Präfix wird statt den Klammern benutzt.
Auch hier ist es Geschmackssache welche Syntax verwendet wird.
Das Resultat ist gleich.

W> #### Eigene Events in Komponenten und Direktiven
W>
W> Es ist wichtig zu beachten, dass eigene Events auch Eigenschaften der Komponente/Direktive sind und zwar sind es spezielle Eigenschaften die als "outputs" definiert worden sind. Solche Eigenschaften sind auch als output-Eigenschaften bekannt. Als Wert, haben output-Eigenschaften eine Instanz der EventEmitter-Klasse.

#### Event-Objekt

Wenn der Nutzer ein Event auslöst, gibt es in der Regel auch ein dazugehöriges Event-Objekt.
Wir können auf das Event-Objekt zugreifen, durch einen speziellen Parameter namens "$event"
Der $event-Parameter referenziert das Event-Objekt.
Wie dieses Objekt aussieht, hängt vom Event-Typ ab.
Bei DOM-Events bekommen wir das dazugehörige DOM-Event-Objekt.
Bei eigene Events, definiert der Entwickler wie das Event-Objekt aussieht.
So bekommen wir Zugriff auf eine Event-Objekt:

{line-numbers=off, lang=html}
```
<button type="button" (click)="doSomething($event)">Do</button>
```

In der doSomething-Methode können wir das Event-Objekt nutzen.
Da wir bei der Event-Bindung, Template-Anweisungen statt Template-Ausdrücken nutzen, gibt es auch eine weitere Möglichkeit das Objekt zu bekommen und zwar mit eine Zuweisung.

{line-numbers=off, lang=html}
```
<button type="button" (click)="myEvent = $event">Do</button>
```

Jetzt haben wir in der Komponente Zugriff auf das Event-Objekt über die myEvent-Eigenschaft der Komponente.
Statt dem __$event__, können wir auch direkt ein Wert zuweisen oder der doSomething-Methode einen anderen Wert übergeben:

{line-numbers=off, lang=html}
```
<button type="button" (click)="name = 'Max'">Do</button>
<button type="button" (click)="doSomething('Max')">Do</button>
```

Jetzt beinhaltet die name-Eigenschaft den Wert __`'`Max`'`__ und die doSomething-Methode bekommt __`'`Max`'`__ als Wert übergeben.
Natürlich können auch lokale Variablen oder Eigenschaften als Wert übergeben bzw. zugewiesen werden.

### Beidseitige-Daten-Bindung

Um eine beidseitige-Daten-Bindung nutzen zu können, brauchen wir spezielle Direktiven und ein weiteres Bindungskonstrukt.
Angular bietet uns von Haus aus eine solche Direktive und zwar die NgModel-Direktive.
Das Bindungskonstrukt sind Klammern umgeben von eckigen Klammern __[(...)]__.
Wie man vermutlich aus der Syntax schon erkennen kann ist eine beidseitige-Daten-Bindung eine Kombination von einer Eigenschafts- und einer Event-Bindung.
Beidseitige-Bindungen funktionieren nur mit Eigenschaften von Komponenten und Direktiven aber nicht mit DOM-Eigenschaften.
Hier ein Beispiel mit einem Eingabefeld und der NgModel-Direktive:

{line-numbers=off, lang=html}
```
<input type="text" [(ngModel)]="name"/>
```

Der Wert der name-Eigenschaft wird als Wert des Eingabefeldes gesetzt und wenn der Nutzer den Inhalt des Eingabefeldes verändert, wird sich auch der Wert der name-Eigenschaft verändern.
Es gibt auch hier eine alternativ-Syntax und zwar mit dem "bindon-" Präfix:

{line-numbers=off, lang=html}
```
<input type="text" bindon-ngModel="name"/>
```

Wichtig bei der beidseitige-Bindung ist der Namen der input- und der output-Eigenschaften.
Im Fall von der NgModel-Direktive, hat die input-Eigenschaft den Namen "ngModel" und die output-Eigenschaft den Namen "ngModelChange".
Wir können also die beidseitige-Bindung auch aufspalten, wenn wir das möchten:

{line-numbers=off, lang=html}
```
<input type="text" [ngModel]="name" (ngModelChange)="name = $event"/>
```

I> #### Eigene Direktive mit beidseitige-Bindung
I>
I> Wenn wir eine eigene Direktive mit beidseitige-Bindung schreiben möchten, müssen wir auf die Namen der Eigenschaft und des Events achten. Wenn wir z. B. eine input-Eigenschaft namens "x" haben, muss die output-Eigenschaft (das Event) den Namen "xChange" haben.

### Attributs-Bindung

Es gibt HTML-Attribute, die keine dazugehörige DOM-Eigenschaft besitzen.
Für solche Fälle bietet Angular die Attributs-Bindung an.
Eine Attributs-Bindung ist ähnlich zu einer Eigenschafts-Bindung, sprich in beiden Fällen nutzen wir eckigen Klammern.
Der Unterschied ist, dass wir hier keinen Eigenschafts-Namen haben, sondern ein Keyword __attr__ und dann den Namen des Attributs.
Als Beispiel nutzen wir das colspan-Attribut:

{line-numbers=off, lang=html}
```
<table>
  <tr>
    <td [attr.colspan]="columnSpan">Num of columns</td>
  </tr>
</table>
```

Diese Schreibweise müssen wir für alle Attribute nutzen, die keine dazugehörige DOM-Eigenschaft besitzen.
Es wird empfohlen immer die Eigenschafts-Bindung zu nutzen, außer es gibt keine andere Wahl.
Bei Unsicherheit können wir versuchen eine Eigenschaft zu binden und falls diese nicht existiert, wird Angular eine Exception schmeißen.
Dann wissen wir, dass wir eine Attributs-Bindung nutzen müssen.

### Klassen-Bindung

Eine Klassen-Bindung ist ähnlich zu eine Attributs-Bindung.
Der Unterschied: hier wird das Keyword __class__ statt __attr__ benutzt und nach dem Keyword kommt ein Klassenname.
Hier ein Beispiel:

{line-numbers=off, lang=html}
```
<div [class.red]="isRed"></div>
```

Hier wird die Klasse "red" konditional gesetzt. Falls die Komponenten-Eigenschaft "isRed" __true__ ist, wird die Klasse gesetzt.
Falls diese __false__ ist, wird die Klasse entfernt.
Diese Schreibweise ist ideal, wenn wir nur eine Klasse konditional setzen möchten.
Falls wir mehrere Klassen setzen möchten, ist es besser die NgClass-Direktive zu nutzen.

### Style-Bindung

Bei der Style-Bindung nutzten wir das Keyword __style__ und nach dem Keyword kommt der Namen des Styles.
Genau wie die Klassen-Bindung, ist die Style-Bindung ideal, wenn wir nur ein Style konditional setzen möchten.
Für mehrere Styleänderungen gibt es die NgStyle-Direktive.
Hier ein Beispiel:

{line-numbers=off, lang=html}
```
<div [style.color]="isRed ? 'red' : 'black'"></div>
```

Falls "isRed" __true__ ist, wird das color-Style den Wert __red__ haben.
Falls es __false__ ist, wird das color-Style den Wert __black__ haben.
Mache Styles haben auch eine Maßeinheit z. B. "px", "em" usw.
So können wir auch die Maßeinheit mit definieren:

{line-numbers=off, lang=html}
```
<div [style.width.px]="isBig ? 150 : 50"></div>
```

Wenn "isBig" __true__ ist, wird die Breite des Elementes __150px__ sein.
Falls es __false__ ist, wird die Breite __50px__ sein.

## Lokale Variablen

Wie schon erwähnt, können wir in Templates lokale Variablen definieren und nutzen.
Das Wort "lokal" bedeutet in diesem Fall, dass wir die Variablen nur im Template nutzen können.
Wir haben z. B. in der Klasse der Komponente keinen direkten Zugriff darauf.
Es zwei Arten von lokalen Variablen: Template Referenz-Variablen (template reference variables) und Template Eingabe-Variablen (template input variables).
Diese unterscheiden sich in der Syntax und den Wert der Variable.

### Template Referenz-Variablen

Diese lokalen Variablen haben als Wert eine Referenz zu einem DOM-Element oder eine Direktive (zur erinnerung, Komponenten sind auch Direktiven).
Um Template Referenz-Variablen zu definieren, können wir eine Raute (#) nutzen.
Hier ein Beispiel:

{line-numbers=off, lang=html, title="DOM-Element Referenz"}
```
<div #local></div>
```

Alternativ können wir template Referenz-Variablen auch mit dem "ref-" Präfix definieren.
Hier ein Beispiel:

{line-numbers=off, lang=html, title="DOM-Element Referenz mit ref-"}
```
<div ref-local></div>
```

In beiden Fällen ist der Wert von "local" das div-Element.
Wie oben erwähnt kann eine Template Referenz-Variable auch eine Referenz zu eine Direktive sein.
Damit die lokale Variable eine Referenz zu eine Direktive sein kann, müssen wir eine Zuweisung nutzen und die Direktive muss die exportAs-Eigenschaft setzen.
Natürlich muss auf dem Tag auch eine entsprechende Direktive definiert sein.
Hier ein Beispiel:

{line-numbers=off, lang=html, title="Direktive Referenz}
```
<form #local="ngForm"></form>
```

Hier hat "local" eine Referenz zu der NgForm-Direktive als Wert. Wichtig zu beachten: NgForm nutzt "exportAs" mit __`'`ngForm`'`__ (ein String) als Wert und wir nutzen den Namen "ngForm" bei der Zuweisung. Ein anderer Name würde zu einem Fehler führen.
Ob eine Direktive einen Wert für die exportAs-Eigenschaft setzt, können wir in der Regel in der Dokumentation nachlesen.
Auch hier können wir das "ref-" Präfix nutzen:

{line-numbers=off, lang=html, title="Direktive Referenz mit ref-"}
```
<form ref-local="ngForm"></form>
```

### Template Eingabe-Variablen

Der Wert von Template Eingabe-Variablen wird von Direktiven gesetzt.
Diese Art von lokalen Variablen funktioniert nur mit strukturellen Direktiven, sprich Direktiven die ein Template nutzen wie z. B. NgFor.
In diesem Fall hat das Wort "lokal" eine leicht veränderte Bedeutung.
Diese Variable können nicht im gesamten Angular-Template benutzt werden, sondern nur im Template der Direktive, die die Variablen definiert.
Hier ein Beispiel:

{line-numbers=off, title="Implizite Eingabe-Variable mit NgFor", lang=html}
```
<li *ngFor="let local of objectsArray"></li>
```

Das li-Element definiert das Template für die NgFor-Direktive.
In diesem Fall ist der Wert von "local" eine Referenz auf das aktuelle Element im Array und kann nur innerhalb des li-Elements benutzt werden.
Die Eingabe-Variable ist implizit da wir für "local" keine Zuweisung nutzen.
Eine Direktive kann auch mehrere Template Eingabe-Variablen definieren.
Hier noch ein Beispiel mit NgFor und eine weitere Variable:

{line-numbers=off, title="Explizite Eingabe-Variable mit NgFor", lang=html}
```
<li *ngFor="let l of objects; let local = index"></li>
```

Hier ist der Wert von "local" der Index des aktuellen Elements. Wie oben ist "l" das aktuelle Element.
Auch hier kann "local" nur innerhalb des li-Elementes benutzt werden.
Die Variable ist explizit da wir für "local" eine Zuweisung nutzen.
Die rechte Seite der Zuweisung ist der Namen einer Eigenschaft.
Die Direktive ist dafür zuständig diesen Namen als Eingabe-Variable zu definieren.
Wir können nur Namen nutzen, die die Eigenschaft in den Kontext des Templates setzt (das macht diese zu Eingabe-Variablen).
Wir können also nicht beliebige Eigenschaften einer Direktive bei der Zuweisung nutzen.

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

In dieses Verzeichnis gehören alle Ressourcen die wir für unsere Anwendung brauchen, die aber nicht Teil des Build-Prozesses sind wie z. B. Bilder und Fonts.

### src

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

