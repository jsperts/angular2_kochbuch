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
* Zeilen 3-5: Die Klasse hat eine (optionale) Konstruktorfunktion mit dem Parameter "name". Diese wird aufgerufen, wenn wir, wie in Zeile 12, "new" benutzen
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

var user: User = new User('Max');
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

