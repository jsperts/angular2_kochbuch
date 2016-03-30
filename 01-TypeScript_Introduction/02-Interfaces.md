## Interfaces {#c01-ifaces}

Nachdem wir uns die Basistypen von TypeScript angeschaut haben, werden wir jetzt sehen wie wir eigene Typen mit Hilfe von Interfaces definieren können.
Ausgenommen von Arrays, haben wir keinen Basistyp für Objekte gesehen.
Mit Interfaces können wir den Typ von Objekten definieren.
Genauer gesagt definieren wir die Struktur von einem Objekt.
Wir geben Typen für dessen Eigenschaften und Methoden an.

Wir haben zwei Möglichkeiten ein Interface zu definieren.
Einmal als anonymes Interface z. B. bei eine Variablendefinition oder als benanntes Interface mit dem Keyword __interface__.
In beiden Fällen wird der kompilierter JavaScript-Code, den Code für das Interface nicht beinhalten.
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

Hier wird erwartet, dass die user-Variable ein Objekt ist mit mindestens den Eigenschaften "name" und "age".
Falls diese Eigenschaften nicht vorhanden sind, oder nicht den richtigen Typ haben, wird der Compiler uns warnen.
Das user-Objekt kann auch mehr als nur diese beiden Eigenschaften haben und das wird vom Compiler auch erlaubt.

Benannte Interfaces haben die gleiche Schreibweise mit gewisse Unterschiede:


* Sie haben einen Namen,
* brauchen das Keyword __interface__ und
* sind nicht Teil der Variablendeklaration, sondern eine Deklaration für sich.

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

Erst wird das Interface definiert (Zeile 1-4) und dann in Zeile 5 benutzt. Ansonsten gilt für den Typ das gleiche wie schon oben erklärt.

Wir haben hier die einfachste Form von Interfaces gezeigt. TypeScript bietet uns da noch mehr Möglichkeiten an.
Z. B. Interfaces mit optionalen Eigenschaften, Interfaces für Funktionen und mehr.
Wer mehr darüber erfahren möchte, kann im [TypeScript-Handbuch](https://www.typescriptlang.org/docs/handbook/interfaces.html) nachschauen.
Im nächsten Abschnitt werden wir uns mit Klassen beschäftigen und wir werden sehen wie wir Interfaces mit Klassen kombinieren können.

