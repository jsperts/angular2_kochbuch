# Einführung in TypeScript {#c01}

Vermutlich ist TypeScript für einige Leser und Leserinnen Neuland. Aus diesem Grund haben wir uns entschieden, dem Buch auch eine kurze Einführung in TypeScript voranzustellen.
TypeScript ist eine von Microsoft entwickelte Programmiersprache mit der man Anwendungen schreiben kann, die später zu JavaScript kompiliert werden.
Es ist eine typisierte Übermenge von JavaScript.
Neben Typen unterstützt TypeScript sowohl gewisse Features aus ES6/ES2015 als auch Features die vermutlich in späteren ECMAScript Versionen enthalten sein werden.
Da TypeScript eine Übermenge von JavaScript ist, ist auch jede JavaScript-Anwendung, zumindest Anwendungen die mit ES5 geschrieben worden sind, eine valide TypeScript-Anwendung.

Wir werden uns nicht die komplette TypeScript-Funktionalität anschauen, sondern nur die Teile, die wir in den verschiedenen Rezepten brauchen werden.
Der Grund dafür ist, dass wir uns auf Angular 2 konzentrieren und nicht zu viele Zeit mit TypeScript verbringen möchten.
Um die komplette Funktionalität von TypeScript abzudecken, bräuchte man ein eigenes Buch.
Der große Vorteile von TypeScript gegenüber JavaScript ist das Typ-System, welches uns TypeScript zur Verfügung stellt.
Dieses ermöglicht uns, Typinformationen für Variablen, Funktionen, Objekte und mehr zu hinterlegen.
In kleineren Anwendungen ist dieser Vorteil vielleicht nicht so relevant, da wir dort relativ schnell sehen können, welche Datentypen wo verwendet werden.
Wer aber größere JavaScript-Anwendungen geschrieben hat, weiß, wie schwer es sein kann, den Überblick zu bewahren und herauszufinden welche Eigenschaften ein bestimmtes Objekt hat.
Mit Hilfe von Typinformationen können wir solche Probleme vermeiden.
Da Typen ein so wichtiger Aspekt von TypeScript sind, werden wir uns zuerst damit befassen.

I> Im Buch wird TypeScript Version 2 benutzt. Ggf. wird es Beispiele geben, die nicht mit eine ältere Version von TypeScript funktionieren.

## Basistypen {#c01-basic-types}

TypeScript bringt von sich aus eine Anzahl von Basistypen wie z. B. "string", "boolean" und "number" mit, aber es erlaubt es uns auch eigene Typen zu definieren.
Es ist zwar nicht erforderlich, dass wir mit dem Typ-System arbeiten, es kann aber manchmal ganz nützlich sein. Darum werden wir in den verschiedenen Rezepten immer wieder auf Typen stoßen.

Insgesamt hat TypeScript zehn Typen, die immer vorhanden sind:

* boolean
* number
* string
* array
* tuple
* enum
* any
* void
* undefined und null
* never

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

Der Typ "array" wird für Listen verwendet. Damit die Typdefinition einen Sinn ergibt, müssen wir auch den Typ der Elemente der Liste angeben.
Unten werden die zwei Möglichkeiten gezeigt, die es gibt, um den Typ einer Liste zu definieren.

```js
var list1: number[] = [1, 2, 3];
var list2: Array<number> = [1, 2, 3];
```

__Erklärung__:

* Zeile 1: Eine Liste von Zahlen definieren. Als Erstes haben wir gesagt, dass der Typ der Elemente "number" ist. Mit den eckigen Klammern haben wir TypeScript mitgeteilt, dass es sich um ein Array handelt
* Zeile 2: Auch eine Liste von Zahlen, diesmal mit generischer Typdefinition. Die Kleiner- (<) und Größerzeichen (>) geben an, dass es sich um einen generischen Typ handelt. Das TypeScript-Handbuch stellt Informationen über [generische Typen](https://www.typescriptlang.org/docs/handbook/generics.html) bereit

### Tuple

Der Typ "tuple" wird auch für Listen verwendet.
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

### Undefined und Null

In TypeScript haben die Werte __null__ und __undefined__ einen eigenen Typ der "null" bzw. "undefined" heißt.

```js
var foo: undefined = undefined;
var bar: null = null;
```

Im Regelfall sind die Typen "undefined" und "null" Subtypen von jedem anderen Typ.
Das bedeutet, dass wir z. B. eine Variable vom Typ "number" haben können die als Wert eine Zahl, __undefined__ oder __null__ haben kann.

```js
var num: number = 1;
num = undefined;
num = null;
```

Wenn wir aber __strictNullChecks__ nutzen, sind die Werte __null__ und __undefined__ nicht in jedem Typ enthalten.
Die Zeilen 2 und 3 im Beispiel oben währen dann keine gültige Zuweisung im Sinne von TypeScript.
Mit __stringNullChecks__, können wir __null__ an Variablen vom Typ "void" und "null" zuweisen.
Entsprechend können wir den Wert __undefined__ nur an Variablen vom Typ "void" und "undefined" zuweisen.
Diese zwei Typen können nur dann sinnvoll eingesetzt werden, wenn wir __strictNullChecks__ nutzen.

### Never

Der "never"-Typ ist ein Typ ohne Wert und repräsentiert etwas was nie passieren kann.
Z. B. eine Funktion die immer eine Exception schmeisst, kann als Rückgabetyp "never" haben, da in so einem Fall die Funktion nie ein Rückgabewert haben kann.

```js
function throwError(): never {
  throw Error('Some error');
}
```

Wir werden uns in diesem Buch mit dem "never"-Typ nicht weiter beschäftigen.
Dieser wird nur in speziellen Situationen benutzt wie z. B. in Type Guards.

## Interfaces {#c01-ifaces}

Nachdem wir uns die Basistypen von TypeScript angeschaut haben, werden wir jetzt sehen, wie wir den Typ von Objekten mit Hilfe von Interfaces definieren können.
Genauer gesagt definieren wir mit Interfaces die Struktur eines Objekts.
Wir geben Typen für dessen Eigenschaften und Methoden an.

Wir haben zwei Möglichkeiten, ein Interface zu definieren.
Einmal als anonymes Interface (inline annotation) z. B. bei einer Variablendefinition oder als benanntes Interface mit dem Keyword __interface__.
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
};
```

__Erklärung__:

Erst wird das Interface definiert (Zeile 1-4) und dann in Zeile 5 benutzt. Ansonsten gilt für den Typ das Gleiche wie schon oben erklärt.

Wir haben hier die einfachste Form eines Interfaces gezeigt. TypeScript bietet uns noch weitere Möglichkeiten an.
Z. B. gibt es Interfaces mit optionalen Eigenschaften, Interfaces für Funktionen und mehr.
Wer mehr darüber erfahren möchte, kann im [TypeScript-Handbuch](https://www.typescriptlang.org/docs/handbook/interfaces.html) nachschauen.
Im nächsten Abschnitt werden wir uns mit Klassen beschäftigen. Wir werden sehen, wie wir Interfaces mit Klassen kombinieren können.

## Klassen {#c01-classes}

Klassen in TypeScript sind ähnlich zu [ES6/ES2015-Klassen](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes).
Beide bieten uns eine einfache Möglichkeit, in JavaScript bzw. TypeScript objektorientiert zu programmieren.
Auch wenn wir das Keyword __class__ nutzen, arbeiten wir hier nicht mit echten Klassen, wie wir diese aus anderen Programmiersprachen wie z. B. Java kennen.
Als Grundlage für Klassen in JavaScript bzw. TypeScript dient immer noch der Prototyp.
Zuerst werden wir uns die Schreibweise für ES6/ES2015-Klassen anschauen.
Danach zeigen wir die dazugehörige ES5-Schreibweise. Und als Letztes werden wir sehen, wie man Klassen in TypeScript definiert.

### ES6/ES2015-Klassen und die dazugehörige ES5-Schreibweise
{title="ES6/ES2015-Klasse", lang=js}
```
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

__Erklärung__:

* Zeile 2: Nach dem class-Keyword steht der Name der Klasse, in unserem Fall "User"
* Zeilen 3-5: Die Klasse hat eine (optionale) Konstruktorfunktion mit dem Parameter "name". Diese wird aufgerufen, wenn wir, wie in Zeile 12, __new__ benutzen
* Zeile 6: Methode namens "print"

