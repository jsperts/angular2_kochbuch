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
  declarations: [ AppComponent, AdminComponent, HomeComponent, ProductsComponent ],
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

Code auf Github: [06-Routing\_Recipes/01-Routing\_Basics](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/01-Routing_Basics)

### Weitere Ressourcen

* Offizielle Dokumentation für die [RouterLink-Direktive](https://angular.io/docs/ts/latest/api/router/index/RouterLink-directive.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für die [RouterOutlet-Direktive](https://angular.io/docs/ts/latest/api/router/index/RouterOutlet-directive.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für das [RouterModule](https://angular.io/docs/ts/latest/api/router/index/RouterModule-class.html) auf der Angular 2 Webseite

