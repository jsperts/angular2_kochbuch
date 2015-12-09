## Klassen {#c01-classes}

Klassen in TypeScript sind ähnlich zu [ES6/ES2015 Klassen](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Classes). Beide bieten uns eine einfache Möglichkeit in JavaScript bzw. TypeScript Objekt-orientiert zu programmieren. Auch wenn wir hier das Keyword "class" nutzen werden, arbeiten wir hier nicht mit echten Klassen wie man die vielleicht aus Java oder andere Programmiersprachen kennt. Als Grundlage für Klassen in JavaScript bzw. TypeScript dient immer noch der Prototyp.

{title="ES6/ES2015 Klasse", lang=js}
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

Erklärung:

* Zeile 2: Nach dem "class"-Keyword kommt der Namen der Klasse, in unserem Fall "User"
* Zeile 3-5: Die Klasse hat eine optionale constructor-Funktion mit dem Parameter "name". Diese Funktion wird aufgerufen wenn wir wie in Zeile 12 "new" benutzen
* Zeile 6: Methode namens "print"

{title="Die User-Klasse in ES5 Schreibweise", lang=js}
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

Erklärung:

Zeile 2 definiert eine Konstruktorfunktion mit Namen "User". In ES6/ES2015/TypeScript wird diese Namen als Klassennamen benutzt. Der Rumpf dieser Funktion und ihre Parameter, werden in der constructor-Funktion benutzt. Methoden einer Klasse sind einfach Methoden die in ES5 zu der prototype-Eigenschaft der Konstruktorfunktion gehören.

{title="TypeScript Klasse", lang=js}
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
```

Erklärung:

In Zeile 2, sagen wir TypeScript, dass unsere Instanzen der Klasse User eine Eigenschaft namens "name" mit Typ "string" haben. Das ist ein von den Unterschieden zwischen TypeScript und ES6/ES2015 Klassen. Da wir hier mit TypeScript arbeiten, können wir natürlich auch Typinformationen in unsere Klassen hinterlegen. Wie immer ist die Typangabe optional, aber wir müssen den Namen der Eigenschaft angeben ansonsten wird der Kompiler eine Warnung geben. Wir können also Zeile 2 auch so schreiben: "name;" ohne die Typangabe.

{title="Eine weitere Schreibweise von TypeScript Klassen", lang=js}
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
```

Erklärung:

Dieses mal haben wir in Zeile 2 direkt einen Wert an unsere Instanzvariable "name" zugewiesen. Diese Schreibweise ist vor allem nützlich wenn wir der Instanzvariable einen Standardwert geben möchten oder wenn man mit statischen Daten arbeitet. Auch das ist in ES6/ES2015 Klassen nicht erlaubt, es ist aber möglich, dass [ES7/ES2016 Klassen](https://github.com/jeffmo/es-class-fields-and-static-properties) das können, natürlich ohne die Typinformation.

### Klassen mit Interfaces

Ein weiterer Vorteil von TypeScript-Klassen gegenüber ES6/ES2015 Klassen ist, dass TypeScript-Klassen ein Interface implementieren können. Dazu nutzt man das Keyword "implements" bei der Klassendefinition.

{title="TypeScript Klasse mit Interface", lang=js}
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

Erklärung:

* Zeile 1-4: Interfacedefinition
  * Zeile 3: Typdefinition für eine Methode. Der Namen der Methode ist "print", sie hat keine Parameter und der Rückgabetyp ist "void"
* Zeile 6-14: Klassendefinition
  * Zeile 6: Nutzung des Keywords "implements", heißt für uns, dass User-Instanzen vom Typ "IUser" sein müssen

Im allgemeinen können TypeScript Klassen noch mehr als hier beschrieben, aber das reicht uns um die Angular 2 Rezepte zu verstehen. Wer mehr über TypeScript Klassen erfahren möchte, kann [hier](http://www.typescriptlang.org/Handbook#classes) nachlesen.

