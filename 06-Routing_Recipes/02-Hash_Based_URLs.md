## Hash-Basiert URLs für das Routing {#c06-hash-based-url}

### Problem

Ich möchte Hash-Basiert URLs für das Routing nutzen, da mein Webserver mit HTML5 URLs nicht umgehen kann.

### Zutaten

* [Einfaches Routing implementieren](#c06-routing-basics)
* Den LocationStrategy-Service von Angular-Common
* Den HashLocationStrategy-Service von Angular-Common
* Anpassungen an der app.module.ts-Datei

### Lösung

{title="app.module.ts", lang=js}
```
import { NgModule }      from '@angular/core';
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
  declarations: [ AppComponent, AdminComponent, HomeComponent, ProductsComponent ],
  providers: [ { provide: LocationStrategy, useClass: HashLocationStrategy } ],
  bootstrap: [ AppComponent ]
})
export class AppModule { }
```

__Erklärung__:

* Zeile 4: Hier importieren wir den LocationStrategy-Service. Dieser sagt Angular wie die URLs auszusehen haben (mit Hash oder HTML5)
* Zeile 5: Hier importieren wir den HashLocationStrategy-Service. Dieser wird für Hash-Basiert URLs benutzt
* Zeile 17: Hier sagen wir Angular, dass zur Laufzeit der LocationStrategy-Service, den HashLocationStrategy-Service als Implementierung nutzen soll

### Diskussion

Standardmäßig wird eine Instanz der PathLocationStrategy-Klasse (HTML5 URLs) zurückgegeben, wenn mittels Dependency Injection eine Instanz des LocationStrategy-Services gefragt ist.
"LocationStrategy" ist ein sogenanntes "Token" und es definiert den Namen eines Services.
Die useClass-Eigenschaft definiert welche Klasse für das Token benutzt werden soll.
Hier (Zeile 17) sagen wir dem Injector: "Wenn jemand das Token "LocationStrategy" nutzt, um ein Service als Abhängigkeit zu definieren, sollst du eine Instanz der Klasse "HashLocationStrategy" zurückgeben".
Im Rezept [Einen Service definieren](#c02-define-service), haben wir für das providers-Array nur "DataService" angegeben.
Die Schreibweise die wir dort benutzt haben ist äquivalent zu `{ provide: DataService, useClass: DataService }`.
Wenn also das Token und die Klasse den gleichen Namen haben, brauchen wir nicht die Objekt-Schreibweise, wie wir diese hier benutzt haben.

Eine vollständige Erklärung, wie Dependency Injection funktioniert und was wir alles damit machen können, gibt es auf der Angular 2 Webseite: [Dependency Injection](https://angular.io/docs/ts/latest/guide/dependency-injection.html) und [Hierarchical Dependency Injectors](https://angular.io/docs/ts/latest/guide/hierarchical-dependency-injection.html).

### Code

Code auf Github: [06-Routing\_Recipes/02-Hash\_Based\_URLs](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/02-Hash_Based_URLs)

### Weitere Ressourcen

* Offizielle Dokumentation für den [LocationStrategy-Service](https://angular.io/docs/ts/latest/api/common/index/LocationStrategy-class.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für den [HashLocationStrategy-Service](https://angular.io/docs/ts/latest/api/common/index/HashLocationStrategy-class.html) auf der Angular 2 Webseite
* Offizielle Dokumentation für den [PathLocationStrategy-Service](https://angular.io/docs/ts/latest/api/common/index/PathLocationStrategy-class.html) auf der Angular 2 Webseite

