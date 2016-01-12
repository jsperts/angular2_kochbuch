## Basistypen {#c01-basic-types}

TypeScript bringt von sich aus eine Anzahl von Basistypen mit wie z. B. "string", "boolean" und "number", aber es erlaubt es uns auch eigenen Typen zu definieren mit Hilfe von Interfaces die wir im nächsten Abschnitt uns anschauen werden. Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, kann aber manchmal ganz nützlich sein und darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript 7 Typen die immer vorhanden sind:
* Boolean
* Number
* String
* Array
* Enum
* Any
* Void

Typdefinitionen kommen immer nach einem Doppelpunkt (:). Wenn wir nach einem Variablennamen, Funktionsnamen oder Funktionsparameter einen Doppelpunkt sehen, dann handelt es sich um eine Typdefinition. Der Wert nach dem Doppelpunkt gibt den Typ an. Bei dem Kompilieren werden die Typinformationen benutzt, um sicher zu stellen, dass wir der Variablen die richtige Werte zuweisen. Der Kompilierte JavaScript-Code enthält dann diese Informationen nicht mehr. Um schnell zu sehen wie der kompilierter Code aussieht, kann man den [TypeScript Playground](http://www.typescriptlang.org/Playground) nutzen.

### Boolean

Diese Typ ist für boolesche Werte gedacht und beinhaltet die Werte true und false. Der Name des Typs ist "boolean".

```js
var isTrue: boolean = false;
```

### Number

Wird verwendet für Ganz- und Gleitkommazahlen. Der Typ heißt in dem Fall "number".

```js
var aNumber: number = 2;
```

### String

Texte haben den Typ "string". Es ist dabei egal, ob wir dabei Anführungszeichen ('), doppelte Anführungszeichen (") oder Backticks (\`) nutzen, der Typ bleibt gleich. Backticks werden für ES6/ES2015 [Template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings) benutzt und die werden auch von TypeScript unterstützt. Die unten gezeigte Beispiele, sind alle valide Werte vom Typ "string".

```js
var aString: string = 'A string';
aString = "another string";
aString = `yet another string`;
```

### Array

Der Typ "Array" wird für Listen verwendet. Damit die Typdefinition ein Sinn ergibt, müssen wir auch den Typ der Elemente der Liste angeben. Unten werden die zwei Möglichkeiten gezeigt die wir haben, um den Typ einer Liste zu definieren.

```js
var list1: number[] = [1, 2, 3];
var list2: Array<number> = [1, 2, 3];
```

Erklärung:

* Zeile 1: Eine Liste von Zahlen definieren. Als erstes haben wir gesagt, dass der Typ der Elementen "number" ist und mit den eckigen Klammern, haben wir TypeScript gesagt, dass es sich um ein Array handelt
* Zeile 2: Auch eine Liste von Zahlen, diesmal mit eine generische Typdefinition. Die kleiner (<) und größer (>) Zeichen geben an, dass es sich um ein generischen Typ handelt. Das TypeScript-Handbuch hat mehr Informationen über [generische Typen](http://www.typescriptlang.org/Handbook#generics)

### Enum

Dieser Typ wird für Aufzählungen benutzt. Damit können wir ein Entwickler-freundlichen Namen für nummerische Werte angeben. Der Namen des Typs ist "enum".

```js
// Enumdefinition
enum Status {DONE, IN_PROGRESS, NEW};
// status Variable hat den Status "NEW"
var status: Status = Status.NEW;
```

Erklärung:

Beim Kompilieren werden die Werte DONE, IN\_PROGRESS und NEW in Zahlen von 0 bis 2 umgewandelt. Enums bieten uns noch mehr Möglichkeiten an, z. B. können wir selbst definieren ob die Zahlen von 0 oder von 1 Anfangen. Mehr Informationen über [Enums gibt es im TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#basic-types-enum).

### Any

Hier reden wir nicht über ein echten Typ sondern, um eine Möglichkeit TypeScript zu sagen, dass wir den Typ nicht oder noch nicht kennen und das TypeScript in dem Fall beim Kompilieren sich nicht beschwerden soll wenn z. B. die Variable nicht den richtigen Typ hat.
Dank des "any"-Typs können wir existierendes JavaScript als TypeScript behandeln ohne, dass wir für jede Variable und Funktion explizit ein Typ definieren müssen.
Den "any"-Typ können wir auch benutzen wenn wir wie hier ein Array haben mit Elementen von unterschiedlichen Typen.

```js
var list: Array<any> = [1, true, 'false'];
```

### Void

Void ist so zusagen der leerer Typ oder einfach die Abwesenheit eines Typs. Werte vom Typ "void" sind "null" und "undefined". Dieser Typ wird oft benutzt bei Funktionen die kein Rückgabewert haben.

```js
function test(): void {
  console.log('test');
}
```

