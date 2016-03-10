## Server-Anfrage mit Query-Parameter

### Problem

Ich möchte bei der Anfrage Query-Parameter an den Server schicken.

### Zutaten
* [Daten vom Server mit GET holen](#c05-get-data)
* Die URLSearchParams-Klasse von Angular
* Die RequestOptions-Klasse von Angular

### Lösung

Wir konzentrieren uns in der Lösung auf GET-Anfragen, da diese am haufigste Query-Parameter nutzen aber wir können auch z. B. bei POST-Anfragen Query-Parameter mitschicken.

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

* Zeile 3: TODO: see 02-Post_data about what I wrote there regarding RequestOptions
* Zeile 11-22: get Data
### Diskussion

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/04-Query\_Parameters](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/04-Query_Parameters)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js)

### Weitere Ressourcen

* Offizielle [URLSearchParams](https://angular.io/docs/ts/latest/api/http/URLSearchParams-class.html) Dokumentation auf der Angular 2 Webseite
* Offizielle [RequestOptions](https://angular.io/docs/ts/latest/api/http/RequestOptions-class.html) Dokumentation auf der Angular 2 Webseite

