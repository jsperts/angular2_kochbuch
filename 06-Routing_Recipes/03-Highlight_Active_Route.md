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
Wenn z. B. der Pfad "admin" ist, wird die CSS-Klasse auf das a-Tag mit `routerLink="admin"` gesetzt.
Für die "Home"-Route nutzen wir einen leeren String als Pfad.
Da der leerer String Teil jedes Pfades ist, wird der a-Tag für die "Home"-Route immer als aktuell/aktiv gesetzt.
Um das zu verhindern, sagen wir dem Router mittels `[routerLinkActiveOptions]="{exact: true}"`, dass das a-Tag mit `routerLink=""` nur dann die aktuelle Route ist, wenn der Pfad der aktuellen Route ein leerer String ist.

### Code

Code auf Github: [06-Routing\_Recipes/03-Highlight\_Active\_Route](https://github.com/jsperts/angular2_kochbuch_code/tree/master/06-Routing_Recipes/03-Highlight_Active_Route)

### Weitere Ressourcen

* Offizielle Dokumentation für die [RouterLinkActive-Direktive](https://angular.io/docs/ts/latest/api/router/index/RouterLinkActive-directive.html) auf der Angular 2 Webseite

