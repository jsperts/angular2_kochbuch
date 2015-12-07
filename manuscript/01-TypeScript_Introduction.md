# Einführung zu TypeScript

Vermutlich ist TypeScript für einige Leser Neuland, und aus diesem Grund haben wir uns entschieden, dass das Buch auch eine kurze Einführung zu TypeScript beinhalten soll.
TypeScript ist eine von Microsoft geschriebene Programmiersprache mit derer man Anwendungen schreiben kann, die dann später zu JavaScript kompiliert werden, damit sie z. B. im Browser funktionieren. Es ist eine typisierte Übermenge von JavaScript (ES5). Außer Typen unterstützt TypeScript auch gewisse Features aus ES6/ES2015 aber auch Features die vermutlich in ES7/ES2016 standardisiert werden. Da TypeScript eine Übermenge von JavaScript ist, ist auch jede JavaScript Anwendung zumindest Anwendungen die mit ES5 geschrieben wurden sind, auch eine valide TypeScript Anwendung.

Wir werden uns nicht die komplette TypeScript Funktionalität anschauen, sondern nur die Teile die wir auch in den verschiedenen Rezepten brauchen werden.
Der Grund dafür ist einfach, wir möchten uns auf Angular 2 konzentrieren und nicht zu viele Zeit mit TypeScript verbringen.
Um die komplette Funktionalität von TypeScript abzudecken, bräuchte man ein eigenes Buch dafür.
Der große Vorteile von TypeScript gegenüber von plain JavaScript, ist das Typ-System das uns TypeScript zur Verfügung stellt.
Dieses ermöglicht uns Typinformationen zu hinterlegen für Variablen, Funktionen, Objekten und mehr.
In kleineren Anwendungen ist dieser Vorteil vielleicht nicht so relevant, da wir dort relativ schnell ein Überblick bekommen kann, welche Datentypen wo verwendet werden.
Wer aber größere JavaScript Anwendungen geschrieben hat, weißt wie schwer es sein kann den Überblick zu bewahren und heraus zu finden z. B. welche Eigenschaften ein bestimmtes Objekt hat.
Mit Hilfe von Typinformationen können wir solche Probleme vermeiden.
Da Typen ein so wichtiger Aspekt von TypeScript sind, werden wir uns als erstes damit befassen.

## Basistypen {#c01-basic-types}

TypeScript bringt von sich aus eine Anzahl von Basistypen mit wie z. B. string, boolean und number aber es erlaubt es uns auch eigenen Typen zu definieren mit Hilfe von Interfaces die wir im nächsten Abschnitt uns anschauen werden. Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, kann aber manchmal ganz nützlich sein und darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript 7 Typen die immer vorhanden sind:
* Boolean
* Number
* String
* Array
* Enum
* Any
* Void

Typdefinitionen kommen immer nach einem doppelt Punkt (:). Wenn wir nach einem Variablennamen, Funktionsnamen oder Funktionsparameter einen doppelt Punkt sehen, dann handelt es sich um eine Typdefinition.

### Boolean

Diese Typ ist für boolesche Werte gedacht und beinhaltet die Werte true und false. Der Name des Typs ist "boolean".

```js
var isTrue: boolean = false;
```

Der unterschied zu plain JavaScript ist der Doppelpunkt nach dem Variablennamen. Bei dem Kompilieren werden die Typinformationen benutzt, um sicher zu stellen, dass wir der Variablen die richtige Werte zuweisen. Der Kompilierte JavaScript-Code enthält dann diese Informationen nicht mehr.

### Number

Wird verwendet für Ganz- und Gleitkommazahlen. Der Typ heißt in dem Fall "number".

```js
var aNumber: number = 2;
```

### String

