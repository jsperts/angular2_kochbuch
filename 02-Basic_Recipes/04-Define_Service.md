## Ein Service Definieren {#c02-define-service}

### Problem

Ich möchte ein Service definieren und nutzen, damit ich so Teile meiner Logik und Daten aus der Komponente entfernen kann.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* Eine Datei für unseren Service (data.service.ts)
* Injectable-Decorator

### Lösung

Was wir in der Angular-Welt ein Service nennen, ist im Grunde genommen nur eine TypeScript-Klasse.
Services werden benutzt, um Daten und Logik außerhalb von Komponenten zu haben wo wir diese auch wiederverwenden können.

{title="data.service.ts", lang=js}
```
import {Injectable} from 'angular2/core';

const data = ['a', 'b', 'c'];

@Injectable()
class DataService {
  data: Array<string>;
  constructor() {
    this.data = data;
  }

  getData() {
    return this.data;
  }
}

export default DataService;
```

Erklärung:

Zeile 1: Abhängigkeit von unserem Service importieren
Zeile 5: Hier nutzen wir den Injectable-Decorator, um den Service als Injectable zu definieren
Zeilen 6-15: Die Klasse die unseren Service repräsentiert. Wir werden später die getData-Methode nutzen, um Daten zu holen
Zeile 17: Den Service exportieren, so dass wir den in Komponenten und Services nutzen können

Wir haben jetzt ein Service definiert und den können wir jetzt in unsere Komponente nutzen.

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';
import DataService from './data.service';

@Component({
    selector: 'my-app',
    providers: [DataService]
})
@View({
    template: '<div>Hello Data!</div>'
})
class MyApp {
    constructor(dataService: DataService) {
        console.log(dataService.getData());
    }
}

export default MyApp;
```

Erklärung:

Zeile 2: DataService importieren
Zeile 6: Die providers-Eigenschaft sagt Angular welche Services der Komponente und ihre Unterkomponenten zur Verfügung stehen und wie diese zu instanziieren sind, wenn diese als Abhängigkeiten definiert werden (siehe auch Zeile 12)
Zeile 12: Hier sagen wir Angular, dass unsere Komponente eine Instanz des DataService braucht.
Zeile 13: Hier nutzen wir die dataService-Instanz und holen die Daten mit der getData-Methode

### Diskussion

Es ist anzunehmen, dass nach unsere kurze Erklärung in der Lösung noch einige Fragen offen sind.
Wir haben erwähnt, dass wir den Service als Injectable definieren.
Aber was heißt das?
Warum brauchen wir kein "new", um den DataService zu instantiieren?
Was genau sind "providers"?
Wir werden hier versuchen diese Fragen zu beantworten.
Allerdings würde eine vollständige Erklärung den Rahmen eines Rezepts sprengen.

Angular nutzt Dependency Injection (DI), um Abhängigkeiten zu verwalten.
Alle Abhängigkeiten von Komponenten werden mit dem sogenannten "Injector" registriert und dieser weiß dann zur Laufzeit was er tun muss, wenn z. B. eine Komponente ein Service im Konstruktor als Abhängigkeit definiert hat.
Die Information, dass die Komponente ein Service braucht wird in den Metadaten der Komponente gespeichert.
Bei der Komponentendefinition stehen uns diese Metadaten zur Verfügung, da wir den Component-Decorator nutzten.
Bei der Servicedefinition müssen wir den Injectable-Decorator nutzen, damit wir da auch Metadaten haben.
Wir brauchen also den Injectable-Decorator nur, wenn wir für ein Service einen weiteren Service im Konstruktor als Abhängigkeit definieren wollen.
Obwohl unser Service keine Abhängigkeiten hat, haben wir den Decorator benutzt, damit alle Services einheitlich sind und, um Fehler zu vermeiden falls wir später doch eine Abhängigkeit brauchen.
Wir wissen jetzt also was es bedeutet ein Service als Injectable zu definieren und warum wir das machen.

Die Frage "Warum brauchen wir kein "new", um den DataService zu instantiieren?" ist einfach zu beantworten.
Der Injector übernimmt die Instantiierung für uns.
Das hat den Vorteil, dass wir als Nutzer des Services gar nicht brauchen müssen wie wir diesen instantiieren müssen.

Jetzt wollen wir noch die letzte Frage beantworten.
Kurz gesagt ist ein "Provider" ein Rezept, um ein Service zu instantiieren.
Unsere Komponente hat nur eine Abhängigkeit und braucht deshalb auch nur ein Provider.
Der Provider ist die Klasse, die den Service repräsentiert und der Injector weiß das eine Klasse mit "new" zu instantiieren ist und die Instanz als Abhängigkeit zu übergeben ist.
Um genau zu wissen welche Klasse zur welcher Instanz gehört, nutzt der Injector die Typdefinition der Konstruktorparameter.
Alternativ können wir statt eine Typdefinition auch den Inject-Decorator nutzen:

{title="Inject-Decorator statt Typ, lang=js}
```
...

import {Inject} from 'angular2/core';
import DataService from './data.service';

...

class MyApp(@Inject(DataService) dataService) { ... }

...
```

Wir haben unsere Erklärung möglichst kurz gehalten.
Eine ausführlichere Erklärung wie Dependency Injection in Angular funktioniert gibt es auf der Angular 2 Webseite: [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html).
Da wird auch beschrieben wie wir komplexere Provider-Rezepte nutzen können und was wir außer Services als Abhängigkeiten definieren können.

### Code

Code auf Github: [02-Basic\_Recipes/04-Define\_Service](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/04-Define_Service)

