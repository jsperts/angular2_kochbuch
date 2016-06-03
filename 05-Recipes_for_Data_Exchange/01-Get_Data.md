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

  constructor(dataService: DataService) {
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

