## Routing-Parameter

### Problem

Ich möchte eine Komponente implementieren, die unterschiedliche Inhalte in der View anzeigt abhängig von einem Parameter in der URL.

### Zutaten

* [Einfaches Routing implementieren](#c06-routing-basics)
* Anpassungen an der products.component.ts-Datei
  * Braucht [Liste von Daten anzeigen](#c03-data-list)
* [Eine Komponente](#c02-component-definition). Der Inhalt der View der Komponente wird sich abhängig von der Route-Parameter ändern. Diese Komponente (ProductComponent) zeigt das jeweilige Produkt an
* ActivatedRoute-Service von Angular-Router
* Anpassungen an der app.routes.ts-Datei

### Lösung

Als Erstes definieren wir eine parametrisierte Route.
Diese bekommt die id-Eigenschaft eines Produktes als Parameter und die "ProductComponent" als Komponente.

{title="app.routes.ts", lang=js}
```
import { RouterModule, Routes } from '@angular/router';

import { AdminComponent } from './admin.component';
import { HomeComponent } from './home.component';
import { ProductsComponent } from './products.component';
import { ProductComponent } from './product.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'admin', component: AdminComponent },
  { path: 'products', component: ProductsComponent },
  { path: 'products/:id', component: ProductComponent },
];

export const routing = RouterModule.forRoot(routes);
```

__Erklärung__:

* Zeile 12: Unsere neue Route. Mit dem Doppelpunkt und einen Namen (hier __id__) definieren wir einen Route-Parameter

Jetzt wollen wir eine Liste von Produkten für "ProductsComponent" definieren.
Die id-Eigenschaft eines Produktes wird als Route-Parameter benutzt __:id__ wird also zur Laufzeit durch die ID des Produktes ersetzt.

{title="products.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  template: `
    <h1>Products</h1>
    <ul>
      <li *ngFor="let prod of products">
        <a [routerLink]="prod.id">{{prod.name}}</a>
      </li>
    </ul>
  `
})
export class ProductsComponent {
  products = [{
    id: 1,
    name: 'Product 1'
  }, {
    id: 2,
    name: 'Product 2'
  }, {
    id: 3,
    name: 'Product 3'
  }];
}
```

__Erklärung__:

* Zeile 8: Hier nutzen wir die RouterLink-Direktive und definieren damit zu welchem Produkt wir hin navigieren möchten. Wir nutzen eine Eigenschaft-Bindung (eckige Klammern) weil der Pfad, im Gegensatz zu den Pfaden in der app.component.ts-Datei, nicht konstant ist

Als letztes definieren wir die "ProductComponent".
Diese wird die id-Eigenschaft aus der Route lesen und sie in der View anzeigen.

{title="product.component.ts", lang=js}
```
import { Component } from '@angular/core';
import { ActivatedRoute } from '@angular/router';

@Component({
  template: `<h1>Product {{id}}</h1>`
})
export class ProductComponent {
  id: string;

  constructor(route: ActivatedRoute) {
    this.id = route.snapshot.params['id'];
  }
}
```

__Erklärung__:

* Zeile 11: Hier lesen wir den id-Parameter aus der aktuellen Route. Der String, hier __'id'__ muss der gleiche sein wie der String nach dem Doppelpunkt in der Pfaddefinition (app.routes.ts-Datei)

### Diskussion

In der app.routes.ts-Datei, haben wir den Pfad "products/:id" definiert aber in der "ProductsComponent" haben wir der RouterLink-Direktive (Zeile 8) nur die ID (__prod.id__) übergeben und trotzdem funktioniert das Routing.
Wir wollen jetzt kurz verstehen warum das so ist.

Wir nutzen hier einen relativen Pfad (den Wert von __prod.id__) und die RouterLink-Direktive befindet sich in einer Komponente die einen nicht leeren Pfad ("products") hat.
In diesem Fall werden die zwei Pfade konkateniert.
Das heißt, wenn wir zur Laufzeit auf den Link für das erste Produkt klicken, navigiert der Router zu der Komponente mit Pfad "products/1" (das erste Produkt hat die ID __1__).
Ausführlichere Informationen zu relativen bzw. absoluten Pfaden gibt es in der Diskussion des Rezepts "[Navigation in der Klasse der Komponente](#c06-navigate-in-class)"

### Code

Code auf Github: [06-Routing\_Recipes/06-Routing\_Parameters](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/06-Routing_Parameters)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/06-Routing_Recipes/06-Routing_Parameters/index.html).
Nutzt Hash-Basierte URLs: "[Hash-Basierte URLs für das Routing](#c06-hash-based-url)"