{title="Die User-Klasse in ES5-Schreibweise", lang=js}
```
// Konstruktorfunktion
function User(name) {
  this.name = name;
}
// Prototypmethoden
User.prototype.print = function() {
  console.log(this.name);
};

var user = new User('Max');
```

__Erklärung__:

Zeile 2 definiert eine Konstruktorfunktion mit dem Namen "User".
In ES6/ES2015/TypeScript wird dieser Name als Klassenname benutzt.
Der Rumpf dieser Funktion und ihre Parameter definieren die Konstruktorfunktion der Klasse.
Methoden einer Klasse entsprechen in ES5 Methoden, die zu der prototype-Eigenschaft der Konstruktorfunktion gehören.

### TypeScript-Klassen

Neben Interfaces bieten TypeScript-Klassen eine weitere Möglichkeit, Typen für Objekte zu definieren.
Interfaces definieren die Typen der Eigenschaften und Methoden eines Objekts, wohingegen Klassen nicht nur Typen, sondern auch das Verhalten und Werte für die Eigenschaften definieren.
Der Klassenname ist auch gleichzeitig der Typname der Instanzen einer Klasse.
Wir können also den Namen einer Klasse bei einer Typdefinition genauso nutzen, wie wir es für Interfaces getan haben.

{title="TypeScript-Klasse", lang=js}
```
class User {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}

var user: User;
user = new User('Max');
```

__Erklärung__:

In Zeile 2 sagen wir TypeScript, dass unsere Instanzen der Klasse "User" eine Eigenschaft namens "name" mit Typ "string" haben.
Das ist einer der Unterschiede zwischen TypeScript und ES6/ES2015 Klassen.
Da wir in TypeScript mit Typen arbeiten, können wir natürlich auch Typinformationen in unseren Klassen hinterlegen.
Wie immer ist die Typangabe optional, aber wir müssen den Namen der Eigenschaft angeben. Andernfalls warnt der Compiler.
Wir können also Zeile 2 auch so schreiben:` name;` ohne die Typangabe.
In der vorletzte Zeile definieren wir eine Variable namens "user" vom Typ "User".
Anschließend wird in der letzten Zeile der user-Variablen eine Instanz der User-Klasse zugewiesen.

{title="Eine weitere Schreibweise von TypeScript-Klassen", lang=js}
```
class User {
  name: string = '';
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}

var user: User;
user = new User('Max');
```

__Erklärung__:

