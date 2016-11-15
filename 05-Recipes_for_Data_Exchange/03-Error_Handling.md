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
      errorString = 'Some error occurred';
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
  * Zeile 32: Wir geben eine Observable-Instanz mit Fehler zurück, so dass der zweite Parameter der subscribe-Methode aufgerufen wird (siehe Zeile 24 im Ausschnitt aus der app.component.ts-Datei)


Den eigentlichen Server-Fehler haben wir schon im Service mit Hilfe der catch-Methode behandelt.
Da wir zusätzlich dem Nutzer eine sinnvolle Fehlermeldung anzeigen möchten, müssen wir den Fehler auch in der Komponente behandeln.

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
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
export class AppComponent {
  ...

  errorText: string;

  constructor(dataService: DataService) {... }

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

* Zeile 8: Fehlermeldung in der View anzeigen
* Zeilen 26-28: Fehlerbehandlungsfunktion als zweiter Parameter der subscribe-Methode
  * Zeile 27: Fehlertext von Zeile 31 des Services als Wert der errorText-Eigenschaft setzen

### Diskussion

Die catch-Methode von Instanzen der Observable-Klasse ist vergleichbar mit der catch-Methode einer Promise-Kette oder dem catch-Block einer __try__/__catch__-Anweisung.
Jeder Fehler in der Kette der Observables, der vor der catch-Methode auftritt, kann in der catch-Methode behandelt werden.
Ähnlich wie bei einem __try__/__catch__ und bei Promises wird bei einen Fehler die Ausführungs-Kette "unterbrochen" und wir springen direkt zu der catch-Methode.
Bei der Fehlerbehandlung in der catch-Methode können wir eine Instanz eines Observable mit Fehler zurückgeben, um erneut einen Fehler zu erzeugen.
Das ist ähnlich zu einer throw-Anweisung in einem catch-Block einer try/catch-Anweisung.

Wie wir in diesem Rezept gesehen haben, kann die subscribe-Methode nicht nur eine Callback-Funktion als Parameter erhalten, sondern zwei (genauer gesagt sind es drei aber der dritte Parameter ist für uns vorerst nicht relevant).
Wir wissen schon, dass die erste Callback-Funktion aufgerufen wird, wenn die Server-Anfrage erfolgreich ist.
Die zweite Callback-Funktion wird im Falle eines Fehlers aufgerufen.
Diese Callback-Funktion ist unsere zweite Möglichkeit, einen Fehler in einer Observables-Kette zu behandeln.
Wir haben also den Fehler an zwei verschiedenen Orten behandelt:
Einmal in unserem Service mittels catch-Methode und einmal in unserer Komponente mit Hilfe des zweiten Parameters der subscribe-Methode.
Prinzipiell wäre es möglich, den Fehler entweder im Service oder in der Komponente zu behandeln.
Der zweite Parameter der subscribe-Methode ist optional und optional ist auch die Nutzung der catch-Methode.
Der Grund, weshalb wir den Fehler an zwei Stellen behandeln, ist ganz einfach.
Wir wollen nicht, dass unsere Komponente wissen muss, wie die Server-Antwort im Falle eines Fehlers aussieht, genauso, wie wir nicht wollten, dass die Komponente weiß, was mit einer erfolgreichen Server-Antwort zu tun ist, bevor Daten angezeigt werden können.
Der Komponente reicht es, Daten bzw. Fehlermeldungen zu erhalten, die direkt angezeigt werden können.

I> #### Fehler bei einer Server-Anfrage
I>
I> Grob können wir bei Server-Anfragen mittels des Http-Services, zwei Fehlerquellen unterscheiden:
I> (1) Die Anfrage kann nicht geschickt werden, z. B., wenn der Server nicht verfügbar ist
I> (2) Der Status der Antwort (response.status) ist nicht zwischen __200__ und __299__

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/03-Error_Handling)

Code für den Server: [server.js](https://github.com/jsperts/angular2_kochbuch_code/tree/master/05-Recipes_for_Data_Exchange/server.js). Der Server funktioniert mit Node.js.

