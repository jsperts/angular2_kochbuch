## Basistypen

TypeScript bringt von sich aus eine Anzahl von Basistypen mit wie z. B. string, boolean und number aber es erlaubt es uns auch eigenen Typen zu definieren mit Hilfe von Interfaces die wir im nächsten Abschnitt uns anschauen werden. Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, kann aber manchmal ganz nützlich sein und darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript 7 Typen die immer vorhanden sind:
* Boolean
* Number
* String
* Array
* Enum
* Any
* Void

Typdefinitionen kommen immer nach einem doppelt Punkt (:). Wenn wir nach einem Variablenamen, Funktionsnamen oder Funktionsparameter einen doppelt Punkt sehen, Dann handelt es sich um eine Typdefinition.

### Boolean

Diese Typ ist für boolesche Werte gedacht und beinhaltet die Werte true und false. Der Name des Typs ist "boolean".

```js
var isTrue: boolean = false;
```

Der unterschied zu plain JavaScript ist der Doppelpunkt nach dem Variablenamen. Was dort steht, gibt den Typ der Variable an. Bei dem Kompilieren werden die Typinformationen benutzt, um sicher zu stellen, dass wir der Variablen die richtige Werte zuweisen. Der Kompilierte JavaScript-Code enthält dann diese Informationen nicht mehr.

### Number

Wird verwendet für Ganz- und Gleitkommazahlen. Der Typ heißt in dem Fall "number".

```js
var aNumber: number = 2;
```

### String

Texte haben den Typ 'string'. Es ist dabei egal, ob wir dabei Anführungszeichen ('), doppelte Anführungszeichen (") oder Backticks (\`) nutzen, der Typ bleibt gleich. Backticks werden für ES6/ES2015 [template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings) benutzt und die werden auch von TypeScript unterstützt.

```js
var aString: string = 'A string';
aString = "another string";
aString = `yet another string`;
```

Die oben gezeigte Beispiele sind all valide Werte von Typ String.

### Array

Diese Typ wird für Liste verwendet und es ist ein zusammen gesetzter Typ. Das bedeutet, dass wir auch noch den Typ der Elemente der Liste angeben müssen. Es gibt zwei möglichkeiten dies zu tun.

```js
var list: number[] = [1, 2, 3];
```

Oben haben wir eine Liste von Zahlen definiert. Als erstes haben wir gesagt, dass der Typ der Elementen "number" ist und mit den eckigen Klammern, haben wir TypeScript gesagt, dass es sich um ein Array handelt.

Die zweite Möglichkeit um Array-Typen zu definieren nutzt ein generische Typdefinition.

```js
var list: Array<number> = [1, 2, 3];
```

Die kleiner (<) und größer (>) Zeichen geben an das es sich um ein generischen Typ handelt. Das TypeScript-Handbuch hat mehr Informationen über [generische Typen](http://www.typescriptlang.org/Handbook#generics). Wir werden uns hier nicht weiter damit befassen.

### Enum

Dieser Typ wird für Aufzählungen benutzt. Damit können wir ein Entwickler-freundlichen Namen für Nummerischewerte angeben. Der Namen des Typs ist "enum".

```js
// Enumdefinition
enum Status {DONE, IN_PROGRESS, NEW};
// status Variable hat den Status "NEW"
var status: Status = Status.NEW;
```

Beim Kompilieren werden die Werte DONE, IN\_PROGRESS und NEW in Zahlen von 0 bis 2 umgewandelt. Enums bieten uns noch mehr Möglichkeiten an, z. B. können wir selbst definieren ob die Zahlen von 0 oder von 1 Anfangen. Mehr Infomationen über [Enums gibt es im TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#basic-types-enum).

### Any

Hier reden wir nicht über ein echten Typ sondern, um eine Möglichkeit TypeScript zu sagen, dass wir den Typ nicht oder noch nicht kennen und das TypeScript in dem Fall beim Kompilieren sich nicht beschwerden soll wenn z. B. die Variable nicht den richtigen Typ hat.
Den "any"-Typ können wir auch benutzen wenn wir wie hier ein Array haben mit Elementen von unterschiedlichen Typen.

```js
var list: Array<any> = [1, true, 'false'];
```

Dank des "any"-Typs können wir existierendes JavaScript in TypeScript umwandeln ohne, dass wir für jede Variable und Funktion explizit ein Typ definieren müssen.

### Void

Void ist so zusagen der leerer Typ oder einfach die Abwesenheit eines Typs. Werte vom Typ "void" sind "null" und "undefined". Dieser Typ wird oft benutzt bei Funktionen die kein Rückgabewert haben.

```js
function test(): void {
  console.log('test');
}
```

