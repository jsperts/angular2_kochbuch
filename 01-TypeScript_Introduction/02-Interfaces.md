## Interfaces {#c01-ifaces}

Nachdem wir uns die Basistypen von TypeScript angeschaut haben, werden wir jetzt betrachten, wie wir eigene Typen mit Hilfe von Interfaces definieren können.
Abgesehen von Arrays haben wir bisher keinen Basistyp für Objekte gesehen.
Mit Interfaces können wir den Typ von Objekten definieren.
Genauer gesagt definieren wir die Struktur eines Objekts.
Wir geben Typen für dessen Eigenschaften und Methoden an.

Wir haben zwei Möglichkeiten, ein Interface zu definieren.
Einmal als anonymes interface z. B. bei einer Variablendefinition oder als benanntes Interface mit dem Keyword __interface__.
In beiden Fällen wird der kompilierte JavaScript-Code den Code für das Interface nicht beinhalten.
Zuerst schauen wir uns anonyme Interfaces an.

{title="Typdefinition für ein Objekt mit einem anonymen Interface", lang=js}
```
var user: {name: string; age: number};
user = {
  name: 'Max',
  age: 23
};
```

__Erklärung__:

Hier wird erwartet, dass die user-Variable ein Objekt mit mindestens den Eigenschaften "name" und "age" ist.
Falls diese Eigenschaften nicht vorhanden sind oder nicht den richtigen Typ haben, wird der Compiler uns warnen.
Das user-Objekt darf auch mehr als nur diese beiden Eigenschaften haben.

Benannte Interfaces haben die gleiche Schreibweise mit gewissen Unterschieden:


* Sie haben einen Namen
* Sie brauchen das Keyword __interface__
* Sie sind nicht Teil der Variablendeklaration, sondern eine Deklaration für sich

{title="Typdefinition für ein Objekt mit einem benannten Interface", lang=js}
```
interface User {
  name: string;
  age: number;
}
var user: User;
user = {
  name: 'Max',
  age: 23
}
```

__Erklärung__:

Erst wird das Interface definiert (Zeile 1-4) und dann in Zeile 5 benutzt. Ansonsten gilt für den Typ das Gleiche wie schon oben erklärt.

Wir haben hier die einfachste Form eines Interfaces gezeigt. TypeScript bietet uns noch weitere Möglichkeiten an.
Z. B. gibt es Interfaces mit optionalen Eigenschaften, Interfaces für Funktionen und mehr.
Wer mehr darüber erfahren möchte, kann im [TypeScript-Handbuch](https://www.typescriptlang.org/docs/handbook/interfaces.html) nachschauen.
Im nächsten Abschnitt werden wir uns mit Klassen beschäftigen. Wir werden sehen, wie wir Interfaces mit Klassen kombinieren können.

