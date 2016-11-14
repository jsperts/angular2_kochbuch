# Appendix A: Template-Syntax {#appendix-a}

Angular 2 nutzt Templates, die es uns erlauben, die Views der Komponenten zu definieren.
Diese Templates unterstützen den Großteil der HTML-Syntax und sie unterstützen auch eine spezielle Syntax, die es uns z. B. ermöglicht, Daten, die sich in Komponenten befinden, dem Nutzer anzuzeigen.
Wir werden gleich sehen, wie die spezielle Angular-Syntax für Templates aussieht und was wir damit machen können.
Hier handelt es sich nur um eine Kurzfassung mit den wichtigsten Informationen.
Die offizielle Angular Dokumentation gibt weitere Details über die [Template-Syntax](https://angular.io/docs/ts/latest/guide/template-syntax.html).

## Template-Ausdruck

Angular erlaubt die Nutzung von Ausdrücken in den Templates.
Diese sind ähnlich zu JavaScript-Ausdrücken, allerdings sind in Template-Ausdrücken nicht alle JavaScript-Konstrukte erlaubt.
Z. B. sind Konstrukte mit Nebeneffekten nicht erlaubt.
Es ist also nicht möglich, Zuweisungen, "new", "++", usw. zu nutzen.
Des Weiteren hat der Operator "|" in Angular-Templates eine andere Bedeutung als in JavaScript.
Hier wird er benutzt, um das Resultat eines Ausdrucks zu transformieren bevor dieses in der View benutzt wird.
Angular bezeichnet den Operator als "Pipe-Operator".
Wie dieser funktioniert wird in den entsprechenden Rezepten gezeigt.
Eine weitere Besonderheit von Template-Ausdrücken ist die Existenz des sogenannten "Elvis-Operators" (?.).
Dieser kann uns helfen, wenn wir im Template mit Objekten arbeiten, die __null__ oder __undefined__ sein könnten.
Da Methodenaufrufe erlaubt sind, müssen wir als Entwickler selbst darauf achten, dass der Aufruf keine Nebeneffekte hat.
Wichtig zu beachten ist der Kontext, in dem die Template-Ausdrücke evaluiert werden.
Wir können nur Eigenschaften der Komponente zu der die View gehört und lokale Variablen, die im Template definiert sind, nutzen.

## Template-Anweisung

Template-Anweisungen erlauben uns das Aktualisieren des Zustands unserer Anwendung.
Sie werden bei Event-Bindungen benutzt und können Nebeneffekte haben.
Sie sind also eine Reaktion auf Events, die durch den Nutzer ausgelöst werden, z. B. click-Events.
Wie auch Template-Ausdrücke nutzen Template-Anweisungen eine JavaScript-ähnliche Syntax.
Aber auch hier ist nicht alles erlaubt, was in einer JavaScript-Anweisung erlaubt ist.
Z. B. sind "new", "++" und bit-Operationen nicht erlaubt.
Auch die Nutzung von globalen Variablen ist nicht erlaubt.
Nur Eigenschaften der Komponente zu der die View gehört und lokale Variablen, die im Template definiert sind, können benutzt werden.

## Datenbindung

Angular bietet verschiedene Möglichkeiten, Daten, die sich in einer Komponente befinden, in der dazugehörige View zu nutzen.
Damit man die Daten nutzen kann, müssen diese als Eigenschaften der Komponente definiert sein.
Das heißt für uns, sie müssen Eigenschaften des this-Wertes der Komponenten-Klasse sein.

Wir unterscheiden zwischen "Einweg-Datenbindung" und "beidseitiger Datenbindung".
Bei der Einweg-Datenbindung fließen die Daten entweder von der View in die Komponente oder von der Komponente in die View.
Bei der beidseitigen Datenbindung fließen die Daten mit nur einem Bindungskonstrukt in beide Richtungen.
Unter Bindungskonstrukt verstehen wir die Syntax, die wir brauchen, um Angular zu signalisieren, dass hier Daten gebunden werden sollen.
Jetzt werden wir sehen, wie wir die verschiedenen Bindungskonstrukte nutzen können und was diese bewirken.

### Daten mittels Interpolation nutzen

Wir können Template-Ausdrücke interpolieren, indem wir doppelte geschweifte Klammern __{{...}}__ nutzen.
Der Template-Ausdruck wird zwischen die Klammern geschrieben.
Bevor der Ausdruck angezeigt oder einem HTML-Attribut zugewiesen werden kann, wird er evaluiert.
Das Resultat der Evaluation wird in einen String umgewandelt und zuletzt mit den Strings, die sich links und rechts von den Klammern befinden, konkateniert.
Bei der String-Umwandlung nutzt Angular die toString-Methode.
Darum ist es selten sinnvoll, bei der Interpolation eine Referenz auf ein Objekt zu nutzen.
Wenn man Daten von Objekten anzeigen möchte, muss man im Template auf die einzelnen Eigenschaften des Objekts zugreifen.

Angenommen wir haben eine Komponenteneigenschaft namens "data" mit einem String-Wert von "test data". Dann können wir Interpolation nutzen, um den Wert anzuzeigen.
Das geht so:

{line-numbers=off, lang=html}
```
<div>My data: {{data}}</div>
```

Was der Nutzer auf seinem Bildschirm sehen wird, ist "My data: test data".
Komplexere Ausdrücke sind auch möglich:

{line-numbers=off, lang=html}
```
<div> 1 + 2 is {{1 + 2}}</div>
```

Hier wird dem Nutzer "1 + 2 is 3" angezeigt.
Das Resultat der Interpolation kann auch als Wert für ein HTML-Attribut benutzt werden:

{line-numbers=off, lang=html}
```
<img src="{{url}}" />
```

Hier wird angenommen, dass unsere Komponente eine Eigenschaft namens "url" besitzt, die als Wert eine URL für das src-Attribut besitzt.
Die Interpolation ist eine Einweg-Bindung, bei der die Daten aus der Komponente in die View fließen.

### Eigenschaft-Bindung

Diese Art der Bindung wird bei Eigenschaften von (Unter-) Komponenten, Direktiven und DOM-Elementen benutzt.
Der Name der Eigenschaft wird als Ziel der Bindung bezeichnet.

W> #### Bindungs-Ziel
W>
W> Wichtig zu beachten ist, dass wir bei Direktiven und Komponenten nicht jede Eigenschaft als Ziel einer Bindung nutzen können. Wir können nur spezielle Eigenschaften, die als "inputs" definiert worden sind, binden. Solche Eigenschaften sind auch als input-Eigenschaften bekannt.

Bei der Eigenschaft-Bindung reden wir von einer Einwegbindung. Hierbei fließen die Daten aus einem Template-Ausdruck in das Ziel der Bindung.
Eigenschaft-Bindungen können wir mit eckigen Klammern __[...]__ definieren.
Hier ein Beispiel:

{line-numbers=off, lang=html}
```
<img [src]="url"/>
```

Der Namen zwischen der Klammern (hier "src") ist das Ziel der Bindung.
Auf der rechten Seite der Eigenschaft-Bindung befindet sich ein Template-Ausdruck, der evaluiert und dann als Wert der src-Eigenschaft gesetzt wird.
Alternativ können wir auch die Eigenschaft-Bindung mit der bind-Syntax realisieren:

{line-numbers=off, lang=html}
```
<img bind-src="url"/>
```

Hier wird der Präfix "bind-", anstelle der eckigen Klammern verwendet.
Das Resultat ist dasselbe, egal welche Syntax wir nutzen.
Es ist also Geschmackssache, ob man Klammern oder "bind-" nutzt.

W> #### HTML-Attribut vs. DOM-Eigenschaft
W>
W> Wir müssen hier zwischen HTML-Attributen und DOM-Eigenschaften unterscheiden. Oft gibt es Attribute, die den gleichen Namen wie DOM-Eigenschaften besitzen, z. B. "src". In Angular werden Attribute benutzt, um initiale Werte zu setzen. Diese Werte sind statisch. Sobald wir Datenbindungen nutzen, nutzen wir automatisch DOM-Eigenschaften. Streng genommen haben wir also bei der Interpolation die src- und die textContent-Eigenschaft der Elemente gesetzt. Da es gewisse Attribute gibt, die zu keiner DOM-Eigenschaft gehören, bietet Angular auch eine spezielle Syntax an, um Attribute zu binden. Diese werden wir später sehen.

### Event-Bindung

Bis jetzt haben wir uns mit Bindungen beschäftigt, die es uns erlaubt haben, Daten der Komponente in der View zu nutzen.
Jetzt geht es um eine Art der Bindung, die zwar auch eine Einwegbindung ist, die aber in die andere Richtung geht.
Hier fließen Daten von der View in die Komponente.
Dafür nutzen wir eine spezielle Syntax mit Klammern __(...)__.
Zwischen die Klammern kommt der Name eines Events.
Wir können DOM-Events wie z. B. "click", "change", etc. nutzen, oder wir können eigene Events definieren.
Eigene Events werden in Komponenten und Direktiven definiert.
Hier ein Beispiel für das click-Event:

{line-numbers=off, lang=html}
```
<button type="button" (click)="doSomething()">Do</button>
```

Der Name zwischen den Klammern wird als das Ziel-Event bezeichnet.
In unserem Beispiel ist "click" das Ziel-Event.
Wenn also der Nutzer auf den Button klickt, wird die doSomething-Methode der Komponenten aufgerufen.
Alternativ können wir auch folgende Syntax verwenden:

{line-numbers=off, lang=html}
```
<button type="button" on-click="doSomething()">Do</button>
```

Das "on-" Präfix wird statt der Klammern benutzt.
Auch hier ist es Geschmackssache, welche Syntax verwendet wird.
Das Resultat ist gleich.

W> #### Eigene Events in Komponenten und Direktiven
W>
W> Es ist wichtig zu beachten, dass eigene Events auch Eigenschaften der Komponente/Direktive sind. Und zwar sind es spezielle Eigenschaften, die als "outputs" definiert werden. Solche Eigenschaften sind auch als output-Eigenschaften bekannt. Als Wert besitzen output-Eigenschaften eine Instanz der EventEmitter-Klasse.

#### Event-Objekt

Wenn der Nutzer ein Event auslöst, gibt es in der Regel auch ein dazugehöriges Event-Objekt.
Wir können mittels einen speziellen Parameters namens "$event" auf das Event-Objekt zugreifen.
Der $event-Parameter referenziert das Event-Objekt.
Wie dieses Objekt aussieht, hängt vom Event-Typ ab.
Bei DOM-Events erhalten wir das dazugehörige DOM-Event-Objekt.
Bei eigenen Events definiert der Entwickler, wie das Event-Objekt aussieht.
So bekommen wir Zugriff auf ein Event-Objekt:

{line-numbers=off, lang=html}
```
<button type="button" (click)="doSomething($event)">Do</button>
```

In der doSomething-Methode können wir das Event-Objekt nutzen.
Da wir bei der Event-Bindung Template-Anweisungen anstelle von Template-Ausdrücken nutzen, gibt es auch eine weitere Möglichkeit, das Objekt zu erhalten: mittels einer Zuweisung.

{line-numbers=off, lang=html}
```
<button type="button" (click)="myEvent = $event">Do</button>
```

Jetzt haben wir in der Komponente über die myEvent-Eigenschaft Zugriff auf das Event-Objekt.
Statt des __$event__, können wir auch direkt einen Wert zuweisen oder der doSomething-Methode einen anderen Wert übergeben:

{line-numbers=off, lang=html}
```
<button type="button" (click)="name = 'Max'">Do</button>
<button type="button" (click)="doSomething('Max')">Do</button>
```

Jetzt beinhaltet die name-Eigenschaft den Wert __`'`Max`'`__ und die doSomething-Methode bekommt __`'`Max`'`__ als Wert übergeben.
Natürlich können auch lokale Variablen oder Eigenschaften als Wert übergeben bzw. zugewiesen werden.

### Beidseitige Datenbindung

Um eine beidseitige Datenbindung nutzen zu können, benötigen wir spezielle Direktiven und ein weiteres Bindungskonstrukt.
Angular bietet von Haus aus eine solche Direktive, und zwar die NgModel-Direktive.
Das Bindungskonstrukt sind Klammern umgeben von eckigen Klammern __[(...)]__.
Wie man vermutlich aus der Syntax schon erkennen kann ist eine beidseitige Datenbindung eine Kombination einer Eigenschaft- und einer Event-Bindung.
Beidseitige Bindungen funktionieren nur mit Eigenschaften von Komponenten und Direktiven aber nicht mit DOM-Eigenschaften.
Hier ein Beispiel mit einem Eingabefeld und der NgModel-Direktive:

{line-numbers=off, lang=html}
```
<input type="text" [(ngModel)]="name"/>
```

Der Wert der name-Eigenschaft wird als Wert des Eingabefeldes gesetzt. Wenn der Nutzer den Inhalt des Eingabefeldes verändert, wird sich auch der Wert der name-Eigenschaft verändern.
Es gibt auch hier eine Alternativ-Syntax, und zwar mit dem "bindon-" Präfix:

{line-numbers=off, lang=html}
```
<input type="text" bindon-ngModel="name"/>
```

Wichtig bei der beidseitigen Bindung sind die Namen der Input- und der Output-Eigenschaften.
Im Fall der NgModel-Direktive hat die Input-Eigenschaft den Namen "ngModel" und die Output-Eigenschaft den Namen "ngModelChange".
Wir können also die beidseitige Bindung aufspalten, wenn wir das möchten:

{line-numbers=off, lang=html}
```
<input type="text" [ngModel]="name" (ngModelChange)="name = $event"/>
```

I> #### Eigene Direktive mit beidseitiger Bindung
I>
I> Wenn wir eine eigene Direktive mit beidseitiger Bindung schreiben möchten, müssen wir auf den Namen der Eigenschaft und den Namen des Events achten. Wenn wir z. B. eine Input-Eigenschaft namens "x" haben, muss die Output-Eigenschaft (das Event) den Namen "xChange" besitzen.

### Attribut-Bindung

Es gibt HTML-Attribute, die keine dazugehörige DOM-Eigenschaft besitzen.
Für solche Fälle bietet Angular die Attribut-Bindung an.
Eine Attribut-Bindung ist ähnlich einer Eigenschaft-Bindung, sprich in beiden Fällen nutzen wir eckige Klammern.
Der Unterschied ist, dass wir hier keinen Eigenschaftsnamen haben, sondern ein Keyword __attr__ und dann den Namen des Attributs.
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
Es wird empfohlen immer die Eigenschaft-Bindung zu nutzen, außer es gibt keine andere Wahl.
Bei Unsicherheit können wir versuchen eine Eigenschaft zu binden. Falls diese nicht existiert, wird Angular eine Exception werfen.
Dann wissen wir, dass wir eine Attribut-Bindung nutzen müssen.

### Klassenbindung

Eine Klassenbindung ist ähnlich einer Attribut-Bindung.
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

Bei der Style-Bindung nutzten wir das Keyword __style__ und nach dem Keyword kommt der Name des Styles.
Genau wie die Klassenbindung ist die Style-Bindung ideal, wenn wir nur einen Style konditional setzen möchten.
Für mehrere Styleänderungen gibt es die NgStyle-Direktive.
Hier ein Beispiel:

{line-numbers=off, lang=html}
```
<div [style.color]="isRed ? 'red' : 'black'"></div>
```

Falls "isRed" __true__ ist, wird das color-Style den Wert __red__ haben.
Falls es __false__ ist, wird das color-Style den Wert __black__ haben.
Manche Styles besitzen auch eine Maßeinheit wie z. B. "px", "em" usw.
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
Wir haben z. B. in der Klasse der Komponente keinen direkten Zugriff darauf.
Es zwei Arten von lokalen Variablen: Template-Referenzvariablen (template reference variables) und Template-Eingabevariablen (template input variables).
Diese unterscheiden sich in der Syntax und dem Wert der Variablen.

### Template-Referenzvariablen

Diese lokalen Variablen besitzen als Wert eine Referenz auf ein DOM-Element oder auf eine Direktive (zur Erinnerung: Komponenten sind auch Direktiven).
Um Template-Referenzvariablen zu definieren, können wir eine Raute (#) nutzen.
Hier ein Beispiel:

{line-numbers=off, lang=html, title="DOM-Element Referenz"}
```
<div #local></div>
```

Alternativ können wir Template-Referenzvariablen auch mit dem "ref-" Präfix definieren.
Hier ein Beispiel:

{line-numbers=off, lang=html, title="DOM-Element Referenz mit ref-"}
```
<div ref-local></div>
```

In beiden Fällen ist der Wert von "local" das div-Element.
Wie oben erwähnt kann eine Template-Referenzvariable auch eine Referenz auf eine Direktive sein.
Damit die lokale Variable eine Referenz auf eine Direktive sein kann, müssen wir eine Zuweisung nutzen und die Direktive muss die exportAs-Eigenschaft setzen.
Natürlich muss auf dem Tag auch eine entsprechende Direktive definiert sein.
Hier ein Beispiel:

{line-numbers=off, lang=html, title="Direktive Referenz}
```
<form #local="ngForm"></form>
```

Hier besitzt "local" eine Referenz auf die NgForm-Direktive als Wert. Wichtig zu beachten: NgForm nutzt "exportAs" mit __`'`ngForm`'`__ (ein String) als Wert und wir nutzen den Namen "ngForm" bei der Zuweisung. Ein anderer Name würde zu einem Fehler führen.
Ob eine Direktive einen Wert für die exportAs-Eigenschaft setzt, können wir in der Regel in der Dokumentation nachlesen.
Auch hier können wir das "ref-" Präfix nutzen:

{line-numbers=off, lang=html, title="Direktive Referenz mit ref-"}
```
<form ref-local="ngForm"></form>
```

### Template-Eingabevariablen

Der Wert der Template Eingabevariablen wird von Direktiven gesetzt.
Diese Art lokaler Variablen funktioniert nur bei strukturellen Direktiven, sprich Direktiven, die ein Template nutzen, wie z. B. NgFor.
In diesem Fall hat das Wort "lokal" eine leicht veränderte Bedeutung.
Diese Variablen können nicht im gesamten Angular-Template benutzt werden, sondern nur im Template der Direktive, die die Variablen definiert.
Hier ein Beispiel:

{line-numbers=off, title="Implizite Eingabe-Variable mit NgFor", lang=html}
```
<li *ngFor="let local of objectsArray"></li>
```

Das li-Element definiert das Template für die NgFor-Direktive.
In diesem Fall ist der Wert von "local" eine Referenz auf das aktuelle Element im Array und kann nur innerhalb des li-Elements benutzt werden.
Die Eingabevariable ist implizit, da wir für "local" keine Zuweisung nutzen.
Eine Direktive kann auch mehrere Template-Eingabevariablen definieren.
Hier noch ein Beispiel mit NgFor und einer weiteren Variablen:

{line-numbers=off, title="Explizite Eingabe-Variable mit NgFor", lang=html}
```
<li *ngFor="let l of objects; let local = index"></li>
```

Hier ist der Wert von "local" der Index des aktuellen Elements. Wie oben ist "l" das aktuelle Element.
Auch hier kann "local" nur innerhalb des li-Elementes benutzt werden.
Die Variable ist explizit, da wir für "local" eine Zuweisung nutzen.
Die rechte Seite der Zuweisung ist der Name einer Eigenschaft.
Die Direktive ist dafür zuständig diesen Namen als Eingabevariable zu definieren.
Wir können nur Namen nutzen, die die Eigenschaft in den Kontext des Templates setzt (das macht diese zu Eingabevariablen).
Wir können also nicht beliebige Eigenschaften einer Direktive bei der Zuweisung nutzen.

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

