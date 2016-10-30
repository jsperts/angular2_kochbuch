## Server-Anfrage mit Query-Parametern

### Problem

Ich möchte bei der Anfrage Query-Parameter an den Server schicken.

### Zutaten
* [Daten vom Server mit GET holen](#c05-get-data)
* Die URLSearchParams-Klasse von Angular
* Die RequestOptions-Klasse von Angular

### Lösung

Wir konzentrieren uns in der Lösung auf GET-Anfragen, da diese am Häufigsten mit Query-Parametern benutzen werden. Wir können aber auch z. B. bei POST-Anfragen Query-Parameter mitschicken.

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

* Zeile 17: Erzeugen einer Instanz der URLSearchParams-Klasse
* Zeile 18: Query-Parameter "limit" mit Wert __`'`1`'`__ (der zweite Parameter der set-Methode muss ein String sein) definieren
* Zeile 20: Erzeugen einer Instanz der RequestOptions-Klasse. Wir setzen unsere "params" als Wert der search-Eigenschaft. Die search-Eigenschaft definiert die Query-Parameter der Anfrage
* Zeile 22: Aufruf der get-Methode mit einer URL und Optionen für die Anfrage

### Diskussion

Wir können die Query-Parameter auch mittels String-Konkatenierung definieren, indem wir selbst einen Query-String zusammensetzen und diesen mit der URL konkatenieren.
Für ein bis zwei Parameter können wir dies auch tun, aber für viele Parameter ist diese Lösung nicht wirklich geeignet.
Die Nutzung der URLSearchParams-Klasse hat in diesem Fall zwei Vorteile.
Zum Einen wird der Code lesbarer, wenn wir pro Parameter eine Zeile Code haben.
Zum Anderen kümmert sich Angular um das richtige Format für den String, der später als Teil der URL mitgeschickt wird.

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/04-Query\_Parameters](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/04-Query_Parameters)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js)

### Weitere Ressourcen

* Offizielle [URLSearchParams](https://angular.io/docs/ts/latest/api/http/index/URLSearchParams-class.html)-Dokumentation auf der Angular 2 Webseite
* Offizielle [RequestOptions](https://angular.io/docs/ts/latest/api/http/index/RequestOptions-class.html)-Dokumentation auf der Angular 2 Webseite

