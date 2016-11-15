## Server-Anfrage abbrechen (cancel) {#c05-cancel-request}

### Problem

Ich möchte dem Nutzer die Möglichkeit anbieten, eine Server-Anfrage abzubrechen, wenn diese zu lange dauert.

### Zutaten

* [Daten vom Server mit GET holen](#c05-get-data)
* Neue URL, um eine Anfrage zu simulieren, die drei Sekunden braucht
* Änderungen an der Komponente aus "Daten vom Server mit GET holen"
* Die Subscription-Klasse von RxJS (wird nur für die Typdefinition gebraucht)

### Lösung

In unserem Service (data.service.ts) haben wir nur eine Änderung durchgeführt. Und zwar haben wir die url-Eigenschaft angepasst. Diese besitzt jetzt den Wert __`'`http://127.0.0.1:3000/longrequest`'`__.

{title="app.component.ts", lang=js}
```
...

import { Subscription } from 'rxjs/Subscription';

...

@Component({
  selector: 'app-root',
  template: `
    <button (click)="getData()">Get Data</button>
    <button (click)="cancelRequest()">Cancel</button>
    <ul>
      <li *ngFor="let d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
export class AppComponent {
  ...

  subscription: Subscription;

  constructor(dataService: DataService) {...}

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
* Zeile 25: Hier speichern wir den Rückgabewert der subscribe-Methode in die subscription-Eigenschaft der Komponenteninstanz
* Zeilen 31-35: Methode, die aufgerufen wird, wenn der Nutzer den cancel-Button klickt

### Diskussion

Die subscribe-Methode der Instanzen der Observables-Klasse gibt eine Instanz der Subscription-Klasse zurück.
Wir können auf dieser Instanz die unsubscribe-Methode aufrufen, um die dazugehörigen Observables wegzuwerfen.
Nach dem Aufruf der unsubscribe-Methode werden die Observables gelöscht und deren Callback-Funktionen nicht mehr aufgerufen.
Auch z. B. die Callback-Funktion der map-Methode (diese wird in der data.service.ts benutzt) wird nicht mehr aufgerufen.
Also erzeugen die Observables keine neuen Werte mehr und der Fluss (stream) wird unterbrochen.
Bei Server-Anfragen wird auch die abort-Methode der XMLHttpRequest-Instanz aufgerufen und die Anfrage wird abgebrochen.

W> #### Server-Anfragen, wenn die Komponente entfernt wird
W>
W> Es gibt verschiedene Situationen, in welchen eine Komponente entfernt wird. Genauer gibt es Situationen, in welchen die View der Komponente aus dem DOM entfernt wird. In einem solchen Fall wird die Komponente meistens von Angular zerstört (destroy), um Ressourcen zu befreien. Aktive Server-Anfragen werden bei der Zerstörung einer Komponente nicht automatisch abgebrochen. Wenn die Antwort zurückkommt, werden alle Callback-Funktionen aufgerufen, auch für eine Komponente die gar keine Daten mehr anzeigen kann. Im schlimmsten Fall kann es zu Fehlern kommen, die wir dem Nutzer nicht oder nicht sinnvoll anzeigen können. Es ist also in den meisten Fällen eine gute Idee die unsubscribe-Methode aufzurufen, wenn die View der Komponente nicht mehr angezeigt wird. Im Rezept "[Code ausführen bei der Zerstörung (destroy) einer Komponente](#c07-on-destroy)" wird gezeigt welche Methode wir für ein Cleanup nutzen können.

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/05-Cancel\_Request](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/05-Cancel_Request)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

### Weitere Ressourcen

* Die RxJS-Dokumentation bietet weitere Informationen über [Subscriptions](https://github.com/ReactiveX/rxjs/blob/master/doc/subscription.md)

