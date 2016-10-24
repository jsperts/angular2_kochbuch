## Basistypen {#c01-basic-types}

TypeScript bringt von sich aus eine Anzahl von Basistypen wie z. B. "string", "boolean" und "number" mit, aber es erlaubt es uns auch eigene Typen zu definieren.
Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, es kann aber manchmal ganz nützlich sein. Darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript acht Typen, die immer vorhanden sind:

* Boolean
* Number
* String
* Array
* Tuple
* Enum
* Any
* Void

Typdefinitionen kommen immer nach einem Doppelpunkt (:).
Wenn wir z. B. nach einem Variablennamen, Funktionsnamen oder Funktionsparameter einen Doppelpunkt sehen, dann handelt es sich um eine Typdefinition.
Der Wert nach dem Doppelpunkt gibt den Typ an.
Beim Kompilieren werden die Typinformationen benutzt, um sicherzustellen, dass wir der Variable nur Werte des richtigen Typs zuweisen.
Der kompilierte JavaScript-Code enthält diese Informationen nicht mehr.
Auf dem [TypeScript Playground](https://www.typescriptlang.org/play/index.html) können wir TypeScript-Code schreiben und sehen wie der dazugehörige JavaScript-Code aussieht.

### Boolean

Dieser Typ ist für boolesche Werte gedacht und beinhaltet die Werte __true__ und __false__. Der Name des Typs ist "boolean".

```js
var isTrue: boolean = false;
```

### Number

Wird für Ganz- und Gleitkommazahlen verwendet. Der Typ heißt in diesem Fall "number".

```js
var aNumber: number = 2;
```

### String

Texte haben den Typ "string".
Es ist dabei egal, ob wir einfache Anführungszeichen (`'`), doppelte Anführungszeichen (`"`) oder Backticks (`` ` ``) nutzen, der Typ bleibt gleich.
Backticks werden für ES6/ES2015 [Template Literals](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Template_literals) verwendet, welche auch von TypeScript unterstützt werden.
Die unten gezeigten Beispiele sind alle valide Werte vom Typ "string".

```js
var aString: string = 'A string';
aString = "another string";
aString = `yet another string`;
```

### Array

Der Typ "Array" wird für Listen verwendet. Damit die Typdefinition einen Sinn ergibt, müssen wir auch den Typ der Elemente der Liste angeben.
Unten werden die zwei Möglichkeiten gezeigt, die es gibt, um den Typ einer Liste zu definieren.

```js
var list1: number[] = [1, 2, 3];
var list2: Array<number> = [1, 2, 3];
```

__Erklärung__:

* Zeile 1: Eine Liste von Zahlen definieren. Als Erstes haben wir gesagt, dass der Typ der Elemente "number" ist. Mit den eckigen Klammern haben wir TypeScript mitgeteilt, dass es sich um ein Array handelt
* Zeile 2: Auch eine Liste von Zahlen, diesmal mit generischer Typdefinition. Die Kleiner- (<) und Größerzeichen (>) geben an, dass es sich um einen generischen Typ handelt. Das TypeScript-Handbuch stellt Informationen über [generische Typen](https://www.typescriptlang.org/docs/handbook/generics.html) bereit

### Tuple

Der Typ "Tuple" wird auch für Listen verwendet.
Mit Hilfe dieses Typs, können wir Listen definieren, bei welchen die Elemente an verschiedenen Positionen unterschiedliche Typen besitzen.
Hier ein kleines Beispiel:

```js
var x: [string, number] = ['bla', 10];
```

__Erklärung__:

Hier definieren wir eine Variable namens "x" als Liste, wobei das erste Element der Liste ein String sein muss und das Zweite eine Zahl.
Wir haben nur die erste und die zweite Positione der Liste mit einem Typ versehen.
Die weiteren Positionen der Liste können entweder Werte vom Typ "string" oder vom Typ "number" sein.
Dieses "entweder ... oder ..." für Typen nennt man "Union Type" (Vereinigung von Typen).
Im TypeScript-Handbuch befinden sich weitere Informationen über [Union Types](https://www.typescriptlang.org/docs/handbook/advanced-types.html#union-types).
Damit wir ein Tupel definieren können, müssen wir den Typ für mindestens das erste Listenelement definieren.

### Enum

Dieser Typ wird für Aufzählungen benutzt. Damit können wir entwicklerfreundlichen Namen für numerische Werten angeben. Der Namen des Typs ist "enum".

```js
// Enumdefinition
enum Status {DONE, IN_PROGRESS, NEW};
// status Variable hat den Status "NEW"
var status: Status = Status.NEW;
```

__Erklärung__:

Beim Kompilieren werden die Werte __DONE__, __IN\_PROGRESS__ und __NEW__ in Zahlen von __0__ bis __2__ umgewandelt.
Enums bieten uns noch mehr Möglichkeiten an, z. B. können wir selbst definieren, ob die Zahlen von __0__ oder von __1__ anfangen. Weitere Informationen über [Enums gibt es im TypeScript-Handbuch](https://www.typescriptlang.org/docs/handbook/enums.html).

### Any

Hier reden wir nicht über einen echten Typ, sondern über eine Möglichkeit, TypeScript zu sagen, dass wir den Typ nicht oder noch nicht kennen und dass TypeScript sich in diesem Fall beim Kompilieren nicht beschwerden soll, wenn z. B. die Variable nicht den richtigen Typ hat.
Dank des any-Typs können wir existierenden JavaScript-Code als TypeScript-Code behandeln, ohne dass wir für jede Variable und Funktion explizit einen Typ definieren müssen.
Den any-Typ können wir auch benutzen, wenn wir, wie hier, ein Array mit Elementen unterschiedlicher Typen haben.

```js
var list: Array<any> = [1, true, 'false'];
```

### Void

Void ist sozusagen der leere Typ oder einfach die Abwesenheit eines Typs.
Dieser Typ wird oft bei Funktionen verwendet, die keinen Rückgabewert haben.
Werte vom Typ "void" sind __null__ und __undefined__.

```js
function test(): void {
  console.log('test');
}
```

