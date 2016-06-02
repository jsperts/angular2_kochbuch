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

