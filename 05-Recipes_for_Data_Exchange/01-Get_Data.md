## Daten vom Server mit GET holen {#c05-get-data}

### Problem

Ich möchte zur Laufzeit Daten im JSON-Format von einem Server holen.

### Zutaten
* [Ein Service](#c02-define-service), um die Daten zu holen
* Das Http-Modul von Angular
* Der Http-Service von Angular
* Die map-Methode für Observables (Ist Teil von RxJS)
* [Auf Nutzer-Input reagieren](#c03-user-input) (Wir holen Daten nach einem Klick auf einen Button)
* [Liste von Daten anzeigen](#c03-data-list)
* Anpassungen an der app.module.ts-Datei
* Anpassungen an der package.json-Datei

### Lösung

In dieser Lösung werden wir sehen, wie wir JSON-Daten von einem Server holen können.
Die Fehlerbehandlung lassen wir außen vor, damit wir uns fürs Erste auf die GET-Anfrage konzentrieren können.
Über Fehler bei Server-Anfragen reden wir im Rezept "[Server-Anfragen und Fehlerbehandlung](#c05-error-handling)".

Wir gehen hier davon aus, dass wir einen Server haben, der auf __127.0.0.1:3000__ hört.
Wenn eine GET-Anfrage an __/data__ geschickt wird, antwortet der Server mit Status __200__ und Daten im JSON-Format.
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
* Zeile 5: Im Gegensatz zum Service im Rezept "Ein Service definieren" ist der Injectable-Decorator hier nicht optional, da unser Service eine Abhängigkeit besitzt: den Http-Service (siehe Zeile 9)
* Zeile 9: Hier definieren wir den Http-Service als Abhängigkeit unseres Services
* Zeile 15: Hier rufen wir die get-Methode des Http-Services auf. Als Parameter erhält diese Methode eine URL. Der Rückgabewert ist ein Observable (Teil von RxJS)
* Zeile 16: Wir nutzen die map-Methode, um die Antwort des Servers zu transformieren. Der response-Parameter ist eine Instanz der Response-Klasse und besitzt eine json-Methode (__.json()__), die die Daten des Servers in ein Objekt transformiert

Jetzt müssen wir noch unsere Komponente aus "Ein Service definieren" anpassen, so dass diese mit dem Http-Service und Observables arbeiten kann.
Wir werden die Daten nach einem Klick auf den "Get Data"-Button holen und diese in einer Liste anzeigen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

import { DataService } from './data.service';

interface Data {
  id: number;
  name: string;
}

@Component({
  selector: 'app-root',
  template: `
    <button (click)="getData()">Get Data</button>
    <ul>
      <li *ngFor="let d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
export class AppComponent {
  dataService: DataService;
  data: Array<Data>;

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

* Zeile 21: Die data-Eigenschaft wird benutzt, um die Daten in der Liste anzuzeigen. Sie ist vom Typ "Data" (Siehe Zeilen 5-8)
* Zeilen 28-33: Methode, die aufgerufen wird, wenn der Nutzer auf den "Get Data"-Button klickt
  * Zeile 30: Die getData-Methode des Services gibt ein Observable zurück. Jedes Observable hat eine subscribe-Methode die wir nutzen können, um auf Änderungen zu reagieren, indem wir der Methode eine Callback-Funktion übergeben


Da sich der Http-Service in einem eigenen Angular-Modul befindet, müssen wir dieses Modul in unser "AppModule" importieren.

{title="app.module.ts", lang=js}
```
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { DataService } from './data.service';

@NgModule({
  imports: [ BrowserModule, HttpModule ],
  declarations: [ AppComponent ],
  bootstrap: [ AppComponent ]
  providers: [ DataService ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 8: Hier importieren wir das "HttpModule" in unser Modul. Jetzt können wir alle Services, die dieses Modul definiert in unserem Code nutzen

Da sich das "HttpModule" in einem eigenen npm-Paket befindet, müssen wir dieses auch in der package.json-Datei deklarieren.

{title="package.json", lang=js}
```
{
  ...
  "dependencies": {
    ...
    "@angular/http": "2.1.2"
    ...
  }
  ...
}
```

Wenn eine Angular-Anwendung mit angular-cli initialisiert wird, wird das "HttpModule" automatisch von angular-cli importiert und das entsprechende npm-Paket in der package.json-Datei deklariert.

### Diskussion

Wir hätten den Http-Service auch direkt in unserer Komponenten nutzen können.
Wir haben uns stattdessen für die Nutzung eines weiteren Services entschieden.
Der Grund dafür ist, dass wir die Logik für den Aufruf nicht in unserer Komponenten haben wollen.
Die Komponente interessiert sich nicht dafür, wie wir die Daten bekommen.
Diese benötigt nur ein Array mit Daten.
Woher dieses Array stammt, ist der Komponente egal.
Mit dem gesonderten Service ist es einfacher z. B. die URL zu ändern, ohne dass wir die Komponente anpassen müssen.
Wir passen nur den Service an und alle Komponenten, die diesen Service benutzen, werden weiterhin funktionieren.
Es ist allgemein ein "Best Practice" unsere Komponenten schlank zu halten und Logik wie z. B. "Wie hole ich Daten?" einem Service zu überlassen.

I> #### Observables
I>
I> Observables sind Objekte, die eine Folge von Werten generieren (einen Fluss/Stream). Das Generieren der Werte kann synchron oder asynchron erfolgen. Die generierten Werte werden an sogenannte "Observer" übergeben, die etwas mit den Daten machen, z. B. diese in der View anzeigen. In unserem Beispiel erzeugt die get-Methode des Http-Services ein Observable. Dieses Observable generiert einen Wert, wenn der Server eine Antwort geliefert hat. Die generierten Werte können transformiert werden (z. B. mit der map-Methode). Am Ende werden sie einem Observer übergeben.

I> #### Observer
I>
I> Observer sind die Callback-Funktionen, die wir der subscribe-Methode übergeben. In unserem Beispiel ist die Funktion mit dem data-Parameter (Zeilen 30-32) ein Observer.

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/01-Get\_Data](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/01-Get_Data)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/05-Recipes_for_Data_Exchange/01-Get_Data)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

### Weitere Ressourcen

* Offizielle Dokumentation für das [response-Objekt](https://angular.io/docs/ts/latest/api/http/index/Response-class.html) auf der Angular 2 Webseite
* Offizielle [Http-Service](https://angular.io/docs/ts/latest/api/http/index/Http-class.html) Dokumentation auf der Angular 2 Webseite
* Die RxJS-Dokumentation bietet weitere Informationen über [Observables](https://github.com/ReactiveX/RxJS/blob/master/doc/observable.md) und [Observer](https://github.com/ReactiveX/rxjs/blob/master/doc/observer.md)

