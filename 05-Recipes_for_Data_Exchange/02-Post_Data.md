## Daten an den Server mit POST schicken

### Problem

Ich möchte mittels POST-Anfrage Daten an einem Server schicken.

### Zutaten
* [Daten vom Server mit GET holen](#c05-get-data)
* Die Headers-Klasse von Angular
* Die RequestOptions-Klasse von Angular

### Lösung

Wir werden hier die Lösung vom Rezept "Daten vom Server mit GET holen" erweitern, so dass wir auch Daten an den Server schicken können.
Auch hier lassen wir die Fehlerbehandlung außen vor.
Siehe dazu "[Server-Anfragen und Fehlerbehandlung](#c05-error-handling)".

Wir gehen davon aus, dass wir einen Server haben der auf __127.0.0.1:3000__ hört.
Wenn eine POST-Anfrage nach __/data__ geschickt wird, antwortet der Server mit Status __200__ und Daten im JSON-Format.
Bei der Anfrage erwartet der Server ein Objekt im JSON-Format mit eine name-Eigenschaft.
Für die Antwort wird dieses Objekt um eine id-Eigenschaft erweitert.
Wir nutzten __http://127.0.0.1:3000/data__ als URL für die Anfrage.

{title="Daten für die Anfrage", lang=json}
```
{
  "name": "New Name"
}
```

{title="Dazugehörige Antwort", lang=json}
```
{
  "data": {
    "id": 3,
    "name": "New Name"
  }
}
```

Unser DataService wird um eine neue Methode und ein Import erweitert.
Der Rest bleibt gleich wie im Rezept "Daten vom Server mit GET holen".

{title="data.service.ts", lang=js}
```
import { Injectable } from '@angular/core';
import {
    Http,
    Headers,
    RequestOptions
} from '@angular/http';
import 'rxjs/add/operator/map';

@Injectable()
export class DataService {

  constructor(http: Http) {...}

  getData() {...}

  sendData(name) {
    const headers = new Headers({ 'Content-Type': 'application/json' });
    const options = new RequestOptions({ headers });

    const data = JSON.stringify({ name });

    const observable = this.http.post(this.url, data, options);
    const anotherObservable = observable.map((response) => response.json().data);
    return anotherObservable;
  }
}
```

__Erklärung__:

* Zeilen 4-5: Hier werden die Klassen Headers und RequestOptions importiert
* Zeilen 16-25: Methode die wir Aufrufen, um Daten an den Server zu schicken
  * Zeile 17: Instantiierung eines headers-Objektes mit "Content-Type" __application/json__
  * Zeile 18: Instantiierung eines Objektes für Request-Optionen. Das headers-Objekt wird dem RequestOptions-Konstruktor übergeben
  * Zeile 20: Zur Zeit erwartet Angular ein String bei dem Aufruf der post-Methode (Zeile 22). Darum müssen wir unser Objekt in ein String transformieren
  * Zeile 22: Aufruf der post-Methode mit den Daten als zweiten Parameter und die Optionen für die Anfrage als dritten Parameter


Auch unsere Komponente wird um eine sendData-Methode erweitert.

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  providers: [DataService, HTTP_PROVIDERS],
  template: `
    <button (click)="getData()">Get Data</button>
    <button (click)="sendData()">Send Data</button>
    <ul>
      <li *ngFor="let d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
export class DemoAppComponent {

  ...

  constructor(dataService:DataService) {...}

  getData() {...}

  sendData() {
    const name = 'New Name';
    this.dataService.sendData(name)
        .subscribe((data) => {
          this.data.push(data);
        });
  }
}
```

__Erklärung__:

* Zeile 8: Neuer Button. Bei Klick wird dir sendData-Methode aufgerufen
* Zeilen 22-28: Methode die aufgerufen wird, um Daten zu schicken
  * Zeile 23: Die Daten, die wir schicken wollen
  * Zeile 24: Aufruf der sendData-Methode des DataService. Diese Methode gibt ein Observable zurück.
  * Zeile 25: Die Callback-Funktion (Observer) der subscribe-Methode wird aufgerufen, wenn der Server uns eine Antwort geschickt hat. Die data-Variable ist ein Objekt mit "name" und "id" als Eigenschaften
  * Zeile 26: Das neue Objekt wird der Liste mit den Daten hinzugefügt

### Diskussion

Einige Serverimplementierungen erwarten __application/json__ als "Content-Type", damit diese eine Anfrage mit JSON-Daten bearbeiten können.
Aus diesem Grund haben wir extra Optionen der post-Methode übergeben.
Tatsächlich ist der dritte Parameter der post-Methode optional.
Alle Methoden der Http-Klasse, darunter auch die get-Methode, die wir schon gesehen haben, können als letzten Parameter eine Instanz der RequestOptions-Klasse bekommen.
Wenn wir also für einzelne Anfragen extra Headers brauchen, können wir diese mit Hilfe der Headers- und der RequestOptions-Klassen definieren.

Wir haben bis jetzt ein Detail über die Observables, die die Methoden der Http-Klasse zurück geben verschwiegen.
Die subscribe-Methode ist nicht nur eine Möglichkeit mittels einer Callback-Funktion auf Änderungen zu reagieren.
Ohne den Aufruf der subscribe-Methode (mit oder ohne Callback) würde Angular gar keine Server-Anfrage schicken.
Der Grund dafür ist, dass die Http-Methoden sogenannte "Cold Observables" zurück geben.
Cold Observables führen erst dann die gewünschte Operation, wenn jemand die subscribe-Methode des Observable aufruft.
In unsere Lösung ist die Operation die POST-Anfrage und unser "jemand" die sendData-Methode der Komponente.
Siehe auch [Cold vs. Hot Observables](https://github.com/Reactive-Extensions/RxJS/blob/master/doc/gettingstarted/creating.md#cold-vs-hot-observables).

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/02-Post\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/02-Post_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/05-Recipes_for_Data_Exchange/02-Post_Data)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

### Weitere Ressourcen

* Offizielle [Headers](https://angular.io/docs/ts/latest/api/http/Headers-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [RequestOptions](https://angular.io/docs/ts/latest/api/http/RequestOptions-class.html) Dokumentation auf der Angular 2 Webseite

