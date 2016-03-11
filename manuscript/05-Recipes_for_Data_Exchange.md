# Rezepte für den Datenaustausch

In der Regel möchten wir bei Web-Anwendungen in der Lage sein mit einem Server Daten auszutauschen.
Wir möchten zur Laufzeit Daten nachladen aber auch Daten die uns der Nutzer gibt an den Server schicken.
In diesem Kapitel werden wir den Http-Service von Angular kennen lernen und sehen wie wir den nutzen können, um mit einem Server zu kommunizieren.

## Daten vom Server mit GET holen {#c05-get-data}

### Problem

Ich möchte zur Laufzeit Daten im JSON-Format von einem Server holen.

### Zutaten
* [Eine Komponente](#c02-component-definition)
* [Ein Service](#c02-define-service)
* Den Http-Service von Angular
* Die map-Methode für Observables (Ist Teil von RxJS)
* [Auf Nutzer-Input reagieren](#c03-user-input) (Wir holen die Daten nach einem Klick auf ein Button)
* [Liste von Daten anzeigen](#c03-data-list)

### Lösung

In dieser Lösung werden wir sehen wie wir JSON-Daten von einem Server holen können.
Die Fehlerbehandlung lassen wir außen vor, damit wir uns für das Erste auf die GET-Anfrage konzentrieren können.
Über Fehler bei Server-Anfragen reden wir im Rezept [Server-Anfragen und Fehlerbehandlung](#c05-error-handling).

Wir gehen hier davon aus, dass wir einen Server haben der auf __127.0.0.1:3000__ hört.
Wenn eine GET-Anfrage nach __/data__ geschickt wird, antwortet der Server mit Status __200__ und Daten im JSON-Format.
Wir nutzen __http://127.0.0.1:3000/data__ als URL für die Anfrage.

{title="Server-Antwort", lang=json}
```
{
  "data": [{"id": 1, "name": "a"}, {"id": 2, "name": "b"}]
}
```

{title="data.service.ts", lang=js}
```
import {Injectable} from 'angular2/core';
import {Http} from 'angular2/http';
import 'rxjs/add/operator/map';

@Injectable()
class DataService {
  http: Http;
  url: string;
  constructor(http: Http) {
    this.http = http;
    this.url = 'http://127.0.0.1:3000/data';
  }

  getData() {
    const observable = this.http.get(this.url);
    const anotherObservable = observable.map((response) => response.json().data);
    return anotherObservable;
  }
}

export default DataService;
```

Erklärung:

Wir haben den Service aus dem Rezept "Ein Service Definieren" und diesen so angepasst, dass wir die Daten mittels Http holen statt statische Daten zu nutzen.

* Zeile 2: Hier importieren wir den Http-Service von Angular
* Zeile 3: Durch diesen Import erweitern wir die Instanzen der Observable-Klasse (siehe Zeile 15) um eine Methode namens "map"
* Zeile 5: Im Gegensatz zu dem Service im Rezept "Ein Service definieren", brauchen wir den Injectable-Decorator, da unser Service eine Abhängigkeit hat und zwar den Http-Service (siehe Zeile 9)
* Zeile 9: Hier definieren wir den Http-Service als Abhängigkeit von unserem Service
* Zeile 15: Hier rufen wir die get-Methode von Http auf. Als Parameter bekommt diese Methode eine URL. Der Rückgabewert ist ein Observable (Teil von RxJS)
* Zeile 16: Wir nutzen die map-Methode, um die Antwort vom Server zu transformieren. Der response-Parameter ist eine Instanz der Response-Klasse und hat eine json-Methode, die die Daten vom Server in ein Objekt transformiert

Jetzt müssen wir noch unsere Komponente aus "Ein Service definieren" anpassen, so dass diese mit Http und Observables arbeiten kann.
Wir werden die Daten nach einem Klick auf den "Get Data"-Button holen und diese in eine Liste anzeigen.

{title="app.component.ts", lang=js}
```
import {Component, View} from 'angular2/core';
import {HTTP_PROVIDERS} from 'angular2/http';
import DataService from './data.service';

interface IData {
  id: number;
  name: string;
}

@Component({
  selector: 'my-app',
  providers: [DataService, HTTP_PROVIDERS]
})
@View({
  template: `
    <button (click)="getData()">Get Data</button>
    <ul>
      <li *ngFor="#d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
class MyApp {
  dataService:DataService;
  data: Array<IData>;

  constructor(dataService:DataService) {
    this.dataService = dataService;
  }

  getData() {
    this.dataService.getData()
        .subscribe((data) => {
          this.data = data;
        });
  }
}

export default MyApp;
```

Erklärung:

Verglichen mit der Komponente aus "Ein Service definieren", wurden zwei Änderungen vorgenommen.
Wir haben weitere Providers definiert und die Konstruktorfunktion angepasst.

* Zeile 2: Hier importieren wir die HTTP\_PROVIDERS Variable. Diese beinhaltet Providers für verschiedene Services die mit Server-Anfragen zu tun haben
* Zeile 12: Damit unser Service den Http-Service nutzen kann, müssen wir dem Injector die HTTP\_PROVIDERS-Variable übergeben
* Zeile 24: Die data-Eigenschaft wird benutzt, um die Daten in der Liste anzuzeigen. Sie ist vom Typ "IData" (Siehe Zeilen 5-8)
* Zeilen 30-25: Methode die Aufgerufen wird, wenn der Nutzer auf den "Get Data"-Button klickt
* Zeile 31: Die getData-Methode des Service gibt ein Observable zurück. Jedes Observable hat eine subscribe-Methode die wir nutzen können, um auf Änderungen zu reagieren, indem wir der Methode eine Callback-Funktion übergeben

Da sich der Http-Service in eine eigener JavaScript-Datei befindet, müssen wir diese Datei in unsere index.html-Datei importieren.

{title="Ausschnitt aus der index.html-Datei", lang=js}
```
...

<script src="https://code.angularjs.org/2.0.0-beta.6/Rx.js"></script>
<script src="https://code.angularjs.org/2.0.0-beta.6/angular2-polyfills.js"></script>
<script src="https://code.angularjs.org/2.0.0-beta.6/angular2.dev.js"></script>
<script src="https://code.angularjs.org/2.0.0-beta.6/http.dev.js"></script>

...
```

### Diskussion

Wir hätten den Http-Service auch direkt in unsere Komponenten nutzen können.
Wir haben uns stattdessen für die Nutzung eines weiteren Services entschieden.
Der Grund dafür ist, dass wir die Logik für den Aufruf nicht in unsere Komponenten haben wollen.
Die Komponente interessiert sich nicht wie wir die Daten bekommen.
Diese braucht nur ein Array mit Daten.
Woher dieses Array stammt ist der Komponente egal.
Mit dem extra Service ist es einfacher z. B. die URL zu ändern ohne, dass wir Komponente anpassen müssen.
Wir passen nur den Service an und alle Komponenten die diesen Service benutzen werden weiterhin funktionieren.
Es ist allgemein ein "Best Practice" unsere Komponenten schlank zu halten und Logik wie z. B. "Wie hole ich Daten?" einem Service zu überlassen.

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/01-Get\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/01-Get_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/05-Recipes_for_Data_Exchange/01-Get_Data)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

### Weitere Ressourcen

* Offizielle [HTTP\_PROVIDERS](https://angular.io/docs/ts/latest/api/http/HTTP_PROVIDERS-let.html) Dokumentation auf der Angular 2 Webseite
* Offizielle Dokumentation für das [response-Objekt](https://angular.io/docs/ts/latest/api/http/Response-class.html) auf der Angular 2 Webseite
* Offizielle [Http-Service](https://angular.io/docs/ts/latest/api/http/Http-class.html) Dokumentation auf der Angular 2 Webseite

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
Siehe dazu [Server-Anfragen und Fehlerbehandlung](#c05-error-handling).

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

Unser DataService wird, um eine neue Methode und ein Import erweitert.
Der Rest bleibt gleich wie im Rezept "Daten vom Server mit GET holen".
Damit wir uns besser auf die neuen Teilen konzentrieren können, haben wir die gleich bleibende Teile durch Punkte (...) ersetzt.

{title="Ausschnitt aus data.service.ts", lang=js}
```
...

import {Headers, RequestOptions} from 'angular2/http';

@Injectable()
class DataService {

  ...

  getData() { ... }

  sendData(name) {
    const headers = new Headers({'Content-Type': 'application/json'});
    const options = new RequestOptions({headers});

    const data = JSON.stringify({name});

    const observable = this.http.post(this.url, data, options);
    const anotherObservable = observable.map((response) => response.json().data);
    return anotherObservable;
  }
}

export default DataService;
```

Erklärung:

* Zeile 3: Hier werden die Klassen Headers und RequestOptions importiert
* Zeilen 12-21: Methode die wir Aufrufen, um Daten an den Server zu schicken
  * Zeile 13: Instantiierung eines headers-Objektes mit "Content-Type" __application/json__
  * Zeile 14: Instantiierung eines Objektes für Request-Optionen. Das headers-Objekt wird bei der Instantiierung dem options-Objekt übergeben
  * Zeile 16: Zur Zeit erwartet Angular ein String bei dem Aufruf der post-Methode (Zeile 18). Darum müssen wir unser Objekt in ein String transformieren
  * Zeile 18: Aufruf der post-Methode mit den Daten als zweiten Parameter und die Optionen für die Anfrage als dritten Parameter

Auch unsere Komponente wird um eine sendData-Methode erweitert.
Teile der Komponente die wir nicht geändert haben, werden durch Punkte (...) ersetzt.

{title="Ausschnitt aus app.component.ts", lang=js}
```
...

@View({
  template: `
    <button (click)="getData()">Get Data</button>
    <button (click)="sendData()">Send Data</button>
    <ul>
      <li *ngFor="#d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
class MyApp {

  ...

  getData() { ... }

  sendData() {
    const name = 'New Name';
    this.dataService.sendData(name)
        .subscribe((data) => {
          this.data.push(data);
        });
  }
}

export default MyApp;
```

Erklärung:

* Zeile 6: Neuer Button. Bei Klick wird dir sendData-Methode aufgerufen
* Zeilen 18-24: Methode die aufgerufen wird, um Daten zu schicken
  * Zeile 19: Die Daten die wir schicken wollen
  * Zeile 20: Aufruf der sendData-Methode des DataService. Diese Methode gibt ein Observable zurück.
  * Zeile 21: Die Callback-Funktion der subscribe-Methode wird aufgerufen, wenn der Server uns eine Antwort geschickt hat. Die data-Variable ist ein Objekt mit "name" und "id" als Eigenschaften
  * Zeile 22: Das neue Objekt wird der Liste mit den Daten hinzugefügt

### Diskussion

Einige Serverimplementierungen erwarten __application/json__ als Content-Type, damit diese eine Anfrage mit JSON-Daten bearbeiten können.
Aus diesen Grund haben wir extra Optionen der post-Methode übergeben.
Tatsächlich ist der dritte Parameter der post-Methode optional.
Alle Methoden der Http-Klasse, darunter auch die get-Methode die wir schon gesehen haben, können als letzten Parameter eine Instanz der RequestOptions-Klasse bekommen.
Wenn wir also für einzelne Anfragen extra Headers brauchen, können wir diese mit Hilfe der Headers- und der RequestOptions-Klasse definieren.

Wir haben bis jetzt ein Detail über die Observables, die die Methoden der Http-Klasse zurück geben verschwiegen.
Die subscribe-Methode ist nicht nur eine Möglichkeit mittels eine Callback-Funktion auf Änderungen zu reagieren.
Ohne den Aufruf der subscribe-Methode (mit oder ohne Callback) würde Angular gar keine Server-Anfrage schicken.
Der Grund dafür ist, dass die Http-Methoden sogenannte "Cold Observables" zurück geben.
Cold Observables führen erst dann die gewünschte Operation, wenn jemand die subscribe-Methode des Observable aufruft.
In unsere Lösung ist die Operation die GET-Anfrage und unser "jemand" die sendData-Methode der Komponente.
Siehe auch [Cold vs. Hot Observables](https://github.com/Reactive-Extensions/RxJS/blob/master/doc/gettingstarted/creating.md#cold-vs-hot-observables).

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/02-Post\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/02-Post_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/05-Recipes_for_Data_Exchange/02-Post_Data)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

### Weitere Ressourcen

* Offizielle [Headers](https://angular.io/docs/ts/latest/api/http/Headers-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [RequestOptions](https://angular.io/docs/ts/latest/api/http/RequestOptions-class.html) Dokumentation auf der Angular 2 Webseite

## Server-Anfragen und Fehlerbehandlung {#c05-error-handling}

### Problem

Ich möchte dem Nutzer eine sinnvolle Fehlermeldung anzeigen, wenn bei einer Server-Anfrage etwas schief läuft.

### Zutaten
* [Daten vom Server mit GET holen](#c05-get-data)
* [Daten einer Komponente in der View anzeigen](#c03-show-data)

### Lösung

Wir werden den Code aus dem Rezept "Daten vom Server mit GET holen" anpassen.
Fehler bei POST- und weiteren Server-Anfragen können wir analog behandeln.

Wir gehen hier davon aus, dass wir einen Server haben der auf __127.0.0.1:3000__ hört.
Wenn eine Anfrage nach __/error__ geschickt wird, antwortet der Server mit Status __500__ und Daten im JSON-Format.
Wir nutzen __http://127.0.0.1:3000/error__ als URL für die Anfrage.

{title="Server-Antwort", lang=json}
```
{
  "error": "Invalid Url"
}
```

{title="Ausschnitt aus der data.service.ts-Datei", lang=js}
```
...

import 'rxjs/add/operator/catch';
import {Observable} from 'rxjs/Observable';
import 'rxjs/add/observable/throw';

@Injectable()
class DataService {
  ...
  constructor(http: Http) {
    this.http = http;
    this.url = 'http://127.0.0.1:3000/error';
  }

  getData() {
    const observable = this.http.get(this.url)
        .map((response) => response.json().data);
    const anotherObservable = observable.catch((response) => {
      return this.handleResponseError(response);
    });
    return anotherObservable;
  }

  handleResponseError(response) {
    let errorString = '';
    if (response.status === 500) {
      errorString = `Server error: ${response.json().error}`;
    } else {
      errorString = 'Some error occurred'
    }
    return Observable.throw(errorString);
  }
}

export default DataService;
```

Erklärung:

* Zeile 3: Durch diesen Import erweitern wir die Instanzen der Observable-Klasse (siehe Zeile 18) um eine Methode namens "catch"
* Zeile 4: Hier importieren wir die Observable-Klasse von RxJS
* Zeile 5: Durch diesen Import erweitern wir die Observable-Klasse (siehe Zeile 31) um eine statische Methode namens "throw"
* Zeile 12: Die Url, um ein Server-Fehler zu erzwingen
* Zeilen 18-20: Hier wird die catch-Methode benutzt, um Fehler beim Server-Aufruf zu behandeln
  * Zeile 19: Wenn ein Fehler auftritt, wird die handleResponseError-Methode aufgerufen
* Zeilen 24-32: Methode, um Server-Fehler zu behandeln
  * Zeile 31: Wir geben zurück eine Instanz von Observable mit Fehler, so dass der zweite Parameter der subscribe-Methode aufgerufen wird (siehe Zeile 24 im Ausschnitt aus der app.component.ts-Datei)

Den eigentlichen Server-Fehler haben wir schon im Service behandelt mit Hilfe der catch-Methode.
Da wir auch dem Nutzer eine sinnvolle Fehlermeldung anzeigen möchten, müssen wir auch in der Komponente den Fehler behandeln.

{title="Ausschnitt aus der app.component.ts-Datei", lang=js}
```
...

@View({
  template: `
    <button (click)="getData()">Get Data</button>
    <p>
      Error: {{errorText}}
    </p>
    <ul>
      <li *ngFor="#d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
class MyApp {
  ...
  errorText: string;

  ...

  getData() {
    this.dataService.getData()
        .subscribe((data) => {
          this.data = data;
        }, (errorText) => {
          this.errorText = errorText;
        });
  }
}

export default MyApp;
```

Erklärung:

* Zeile 7: Fehlermeldung in der View anzeigen
* Zeilen 24-26: Fehlerbehandlungsfunktion als zweiter Parameter der subscribe-Methode
  * Zeile 25: Fehlertext von Zeile 31 des Service als Wert für die errorText-Eigenschaft setzen

### Diskussion

Die catch-Methode von Instanzen der Observable-Klasse ist vergleichbar zu der catch-Methode einer Promise-Kette oder im catch-Block einer try/catch-Anweisung.
Jeder Fehler in der Kette von Observables, der vor der catch-Methode auftritt, kann in der catch-Methode behandelt werden.
Ähnlich wie bei einem try/catch und bei Promises wird bei einen Fehler die Ausführungs-Kette "unterbrochen" und wir springen direkt zu der catch-Methode.
Bei der Fehlerbehandlung im "catch" können wir eine Instanz von Observable mit Fehler zurück geben, um erneut ein Fehler zu erzeugen.
Das ist ähnlich wie wenn wir bei einer try/catch-Anweisung ein "throw" im catch-Block nutzen.

Wie wir in diesem Rezept gesehen haben, kann die subscribe-Methode nicht nur eine Callback-Funktion als Parameter haben, sondern zwei (genauer gesagt sind es drei aber der dritte Parameter ist für uns vorerst nicht relevant).
Wir wissen schon, dass die erste Callback-Funktion aufgerufen wird, wenn die Server-Anfrage erfolgreich ist.
Die zweite Callback-Funktion wird im Falle eines Fehlers aufgerufen.
Diese Callback-Funktion ist unsere zweite Möglichkeit einen Fehler in eine Observables-Kette zu behandeln.
Wir haben also Fehler an zwei verschiedenen Orten behandelt.
Einmal in unserem Service mittels "catch" und einmal in unsere Komponente mit Hilfe der zweite Parameter der subscribe-Methode.
Prinzipiell wäre es möglich den Fehler entweder im Service oder in der Komponente zu behandeln.
Der zweite Parameter der subscribe-Methode ist optional und optional ist auch die Nutzung der catch-Methode.
Der Grund weshalb wir den Fehler an zwei Stellen behandeln ist ganz einfach.
Wir wollen nicht, dass unsere Komponente wissen muss wie die Server-Antwort aussieht im Falle eines Fehlers genau so wie wir nicht wollten, dass die Komponente weiß was mit einer erfolgreiche Server-Antwort zu tun ist vor Daten angezeigt werden können.
Der Komponente reicht es Daten bzw. Fehlermeldungen zu bekommen, die direkt angezeigt werden können.

I> #### Fehler bei einer Server-Anfrage
I>
I> Grob können wir bei Server-Anfragen mittels Http, zwei Fehlerquellen unterscheiden:
I> (1) Die Anfrage kann nicht geschickt werden z. B. wenn der Server nicht verfügbar ist
I> (2) Der Status der Antwort (response.status) ist nicht zwischen __200__ und __299__

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/03-Error\_Handling](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/03-Error_Handling)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

## Server-Anfrage mit Query-Parameter

### Problem

Ich möchte bei der Anfrage Query-Parameter an den Server schicken.

### Zutaten
* [Daten vom Server mit GET holen](#c05-get-data)
* Die URLSearchParams-Klasse von Angular
* Die RequestOptions-Klasse von Angular

### Lösung

Wir konzentrieren uns in der Lösung auf GET-Anfragen, da diese am häufigste Query-Parameter nutzen aber wir können auch z. B. bei POST-Anfragen Query-Parameter mitschicken.

{title="Ausschnitt aus der data.service.ts-Datei", lang=js}
```
...

import {RequestOptions, URLSearchParams} from 'angular2/http';

...

class DataService {

  ...

  getData() {
    const limit = 1;

    const params = new URLSearchParams();
    params.set('limit', String(limit));

    const requestOptions = new RequestOptions({search: params});

    const observable = this.http.get(this.url, requestOptions);
    const anotherObservable = observable.map((response) => response.json().data);
    return anotherObservable;
  }
}

export default DataService;
```

Erklärung:

* Zeile 3: Hier werden die Klassen RequestOptions und URLSearchParams importiert
* Zeile 14: Erzeugung einer Instanz der URLSearchParams-Klasse
* Zeile 15: Query-Parameter "limit" definieren mit Wert __'1'__ (der zweite Parameter der set-Methode muss ein String sein)
* Zeile 17: Erzeugung einer Instanz der RequestOptions-Klasse. Wir setzen unsere "params" als Wert für die search-Eigenschaft. Die search-Eigenschaft definiert die Query-Parameter für die Anfrage
* Zeile 19: Aufruf der get-Methode mit einer URL und Optionen für die Anfrage

### Diskussion

Wir können die Query-Parameter auch mittels String-Konkatenierung definieren, indem wir selbst ein Query-String zusammen setzen und diesen mit der URL konkatenieren.
Für ein, zwei Parameter können wir dies auch tun aber für viele Parameter ist die Lösung nicht wirklich geeignet.
Die Nutzung der URLSearchParams-Klasse hat in dem Fall zwei Vorteile.
Zum einen wird der Code lesbarer, wenn wir pro Parameter eine Zeile Code haben.
Zum anderen kümmert sich Angular um das richtige Format für den String der später als Teil der URL mitgeschickt wird.

W> #### URL-Encoding
W>
W> Derzeit werden die Query-Parameter nicht automatisch encodiert vor diese an den Server geschickt werden. Wenn also Zeichen wie z. B. = und & in den Parametern vorhanden sind (als Teil des Keys oder Wertes), müssen wir diese selbst transformieren. Siehe auch [#4948](https://github.com/angular/angular/issues/4948).

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/04-Query\_Parameters](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/04-Query_Parameters)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js)

### Weitere Ressourcen

* Offizielle [URLSearchParams](https://angular.io/docs/ts/latest/api/http/URLSearchParams-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [RequestOptions](https://angular.io/docs/ts/latest/api/http/RequestOptions-class.html) Dokumentation auf der Angular 2 Webseite

