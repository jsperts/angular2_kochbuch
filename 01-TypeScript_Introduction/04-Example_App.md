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

