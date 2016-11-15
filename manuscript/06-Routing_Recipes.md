# Rezepte für Routing

In der Regel brauchen, vor allem größere Anwendungen verschiedene Views, die abhängig von eine Kondition angezeigt werden.
Eine Möglichkeit so etwas zu implementieren, ist mittels Client-Seitigen Routing.
Je nach Browser-URL, wird die Anwendung dem Nutzer eine andere View bzw. andere Inhalte anzeigen.
Da wir beim Client-Seitigen Routing die Browser-URL als einer Art Zustand nutzen, kann ein Nutzer z. B. die URL in ein anderes Browser-Fenster kopieren und einfach dort weiter machen wo er war.

In diesem Kapitel, werden wir uns mit dem Router, den Angular uns zur Verfügung stellt beschäftigen.
Wir werden uns nicht alle mögliche Funktionen des Routers anschauen.
Dafür bräuchte man ein eigenes Buch.
Ziel des Kapitels ist es mit ein paar wenige Rezepte, eine Basis zu schaffen, die man später je nach konkreten Anwendungsfall erweitern kann.

## Einfaches Routing implementieren {#c06-routing-basics}

### Problem

Ich möchte meine Anwendung mit Hilfe des Routers in drei Teilbereichen aufspalten.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* [Eine Komponente](#c02-component-definition) für jeden Teilbereich
* Das Router-Modul von Angular
* Router-Konfiguration mit Pfaden für die drei Teilbereiche (app.routes.ts)
* Anpassungen an der app.component.ts- und der app.module.ts-Datei
* Die RouterLink-Direktive von Angular-Router
* Die RouterOutlet-Direktive von Angular-Router
* Anpassungen an der package.json-Datei

### Lösung

Wie schon erwähnt, wollen wir die Anwendung in drei Teilbereichen aufspalten.
Diese sind "Home", "Products" und "Admin" und für jeden diese Teilbereiche werden wir eine Komponente implementieren.

{title="home.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  template: '<h1>Home</h1>'
})
export class HomeComponent {}
```

__Erklärung__:

Wie wir sehen, haben wir jetzt keine selector-Eigenschaft für den @Component-Decorator definiert.
Wir brauchen diese nicht, weil unsere Komponente nicht in einem Template referenziert wird, sondern vom Router abhängig vom Pfad geladen wird.
Die Restlichen zwei Komponenten zeigen wir hier nicht, diese werden analog zu der "HomeComponent" definiert.

Damit der Router weiß welcher Pfad bzw. URL zu welcher Komponente gehört, müssen wir diesen jetzt konfigurieren.
Wir tun dies in eine eigene Datei, so dass es später einfacher ist die Konfiguration zu finden und zu erweitern bzw. anpassen.

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
];

export const routing = RouterModule.forRoot(routes);
```

__Erklärung__:

* Zeile 1: Als Erstes importieren wir die nötigen Abhängigkeiten aus dem __@angular/router__-Paket. Dieses kann mittels __npm__ installiert werden
* Zeilen 7-11: Unsere Router-Konfiguration. Die path-Eigenschaft ist der Teil nach der Domain der URL. Z. B. in der URL "http://localhost:4200/foo" ist "foo" der Pfad
  * Zeile 8: Wenn kein Pfad angegeben wird, wird die "HomeComponent" angezeigt
  * Zeile 9: Wenn der Pfad "admin" ist, wird die "AdminComponent" angezeigt
  * Zeile 10: Wenn der Pfad "products" ist, wird die "ProductsComponent" angezeigt
* Zeile 13: Hier wird die Konfiguration dem Router übergeben. Die forRoot-Methode gibt dann ein Angular-Modul zurück mit der Konfiguration und Services, die uns die Arbeit mit dem Router erleichtern

Wie jedes andere Angular-Modul, müssen wir auch das Routing-Modul in unser "AppModule" importieren.

{title="app.module.ts", lang=js}
```
import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { routing } from './app.routes';
import { AppComponent }  from './app.component';
import { AdminComponent } from './admin.component';
import { HomeComponent } from './home.component';
import { ProductsComponent } from './products.component';

@NgModule({
  imports: [ BrowserModule, routing ],
  declarations: [
    AppComponent, AdminComponent,
    HomeComponent, ProductsComponent
  ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
```

