## Umleitung für unbekannte Pfade

### Problem

Ich möchte, dass unbekannte Pfade zu der Hauptkomponente umgeleitet (redirect) werden.

### Zutaten

* [Einfaches Routing implementieren](#c06-routing-basics)
* Anpassungen an der app.routes.ts-Datei

### Lösung

{title="app.routes.ts", lang=js}
```
import { RouterModule, Routes } from '@angular/router';

import { AdminComponent } from './admin.component';
import { HomeComponent } from './home.component';
import { ProductsComponent } from './products.component';

const routes: Routes = [
  { path: '', component: HomeComponent },
  { path: 'admin', component: AdminComponent },
  { path: 'products', component: ProductsComponent },
  { path: '**', redirectTo: '' },
];

export const routing = RouterModule.forRoot(routes);
```

__Erklärung__:

* Zeile 11: Hier definieren wir eine Route mit Pfad "\*\*", die immer dann greift, wenn keine andere Route zu der Browser-URL passt. Die redirectTo-Eigenschaft bekommt als Wert den Pfad zu den wir umleiten möchten

### Code

Code auf Github: [06-Routing\_Recipes/04-Redirect\_Unknown\_Path](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/04-Redirect_Unknown_Path)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/06-Routing_Recipes/04-Redirect_Unknown_Path/index.html).
Nutzt Hash-Basierte URLs: "[Hash-Basierte URLs für das Routing](#c06-hash-based-url)"