Texte haben den Typ "string". Es ist dabei egal, ob wir dabei Anführungszeichen ('), doppelte Anführungszeichen (") oder Backticks (\`) nutzen, der Typ bleibt gleich. Backticks werden für ES6/ES2015 [template Strings](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/template_strings) benutzt und die werden auch von TypeScript unterstützt.

```js
var aString: string = 'A string';
aString = "another string";
aString = `yet another string`;
```

Die oben gezeigte Beispiele sind all valide Werte vom Typ String.

### Array

Dieser Typ wird für Liste verwendet und es ist ein zusammen gesetzter Typ. Das bedeutet, dass wir auch noch den Typ der Elemente der Liste angeben müssen. Es gibt zwei Möglichkeiten dies zu tun.

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

Dieser Typ wird für Aufzählungen benutzt. Damit können wir ein Entwickler-freundlichen Namen für nummerische Werte angeben. Der Namen des Typs ist "enum".

```js
// Enumdefinition
enum Status {DONE, IN_PROGRESS, NEW};
// status Variable hat den Status "NEW"
var status: Status = Status.NEW;
```

Beim Kompilieren werden die Werte DONE, IN\_PROGRESS und NEW in Zahlen von 0 bis 2 umgewandelt. Enums bieten uns noch mehr Möglichkeiten an, z. B. können wir selbst definieren ob die Zahlen von 0 oder von 1 Anfangen. Mehr Informationen über [Enums gibt es im TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#basic-types-enum).

### Any

Hier reden wir nicht über ein echten Typ sondern, um eine Möglichkeit TypeScript zu sagen, dass wir den Typ nicht oder noch nicht kennen und das TypeScript in dem Fall beim Kompilieren sich nicht beschwerden soll wenn z. B. die Variable nicht den richtigen Typ hat.
Den "any"-Typ können wir auch benutzen wenn wir wie hier ein Array haben mit Elementen von unterschiedlichen Typen.

```js
var list: Array<any> = [1, true, 'false'];
```

Dank des "any"-Typs können wir existierendes JavaScript als TypeScript behandeln ohne, dass wir für jede Variable und Funktion explizit ein Typ definieren müssen.

### Void

Void ist so zusagen der leerer Typ oder einfach die Abwesenheit eines Typs. Werte vom Typ "void" sind "null" und "undefined". Dieser Typ wird oft benutzt bei Funktionen die kein Rückgabewert haben.

```js
function test(): void {
  console.log('test');
}
```

## Interfaces

Nachdem wir uns die Basistypen von TypeScript angeschaut haben werden wir jetzt sehen wie wir eigene Typen mit Hilfe von Interfaces definieren können.
Es ist vielleicht dem einen oder dem anderen aufgefallen, dass wir kein Basistyp für Objekte, ausgenommen von Arrays, gesehen haben.
Mit Interfaces können wir genau dies tun, wir können den Typ von Objekten definieren.

Wir haben zwei Möglichkeiten ein Interface zu definieren. Einmal anonyme Interfaces z. B. bei eine Variablendefinition oder benannte Interfaces mit dem Keyword "interface". In beiden Fällen wird der kompilierter JavaScript-Code, den Code für das Interface nicht beinhalten. Als erstes schauen wir uns anonyme Interfaces an.

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

Wir haben hier die einfachste Form von Interfaces gezeigt. Aber TypeScript bietet uns da noch mehr Möglichkeiten wie Interfaces mit optionalen Eigenschaften, Interfaces für Funktionen und mehr. Wer mehr darüber erfahren möchte, kann im [TypeScript-Handbuch](http://www.typescriptlang.org/Handbook#interfaces) nachschauen.

## Klassen {#c01-classes}

Klassen in TypeScript sind ähnlich zu [ES6/ES2015 Klassen](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes). Beide bieten uns eine einfachere Möglichkeit an in JavaScript bzw. TypeScript Objekt-orientiert zu programmieren. Auch wenn wir hier das Keyword "class" nutzen werden, arbeiten wir hier nicht mit echten Klassen wie man die vielleicht aus Java oder andere Programmiersprachen kennt. Als Grundlage für Klassen in JavaScript bzw. TypeScript dient immer noch der Prototyp. So sieht eine Klasse in TypeScript aus:

```js
// Klassendefinition
class User {
  constructor(name) {
    this.name = name;
  }
  print() {
    console.log(this.name);
  }
}

// Nutzung
var user = new User('Max');
```

Nach dem "class"-Keyword kommt der Name der Klasse, in unserem Fall "User" und in der Klasse gibt es eine optional Konstruktorfunktion (constructor) mit dem Parameter "name" und eine "print"-Methode. In ES5 würde unsere Klasse so aussehen:

```js
// Konstruktorfunktion
function User(name) {
  this.name = name;
}
// Prototypmethoden
User.prototype.print = function() {
  console.log(this.name);
}

var user = new User('Max');
```

Der Namen der Konstruktorfunktion wird in TypeScript als Klassennamen benutzt und der Rumpf der Konstruktorfunktion und ihre Parameter, werden der constructor-Eigenschaft übergeben. Die restliche Methoden einer Klasse sind einfach Methoden die in ES5 zu der prototype-Eigenschaft gehören. Da wir hier mit TypeScript arbeiten, können wir natürlich auch Typinformationen in unsere Klassen hinterlegen. So könnte die Klasse von oben aussehen mit Typinformationen:

```js
class User {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}
```

In Zeile 2, sagen wir TypeScript, dass unsere Instanzen der Klasse User eine Instanzvariable namens "name" mit Typ "string" haben. Das hier ist ein von den Unterschieden zwischen TypeScript und ES6/ES2015 Klassen. In ES6/ES2015 Klassen haben wir keine Typinformationen und wir geben auch nicht an was für Instanzvariablen unsere Instanzen haben. Ein weiteren Unterschied sehen wir hier:

```js
class User {
  name: string = '';
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}
```

Dieses mal haben wir in Zeile 2 direkt einen Wert an unsere Instanzvariable "name" zugewiesen. Diese Schreibweise ist vor allem nützlich wenn wir der Instanzvariable einen Standardwert geben möchten oder wenn man mit statischen Daten arbeitet. Auch das ist in ES6/ES2015 Klassen nicht erlaubt, aber es ist möglich, dass [ES7/ES2016 Klassen](https://github.com/jeffmo/es-class-fields-and-static-properties) das können, natürlich aber ohne die Typinformation. Im allgemeinen können TypeScript Klassen noch viel mehr als hier beschrieben, aber das reicht uns um die Angular 2 Rezepte zu verstehen. Wer mehr über TypeScript Klassen erfahren möchte, kann [hier](http://www.typescriptlang.org/Handbook#classes) nachlesen.