Bis jetzt haben wir die Komponenten für unsere Teilbereiche definiert und den Router konfiguriert.
Jetzt müssen wir die Teilbereiche noch anzeigen und ein einfaches Menü für die Navigation definiert.
Wir tun dies in der app.component.ts-Datei.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  template: `
    <nav>
      <ul>
        <li><a routerLink="">Home</a></li>
        <li><a routerLink="products">Products</a></li>
        <li><a routerLink="admin">Admin</a></li>
      </ul>
    </nav>
    <router-outlet></router-outlet>
  `
})
export class AppComponent {}
```

__Erklärung__:

* Zeilen 6-12: Die Navigation für unsere Anwendung. Mit der RouterLink-Direktive definieren wir, zu welchem Teilbereich der Router hin navigieren soll, wenn der Nutzer auf das Element klickt. Die Pfade, die wir der RouterLink-Direktive übergeben, müssen zu den path-Eigenschaften in der Router-Konfiguration passen
* Zeile 13: Mit der RouterOutlet-Direktive, sagen wir dem Router wo er die Teilbereiche anzeigen soll. Je nach Pfad bzw. Routerzustand, entscheidet der Router welcher Teilbereich angezeigt werden muss


Da sich das "RouterModule" in einem eigenen npm-Paket befindet, müssen wir dieses auch in der package.json deklarieren.

{title="package.json", lang=js}
```
{
  ...
  "dependencies": {
    ...
    "@angular/router": "3.1.2"
    ...
  }
  ...
}
```

Wenn eine Angular-Anwendung mit angular-cli initialisiert wird, wird das "RouterModule" automatisch von angular-cli importiert und das entsprechende npm-Paket in der package.json-Datei deklariert.

### Diskussion

Standardmäßig nutzt der Angular-Router HTML5-URLs.
Allerdings brauchen die meisten Webserver eine spezielle Konfiguration, damit diese mit HTML5-URLs umgehen können.
Aus diesem Grund bietet uns Angular auch die Möglichkeit Hash-Basierte (#) URLs zu nutzen.
Wie das geht wird im Rezept "[Hash-Basiert URLs für das Routing](#c06-hash-based-url)" gezeigt

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/01-Routing_Basics)

### Weitere Ressourcen

* Offizielle Dokumentation für die [RouterLink-Direktive](https://angular.io/docs/ts/latest/api/router/index/RouterLink-directive.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für die [RouterOutlet-Direktive](https://angular.io/docs/ts/latest/api/router/index/RouterOutlet-directive.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für das [RouterModule](https://angular.io/docs/ts/latest/api/router/index/RouterModule-class.html) auf der Angular 2 Webseite

## Hash-Basierte URLs für das Routing {#c06-hash-based-url}

### Problem

Ich möchte Hash-Basierte URLs für das Routing nutzen, da mein Webserver mit HTML5-URLs nicht umgehen kann.

### Zutaten

* [Einfaches Routing implementieren](#c06-routing-basics)
* Den LocationStrategy-Service von Angular-Common
* Den HashLocationStrategy-Service von Angular-Common
* Anpassungen an der app.module.ts-Datei

### Lösung

{title="app.module.ts", lang=js}
```
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import {
  LocationStrategy,
  HashLocationStrategy
} from '@angular/common';

import { routing } from './app.routes';
import { AppComponent }  from './app.component';
import { AdminComponent } from './admin.component';
import { HomeComponent } from './home.component';
import { ProductsComponent } from './products.component';

