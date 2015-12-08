## Beispielanwendung

Um besser zu verstehen wie Typen, Interfaces und Klassen zusammen arbeiten, gibt es hier noch eine kleine TypeScript Todo-Anwendung. Die Anwendung kann vordefinierte Todos anzeigen und neue Todos in einer existierende Liste von Todos hinzufügen. Es ist zwar eine kleine Anwendung, ist aber trotzdem in mehrere Dateien aufgespaltet, um zu zeigen wie man in TypeScript mit Hilfe von ES6/ES2015 Modulen eine Anwendung modular gestalten kann. Der komplette Code für die Anwendung befindet sich im Github unter [01-TypeScript/01-Simple\_Todo\_App](https://github.com/jsperts/angular2_kochbuch_code/tree/master/01-TypeScript/01-Simple_Todo_App).

Die Anwendung hat 2 Verzeichnisse, ein Verzeichnis für den Anwendungscode und eins für Interfaces. Natürlich gibt es auch eine index.html-Datei, in der wir die Anwendung laden und im Browser anzeigen. Das Verzeichnis für den Anwendungscode heißt "app" und das für die Interfaces "interfaces". Im app-Verzeichnis gibt es 3 Dateien namens "main.ts", "todo\_item.ts" und "todo\_list.ts". Den Inhalt diese Dateien werden wir gleich sehen. Im interfaces-Verzeichnis gibt es die itodo.ts-Datei, die ein Todo repräsentiert.

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

Erklärung:

* Zeile 6: Laden von SystemJS
* Zeile 7: Laden vom TypeScript-Compiler
* Zeile 8-17: Konfiguration für SystemJS und Laden der Anwendung
  * Zeile 10: Hier sagen wir SystemJS, dass unsere Module mit TypeScript geschrieben sind, und dass die on-the-fly kompiliert werden sollen, vor der Browser die nutzten kann
  * Zeile 11-13: Optionen für den TypeScript-Compiler. Die angegebene Option ist für die Beispiel-Anwendung nicht erforderlich, wird aber später bei unsere Rezepte gebraucht, um [Decorators]{#gl-decorator} richtig anwenden zu können
  * Zeile 14: Hier sagen wir SystemJS, dass alle Dateien im Verzeichnis "app" eine ".ts" Endung haben. Somit brauchen wir bei imports nicht explizit die Endung anzugeben
  * Zeile 16: Laden der main.ts-Datei, das Hauptmodul unserer Anwendung

W> ## Achtung
W>
W> Wichtig zu beachten ist, dass wir hier TypeScript on-the-fly, sprich im Browser kompilieren. Für unsere kleine Anwendung ist das noch in Ordnung, wird aber für größere Anwendungen zu langsam sein. Wir werden in einem weiteren Abschnitt sehen wie wir die TypeScript-Dateien vorkompilieren können.

I> ## SystemJS
I>
I> SystemJS ist ein Modullader, der verschiedene Arten von Modulen wie z. B. CommonJS, AMD und ES6/ES2015 Module unterstützt. Strenggenommen müssen wir SystemJS nicht nutzen, es gibt auch andere Möglichkeiten, aber da es vom Angular-Team empfohlen wird, nutzen wir es hier. Wer mehr über SystemJS erfahren möchte kann [hier](https://github.com/systemjs/systemjs) darüber lesen.

{title="interfaces/itodo.ts", lang=js}
```
interface ITodo {
  title: string;
  checked: boolean;
  render: (listElement: HTMLElement) => HTMLElement;
}
```

Erklärung:

Interface für eine Todo-Element. Beschreibt eine Todo-Item Instanz (todo\_item.ts).

* Zeile 1: Der Namen des Interfaces ist "ITodo"
* Zeile 2: Ein Element vom Typ "ITodo" hat eine Eigenschaft "title" vom Typ "string"
* Zeile 3: Ein Element vom Typ "ITodo" hat eine Eigenschaft "checked" vom Typ "boolean"
* Zeile 4: Ein Element vom Type "ITodo" hat eine Methode namens "render". Diese Methode hat ein Parameter vom Typ "HTMLElement" und gibt zurück ein Element vom Typ "HTMLElement". Der Rückgabetyp kommt nach dem größer, gleich Zeichen (=>)

{title="app/main.ts", lang=js}
```
///<reference path="../interfaces/itodo.ts"/>
import TodoList from './todo_list';
import TodoItem from './todo_item';

const todos: Array<ITodo> = [new TodoItem('Todo 1'), new TodoItem('Todo 2')];

const inputElement: HTMLInputElement = document.getElementsByTagName('todoTitle').item(0);
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

Erklärung:

Das Hauptmodul für unsere Anwendung. Instanziert Todos und die Liste, hat Zugriff auf DOM-Elemente und ruft Methoden auf, um die Todos anzuzeigen und um eine Todo hinzuzufügen.

* Zeile 1: Importiere die Typdefinition für den Typ "ITodo". Ohne diese Zeile, kann TypeScript nicht wissen wie ein Element vom Typ "ITodo" aussieht
* Zeile 2-3: Importiere die Module TodoList und TodoItem mittels [ES6/ES2015 import-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/import). Wir nutzen hier den Namen der Datei ohne Endung, da wir SystemJS schon gesagt haben, dass Dateien im app-Verzeichnis immer die Endung ".ts" haben
* Zeile 5: Todos für unsere Liste. Das Array ist vom Typ "ITodo"
* Zeile 7-9: DOM-Elemente an Konstanten zuweisen. Wir nutzen dafür das [ES6/ES2015 Keyword "const"](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Statements/const). Die Typen "HTMLInputElement" und "HTMLElement" sind in TypeScript vordefiniert

I> ## TypeScript DOM-Typen
I>
I> Leider scheint es keine Liste von Typen zu geben die TypeScript bereitstellt außer die Liste mit den Basistypen. Wer also mit dem Browser arbeitet und Typen für HTML-Elemente usw. sucht, muss in der [Typdefinitionsdatei für den DOM](https://github.com/Microsoft/TypeScript/blob/master/src/lib/dom.generated.d.ts) schauen.

{title="app/todo_item.ts", lang=js}
```
///<reference path="../interfaces/itodo.ts"/>

class TodoItem implements ITodo {
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

Erklärung:

Modul und Klassendefinition für ein Todo-Element. In der letzte Zeile nutzen wir eine [ES6/ES2015 export-Anweisung](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/export) um die Klasse zu exportieren, damit wir die in andere Modulen importieren und nutzen kann. Das besondere zur Vergleich zu den Klassen die wir in im [vorherigen Abschnitt](#c01-classes) gesehen haben, ist dass diese Klasse das "ITodo"-Interface implementiert. Mit dem Keyword "implements", können wir TypeScript sagen, dass unsere Klasse mindestens die Eigenschaften und Methoden vom angegebenen Interface haben muss.

{title="app/todo_list.ts", lang=js}
```
///<reference path="../interfaces/itodo.ts"/>

class TodoList {
  todos: Array<ITodo>;
  constructor(todos: Array<ITodo>) {
    this.todos = todos;
  }
  render(listElement: HTMLElement) {
    this.todos.forEach((todo: ITodo) => {
      const listItem: HTMLLIElement = document.createElement('li');
      listElement.appendChild(todo.render(listItem));
    });
  }
  add(todo: ITodo) {
    this.todos.push(todo);
  }
  clear(listElement: HTMLElement) {
    listElement.innerHTML = '';
  }
}

export default TodoList;
```

Erklärung:

Modul/Klasse für die gesamte Todo-Liste. Das meiste sollte uns schon bekannt sein, nur Zeile 9 hat eine Besonderheit. Statt eine normale Funktion (Keyword "function") nutzen wir hier eine [ES6/ES2015 Arrow-Funktion](https://jsperts.de/blog/arrow-functions/). Arrow-Funktionen sind kürzer zu schreiben und sie haben die Eigenschaft, dass sie den this-Wert ihrer Umgebung nutzen und kein eigenen this-Wert definieren.

