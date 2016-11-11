## Navigation in der Klasse der Komponente

### Problem

Ich möchte zu eine andere Komponente navigieren, indem ich auf einen Button klicke.

### Zutaten

* [Einfaches Routing implementieren](#c06-routing-basics)
* Den ActivatedRoute-Service vom Angular-Router
* Den Router-Service vom Angular-Router
* Anpassungen an der app.component.ts-Datei

### Lösung

Wir wollen jetzt nicht mit Hilfe der RouterLink-Direktive navigieren, sondern mit der navigate-Methode des Routers. Diese können wir nutzen, um zu navigieren als Reaktion auf ein Event z. B. nach dem Speichern von Daten.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
  selector: 'app-root',
  template: `
    <nav>
      <ul>
        <li>
          <button type="button" (click)="navigate('')">
            Home
          </button>
        </li>
        <li>
          <button type="button" (click)="navigate('products')">
            Products
          </button>
        </li>
        <li>
          <button type="button" (click)="navigate('admin')">
            Admin
          </button>
        </li>
      </ul>
    </nav>
    <router-outlet></router-outlet>
  `
})
export class AppComponent {
  route: ActivatedRoute;
  router: Router;
  constructor(route: ActivatedRoute, router: Router) {
    this.route = route;
    this.router = router;
  }

  navigate(path) {
    this.router.navigate([ path ], { relativeTo: this.route });
  }
}
```

__Erklärung__:

Die a-Tags mit der RouterLink-Direktive, die wir im Rezept "Einfaches Routing implementieren" benutzt haben, haben wir hier mit einem button-Tag ersetzt.
Jeder Button ruft bei einem Klick die navigate-Methode der Komponenten-Klasse und übergibt den Pfad.

* Zeile 34: Hier injizieren wir den ActivatedRoute- und den Router-Service. Der ActivatedRoute-Service repräsentiert die aktuelle Route
* Zeilen 39-41: navigate-Methode, die von den Buttons aufgerufen wird
  * Zeile 40: Hier wird die navigate-Methode des Routers aufgerufen. Dieser Aufruf ist äquivalent zu der RouterLink-Direktive, die wir schon gesehen haben

### Diskussion

Wenn wir mit einem Pfad der ohne Slash (/) beginnt navigieren z. B. "admin", führen wir eine relative Navigation aus.
Dem entsprächen heißen Pfade, die ohne Slash beginnen "relative Pfade".
Auch Pfade, die mit "./" (die Pfade "admin" und "./admin" sind äquivalent) oder "../" beginnen sind relativ.
Pfade, die mit einem Slash beginnen z. B. "/admin" heißen "absolute Pfade".
Immer wenn wir relative Pfade nutzen, müssen wir dem Router sagen relativ zu welcher Route wir navigieren möchten.
Im Falle der RouterLink-Direktive wird immer relativ zu der aktuellen Route navigiert.
Mit der navigate-Methode müssen wir explizit die Route angeben zu der wir relativ Navigieren wollen, indem wir die relativeTo-Eigenschaft setzen.

Die Auswirkungen von relativen Pfaden sind vor allem sichtbar, wenn wir verschachtelte (nested) Routen nutzen, was wir hier nicht tun.
In unserem Beispiel hätten wir problemlos auch absolute Pfade nutzen können z. B. in Zeile 15 "/products" statt "products".
Wenn wir absolute Pfade nutzen, brauchen wir den zweiten Parameter (`{relativeTo: this.route}`) der navigate-Methode nicht.

### Code

Code auf Github: [07-Routing\_Recipes/05-Navigation\_in\_Class](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/05-Navigation_in_Class)

### Weitere Ressourcen

* Offizielle Dokumentation für den [Router-Service](https://angular.io/docs/ts/latest/api/router/index/Router-class.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für den [ActivatedRoute-Service](https://angular.io/docs/ts/latest/api/router/index/ActivatedRoute-interface.html) auf der Angular 2 Webseite

