## Klassen

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

Nach dem "class"-Keyword kommt der Name der Klasse, in unserem Fall "User" und in der Klasse gibts eine optional Konstruktorfunktion (constructor) mit dem Parameter "name" und eine "print"-Methode. In ES5 würde unsere Klasse so aussehen:

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

Der Namen der Konstruktorfunktion wird in TypeScript als Klassenname benutzt und der Rumpf der Konstruktorfunktion und ihre Parameter, werden der constructor-Eigenschaft übergeben. Die restliche Methoden einer Klasse sind einfach Methoden die in ES5 zu der prototype-Eigenschaft gehören. Da wir hier mit TypeScript arbeiten, können wir natürlich auch Typinformationen in unsere Klassen hinterlegen. So könnte die Klasse von oben aussehen mit Typinformationen:

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

In Zeile 2, sagen wir TypeScript, dass unsere Instanzen der Klasse User eine Instanzvariable names "name" mit Typ "string" haben. Das hier ist ein von den Unterschieden zwischen TypeScript und ES6/ES2015 Klassen. In ES6/ES2015 Klassen haben wir keine Typinformationen und wir geben auch nicht an was für Instanzvariablen unsere Instanzen haben. Ein weiteren Unterschied sehen wir hier:

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

Dieses mal haben wir in Zeile 2 direkt einen Wert an unsere Instanzvariable "name" zugewiesen. Diese Schreibweise ist vorallem nützlich wenn wir der Instanzvariable einen Standardwert geben möchten oder wenn man mit statischen Daten arbeitet. Auch das ist in ES6/ES2015 Klassen nicht erlaubt, aber es ist möglich, dass [ES7/ES2016 Klassen](https://github.com/jeffmo/es-class-fields-and-static-properties) das können, natürlich aber ohne die Typinformation. Im allgemeinen können TypeScript Klassen noch viel mehr als hier beschrieben, aber das reicht uns um die Angular 2 Rezepte zu verstehen. Wer mehr über TypeScript Klassen erfahren möchte, kann [hier](http://www.typescriptlang.org/Handbook#classes) nachlesen.

