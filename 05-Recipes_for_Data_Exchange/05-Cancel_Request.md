## Server-Anfrage abrechen (cancel) {#c05-cancel-request}

### Problem

Ich möchte dem Nutzter die Möglichkeit anbieten eine Server-Anfrage abzubrechen, wenn diese zu lange dauert.

### Zutaten

* [Daten vom Server mit GET holen](#c05-get-data)
* Neue URL für die Anfrage, um eine Anfrage zu simulieren die drei Sekunden braucht
* Änderungen an der Komponente von "Daten vom Server mit GET holen"
* Die Subscription-Klasse vib RxJS (wird nur für die Typdefinition gebraucht)

### Lösung

In unserem Service (data.service.ts) haben wir nur eine Änderung gemacht und zwar haben wir die url-Eigenschaft angepasst. Diese hat jezt den Wert __`'`http://127.0.0.1:3000/longrequest`'`__

{title="Ausschnitt aus der app.component.ts-Datei", lang=js}
```
...

import {Subscription} from 'rxjs/Subscription';

@Component({
  selector: 'my-app',
  providers: [DataService, HTTP_PROVIDERS],
  template: `
    <button (click)="getData()">Get Data</button>
    <button (click)="cancelRequest()">Cancel</button>
    <ul>
      <li *ngFor="#d of data">ID: {{d.id}} Name: {{d.name}}</li>
    </ul>
  `
})
class MyApp {
  subscription: Subscription;

  ...

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

...
```

__Erklärung__:

* Zeile 3: Hier importieren wir die Subscription-Klasse von RxJS, die wir in Zeile 17 als Typ nutzen
* Zeile 22: Hier speichern wir den Rückgabewert der subscribe-Methode in die subscription-Eigenschaft der Komponenteninstanz
* Zeilen 28-32: Methode die aufgerufen wird, wenn der Nutzer den cancel-Button klickt

### Diskussion

Die subscribe-Methode von Instanzen der Observables-Klasse gibt eine Instanz der Subscription-Klasse zurück.
Wir können auf diese Instanz die unsubscribe-Methode aufrufen, um die dazugehörige Observables wegzuschmeisen.
Nach dem Aufruf der unsubscribe-Methode werden die Observables gelöscht und deren Callback-Funktionen werden nicht mehr aufgerufen.
Auch z. B. die Callback-Funktion der map-Methode (diese wird in der data.service.ts benuzt) wird nicht mehr Aufgerufen.
Also erzeugen die Observables keine neue Werte mehr und der Fluss (stream) wird abgebrochen.
Bei Server-Anfrage wird auch die abort-Methode der XMLHttpRequest-Instanz aufgerufen und die Anfrage wird abgebrochen.

### Code

Code auf Github: [05-Recipes\_for\_Data\_Exchange/05-Cancel\_Request](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/05-Cancel_Request)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

