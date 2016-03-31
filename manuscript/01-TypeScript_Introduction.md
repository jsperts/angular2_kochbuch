# Einführung in TypeScript {#c01}

Vermutlich ist TypeScript für einige Leser und Leserinnen Neuland und aus diesem Grund haben wir uns entschieden, dass das Buch auch eine kurze Einführung in TypeScript beinhalten soll.
TypeScript ist eine von Microsoft geschriebene Programmiersprache mit derer man Anwendungen schreiben kann, die dann später zu JavaScript kompiliert werden.
Es ist eine typisierte Übermenge von JavaScript.
Außer Typen unterstützt TypeScript auch gewisse Features aus ES6/ES2015 aber auch Features die vermutlich in späteren ECMAScript Versionen enthalten sein werden.
Da TypeScript eine Übermenge von JavaScript ist, ist auch jede JavaScript-Anwendung zumindest Anwendungen die mit ES5 geschrieben worden sind, auch eine valide TypeScript-Anwendung.

Wir werden uns nicht die komplette TypeScript-Funktionalität anschauen, sondern nur die Teile die wir auch in den verschiedenen Rezepten brauchen werden.
Der Grund dafür ist einfach, wir möchten uns auf Angular 2 konzentrieren und nicht zu viele Zeit mit TypeScript verbringen.
Um die komplette Funktionalität von TypeScript abzudecken, bräuchte man ein eigenes Buch.
Der großer Vorteile von TypeScript gegenüber von JavaScript ist das Typ-System, jenes uns TypeScript zur Verfügung stellt.
Dieses ermöglicht uns Typinformationen für Variablen, Funktionen, Objekten und mehr zu hinterlegen.
In kleineren Anwendungen ist dieser Vorteil vielleicht nicht so relevant, da wir dort relativ schnell sehen können welche Datentypen, wo verwendet werden.
Wer aber größere JavaScript Anwendungen geschrieben hat, weißt wie schwer es sein kann den Überblick zu bewahren und herauszufinden welche Eigenschaften ein bestimmtes Objekt hat.
Mit Hilfe von Typinformationen können wir solche Probleme vermeiden.
Da Typen ein so wichtiger Aspekt von TypeScript sind, werden wir uns zuerst damit befassen.

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
Es ist dabei egal, ob wir Anführungszeichen (`'`), doppelte Anführungszeichen (`"`) oder Backticks (`` ` ``) nutzen, der Typ bleibt gleich.
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

* Zeile 1: Eine Liste von Zahlen definieren. Als Erstes haben wir gesagt, dass der Typ der Elemente "number" ist und mit den eckigen Klammern haben wir TypeScript gesagt, dass es sich um ein Array handelt
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

## Klassen {#c01-classes}

Klassen in TypeScript sind ähnlich zu [ES6/ES2015-Klassen](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes).
Beide bieten uns eine einfache Möglichkeit in JavaScript bzw. TypeScript Objekt-orientiert zu programmieren.
Auch wenn wir das Keyword __class__ nutzen, arbeiten wir hier nicht mit echten Klassen wie wir diese aus andere Programmiersprachen wie z. B. Java kennen.
Als Grundlage für Klassen in JavaScript bzw. TypeScript dient immer noch der Prototyp.
Zuerst werden wir uns die Schreibweise für ES6/ES2015-Klassen anschauen.
Danach zeigen wir die dazugehörige ES5-Schreibweise und als letztes werden wir sehen wie man Klassen in TypeScript definieren.

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

* Zeile 2: Nach dem class-Keyword kommt der Namen der Klasse, in unserem Fall "User"
* Zeilen 3-5: Die Klasse hat eine (optionale) Konstruktorfunktion mit dem Parameter "name". Diese wird aufgerufen, wenn wir wie in Zeile 12 "new" benutzen
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
}

var user = new User('Max');
```

__Erklärung__:

Zeile 2 definiert eine Konstruktorfunktion mit Namen "User".
In ES6/ES2015/TypeScript wird dieser Namen als Klassennamen benutzt.
Der Rumpf dieser Funktion und ihre Parameter, definieren die Konstruktorfunktion der Klasse.
Methoden einer Klasse sind einfach Methoden die in ES5 zu der prototype-Eigenschaft der Konstruktorfunktion gehören.

### TypeScript-Klassen

Neben Interfaces bieten TypeScript-Klassen eine weitere Möglichkeit, um Typen für Objekte zu definieren.
Interfaces definieren die Typen für die Eigenschaften und die Methoden eines Objekts wo hingegen Klassen nicht nur Typen sondern auch das Verhalten und Werte für die Eigenschaften definieren.
Der Klassennamen ist auch der Typnamen für die Instanzen einer Klasse.
Wir können also den Namen einer Klasse bei einer Typdefinition nutzen genau so wie wir es für Interfaces getan haben.

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
Das ist einer von den Unterschieden zwischen TypeScript und ES6/ES2015 Klassen.
Da wir in TypeScript mit Typen arbeiten, können wir natürlich auch Typinformationen in unseren Klassen hinterlegen.
Wie immer ist die Typangabe optional aber wir müssen den Namen der Eigenschaft angeben ansonsten wird der Compiler eine Warnung geben.
Wir können also Zeile 2 auch so schreiben:` name;` ohne die Typangabe.
In der vorletzte Zeile definieren wir eine Variable namens "user" die vom Typ "User" ist.
Anschliessend wird in der letzte Zeile der user-Variable eine Instanz der User-Klasse zugewiesen.

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

var user: User = new User('Max');
```

__Erklärung__:

Dieses mal haben wir der name-Eigenschaft einen Wert zugewiesen (Zeile 2).
Diese Schreibweise ist vor allem nützlich, wenn wir der Eigenschaft einen Initialwert geben möchten oder, wenn wir mit statischen Daten arbeiten.
Genau wie oben, ist auch hier die Typdefinition optional.
Die gezeigte Schreibweise ist in ES6/ES2015-Klassen nicht erlaubt.
Da dürfen Eigenschaften nur dem this-Wert zugewiesen werden und nicht als Teil der Klassendefinition benutzt werden.
Es ist aber möglich, dass spätere Versionen von [ECMAScript-Klassen](https://github.com/jeffmo/es-class-fields-and-static-properties) das können, natürlich ohne die Typinformation.

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
  * Zeile 3: Typdefinition für eine Methode. Der Namen der Methode ist "print", sie hat keine Parameter und der Rückgabetyp ist "void"
* Zeilen 6-14: Klassendefinition
  * Zeile 6: Nutzung des Keywords __implements__, heißt für uns, dass User-Instanzen vom Typ "IUser" sein müssen

Im Allgemeinen können TypeScript-Klassen noch mehr als hier beschrieben aber das reicht uns, um die Angular 2 Rezepte zu verstehen. Wer mehr über TypeScript-Klassen erfahren möchte, kann [hier](https://www.typescriptlang.org/docs/handbook/classes.html) nachlesen.

## Beispielanwendung

Um besser zu verstehen wie wir mit TypeScript arbeiten können, gibt es hier noch eine kleine Beispielanwendung.
Da Todo-Listen mittlerweile zum Standard geworden sind was Beispielanwendungen angeht, haben wir uns entschieden, dass unsere Anwendung eine Todo-Liste sein soll.
Die Anwendung kann vordefinierte Todos anzeigen und neue Todos in einer existierenden Liste von Todos hinzufügen.
Es ist zwar eine kleine Anwendung, ist aber trotzdem in mehrere Dateien aufgespalten.
Wir wollen damit zeigen wie man mit Hilfe von [ECMAScript-Modulen (ESM)](http://exploringjs.com/es6/ch_modules.html) eine Anwendung modular gestalten kann.
Wenn wir mit ESM arbeiten, ist jede Datei auch ein Modul.
Der komplette Code für die Anwendung befindet sich im Github unter [01-TypeScript/01-Simple\_Todo\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/01-Simple_Todo_App).

### Code für die Anwendung

Die Anwendung hat eine index.html-Datei in der wir die Anwendung laden und im Browser anzeigen und ein Verzeichnis namens "app" für unsere TypeScript-Dateien.
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
      typescriptOptions: {
        emitDecoratorMetadata: true
      },
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
* Zeile 7: Laden vom TypeScript-Compiler
* Zeilen 8-17: Konfiguration für SystemJS und Laden der Anwendung
  * Zeile 10: Hier sagen wir SystemJS, dass unsere TypeScript-Dateien on-the-fly kompiliert werden sollen
  * Zeilen 11-13: Optionen für den TypeScript-Compiler. Die angegebene Option ist für die Beispiel-Anwendung nicht erforderlich, wird aber später bei unseren Rezepten gebraucht, um [Decorators](#gl-decorator) richtig anwenden zu können
  * Zeile 14: Hier sagen wir SystemJS, dass alle Dateien im Verzeichnis "app" eine ".ts" Endung haben. Somit brauchen wir bei dem Importieren eines Moduls die Endung nicht anzugeben
  * Zeile 16: Laden der main.ts-Datei, das Hauptmodul unserer Anwendung

W> #### Achtung
W>
W> Wichtig zu beachten ist, dass wir hier TypeScript on-the-fly, sprich im Browser kompilieren. Für unsere kleine Anwendung ist das noch in Ordnung wird aber für größere Anwendungen zu langsam sein. Wir werden in einem weiteren Abschnitt sehen wie wir die TypeScript-Dateien vorkompilieren können.

I> #### SystemJS
I>
I> SystemJS ist ein Modullader, der verschiedene Arten von Modulen wie z. B. CommonJS, AMD und ESM unterstützt. Strenggenommen müssen wir SystemJS nicht nutzen. Es gibt auch andere Möglichkeiten, aber da es vom Angular-Team empfohlen wird, nutzen wir SystemJS hier und in den Rezepten. Wer mehr über SystemJS erfahren möchte kann [hier](https://github.com/systemjs/systemjs) darüber lesen.

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

Dies ist das Hauptmodul für unsere Anwendung.
Es instantiiert unsere vordefinierte Todos und die Liste von Todos.
Es hat Zugriff auf DOM-Elemente und ruft Methoden auf, um die existierende Todos anzuzeigen und neue Todos hinzuzufügen.

* Zeilen 1-2: Importieren die Module "TodoList" und "TodoItem" mittels [ESM import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import). Wir nutzen hier den Namen der Datei ohne Endung, da wir SystemJS schon gesagt haben, dass Dateien im app-Verzeichnis immer die Endung ".ts" haben (Siehe index.html Zeile 14)
* Zeile 4: Todos für unsere Liste. Die Liste beinhaltet Elemente vom Typ "TodoItem"
* Zeilen 6-8: DOM-Elemente an Konstanten zuweisen. Wir nutzen dafür das [ES6/ES2015 Keyword __const__](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/const). Die Typen "HTMLInputElement" und "HTMLElement" sind in TypeScript vordefiniert

I> #### TypeScript DOM-Typen
I>
I> Leider scheint es keine Liste von Typen zu geben die TypeScript bereitstellt, außer der Liste mit den Basistypen. Wer also mit dem Browser arbeitet und Typen für HTML-Elemente usw. sucht, muss in der [Typdefinitionsdatei für das DOM](https://github.com/Microsoft/TypeScript/blob/master/src/lib/dom.generated.d.ts) nachschauen.

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
In der letzten Zeile nutzen wir eine [ESM export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export) um die Klasse zu exportieren, damit wir diese in anderen Modulen importieren und nutzen können.

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
* Zeile 9: Statt eine normale Funktion (Keyword __function__) nutzen wir hier eine [ES6/ES2015 Arrow-Funktion](https://jsperts.de/blog/arrow-functions/). Arrow-Funktionen sind kürzer zu schreiben und sie haben die Eigenschaft, dass sie den this-Wert ihrer Umgebung nutzen und kein eigenen this-Wert definieren

### Die Anwendung im Browser laden

Da SystemJS Ajax nutzt, um die einzelne Module asynchron zu laden brauchen wir einen Webserver, um unsere Todo-Anwendung im Browser zu laden.
Das Angular-Team empfiehlt den [live-server](https://www.npmjs.com/package/live-server) der automatisch die Seite bei Änderungen neuladen kann.
Wer kein live-reload mag kann auch den [http-server](https://www.npmjs.com/package/http-server) nutzen.
Beide Webserver sind über npm installierbar.
Natürlich kann man auch andere Webserver nutzen wie z. B. Apache, nginx oder Webserver die in einem IDE integriert sind.
Nachdem wir einen Webserver gestartet haben, können wir im Browser zu der richtigen URL navigieren und uns die Anwendung anschauen.

## TypeScript-Dateien vorkompilieren {#c01-precompile}

Wie schon erwähnt, ist das on-the-fly Kompilieren von TypeScript-Dateien auf Dauer keine Lösung.
In diesem Abschnitt werden wir sehen wie wir die TypeScript-Dateien vor dem Laden kompilieren können.
Als Erstes brauchen wir den TypeScript-Compiler.
Es gibt verschiedene Möglichkeiten diesen herunterzuladen und zu installieren.
Wir werden hier mit Node.js und npm arbeiten, da diese Tools weit verbreitet und einfach zu nutzen sind.
Wir können Node.js installieren, indem wir es von der [offizielle Webseite](https://nodejs.org/en/download/) herunterladen.
Bei der Installation von Node.js, wird npm mit installiert.
Nachdem Node.js und npm installiert sind, können wir den Compiler mit

```bash
npm install -g typescript
```

installieren.

Wir nehmen jetzt die Todo-Anwendung vom vorherigen Abschnitt und passen diese so an, dass die TypeScript-Dateien nicht mehr im Browser kompiliert werden.
Dazu müssen wir zwei Sachen machen. Erstens muss die index.html-Datei angepasst werden und zweitens müssen wir die TypeScript-Dateien kompilieren.
Der Code für die Anwendung mit angepasste index.html-Datei befindet sich in [01-TypeScript/02-Precompile](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/02-Precompile).

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

TypeScript wird jetzt nicht mehr in der index.html-Datei geladen und in der SystemJS-Konfiguration haben wir die transpiler-Eigenschaft und die Optionen für den Compiler entfernt. Einen weiteren Unterschied sehen wir in Zeile 9 wo wir jetzt ".js" als Endung nutzen und nicht mehr ".ts". Der Grund dafür ist, dass wir jetzt die kompilierte JavaScript-Dateien laden möchten. Jetzt müssen wir nur noch die TypeScript-Dateien kompilieren. Weitere Anpassungen sind nicht nötig.

{title="Dateien kompilieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs app/main.ts
```

__Erklärung__:

tsc ist der TypeScript-Compiler. Die Optionen "emitDecoratorMetadata" und "experimentalDecorators" sind in unserem Beispiel optional.
Diese werden später für die Angular Rezepte gebraucht.
Die Option "module" gibt an, dass die ESM die wir nutzen in CommonJS-Module umgewandelt werden sollen.
Die Option "target" gibt an welcher ECMAScript-Version unser JavaScript entsprechen soll.
Hier nutzen wir ECMAScript 5.
Als letztes geben wir die main.ts-Datei an.
Da die main.ts-Datei weitere Module importiert, werden diese automatisch kompiliert.
Wir müssen also nicht jede Datei einzeln kompilieren.
Der TypeScript-Compiler bietet noch mehr Optionen an die wir nutzen können. Zwei davon werden wir noch gleich sehen. Weitere Optionen gibt es im [TypeScript-Wiki](https://github.com/Microsoft/TypeScript/wiki/Compiler-Options).

W> #### Wichtig
W>
W> Das Kommando muss im Hauptverzeichnis unserer Anwendung aufgerufen werden. Die resultierende JavaScript-Dateien, werden im gleichen Verzeichnis wie die jeweilige TypeScript-Datei abgelegt.

I> #### CommonJS
I>
I> CommonJS ist ein Modul-Standard der hauptsächlich in Node.js verwendet wird. Wir nutzen CommonJS, weil dies die Zusammenarbeit von TypeScript mit externen Bibliotheken wie Angular 2 vereinfacht. Durch die Verwendung von CommonJS-Modulen ist der Compiler in der Lage automatisch nach Typdefinitionen für externe Bibliotheken im node\_modules-Verzeichnis zu suchen ohne, dass wir ihm sagen müssen wo die Typdefinitionen sind.

I> #### Die target-Option
I>
I> Standardmäßig nutzt der TypeScript-Compiler ECMAScript 3 als "target". Der generierter JavaScript-Code ist also ES3 kompatibel. ES3 zu nutzen ist nur sinnvoll wenn wir alte Browser wie z. B. Internet Explorer 8 unterstützen möchten. Da Angular 2 nur neuere Browser (ab Internet Explorer 9) unterstützt, können wir ruhig ES5 nutzen. Ein weiterer Grund um ES5 zu nutzen ist, dass manche TypeScript-Features wie z. B. [getter/setters](https://www.typescriptlang.org/docs/handbook/classes.html#accessors) für Klassen, in ES3 nicht unterstützt werden.

### Dateien automatisch kompilieren mit "watch"

Bei jede Änderung die Dateien manuell zu kompilieren, kann auf Dauer nerven. Dafür bietet uns der Compiler eine einfache Lösung.
Es gibt eine Option namens "watch". Mit dieser Option werden die Dateien automatisch bei jede Änderung kompiliert.

{title="Kommando mit watch", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs --watch app/main.ts
```

__Erklärung__:

Mit der watch-Option werden unsere Dateien bei jede Änderung automatisch neukompiliert. Das gilt nicht nur für die angegebene app/main.ts-Datei, sondern auch alle Dateien die importiert werden.

### Sourcemaps generieren

Nach dem Kompilieren stimmen meistens die Zeilennummern in der JavaScript- und der TypeScript-Dateien nicht mehr überein.
Das kann das Debugging erschweren, wenn z. B. der Browser ein Fehler in der JavaScript-Datei findet und wir diesen in der TypeScript-Datei finden und korrigieren möchten.
Für genau solche Fälle gibt es Sourcemaps, die uns die richtige Zeile in der TypeScript-Datei anzeigen.
Um Sourcemaps zu erzeugen, nutzen wir eine weitere Option des Compilers.

{title="Sourcemaps generieren", lang=bash}
```
tsc --emitDecoratorMetadata --experimentalDecorators --target ES5 --module commonjs --sourceMap app/main.ts
```

__Erklärung__:

Die Sourcemaps werden im gleichen Verzeichnis wie die JavaScript-Dateien abgelegt und automatisch vom Browser geladen. Wir können auch "watch" mit "sourceMap" kombinieren, wenn wir das möchten.

### Konfigurationsdatei für den Compiler nutzen

Auf Dauer kann es nerven, wenn man die ewig lange Zeile eintippen muss, um unser Projekt zu kompilieren.
Eine Alternative hierfür bietet die tsconfig.json-Datei. Darin können wir alle nötige Optionen angeben und dann den Compiler aufrufen ohne selbst die Optionen angeben zu müssen.

{title="tsconfig.json", lang=json}
```
{
  "compilerOptions": {
    "module": "commonjs",
    "sourceMap": true,
    "emitDecoratorMetadata": true,
    "experimentalDecorators": true,
    "target": "ES5"
  }
}
```

Das Verzeichnis in dem sich die tsconfig.json-Datei befindet, ist das Hauptverzeichnis unseres TypeScript-Projektes.
Nachdem wir die config-Datei erstellt haben, haben wir zwei Möglichkeiten, um unsere Anwendung zu kompilieren.

Wir können

```bash
tsc
```

im Haupt- oder einem Unterverzeichnis unserer Anwendung aufrufen oder wir können

```bash
tsc -p Hauptverzeichnis
```

aufrufen wobei __Hauptverzeichnis__ der Pfad zu dem Verzeichnis ist in dem die tsconfig.json-Datei liegt.
Da unsere config-Datei die files-Eigenschaft nicht setzt, werden alle \*.ts-Dateien kompiliert, die sich im Haupt- und in den Unterverzeichnissen befinden. Das TypeScript-Handbuch hat mehr Informationen über die [tsconfig.json-Datei](http://www.typescriptlang.org/docs/handbook/tsconfig.json.html) und die Eigenschaften, die diese enthalten kann.

