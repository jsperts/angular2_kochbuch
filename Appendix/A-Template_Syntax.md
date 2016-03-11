# Appendix A: Template-Syntax {#appendix-a}

Angular 2 nutzt Templates die uns erlauben die View von Komponenten zu definieren.
Diese Templates unterstützen den Großteil der HTML-Syntax und sie definieren auch eine spezielle Syntax die uns z. B. ermöglicht Daten die sich in Komponenten befinden, dem Nutzer anzuzeigen.
Wir werden gleich sehen, wie die spezielle Angular-Syntax für Templates aussieht und was man damit machen kann.
Hier handelt es sich nur um eine Kurzfassung mit den wichtigsten Informationen.
Die offizielle Angular Dokumentation gibt weitere Details über die [Template-Syntax](https://angular.io/docs/ts/latest/guide/template-syntax.html).

## Template-Ausdruck

Angular erlaubt die Nutzung von Ausdrücken in seine Templates.
Diese sind ähnlich zur JavaScript Ausdrücken, allerdings sind in Template-Ausdrücken nicht alle JavaScript-Konstrukte erlaubt.
Z. B. sind Konstrukte mit Nebeneffekten nicht erlaubt, es ist also nicht möglich Zuweisungen, new, ++, usw. zu nutzen.
Des Weiteren hat der Operator __|__ eine andere Bedeutung in Angular Templates als in JavaScript.
Hier wird er benutzt, das Resultat eines Ausdrucks zu transformieren vor dieses benutzt wird.
Angular bezeichnet den Operator als "Pipe-Operator".
Wie der funktioniert, wird in den entsprechenden Rezepten gezeigt.
Eine weitere Besonderheit von Template-Ausdrücken, ist die Existenz des sogenannten "Elvis-Operators" (?.).
Dieser kann uns helfen, wenn wir im Template mit Objekten arbeiten die __null__ oder __undefined__ sein könnten.
Da Methodenaufrufe erlaubt sind, müssen wir als Entwickler selbst achten, dass der Aufruf keine Nebeneffekte hat.
Wichtig zu beachten ist der Kontext in dem die Template-Ausdrücke evaluiert werden.
Wir können nur Eigenschaften von der Komponente zu der die View gehört und lokale Variablen die im Template definiert sind nutzen.

## Template-Anweisung

Template-Anweisungen erlauben uns das Aktualisieren des Zustands unserer Anwendung.
Sie werden bei Event-Bindungen benutzt und können Nebeneffekte haben.
Sie sind also eine Reaktion auf Events die durch den Nutzer ausgelöst werden z. B. click-Event.
Wie auch Template-Ausdrücken, nutzen Template-Anweisungen in eine JavaScript-ähnliche Syntax.
Aber auch hier ist nicht alles erlaubt, was in eine JavaScript-Anweisung erlaubt ist.
Z. B. sind new, ++ und bit-Operationen nicht erlaubt.
Auch die Nutzung von globalen Variablen ist nicht erlaubt.
Nur Eigenschaften von der Komponente zu der die View gehört und lokale Variablen die im Template definiert sind können benutzt werden.

## Daten-Bindung

Angular bietet verschiedene Möglichkeiten, um Daten die sich in einer Komponente befinden, in der dazugehörige View zu nutzen.
Damit man die Daten nutzen kann, müssen diese als Eigenschaften der Komponente definiert sein.
Das heißt für uns, sie müssen Eigenschaften des this-Wertes der Komponenten-Klasse sein.

Wir unterscheiden zwischen einweg-Daten-Bindung und beidseitige-Daten-Bindung.
Bei der einweg-Daten-Bindung fließen die Daten entweder von der View in die Komponente oder von der Komponente in die View.
Bei der beidseitige-Daten-Bindung fließen die Daten mit nur einem Bindungskonstrukt in beide Richtungen.
Unter Bindungskonstrukt, verstehen wir die Syntax die wir brauchen, um Angular zu signalisieren, dass hier Daten gebunden werden sollen.
Jetzt werden wir sehen wie wir die verschiedene Bindungskonstrukte nutzen können und was sie bewirken.

### Daten nutzen mittels Interpolation

Wir können Template-Ausdrücken interpolieren, indem wir doppelte geschweifte Klammern __{{...}}__ nutzen.
Der Template-Ausdruck wird zwischen den Klammern geschrieben.
Vor der Ausdruck angezeigt oder eine HTML-Attribut zugewiesen werden kann, wird er evaluiert.
Das Resultat der Evaluation wird in einem String umgewandelt und zuletzt mit den Strings die sich links und rechts von den Klammern befindet konkateniert.
Bei der String-Umwandlung, nutzt Angular die toString-Funktion.
Darum ist es selten sinnvoll einer Referenz zu einem Objekt bei der Interpolation zu nutzen.
Wenn man Daten von Objekten anzeigen möchte, muss man im Template auf die einzelnen Eigenschaften des Objekts zugreifen.

Angenommen wir haben eine Komponenten-Eigenschaft namens "data" mit einem String-Wert von "test data", können wir Interpolation nutzen, um den Wert anzuzeigen.
So geht das:

{lang=html}
```
<div>My data: {{data}}</div>
```

Was der Nutzer auf seinem Bildschirm sehen wird ist "My data: test data".
Komplexere Ausdrücke sind auch möglich:

{lang=html}
```
<div> 1 + 2 is {{1 + 2}}
```

Hier wird dem Nutzer "1 + 2 is 3" angezeigt.
Das Resultat der Interpolation, kann auch als Wert für ein HTML-Attribut benutzt werden:

{lang=html}
```
<img src={{url}}/>
```

Hier wird angenommen, dass unsere Komponente eine Eigenschaft namens "url" besitzt die eine URL für das src-Attribut als Wert hat.
Die Interpolation ist eine einweg-Bindung bei der die Daten aus der Komponente in die View fließen.

### Eigenschaft-Bindung

Diese Art von Bindung wird mit Eigenschaften von (Unter-) Komponenten, Direktiven und DOM-Elementen benutzt.
Der Namen der Eigenschaft wird als Ziel der Bindung bezeichnet.

W> #### Bindungs-Ziel
W>
W> Wichtig zu beachten ist, dass wir bei Direktiven und Komponenten nicht jede Eigenschaft als Ziel einer Bindung nutzen können. Wir können nur spezielle Eigenschaften, die als "inputs" definiert worden sind, nutzen. Solche Eigenschaften sind auch als input-Eigenschaften bekannt.

Bei der Eigenschafts-Bindung reden wir von eine einweg-Bindung, wobei die Daten aus einem Template-Ausdruck in das Ziel der Bindung fließen.
Eigenschaft-Bindungen können wir mit eckigen Klammern __[...]__ definieren.
Hier ein Beispiel:

{lang=html}
```
<img [src]="url"/>
```

Der Namen zwischen der Klammern, hier "src" ist das Ziel der Bindung.
Auf der rechten Seite der Eigenschafts-Bindung befindet sich ein Template-Ausdruck, der evaluiert wird und dann als Wert der src-Eigenschaft gesetzt wird.
Alternativ können wir auch die Eigenschaft-Bindung mit der bind-Syntax realisieren:

{lang=html}
```
<img bind-src="url"/>
```

Hier wird "bind-" als Präfix, statt eckigen Klammern benutzt.
Das Resultat ist dasselbe egal welche Syntax wir nutzen.
Es ist also Geschmackssache, ob man Klammern oder "bind-" nutzt.

W> #### HTML-Attribut vs. DOM-Eigenschaft
W>
W> Wir müssen hier zwischen HTML-Attribute und DOM-Eigenschaften unterscheiden. Oft gibt es Attribute die den gleichen Namen haben wie DOM-Eigenschaften z. B. "src". In Angular werden Attribute benutzt, um initiale Werte zu setzen und diese Werte sind statisch. Sobald wir Daten-Bindungen nutzen, nutzen wir automatisch DOM-Eigenschaften. Streng genommen haben wir also bei der Interpolation die src- und die textContent-Eigenschaft der Elemente gesetzt. Da es gewisse Attribute gibt, die zu keiner DOM-Eigenschaft gehören, bietet Angular auch eine spezielle Syntax an, um Attribute zu binden. Die werden wir später sehen.

### Event-Bindung

Bis jetzt haben wir uns mit Bindungen beschäftigt die uns erlaubt haben, Daten aus der Komponente in einer View zu nutzen.
Jetzt geht es um eine Art von Bindung die zwar auch eine einweg-Bindung ist, die aber in die andere Richtung geht.
Hier fließen Daten von der View in die Komponente.
Dafür nutzen wir eine spezielle Syntax mit Klammern __(...)__.
Zwischen den Klammern kommt der Name eines Events.
Wir können DOM-Events nutzen wie z. B. "click", "change", etc. oder wir können auch eigene Events definieren.
Eigene Events werden in Komponenten und Direktiven definiert.
Hier ein Beispiel für das click-Event:

{lang=html}
```
<button type="button" (click)="doSomething()">Do</button>
```

Der Namen zwischen den Klammern wird als das Ziel-Event bezeichnet.
In unserem Beispiel ist "click" das Ziel-Event.
Wenn also der Nutzer auf den Button klickt, wird die doSomething-Methode der Komponenten aufgerufen.
Alternativ können wir auch folgende Syntax verwenden:

{lang=html}
```
<button type="button" on-click="doSomething()">Do</button>
```

Das "on-" Präfix wird statt den Klammern benutzt.
Auch hier ist es Geschmackssache, welche Syntax verwendet wird.
Das Resultat ist gleich.

W> #### Eigene Events in Komponenten und Direktiven
W>
W> Es ist wichtig zu beachten, dass eigene Events auch als Eigenschaften definiert werden und zwar sind es spezielle Eigenschaften die als "outputs" definiert worden sind. Solche Eigenschaften sind auch als output-Eigenschaften bekannt.

#### Event-Objekt

Wenn der Nutzer ein Event auslöst, gibt es in der Regel auch ein dazugehöriges Event-Objekt.
Wir können auf das Event-Objekt zugreifen, durch ein spezielles Objekt namens __$event__.
Wie dieses Objekt aussieht, hängt von dem Event-Typ ab.
Bei DOM-Events bekommen wir das dazugehörige DOM-Event-Objekt.
Bei eigene Events, definiert der Entwickler wie das Event-Objekt aussieht.
So bekommen wir Zugriff auf eine Event-Objekt:

{lang=html}
```
<button type="button" (click)="doSomething($event)">Do</button>
```

In der doSomething-Methode, können wir das Event-Objekt nutzen.
Da wir bei der Event-Bindung Template-Anweisungen statt Template-Ausdrücken nutzen, gibt es auch eine weitere Möglichkeit das Objekt zu bekommen und zwar mit eine Zuweisung.

{lang=html}
```
<button type="button" (click)="myEvent = $event">Do</button>
```

Jetzt haben wir in der Komponente Zugriff auf das Event-Objekt über die myEvent-Eigenschaft der Komponente.
Statt dem $event, können wir auch direkt ein Wert zuweisen oder der doSomething-Methode einen anderen Wert übergeben:

{lang=html}
```
<button type="button" (click)="name = 'Max'">Do</button>
<button type="button" (click)="doSomething('Max')">Do</button>
```

Jetzt beinhaltet die name-Eigenschaft den Wert "Max" und die doSomething-Methode bekommt "Max" als Wert übergeben.
Natürlich können auch lokale Variablen oder Eigenschaften als Wert übergeben bzw. zugewiesen werden.

### Beidseitige-Daten-Bindung

Um eine beidseitige-Daten-Bindung nutzen zu können, brauchen wir spezielle Direktiven und ein weiteres Bindungskonstrukt.
Angular bietet uns von Haus aus eine solche Direktive und zwar die NgModel-Direktive.
Das Bindungskonstrukt sind Klammern umgeben von eckigen Klammern __[(...)]__.
Wie man vermutlich aus der Syntax schon erkennen kann, ist eine beidseitige-Daten-Bindung eine Kombination von einer Eigenschafts-Bindung und einer Event-Bindung.
Beidseitige-Bindungen funktionieren nur mit Eigenschaften von Komponenten und Direktiven aber nicht mit DOM-Eigenschaften.
Hier ein Beispiel mit einem Eingabefeld und NgModel:

{lang=html}
```
<input type="text" [(ngModel)]="name"/>
```

Der Wert der name-Eigenschaft wird als Wert des Eingabefeldes gesetzt und wenn der Nutzer den Inhalt des Eingabefeldes verändert, wird sich auch der Wert der name-Eigenschaft verändern.
Es gibt auch hier eine alternativ-Syntax und zwar mit dem "bindon-" Präfix:

{lang=html}
```
<input type="text" bindon-ngModel="name"/>
```

Wichtig bei der beidseitige-Bindung ist der Namen der input- und der output-Eigenschaft.
Im Fall von NgModel, hat die input-Eigenschaft den Namen "ngModel" und die output-Eigenschaft den Namen "ngModelChange".
Wir können also die beidseitige-Bindung auch aufspalten, wenn wir möchten:

{lang=html}
```
<input type="text" [ngModel]="name" (ngModelChange)="name = $event"/>
```

I> #### Eigene Direktive mit beidseitige-Bindung
I>
I> Wenn wir eine eigene Direktive mit beidseitige-Bindung schreiben möchten müssen wir auf die Namen der Eigenschaft und des Events achten. Wenn wir z. B. eine input-Eigenschaft namens "x" haben, muss die output-Eigenschaft (das Event) den Namen "xChange" haben.

### Attribut-Bindung

Es gibt HTML-Attribute die keine dazugehörige DOM-Eigenschaft besitzen.
Für solche Fälle bietet Angular die Attributs-Bindung an.
Eine Attributs-Bindung ist ähnlich zu einer Eigenschafts-Bindung, sprich in beiden Fällen nutzen wir eckigen Klammern.
Der Unterschied ist, dass wir hier keinen Eigenschafts-Namen haben, sondern ein Keyword "attr" und dann den Namen des Attributs.
Als Beispiel nutzen wir das colspan-Attribut:

{lang=html}
```
<table>
  <tr>
    <td [attr.colspan]="columnSpan">Num of columns</td>
  </tr>
</table>
```

Diese Schreibweise müssen wir für alle Attribute nutzen, die keine dazugehörige DOM-Eigenschaft besitzen.
Es wird empfohlen immer die Eigenschafts-Bindung zu nutzen, außer es gibt keine andere Wahl.
Bei Unsicherheit, kann man versuchen eine Eigenschaft zu binden und falls die nicht existiert, wird Angular eine Exception schmeißen.
Dann wissen wir, dass wir eine Attributs-Bindung nutzen müssen.

### Klassen-Bindung

Eine Klassen-Bindung ist ähnlich zu eine Attributs-Bindung.
Der Unterschied: hier wird das Keyword "class" statt "attr" benutzt und nach dem Keyword kommt ein Klassenname.
Hier ein Beispiel:

{lang=html}
```
<div [class.red]="isRed"></div>
```

Hier wird die Klasse "red" konditional gesetzt. Falls die Komponenten-Eigenschaft "isRed" __true__ ist, wird die Klasse gesetzt.
Falls sie __false__ ist, wird die Klasse entfernt.
Diese Schreibweise ist ideal, wenn wir nur eine Klasse konditional setzen möchten.
Falls wir mehrere Klassen setzen möchten, ist es besser die NgClass-Direktive zu nutzen.

### Style-Bindung

Bei der Style-Bindung nutzten wir das Keyword "style" und nach dem Keyword kommt der Namen des Styles.
Genau wie die Klassen-Bindung, ist die Style-Bindung ideal wenn wir nur ein Style konditional setzen möchten.
Bei mehrere Styles gibt es die NgStyle-Direktive.
Hier ein Beispiel:

{lang=html}
```
<div [style.color]="isRed ? 'red' : 'black'"></div>
```

Falls "isRed" __true__ ist, wird der color-Style "red" sein.
Falls es __false__ ist, wird der color-Style "black" sein.
Mache Styles haben auch eine Maßeinheit z. B. "px", "em" usw.
So können wir auch die Maßeinheit mit definieren:

{lang=html}
```
<div [style.width.px]="isBig ? 150 : 50"></div>
```

Wenn "isBig" __true__ ist, wird die Breite des Elementes "150px" sein.
Falls es __false__ ist, wird die Breite "50px" sein.

## Lokale Variablen

Wie schon erwähnt, können wir in Templates lokale Variablen definieren und nutzen.
Um eine lokale Variable zu definieren, nutzen wir eine Raute (#).
Hier ein Beispiel:

{lang=html}
```
<div #local></div>
```

In diesem Fall ist der Wert von "local" das div-Element.
Alternativ können wir lokale Variablen auch mit dem "var-" Präfix definieren.
Hier ein Beispiel:

{lang=html}
```
<div var-local></div>
```

Lokale Variable können genau so wie Komponenten-Eigenschaften genutzt werden z. B. mittels Interpolation.

### Wert der Variable

Der Wert der Variable hängt vom Kontext ab.
Oben haben wir eine lokale Variable ohne Zuweisung definiert und das Element besitze auch keine Direktive.
In so einem Fall ist der Wert immer das DOM-Element.
Bei Elementen mit Direktiven ist das ganze ein bisschen komplizierter.
Da gibt es verschiedene Möglichkeiten für den Wert der Variable:

1. Wir nutzen keine Zuweisung und die Direktive setzt kein Wert, dann ist der Wert der Variable das DOM-Element
2. Wir nutzen keine Zuweisung aber die Direktive setzt ein Wert, dann hängt der Wert von der Direktive ab. Hier wird der Wert implizit gesetzt
3. Wir nutzen eine Zuweisung und die Direktive nutzt "exportAs", dann ist der Wert der Variable die Direktive. Allerdings muss in so einem Fall die rechte Seite der Zuweisung, der Namen sein der bei "exportAs" definiert wurde
4. Wir nutzen eine Zuweisung und die Direktive setzt ein Wert mit einem bestimmten Namen, dann hängt der Wert der Variable von dem gesetzten Wert ab. Hier wird der Wert explizit gesetzt und die rechte Seite der Zuweisung muss den richtigen Namen haben. Der Namen wird von der Direktiven definiert

Von der Fallunterscheidung sehen wir, dass es nicht immer einfach ist den Wert einer lokalen Variablen zu bestimmen. Ob die Direktive ein Wert setzt oder "exportAs" nutzt, steht in der Regel in der Dokumentation.
Damit das ganze verständlicher wird, zeigen wir noch ein paar Beispielen mit eingebaute Angular-Direktiven.
In den Beispielen beschäftigen wir uns nur mit den Werten von lokalen Variablen.
Wie die einzelnen Direktiven funktionieren, ist in den Rezepten beschrieben.

{title="Beispiel für Fall 1", lang=html}
```
<div #local [ngClass]="{bla: true}"></div>
```

Hier hat "local" das DOM-Div-Element als Wert.

{title="Beispiel für Fall 2", lang=html}
```
<li *ngFor="#local of objects"></li>
```

Hier nutzen wir die NgFor-Direktive mit eine Liste von Objekten namens "objects". In diesem Fall ist der Wert von "local" das aktuelle Listenelement.

{title="Beispiel für Fall 3", lang=html}
```
<form #local="ngForm"></form>
```

Hier hat "local" die NgForm-Direktive als Wert. Wichtig zu beachten: NgForm nutzt "exportAs" mit "ngForm" als Wert und wir nutzen den Namen "ngForm" bei der Zuweisung. Ein anderer Name würde zu einem Fehler führen.

{title="Beispiel für Fall 4", lang=html}
```
<li *ngFor="#l of objects; #local = index"></li>
```

Die Variable "local" hat den aktuellen Index als Wert. Die NgFor-Direktive definiert intern eine lokale Variable namens "index" die wir an unsere locale Variable "local" zuweisen.

