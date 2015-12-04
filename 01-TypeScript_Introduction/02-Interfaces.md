## Interfaces

Nachdem wir uns die Basistypen von TypeScript angeschaut haben werden wir jetzt sehen wie wir eigene Typen mit Hilfe von Interfaces definieren können.
Es ist vielleicht dem einen oder dem anderen aufgefallen, dass wir kein Basistyp für Objekte, ausgenommen von Arrays, gesehen haben.
Mit Interfaces können wir genau dies tun, wir können den Typ von Objekten definieren.

Wir haben zwei Möglichkeiten ein Interface zu definieren. Einmal anonyme Interfaces bei z. B. eine Variabledefinition oder benannte Interfaces mit dem Keyword "interface". In beiden Fällen wird der kompilierter JavaScript-Code, den Code für das Interface nicht beinhalten. Als erstes schauen wir uns anonyme Interfaces an.

```js
var user: {name: string; age: number};
user = {
  name: 'Max',
  age: 23
};
```

Hier wird erwartet, dass die "user"-Variable ein Objekt ist mit mindestens den Eigenschaften "name" und "age". Falls diese Eigenschaften nicht vorhanden sind, oder nicht den richtigen Typ haben, wird der Kompiler uns warnen. User Objekt kann auch mehr als nur diese beiden Eigenschaften haben, aber das wird vom Kompiler nicht überprüft.

Benannte Interfaces haben die gleiche Schreibweise, mit dem Unterschied, dass sie ein Namen haben und sie das Keyword "interface" brauchen.

```js
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

Wir haben hier die einfachste Form von Interfaces gezeigt. Aber TypeScript bietet uns da noch mehr möglichkeiten wie Interfaces mit optionalen Eigenschaften, Interfaces für Funktionen und mehr. Wer mehr darüber erfahren möchte, kann im [TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#interfaces) nachschauen.

