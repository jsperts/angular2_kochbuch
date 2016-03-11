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

