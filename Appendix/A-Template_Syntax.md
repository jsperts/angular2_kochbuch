# Appendix A: Template-Syntax {#appendix-a}

Angular 2 nutzt Templates die uns erlauben die View von Komponenten zu definieren.
Diese Templates unterstützen den Großteil der HTML-Syntax und sie definieren auch eine spezielle Syntax die uns z. B. ermöglicht Daten die sich in der Komponente befinden, dem Nutzer anzuzeigen.
Hier werden wir sehen wie wir die spezielle Angular-Syntax für Templates nutzen können und was man damit machen kann.

## Template-Ausdruck

Angular erlaubt die Nutzung von Ausdrücken in seine Templates. Diese sind ähnlich zur JavaScript Ausdrücken, allerdings sind in Template-Ausdrücken nicht alle JavaScript-Konstrukte erlaubt.
Z. B. werden Konstrukte mit Nebeneffekten nicht erlaubt, es ist also nicht möglich Zuweisungen, new, ++, usw. zu nutzen.
Ein weiterer Unterschied ist der Kontext in dem die Template-Ausdrücke evaluiert werden.
Wir können nur Eigenschaften von der Komponente zu der die View gehört und lokale Variablen die im Template definiert sind nutzen.

## Daten-Bindung

Angular bietet verschiedene Möglichkeiten, um Daten die sich in einer Komponenten befinden, in der dazugehörige View zu nutzen.
Damit man die Daten nutzen kann, müssen diese als Eigenschaften der Komponente definiert sein.
Das heißt für uns, sie müssen Eigenschaften des this-Wertes der Komponenten-Klasse sein.

### Daten nutzen mittels Interpolation

Wir können Template-Ausdrücken interpolieren, indem wir doppelte geschweifte Klammern __{{...}}__ nutzen.
Der Template-Ausdruck wird zwischen den Klammern geschrieben.
Vor der Ausdruck angezeigt wird oder eine HTML-Attribut zugewiesen wird, wird er evaluiert.
Das Resultat der Evaluation wird in einem String umgewandelt und zuletzt mit den Strings die sich links und rechts von den Klammern befindet konkateniert.
Bei der String-Umwandlung, nutzt Angular die toString-Funktion und darum ist es selten sinnvoll ein Referenz zu einem Objekt bei der Interpolation zu nutzen.
Wenn man Daten von Objekten anzeigen möchte, muss man im Template auf die einzelne Eigenschaften des Objekts zugreifen.

Angenommen wir haben eine Komponenten-Eigenschaft namens "data" mit einem String-Wert von "test data", können wir Interpolation nutzen, um den Wert anzuzeigen.
So geht das:

{lang=js}
```
<div>My data: {{data}}</div>
```

Was der Nutzer auf seinem Bildschirm sehen wird ist "My data: test data".
Komplexere Ausdrücke sind auch möglich:

{lang=js}
```
<div> 1 + 2 is {{1 + 2}}
```

Hier wird dem Nutzer "1 + 2 is 3" angezeigt.
Das Resultat der Interpolation, kann auch als Wert für ein HTML-Attribut benutzt werden:

{lang=js}
```
<img src={{url}}/>
```

Hier wird angenommen, dass unsere Komponente eine Eigenschaft namens "url" besitzt die eine URL für das src-Attribut als Wert hat.

## Lokale Variablen