@NgModule({
  imports: [ BrowserModule, routing ],
  declarations: [
    AppComponent, AdminComponent,
    HomeComponent, ProductsComponent
  ],
  providers: [ { provide: LocationStrategy, useClass: HashLocationStrategy } ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 4: Hier importieren wir den LocationStrategy-Service. Dieser sagt Angular wie die URLs auszusehen haben (mit Hash oder HTML5)
* Zeile 5: Hier importieren wir den HashLocationStrategy-Service. Dieser wird für Hash-Basierte URLs benutzt
* Zeile 20: Hier sagen wir Angular, dass zur Laufzeit der LocationStrategy-Service, den HashLocationStrategy-Service als Implementierung nutzen soll

### Diskussion

Standardmäßig wird eine Instanz der PathLocationStrategy-Klasse (HTML5-URLs) zurückgegeben, wenn mittels Dependency Injection eine Instanz des LocationStrategy-Services gefragt ist.
"LocationStrategy" ist ein sogenanntes "Token" und es definiert den Namen eines Services.
Die useClass-Eigenschaft definiert welche Klasse für das Token benutzt werden soll.
Hier (Zeile 20) sagen wir dem Injector: "Wenn jemand das Token "LocationStrategy" nutzt, um einen Service als Abhängigkeit zu definieren, sollst du eine Instanz der Klasse "HashLocationStrategy" zurückgeben".
Im Rezept [Einen Service definieren](#c02-define-service), haben wir für das providers-Array nur "DataService" angegeben.
Die Schreibweise, die wir dort benutzt haben ist äquivalent zu `{ provide: DataService, useClass: DataService }`.
Wenn also das Token und die Klasse den gleichen Namen haben, brauchen wir nicht die Objekt-Schreibweise, wie wir diese hier benutzt haben.

Eine vollständige Erklärung, wie Dependency Injection funktioniert und was wir alles damit machen können, gibt es auf der Angular 2 Webseite: [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html) und [Hierarchical Dependency Injectors](https://angular.io/docs/ts/latest/guide/hierarchical-dependency-injection.html).

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/02-Hash_Based_URLs)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/06-Routing_Recipes/02-Hash_Based_URLs/index.html)

### Weitere Ressourcen

* Offizielle Dokumentation für den [LocationStrategy-Service](https://angular.io/docs/ts/latest/api/common/index/LocationStrategy-class.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für den [HashLocationStrategy-Service](https://angular.io/docs/ts/latest/api/common/index/HashLocationStrategy-class.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für den [PathLocationStrategy-Service](https://angular.io/docs/ts/latest/api/common/index/PathLocationStrategy-class.html) auf der Angular 2 Webseite

## Die aktuelle Route hervorheben

### Problem

Ich möchte die aktuelle Route in der Navigation farblich hervorheben, damit der Nutzer weiß wo er/sie sich aktuell befindet.

### Zutaten

* [Einfaches Routing implementieren](#c06-routing-basics)
* Die RouterLinkActive-Direktive vom Angular-Router
* Anpassungen an der app.component.ts-Datei

### Lösung

Der einfachste Weg, die aktuelle Route farblich hervorzuheben ist mit Hilfe einer CSS-Klasse und der RouterLinkActive-Direktive. Dafür brauchen wir nur die app.component.ts-Datei anzupassen.

{title="app.component.ts", lang=js}
```
import { Component } from '@angular/core';

@Component({
  selector: 'app-root',
  styles: ['.active-route { color: red; }'],
  template: `
    <nav>
      <ul>
        <li><a routerLink=""
          routerLinkActive="active-route"
          [routerLinkActiveOptions]="{exact: true}">Home</a></li>
        <li><a routerLink="products"
          routerLinkActive="active-route">Products</a></li>
        <li><a routerLink="admin"
          routerLinkActive="active-route">Admin</a></li>
      </ul>
    </nav>
    <router-outlet></router-outlet>
  `
})
export class AppComponent {}
```

__Erklärung__:

* Zeile 5: Hier definieren wir die "active-route"-CSS-Klasse. Siehe auch [Das Template der Komponente von dem CSS trennen](#c07-styles)
* Zeilen 10, 13 und 15: Mittels der RouterLinkActive-Direktive, setzen wir die "active-route"-CSS-Klasse auf das Element, das auf die aktuelle Route zeigt

### Diskussion

Die RouterLinkActive-Direktive nimmt den Wert der RouterLink-Direktive und ermittelt, ob der Pfad der RouterLink-Direktive der gleiche ist wie der Pfad der aktuellen Route.
Falls ja wird der Wert nach dem Gleichheitszeichen als CSS-Klasse für das Element gesetzt.
In unserem Fall wird die "active-route"-CSS-Klasse auf das a-Tag gesetzt.
Wenn z. B. der Pfad "admin" ist, wird die CSS-Klasse auf das a-Tag mit __routerLink="admin"__ gesetzt.
Für die "Home"-Route nutzen wir einen leeren String als Pfad.
Da der leerer String Teil jedes Pfades ist, wird der a-Tag für die "Home"-Route immer als aktuell/aktiv gesetzt.
Um das zu verhindern, sagen wir dem Router mittels __[routerLinkActiveOptions]="{exact: true}"__, dass das a-Tag mit __routerLink=""__ nur dann die aktuelle Route ist, wenn der Pfad der aktuellen Route ein leerer String ist.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/03-Highlight_Active_Route)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/06-Routing_Recipes/03-Highlight_Active_Route/index.html).
Nutzt Hash-Basierte URLs: "[Hash-Basierte URLs für das Routing](#c06-hash-based-url)"

### Weitere Ressourcen

* Offizielle Dokumentation für die [RouterLinkActive-Direktive](https://angular.io/docs/ts/latest/api/router/index/RouterLinkActive-directive.html) auf der Angular 2 Webseite

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

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/04-Redirect_Unknown_Path)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/06-Routing_Recipes/04-Redirect_Unknown_Path/index.html).
Nutzt Hash-Basierte URLs: "[Hash-Basierte URLs für das Routing](#c06-hash-based-url)"

## Navigation in der Klasse der Komponente {#c06-navigate-in-class}

### Problem

Ich möchte zu eine andere Komponente navigieren, indem ich auf einen Button klicke.

### Zutaten

* [Einfaches Routing implementieren](#c06-routing-basics)
* Den ActivatedRoute-Service vom Angular-Router
* Den Router-Service vom Angular-Router
* Anpassungen an der app.component.ts-Datei

### Lösung

Wir wollen jetzt nicht mit Hilfe der RouterLink-Direktive navigieren, sondern mit der navigate-Methode des Routers. Diese können wir nutzen, um zu navigieren als Reaktion z. B. auf ein Event nach dem Speichern von Daten.

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

* Zeile 32: Hier injizieren wir den ActivatedRoute- und den Router-Service. Der ActivatedRoute-Service repräsentiert die aktuelle Route
* Zeilen 37-39: navigate-Methode, die von den Buttons aufgerufen wird
  * Zeile 38: Hier wird die navigate-Methode des Routers aufgerufen. Dieser Aufruf ist äquivalent zu der RouterLink-Direktive, die wir schon gesehen haben

### Diskussion

Wenn wir mit einem Pfad der ohne Slash (/) beginnt navigieren z. B. "admin", führen wir eine relative Navigation aus.
Dem entsprächen heißen Pfade, die ohne Slash beginnen "relative Pfade".
Auch Pfade, die mit "./" (die Pfade "admin" und "./admin" sind äquivalent) oder "../" beginnen sind relativ.
Pfade, die mit einem Slash beginnen z. B. "/admin" heißen "absolute Pfade".
Immer wenn wir relative Pfade nutzen, müssen wir dem Router sagen relativ zu welcher Route wir navigieren möchten.
Im Falle der RouterLink-Direktive wird immer relativ zu der aktuellen Route navigiert.
Mit der navigate-Methode müssen wir explizit die Route angeben zu der wir relativ Navigieren wollen, indem wir die relativeTo-Eigenschaft setzen.

Die Auswirkungen von relativen Pfaden sind vor allem sichtbar, wenn wir innerhalb einer Komponente navigieren, die einen eigenen nicht leeren Pfad hat z. B. AdminComponent mit "admin" als Pfad.
In unserem Beispiel hätten wir problemlos auch absolute Pfade nutzen können z. B. in Zeile 15 "/products" statt "products".
Wenn wir absolute Pfade nutzen, brauchen wir den zweiten Parameter (__{relativeTo: this.route}__) der navigate-Methode nicht.

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/05-Navigation_in_Class)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/06-Routing_Recipes/05-Navigation_in_Class/index.html).
Nutzt Hash-Basierte URLs: "[Hash-Basierte URLs für das Routing](#c06-hash-based-url)"

### Weitere Ressourcen

* Offizielle Dokumentation für den [Router-Service](https://angular.io/docs/ts/latest/api/router/index/Router-class.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für den [ActivatedRoute-Service](https://angular.io/docs/ts/latest/api/router/index/ActivatedRoute-interface.html) auf der Angular 2 Webseite

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

* Zeile 11: Hier lesen wir den id-Parameter aus der aktuellen Route. Der String, hier __'id'__ muss der gleiche sein wie der String nach dem Doppelpunkt in der Pfaddefinition (app.routes.ts-Datei). Alternativ können wir die id-Eigenschaft in der ngOnInit-Methode lesen. Mehr Informationen über diese Methode gibt es im Rezept "[Code ausführen bei der Initialisierung einer Komponente](#c07-on-init)"

### Diskussion

In der app.routes.ts-Datei, haben wir den Pfad "products/:id" definiert aber in der "ProductsComponent" haben wir der RouterLink-Direktive (Zeile 8) nur die ID (__prod.id__) übergeben und trotzdem funktioniert das Routing.
Wir wollen jetzt kurz verstehen warum das so ist.

Wir nutzen hier einen relativen Pfad (den Wert von __prod.id__) und die RouterLink-Direktive befindet sich in einer Komponente die einen nicht leeren Pfad ("products") hat.
In diesem Fall werden die zwei Pfade konkateniert.
Das heißt, wenn wir zur Laufzeit auf den Link für das erste Produkt klicken, navigiert der Router zu der Komponente mit Pfad "products/1" (das erste Produkt hat die ID __1__).
Ausführlichere Informationen zu relativen bzw. absoluten Pfaden gibt es in der Diskussion des Rezepts "[Navigation in der Klasse der Komponente](#c06-navigate-in-class)"

### Code

[Code auf Github](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/06-Routing_Parameters)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/06-Routing_Recipes/06-Routing_Parameters/index.html).
Nutzt Hash-Basierte URLs: "[Hash-Basierte URLs für das Routing](#c06-hash-based-url)"

### Weitere Ressourcen

* Offizielle Dokumentation für den [ActivatedRoute-Service](https://angular.io/docs/ts/latest/api/router/index/ActivatedRoute-interface.html) auf der Angular 2 Webseite

