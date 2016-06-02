# Rezepte für den Datenaustausch

In der Regel möchten wir bei Web-Anwendungen in der Lage sein mit einem Server Daten auszutauschen.
Wir möchten zur Laufzeit Daten nachladen aber auch Daten, die uns der Nutzer gibt an den Server schicken.
In diesem Kapitel werden wir den Http-Service von Angular kennen lernen und sehen wie wir den nutzen können, um mit einem Server zu kommunizieren.

## Daten vom Server mit GET holen {#c05-get-data}

### Problem

Ich möchte zur Laufzeit Daten im JSON-Format von einem Server holen.

### Zutaten
* [Angular 2 Anwendung](#c02-angular-app)
* [Ein Service](#c02-define-service)
* Den Http-Service von Angular
* Die map-Methode für Observables (Ist Teil von RxJS)
* [Auf Nutzer-Input reagieren](#c03-user-input) (Wir holen die Daten nach einem Klick auf einen Button)
* [Liste von Daten anzeigen](#c03-data-list)

### Lösung

In dieser Lösung werden wir sehen wie wir JSON-Daten von einem Server holen können.
Die Fehlerbehandlung lassen wir außen vor, damit wir uns für das Erste auf die GET-Anfrage konzentrieren können.
Über Fehler bei Server-Anfragen reden wir im Rezept "[Server-Anfragen und Fehlerbehandlung](#c05-error-handling)".

Wir gehen hier davon aus, dass wir einen Server haben der auf __127.0.0.1:3000__ hört.
Wenn eine GET-Anfrage nach __/data__ geschickt wird, antwortet der Server mit Status __200__ und Daten im JSON-Format.
Wir nutzen __http://127.0.0.1:3000/data__ als URL für die Anfrage.
Die Daten sehen wie folgt aus:

{title="Server-Antwort", lang=json}
```
{
  "data": [{"id": 1, "name": "a"}, {"id": 2, "name": "b"}]
}
```

Jetzt implementieren wir einen Service, um die GET-Anfrage zu schicken.

{title="data.service.ts", lang=js}
```
import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import 'rxjs/add/operator/map';

@Injectable()
export class DataService {
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
```

__Erklärung__:

* Zeile 2: Hier importieren wir den Http-Service von Angular
* Zeile 3: Durch diesen Import erweitern wir die Instanzen der Observable-Klasse (siehe Zeile 16) um eine Methode namens "map"
* Zeile 5: Im Gegensatz zu dem Service im Rezept "Ein Service definieren", ist der Injectable-Decorator hier nicht optional, da unser Service eine Abhängigkeit hat und zwar den Http-Service (siehe Zeile 9)
* Zeile 9: Hier definieren wir den Http-Service als Abhängigkeit von unserem Service
* Zeile 15: Hier rufen wir die get-Methode vom Http-Service auf. Als Parameter bekommt diese Methode eine URL. Der Rückgabewert ist ein Observable (Teil von RxJS)
* Zeile 16: Wir nutzen die map-Methode, um die Antwort vom Server zu transformieren. Der response-Parameter ist eine Instanz der Response-Klasse und hat eine json-Methode (__.json()__), die die Daten vom Server in ein Objekt transformiert

Jetzt müssen wir noch unsere Komponente aus "Ein Service definieren" anpassen, so dass diese mit dem Http-Service und Observables arbeiten kann.
Wir werden die Daten nach einem Klick auf den "Get Data"-Button holen und diese in eine Liste anzeigen.

{title="demo.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { HTTP_PROVIDERS } from '@angular/http';
import { DataService } from './data.service';

interface IData {
  id: number;
  name: string;
}

@Component({
  selector: 'demo-app',
  providers: [DataService, HTTP_PROVIDERS],
  template: `
    <button (click)="getData()">Get Data</button>
    <ul>
      <li *ngFor="let d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
export class DemoAppComponent {
  dataService: DataService;
  data: Array<IData>;

  constructor(dataService:DataService) {
    this.dataService = dataService;
    this.data = [];
  }

  getData() {
    this.dataService.getData()
        .subscribe((data) => {
          this.data = data;
        });
  }
}
```

__Erklärung__:

Verglichen mit der Komponente aus "Ein Service definieren", wurden zwei Änderungen vorgenommen.
Wir haben weitere Providers definiert und die Konstruktorfunktion angepasst.

* Zeile 2: Hier importieren wir die "HTTP\_PROVIDERS" Variable. Diese beinhaltet Providers für verschiedene Services, die mit Server-Anfragen zu tun haben
* Zeile 12: Damit unser Service den Http-Service nutzen kann, müssen wir dem Injector die HTTP\_PROVIDERS-Variable übergeben
* Zeile 22: Die data-Eigenschaft wird benutzt, um die Daten in der Liste anzuzeigen. Sie ist vom Typ "IData" (Siehe Zeilen 5-8)
* Zeilen 29-34: Methode die Aufgerufen wird, wenn der Nutzer auf den "Get Data"-Button klickt
  * Zeile 31: Die getData-Methode des Services gibt ein Observable zurück. Jedes Observable hat eine subscribe-Methode die wir nutzen können, um auf Änderungen zu reagieren, indem wir der Methode eine Callback-Funktion übergeben

Da sich der Http-Service in einem eigenen Paket befindet, müssen wir dieses Paket auch über npm herunterladen und SystemJS informieren, dass es das Paket importieren soll.
Wenn wir ein Projekt mit angular-cli initialisieren, ist das @angular/http-Paket schon als Abhängigkeit definiert da müssen wir also keine Änderungen vornehmen um den Http-Service zu nutzen.

{title="package.json", lang=json}
```
{

...

  "dependencies": {
    "@angular/common": "2.0.0-rc.1",
    "@angular/compiler": "2.0.0-rc.1",
    "@angular/core": "2.0.0-rc.1",

    "@angular/http": "2.0.0-rc.1",

    "@angular/platform-browser": "2.0.0-rc.1",
    "@angular/platform-browser-dynamic": "2.0.0-rc.1",
    "es6-shim": "^0.35.0",
    "reflect-metadata": "0.1.3",
    "rxjs": "5.0.0-beta.6",
    "systemjs": "0.19.26",
    "zone.js": "^0.6.12"
  },

...

}
```

{title="system-config.ts", lang=js}
```
...

const barrels: string[] = [
  // Angular specific barrels.
  '@angular/core',
  '@angular/common',
  '@angular/compiler',

  '@angular/http',

  '@angular/platform-browser',
  '@angular/platform-browser-dynamic',

  // Thirdparty barrels.
  'rxjs',

  // App specific barrels.
  'app',
  'app/shared',
  /** @cli-barrel */
];

...
```

### Diskussion

Wir hätten den Http-Service auch direkt in unsere Komponenten nutzen können.
Wir haben uns stattdessen für die Nutzung eines weiteren Services entschieden.
Der Grund dafür ist, dass wir die Logik für den Aufruf nicht in unsere Komponenten haben wollen.
Die Komponente interessiert sich nicht wie wir die Daten bekommen.
Diese braucht nur ein Array mit Daten.
Woher dieses Array stammt ist der Komponente egal.
Mit dem extra Service ist es einfacher z. B. die URL zu ändern ohne, dass wir die Komponente anpassen müssen.
Wir passen nur den Service an und alle Komponenten die diesen Service benutzen werden weiterhin funktionieren.
Es ist allgemein ein "Best Practice" unsere Komponenten schlank zu halten und Logik wie z. B. "Wie hole ich Daten?" einem Service zu überlassen.

I> #### Observables
I>
I> Observables sind Objekte, die eine Folge von Werten generieren (einen Fluss/Stream). Das Generieren der Werte kann synchron oder asynchron erfolgen. Die generierte Werte werden an sogenannten "Observers" übergeben die etwas mit den Daten machen z. B. diese in der View anzeigen. In unserem Beispiel erzeugt die get-Methode des Http-Services ein Observable. Dieses Observable generiert ein Wert, wenn der Server eine Antwort geliefert hat. Die generierte Werte können transformiert werden (z. B. mit der map-Methode) und am Ende werden diese einem Observer übergeben.

I> #### Observers
I>
I> Observers sind die Callback-Funktionen, die wir der subscribe-Methode übergeben. In unserem Beispiel ist die Funktion mit dem data-Parameter (Zeilen 30-32) ein Observer.

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/01-Get\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/01-Get_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/05-Recipes_for_Data_Exchange/01-Get_Data)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

### Weitere Ressourcen

* Offizielle [HTTP\_PROVIDERS](https://angular.io/docs/ts/latest/api/http/HTTP_PROVIDERS-let.html) Dokumentation auf der Angular 2 Webseite
* Offizielle Dokumentation für das [response-Objekt](https://angular.io/docs/ts/latest/api/http/Response-class.html) auf der Angular 2 Webseite
* Offizielle [Http-Service](https://angular.io/docs/ts/latest/api/http/Http-class.html) Dokumentation auf der Angular 2 Webseite
* Die RxJS-Dokumentation hat mehr Informationen über [Observables](https://github.com/ReactiveX/RxJS/blob/master/doc/observable.md) und [Observers](https://github.com/ReactiveX/rxjs/blob/master/doc/observer.md)

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

{title="data.service.ts", lang=js}
```
...

import 'rxjs/add/operator/catch';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/observable/throw';

@Injectable()
export class DataService {
  ...

  constructor(http: Http) {
    this.http = http;
    this.url = 'http://127.0.0.1:3000/data';
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
```

__Erklärung__:

* Zeile 3: Durch diesen Import erweitern wir die Instanzen der Observable-Klasse (siehe Zeile 18) um eine Methode namens "catch"
* Zeile 4: Hier importieren wir die Observable-Klasse von RxJS
* Zeile 5: Durch diesen Import erweitern wir die Observable-Klasse (siehe Zeile 31) um eine statische Methode namens "throw"
* Zeile 13: Die URL, um einen Server-Fehler zu erzwingen
* Zeilen 19-21: Hier wird die catch-Methode benutzt, um Fehler beim Server-Aufruf zu behandeln
  * Zeile 20: Wenn ein Fehler auftritt, wird die handleResponseError-Methode aufgerufen
* Zeilen 25-33: Methode, um Server-Fehler zu behandeln
  * Zeile 32: Wir geben zurück eine Instanz von Observable mit Fehler, so dass der zweite Parameter der subscribe-Methode aufgerufen wird (siehe Zeile 24 im Ausschnitt aus der app.component.ts-Datei)


Den eigentlichen Server-Fehler haben wir schon im Service behandelt mit Hilfe der catch-Methode.
Da wir auch dem Nutzer eine sinnvolle Fehlermeldung anzeigen möchten, müssen wir auch in der Komponente den Fehler behandeln.

{title="demo.component.ts", lang=js}
```
...

@Component({
  selector: 'demo-app',
  providers: [DataService, HTTP_PROVIDERS],
  template: `
    <button (click)="getData()">Get Data</button>
    <p>
      Error: {{errorText}}
    </p>
    <ul>
      <li *ngFor="let d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
export class DemoAppComponent {
  ...

  errorText: string;

  constructor(dataService:DataService) {... }

  getData() {
    this.dataService.getData()
        .subscribe((data) => {
          this.data = data;
        }, (errorText) => {
          this.errorText = errorText;
        });
  }
}
```

__Erklärung__:

* Zeile 9: Fehlermeldung in der View anzeigen
* Zeilen 27-29: Fehlerbehandlungsfunktion als zweiter Parameter der subscribe-Methode
  * Zeile 28: Fehlertext von Zeile 31 des Services als Wert für die errorText-Eigenschaft setzen

### Diskussion

Die catch-Methode von Instanzen der Observable-Klasse ist vergleichbar zu der catch-Methode einer Promise-Kette oder dem catch-Block einer __try__/__catch__-Anweisung.
Jeder Fehler in der Kette von Observables, der vor der catch-Methode auftritt, kann in der catch-Methode behandelt werden.
Ähnlich wie bei einem __try__/__catch__ und bei Promises wird bei einen Fehler die Ausführungs-Kette "unterbrochen" und wir springen direkt zu der catch-Methode.
Bei der Fehlerbehandlung in der catch-Methode können wir eine Instanz von Observable mit Fehler zurück geben, um erneut ein Fehler zu erzeugen.
Das ist ähnlich wie, wenn wir bei einer try/catch-Anweisung ein throw-Anweisung im catch-Block nutzen.

Wie wir in diesem Rezept gesehen haben, kann die subscribe-Methode nicht nur eine Callback-Funktion als Parameter haben, sondern zwei (genauer gesagt sind es drei aber der dritte Parameter ist für uns vorerst nicht relevant).
Wir wissen schon, dass die erste Callback-Funktion aufgerufen wird, wenn die Server-Anfrage erfolgreich ist.
Die zweite Callback-Funktion wird im Falle eines Fehlers aufgerufen.
Diese Callback-Funktion ist unsere zweite Möglichkeit einen Fehler in eine Observables-Kette zu behandeln.
Wir haben also den Fehler an zwei verschiedenen Orten behandelt.
Einmal in unserem Service mittels catch-Methode und einmal in unsere Komponente mit Hilfe des zweiten Parameters der subscribe-Methode.
Prinzipiell wäre es möglich den Fehler entweder im Service oder in der Komponente zu behandeln.
Der zweite Parameter der subscribe-Methode ist optional und optional ist auch die Nutzung der catch-Methode.
Der Grund weshalb wir den Fehler an zwei Stellen behandeln ist ganz einfach.
Wir wollen nicht, dass unsere Komponente wissen muss wie die Server-Antwort aussieht im Falle eines Fehlers genau so wie wir nicht wollten, dass die Komponente weiß was mit einer erfolgreiche Server-Antwort zu tun ist bevor Daten angezeigt werden können.
Der Komponente reicht es Daten bzw. Fehlermeldungen zu bekommen, die direkt angezeigt werden können.

I> #### Fehler bei einer Server-Anfrage
I>
I> Grob können wir bei Server-Anfragen mittels des Http-Services, zwei Fehlerquellen unterscheiden:
I> (1) Die Anfrage kann nicht geschickt werden z. B., wenn der Server nicht verfügbar ist
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

Wir konzentrieren uns in der Lösung auf GET-Anfragen, da diese am häufigsten mit Query-Parameter benutzen werden aber wir können auch z. B. bei POST-Anfragen Query-Parameter mitschicken.

{title="data.service.ts", lang=js}
```
import { Injectable } from '@angular/core';
import {
    Http,
    RequestOptions,
    URLSearchParams
} from '@angular/http';
import 'rxjs/add/operator/map';

@Injectable()
export class DataService {

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
```

__Erklärung__:

* Zeile 4-5: Hier werden die Klassen "RequestOptions" und "URLSearchParams" importiert
* Zeile 17: Erzeugung einer Instanz der URLSearchParams-Klasse
* Zeile 18: Query-Parameter "limit" definieren mit Wert __`'`1`'`__ (der zweite Parameter der set-Methode muss ein String sein)
* Zeile 20: Erzeugung einer Instanz der RequestOptions-Klasse. Wir setzen unsere "params" als Wert für die search-Eigenschaft. Die search-Eigenschaft definiert die Query-Parameter für die Anfrage
* Zeile 22: Aufruf der get-Methode mit einer URL und Optionen für die Anfrage

### Diskussion

Wir können die Query-Parameter auch mittels String-Konkatenierung definieren, indem wir selbst ein Query-String zusammen setzen und diesen mit der URL konkatenieren.
Für ein, zwei Parameter können wir dies auch tun aber für viele Parameter ist diese Lösung nicht wirklich geeignet.
Die Nutzung der URLSearchParams-Klasse hat in dem Fall zwei Vorteile.
Zum einen wird der Code lesbarer, wenn wir pro Parameter eine Zeile Code haben.
Zum anderen kümmert sich Angular um das richtige Format für den String der später als Teil der URL mitgeschickt wird.

W> #### URL-Encoding
W>
W> Derzeit werden die Query-Parameter nicht automatisch encodiert vor diese an den Server geschickt werden. Wenn also Zeichen wie z. B. "=" und "&" in den Parametern vorhanden sind (als Teil des Keys oder Wertes), müssen wir diese selbst transformieren. Siehe auch [#4948](https://github.com/angular/angular/issues/4948).

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/04-Query\_Parameters](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/04-Query_Parameters)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js)

### Weitere Ressourcen

* Offizielle [URLSearchParams](https://angular.io/docs/ts/latest/api/http/URLSearchParams-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [RequestOptions](https://angular.io/docs/ts/latest/api/http/RequestOptions-class.html) Dokumentation auf der Angular 2 Webseite

## Server-Anfrage abbrechen (cancel) {#c05-cancel-request}

### Problem

Ich möchte dem Nutzer die Möglichkeit anbieten eine Server-Anfrage abzubrechen, wenn diese zu lange dauert.

### Zutaten

* [Daten vom Server mit GET holen](#c05-get-data)
* Neue URL, um eine Anfrage zu simulieren die drei Sekunden braucht
* Änderungen an der Komponente von "Daten vom Server mit GET holen"
* Die Subscription-Klasse von RxJS (wird nur für die Typdefinition gebraucht)

### Lösung

In unserem Service (data.service.ts) haben wir nur eine Änderung gemacht und zwar haben wir die url-Eigenschaft angepasst. Diese hat jetzt den Wert __`'`http://127.0.0.1:3000/longrequest`'`__.

{title="demo.component.ts", lang=js}
```
...

import { Subscription } from 'rxjs/Subscription';

...

@Component({
  selector: 'demo-app',
  providers: [DataService, HTTP_PROVIDERS],
  template: `
    <button (click)="getData()">Get Data</button>
    <button (click)="cancelRequest()">Cancel</button>
    <ul>
      <li *ngFor="let d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
export class DemoAppComponent {
  ...

  subscription: Subscription;

  constructor(dataService:DataService) {...}

  getData() {
    this.subscription = this.dataService.getData()
        .subscribe((data) => {
          this.data = data;
        });
  }

  cancelRequest() {
    if (this.subscription) {
      this.subscription.unsubscribe();
    }
  }
}
```

__Erklärung__:

* Zeile 3: Hier importieren wir die Subscription-Klasse von RxJS, die wir in Zeile 17 als Typ nutzen
* Zeile 26: Hier speichern wir den Rückgabewert der subscribe-Methode in die subscription-Eigenschaft der Komponenteninstanz
* Zeilen 32-36: Methode die aufgerufen wird, wenn der Nutzer den cancel-Button klickt

### Diskussion

Die subscribe-Methode von Instanzen der Observables-Klasse gibt eine Instanz der Subscription-Klasse zurück.
Wir können auf diese Instanz die unsubscribe-Methode aufrufen, um die dazugehörige Observables wegzuschmeisen.
Nach dem Aufruf der unsubscribe-Methode werden die Observables gelöscht und deren Callback-Funktionen werden nicht mehr aufgerufen.
Auch z. B. die Callback-Funktion der map-Methode (diese wird in der data.service.ts benutzt) wird nicht mehr aufgerufen.
Also erzeugen die Observables keine neuen Werte mehr und der Fluss (stream) wird unterbrochen.
Bei Server-Anfrage wird auch die abort-Methode der XMLHttpRequest-Instanz aufgerufen und die Anfrage wird abgebrochen.

W> #### Server-Anfragen, wenn die Komponente entfernt wird
W>
W> Es gibt verschiedene Situationen, wo eine Komponente entfernt wird. Genauer gibt es Situationen, wo die View der Komponente aus dem DOM entfernt wird. In so einem Fall wird die Komponente meistens von Angular zerstört (destroy), um Ressourcen zu befreien. Aktive Server-Anfragen werden bei der Zerstörung einer Komponente nicht automatisch abgebrochen. Wenn die Antwort zurück kommt, werden alle Callback-Funktionen aufgerufen für eine Komponente die gar keine Daten mehr anzeigen kann. Im schlimmsten Fall kann es zu Fehlern kommen, die wir dem Nutzer nicht oder nicht sinnvoll anzeigen können. Es ist also in den meisten Fällen eine gute Idee die unsubscribe-Methode aufzurufen, wenn die View der Komponente nicht mehr angezeigt wird.

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/05-Cancel\_Request](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/05-Cancel_Request)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

### Weitere Ressourcen

* Die RxJS-Dokumentation hat mehr Informationen über [Subscriptions](https://github.com/ReactiveX/rxjs/blob/master/doc/subscription.md)

