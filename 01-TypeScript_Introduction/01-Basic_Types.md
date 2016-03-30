## Basistypen {#c01-basic-types}

TypeScript bringt von sich aus eine Anzahl von Basistypen mit wie z. B. "string", "boolean" und "number", aber es erlaubt es uns auch eigenen Typen zu definieren.
Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, kann aber manchmal ganz nützlich sein und darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript 8 Typen die immer vorhanden sind:

* Boolean
* Number
* String
* Array
* Tuple
* Enum
* Any
* Void

Typdefinitionen kommen immer nach einem Doppelpunkt (:).
Wenn wir z. B. nach einem Variablennamen, Funktionsnamen oder Funktionsparameter einen Doppelpunkt sehen, dann handelt es sich um eine Typdefinition.
Der Wert nach dem Doppelpunkt gibt den Typ an.
Bei dem Kompilieren werden die Typinformationen benutzt, um sicher zu stellen, dass wir der Variablen die richtigen Werte zuweisen.
Der Kompilierte JavaScript-Code enthält dann diese Informationen nicht mehr.
Auf der [TypeScript Playground](https://www.typescriptlang.org/play/index.html), können wir TypeScript-Code schreiben und sehen wie der dazugehörige JavaScript-Code aussieht.

### Boolean

Dieser Typ ist für boolesche Werte gedacht und beinhaltet die Werte __true__ und __false__. Der Name des Typs ist "boolean".

```js
var isTrue: boolean = false;
```

### Number

Wird verwendet für Ganz- und Gleitkommazahlen. Der Typ heißt in diesem Fall "number".

```js
var aNumber: number = 2;
```

### String

Texte haben den Typ "string".
Es ist dabei egal, ob wir Anführungszeichen ('), doppelte Anführungszeichen (") oder Backticks (\`) nutzen, der Typ bleibt gleich.
Backticks werden für ES6/ES2015 [Template Literals](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Template_literals) benutzt und diese werden auch von TypeScript unterstützt.
Die unten gezeigte Beispiele sind alle valide Werte vom Typ "string".

```js
var aString: string = 'A string';
aString = "another string";
aString = `yet another string`;
```

### Array

Der Typ "Array" wird für Listen verwendet. Damit die Typdefinition ein Sinn ergibt, müssen wir auch den Typ der Elemente der Liste angeben.
Unten werden die zwei Möglichkeiten gezeigt die es gibt, um den Typ einer Liste zu definieren.

```js
var list1: number[] = [1, 2, 3];
var list2: Array<number> = [1, 2, 3];
```

__Erklärung__:

* Zeile 1: Eine Liste von Zahlen definieren. Als erstes haben wir gesagt, dass der Typ der Elemente "number" ist und mit den eckigen Klammern haben wir TypeScript gesagt, dass es sich um ein Array handelt
* Zeile 2: Auch eine Liste von Zahlen, diesmal mit eine generische Typdefinition. Die kleiner (<) und größer (>) Zeichen geben an, dass es sich um einen generischen Typ handelt. Das TypeScript-Handbuch hat mehr Informationen über [generische Typen](https://www.typescriptlang.org/docs/handbook/generics.html)

### Tuple

Der Typ "Tuple" wird auch für Listen verwendet.
Mit Hilfe dieses Typs, können wir Listen mit Elementen von unterschiedlichen Typen definieren.
Hier ein kleines Beispiel:

```js
var x: [string, number] = ['bla', 10];
```

__Erklärung__:

Hier definieren wir eine Variable namens "x" als Listen, wobei das erste Element der Liste ein String sein muss und das zweite eine Zahl.
Wir haben nur die erste und zweite Positionen der Liste mit einem Typ versehen.
Die weiteren Positionen der Liste können entweder Werte vom Typ "string" oder vom Typ "number" beinhalten.
Dieses "entweder ... oder ..." für Typen nennt man eine Vereinigung von Typen, auf Englisch "Union Type".
Im TypeScript Handbuch befinden sich mehr Informationen über [Union Types](https://www.typescriptlang.org/docs/handbook/advanced-types.html#union-types).
Damit wir ein Tupel definieren können, müssen wir den Typ für mindestens das erste Listenelement definieren.

### Enum

Dieser Typ wird für Aufzählungen benutzt. Damit können wir ein Entwickler-freundlichen Namen für nummerische Werten angeben. Der Namen des Typs ist "enum".

```js
// Enumdefinition
enum Status {DONE, IN_PROGRESS, NEW};
// status Variable hat den Status "NEW"
var status: Status = Status.NEW;
```

__Erklärung__:

Beim Kompilieren werden die Werte __DONE__, __IN\_PROGRESS__ und __NEW__ in Zahlen von __0__ bis __2__ umgewandelt.
Enums bieten uns noch mehr Möglichkeiten an z. B. können wir selbst definieren, ob die Zahlen von __0__ oder von __1__ Anfangen. Mehr Informationen über [Enums gibt es im TypeScript-Handbuch](https://www.typescriptlang.org/docs/handbook/enums.html).

### Any

Hier reden wir nicht über einen echten Typ, sondern um eine Möglichkeit TypeScript zu sagen, dass wir den Typ nicht oder noch nicht kennen und das TypeScript in dem Fall beim Kompilieren sich nicht beschwerden soll, wenn z. B. die Variable nicht den richtigen Typ hat.
Dank des any-Typs können wir existierenden JavaScript-Code als TypeScript-Code behandeln ohne, dass wir für jede Variable und Funktion explizit ein Typ definieren müssen.
Den any-Typ können wir auch benutzen, wenn wir wie hier ein Array mit Elementen von unterschiedlichen Typen haben.

```js
var list: Array<any> = [1, true, 'false'];
```

### Void

Void ist so zusagen der leere Typ oder einfach die Abwesenheit eines Typs.
Dieser Typ wird oft bei Funktionen benutzt die keinen Rückgabewert haben.
Werte vom Typ "void" sind __null__ und __undefined__.

```js
function test(): void {
  console.log('test');
}
```