Diesesmal haben wir der name-Eigenschaft einen Wert zugewiesen (Zeile 2).
Diese Schreibweise ist vor allem nützlich, wenn wir der Eigenschaft einen Initialwert geben möchten oder wenn wir mit statischen Daten arbeiten.
Genau wie oben ist auch hier die Typdefinition optional.
Die gezeigte Schreibweise ist in ES6/ES2015-Klassen nicht erlaubt.
Dort dürfen Eigenschaften nur dem this-Wert zugewiesen und nicht als Teil der Klassendefinition benutzt werden.
Es ist aber möglich, dass spätere Versionen von [ECMAScript-Klassen](https://github.com/jeffmo/es-class-fields-and-static-properties) dies erlauben, natürlich ohne die Typinformation.

### Klassen mit Interfaces

Ein weiterer Vorteil von TypeScript-Klassen gegenüber ES6/ES2015-Klassen ist, dass TypeScript-Klassen ein Interface implementieren können.
Dazu nutzt man das Keyword __implements__ bei der Klassendefinition.

{title="TypeScript-Klasse mit Interface", lang=js}
```
interface IUser {
  name: string;
  print(): void;
}

class User implements IUser {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  print(): void {
    console.log(this.name);
  }
}
```

__Erklärung__:

* Zeilen 1-4: Interfacedefinition (Siehe auch [Interfaces](#c01-ifaces))
  * Zeile 3: Typdefinition für eine Methode. Der Name der Methode ist "print", sie hat keine Parameter und der Rückgabetyp ist "void"
* Zeilen 6-14: Klassendefinition
  * Zeile 6: Nutzung des Keywords __implements__ heißt für uns, dass User-Instanzen vom Typ "IUser" sein müssen

Im Allgemeinen können TypeScript-Klassen noch mehr als hier beschrieben, aber das hier beschriebene reicht uns, um die Angular 2 Rezepte zu verstehen. Wer mehr über TypeScript-Klassen erfahren möchte, kann dies [hier](https://www.typescriptlang.org/docs/handbook/classes.html) nachlesen.

## Beispielanwendung

Um besser zu verstehen, wie wir mit TypeScript arbeiten können, gibt es hier noch eine kleine Beispielanwendung.
Weil Todo-Listen als Beispielanwendung mittlerweile zum Standard geworden sind, haben wir uns entschieden, dass unsere Anwendung ebenfalls eine Todo-Liste sein soll.
Die Anwendung kann vordefinierte Todos anzeigen und neue Todos in einer existierenden Liste von Todos hinzufügen.
Obwohl die Todo-Anwendung klein ist, ist sie trotzdem in mehrere Dateien aufgespalten.
Wir wollen damit zeigen, wie man mit Hilfe von [ECMAScript-Modulen (ESM)](http://exploringjs.com/es6/ch_modules.html) eine Anwendung modular aufbauen kann.
Wenn wir mit ESM arbeiten, ist jede Datei auch ein Modul.
Der komplette Code für die Anwendung befindet sich in Github unter [01-TypeScript/01-Simple\_Todo\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/01-Simple_Todo_App).

### Code für die Anwendung

Der Einstiegspunkt für die Anwendung ist die Datei index.html. In dieser laden wir die Anwendung und zeigen sie im Browser an. Im Verzeichnis "app" befinden sich unsere TypeScript-Dateien.
Im app-Verzeichnis gibt es drei Dateien namens "main.ts", "todo\_item.ts" und "todo\_list.ts".

{title="index.html", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>TypeScript - Todo App</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script src="https://code.angularjs.org/tools/typescript.js"></script>
  <script>
    System.config({
      transpiler: 'typescript',
      packages: {'app': {defaultExtension: 'ts'}}
    });
    System.import('./app/main');
  </script>
</head>
<body>
  <form>
  <input id="todoTitle"/>
  <button type="submit" id="addTodo">Add</button>
</form>
  <ul id="todosList"></ul>
</body>
</html>
```

__Erklärung__:

* Zeile 6: Laden von SystemJS
* Zeile 7: Laden des TypeScript-Compilers
* Zeilen 8-14: Konfiguration von SystemJS und Laden der Anwendung
  * Zeile 10: Hier teilen wir SystemJS mit, dass unsere TypeScript-Dateien on-the-fly kompiliert werden sollen
  * Zeile 11: Hier sagen wir SystemJS, dass alle Dateien im Verzeichnis "app" eine ".ts" Endung haben. Somit brauchen wir beim Importieren eines Moduls die Endung nicht anzugeben
  * Zeile 13: Laden der main.ts-Datei, das Hauptmodul unserer Anwendung

W> #### Achtung
W>
W> Wichtig zu beachten ist, dass wir hier TypeScript on-the-fly, sprich im Browser kompilieren. Für unsere kleine Anwendung ist das noch in Ordnung, für größere Anwendungen wird dies aber zu langsam sein. Wir werden in einem späteren Abschnitt sehen, wie wir die TypeScript-Dateien vorkompilieren können.

I> #### SystemJS
I>
I> SystemJS ist ein Modullader, der verschiedene Arten von Modulen wie z. B. CommonJS, AMD und ESM unterstützt. Wer mehr über SystemJS erfahren möchte kann [hier](https://github.com/systemjs/systemjs) mehr darüber lesen.

{title="app/main.ts", lang=js}
```
import TodoList from './todo_list';
import TodoItem from './todo_item';

const todos: Array<TodoItem> = [new TodoItem('Todo 1'), new TodoItem('Todo 2')];

const inputElement: HTMLInputElement = document.getElementsByTagName('input').item(0);
const button: HTMLElement = document.getElementById('addTodo');
const todosList: HTMLElement = document.getElementById('todosList');

const todoList = new TodoList(todos);

todoList.render(todosList);

button.addEventListener('click', function(event) {
  event.preventDefault();
  const todoTitle: string = inputElement.value;
  todoList.add(new TodoItem(todoTitle));
  todoList.clear(todosList);
  todoList.render(todosList);
});
```

__Erklärung__:

Dies ist das Hauptmodul unserer Anwendung.
Es instantiiert unsere vordefinierten Todos und die Liste von Todos.
Es hat Zugriff auf DOM-Elemente und ruft Methoden auf, um die existierende Todos anzuzeigen und neue Todos hinzuzufügen.

* Zeilen 1-2: Import der Module "TodoList" und "TodoItem" mittels [ESM import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import). Wir nutzen hier den Namen der Datei ohne Endung, da wir SystemJS schon gesagt haben, dass Dateien im app-Verzeichnis immer die Endung ".ts" haben (Siehe index.html Zeile 14)
* Zeile 4: Todos für unsere Liste. Die Liste beinhaltet Elemente vom Typ "TodoItem"
* Zeilen 6-8: DOM-Elemente an Konstanten zuweisen. Wir nutzen dafür das [ES6/ES2015 Keyword __const__](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/const). Die Typen "HTMLInputElement" und "HTMLElement" sind in TypeScript vordefiniert

I> #### TypeScript DOM-Typen
I>
I> Leider scheint TypeScript außer der Liste der Basistypen keine weitere Typenliste bereitzustellen. Wer also mit dem Browser arbeitet und Typen für HTML-Elemente usw. sucht, muss in der [Typdefinitionsdatei für das DOM](https://github.com/Microsoft/TypeScript/blob/master/src/lib/dom.generated.d.ts) nachschauen.

{title="app/todo_item.ts", lang=js}
```
class TodoItem {
  title: string;
  checked: boolean;
  constructor(title: string) {
    this.title = title;
    this.checked = false;
  }
  render(listItem: HTMLElement): HTMLElement {
    const checkbox: HTMLInputElement = document.createElement('input');
    const label: HTMLLabelElement = document.createElement('label');

    checkbox.type = 'checkbox';
    checkbox.checked = this.checked;

    label.textContent = this.title;

    listItem.appendChild(checkbox);
    listItem.appendChild(label);

    return listItem;
  }
}

export default TodoItem;
```

__Erklärung__:

Modul und Klassendefinition für ein Todo-Element.
Unsere Klasse erzeugt Instanzen vom Typ "TodoItem".
In der letzten Zeile nutzen wir eine [ESM export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export), um die Klasse zu exportieren.
Somit können wir diese in anderen Modulen importieren und nutzen.

{title="app/todo_list.ts", lang=js}
```
import TodoItem from './todo_item';

class TodoList {
  todos: Array<TodoItem>;
  constructor(todos: Array<TodoItem>) {
    this.todos = todos;
  }
  render(listElement: HTMLElement) {
    this.todos.forEach((todo: TodoItem) => {
      const listItem: HTMLLIElement = document.createElement('li');
      listElement.appendChild(todo.render(listItem));
    });
  }
  add(todo: TodoItem) {
    this.todos.push(todo);
  }
  clear(listElement: HTMLElement) {
    listElement.innerHTML = '';
  }
}

export default TodoList;
```

Erklärung:

Modul/Klasse für die Todo-Liste. Unsere Klasse hat drei Methoden, "render", "add" und "clear" und eine Eigenschaft vom Typ "Array<TodoItem>" namens "todos".

* Zeile 1: Hier wird das TodoItem-Modul importiert, um Zugriff auf die TodoItem-Klasse zu bekommen. Da wir die Klasse nur als Typdefinition nutzen, wird dieser Import nicht im kompilierten Code vorkommen
* Zeile 9: Statt einer normalen Funktion (Keyword __function__) nutzen wir hier eine [ES6/ES2015 Arrow-Funktion](https://jsperts.de/blog/arrow-functions/). Arrow-Funktionen sind kürzer zu schreiben und haben die Eigenschaft, dass sie den this-Wert ihrer Umgebung nutzen und keinen eigenen this-Wert definieren

### Die Anwendung im Browser laden

Da SystemJS Ajax nutzt, um die einzelnen Module asynchron zu laden, brauchen wir einen Webserver, um unsere Todo-Anwendung im Browser zu laden.
Das Angular-Team empfiehlt den [live-server](https://www.npmjs.com/package/live-server), der die Seite bei Änderungen automatisch neu laden kann.
Wer kein live-reload mag, kann auch den [http-server](https://www.npmjs.com/package/http-server) nutzen.
Beide Webserver sind über npm installierbar.
Natürlich kann man auch andere Webserver nutzen, wie z. B. Apache, nginx oder Webserver, die in einer IDE integriert sind.
Nachdem wir einen Webserver gestartet haben, können wir im Browser zu der richtigen URL navigieren und uns die Anwendung ansehen.

## TypeScript-Dateien vorkompilieren {#c01-precompile}

Wie schon erwähnt, ist das on-the-fly-Kompilieren von TypeScript-Dateien auf Dauer keine Lösung.
In diesem Abschnitt werden wir sehen, wie wir die TypeScript-Dateien vor dem Laden kompilieren können.
Als Erstes benötigen wir den TypeScript-Compiler.
Es gibt verschiedene Möglichkeiten, diesen herunterzuladen und zu installieren.
Wir werden hier mit Node.js und npm arbeiten, da diese Tools weit verbreitet und einfach zu nutzen sind.
Wir können Node.js installieren, indem wir es von der [offiziellen Webseite](https://nodejs.org/en/download/) herunterladen.
Bei der Installation von Node.js wird npm mit installiert.
Anschließend können wir den TypeScript-Compiler mit

```bash
npm install -g typescript
```

installieren.

Wir nehmen jetzt die Todo-Anwendung aus dem vorherigen Abschnitt und passen diese so an, dass die TypeScript-Dateien nicht mehr im Browser kompiliert werden.
Dazu müssen wir zwei Sachen machen: Erstens muss die index.html-Datei angepasst werden und zweitens müssen wir die TypeScript-Dateien kompilieren.
Der Code für die Anwendung mit angepasster index.html-Datei befindet sich in [01-TypeScript/02-Precompile](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/02-Precompile).

{title="Anpassungen an der index.html-Datei", lang=html}
```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>TypeScript - Todo App</title>
  <script src="https://code.angularjs.org/tools/system.js"></script>
  <script>
    System.config({
      packages: {'app': {defaultExtension: 'js'}}
    });
    System.import('./app/main');
  </script>
</head>
<body>
  <form>
    <input id="todoTitle"/>
    <button type="submit" id="addTodo">Add</button>
  </form>
  <ul id="todosList"></ul>
</body>
</html>
```

__Erklärung__:

Der TypeScript-Compiler wird jetzt nicht mehr in der index.html-Datei geladen.
In der SystemJS-Konfiguration haben wir die transpiler-Eigenschaft entfernt.
Einen weiteren Unterschied sehen wir in Zeile 9, wo wir jetzt ".js" als Endung nutzen und nicht mehr ".ts".
Der Grund dafür ist, dass wir nun die kompilierten JavaScript-Dateien laden möchten.
Jetzt müssen wir nur noch die TypeScript-Dateien kompilieren.
Weitere Anpassungen sind nicht nötig.

{title="Dateien kompilieren", lang=bash}
```
tsc --target ES5 --module commonjs app/main.ts
```

__Erklärung__:

tsc ist der TypeScript-Compiler.
Die Option "module" gibt an, dass die ESM, die wir nutzen, in CommonJS-Module umgewandelt werden sollen.
Die Option "target" gibt an, welcher ECMAScript-Version unser JavaScript entsprechen soll.
Hier nutzen wir ECMAScript 5.
Als Letztes geben wir die main.ts-Datei an.
Die weiteren Module, die die main.ts-Datei importiert, werden automatisch mit kompiliert.
Wir müssen also nicht jede Datei einzeln kompilieren.
Der TypeScript-Compiler bietet noch mehr Optionen an, die wir nutzen können. Zwei davon werden wir gleich noch sehen. Weitere Optionen werden im [TypeScript-Wiki](https://github.com/Microsoft/TypeScript/wiki/Compiler-Options) erläutert.

W> #### Wichtig
W>
W> Das Kommando muss im Hauptverzeichnis unserer Anwendung aufgerufen werden. Die resultierenden JavaScript-Dateien werden im gleichen Verzeichnis wie die jeweilige TypeScript-Datei abgelegt.

I> #### CommonJS
I>
I> CommonJS ist ein Modul-Standard, der hauptsächlich in Node.js verwendet wird. Wir nutzen CommonJS, weil dies die Zusammenarbeit von TypeScript mit externen Bibliotheken wie Angular 2 vereinfacht. Durch die Verwendung von CommonJS-Modulen ist der Compiler in der Lage, automatisch nach Typdefinitionen für externe Bibliotheken im node\_modules-Verzeichnis zu suchen, ohne dass wir ihm sagen müssen, wo die Typdefinitionen sind.

I> #### Die target-Option
I>
I> Standardmäßig nutzt der TypeScript-Compiler ECMAScript 3 als "target". Der generierte JavaScript-Code ist also ES3 kompatibel. ES3 zu nutzen ist nur sinnvoll, wenn wir alte Browser wie z. B. den Internet Explorer 8 unterstützen möchten. Da Angular 2 nur neuere Browser (ab Internet Explorer 9) unterstützt, können wir ruhig ES5 nutzen. Ein weiterer Grund, ES5 zu nutzen, ist, dass manche TypeScript-Features wie z. B. [getters/setters](https://www.typescriptlang.org/docs/handbook/classes.html#accessors) für Klassen in ES3 nicht unterstützt werden.

### Dateien automatisch kompilieren mit "watch"

Bei jeder Änderung die Dateien manuell zu kompilieren, kann auf Dauer nerven. Dafür bietet uns der Compiler eine einfache Lösung.
Es gibt eine Option namens "watch". Mit dieser Option werden die Dateien automatisch bei jeder Änderung kompiliert.

{title="Kommando mit watch", lang=bash}
```
tsc --target ES5 --module commonjs --watch app/main.ts
```

__Erklärung__:

Mit der watch-Option werden unsere Dateien bei jeder Änderung automatisch neukompiliert. Das gilt nicht nur für die angegebene app/main.ts-Datei, sondern auch für alle Dateien, die importiert werden.

### Sourcemaps generieren

Nach dem Kompilieren stimmen meistens die Zeilennummern in der JavaScript- und der TypeScript-Dateien nicht mehr überein.
Das kann das Debugging erschweren, wenn z. B. der Browser einen Fehler in der JavaScript-Datei findet und wir diesen in der TypeScript-Datei finden und korrigieren möchten.
Für genau solche Fälle gibt es Sourcemaps, die uns die richtige Zeile in der TypeScript-Datei anzeigen.
Um Sourcemaps zu erzeugen, nutzen wir eine weitere Option des Compilers.

{title="Sourcemaps generieren", lang=bash}
```
tsc --target ES5 --module commonjs --sourceMap app/main.ts
```

__Erklärung__:

Die Sourcemaps werden im gleichen Verzeichnis wie die JavaScript-Dateien abgelegt und automatisch vom Browser geladen. Wir können auch "watch" mit "sourceMap" kombinieren, wenn wir das möchten.

### Konfigurationsdatei für den Compiler nutzen

Auf Dauer kann es nerven, die ewig lange Zeile einzutippen, um unser Projekt zu kompilieren.
Eine Alternative hierfür bietet die tsconfig.json-Datei. Darin können wir alle nötige Optionen angeben und dann den Compiler aufrufen, ohne selbst die Optionen angeben zu müssen.

{title="tsconfig.json", lang=json}
```
{
  "compilerOptions": {
    "module": "commonjs",
    "sourceMap": true,
    "target": "ES5"
  }
}
```

Das Verzeichnis, in dem sich die tsconfig.json-Datei befindet, ist das Hauptverzeichnis unseres TypeScript-Projektes.
Nachdem wir die config-Datei erstellt haben, haben wir zwei Möglichkeiten, unsere Anwendung zu kompilieren.

Wir können

```bash
tsc
```

im Haupt- oder einem Unterverzeichnis unserer Anwendung aufrufen oder wir können

```bash
tsc -p Hauptverzeichnis
```

aufrufen, wobei __Hauptverzeichnis__ der Pfad zu dem Verzeichnis ist, in dem die tsconfig.json-Datei liegt.
Da unsere config-Datei die files-Eigenschaft nicht setzt, werden alle \*.ts-Dateien kompiliert, die sich im Haupt- und in den Unterverzeichnissen befinden. Das TypeScript-Handbuch bietet weitere Informationen über die [tsconfig.json-Datei](http://www.typescriptlang.org/docs/handbook/tsconfig.json.html) an und die Eigenschaften, die diese enthalten kann.

