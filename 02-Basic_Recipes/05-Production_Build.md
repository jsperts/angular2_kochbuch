## Angular 2 in Produktion nutzen {#c02-prod-build}

### Problem

Ich möchte meine Angular 2 Anwendung produktiv nutzen.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Anpassungen in der main.ts-Datei
* environment-Dateien

### Lösung

Mit angular-cli ist es sehr einfach eine produktiv-Version von unserer Anwendung zu bauen.
Tatsächlich hat ein neu initialisiertes Projekt schon den Code in der main.ts-Datei, den wir in diesem Rezept hinzufügen wollen.
Auch die nötige environment-Dateien ist da schon vorhanden.

Als Erstes schauen wir uns die environment.prod.ts-Datei an.
Diese befindet sich im Verzeichnis "src/environments".

{title="environment.prod.ts", lang=js}
```
export const environment = {
    production: true
};
```

__Erklärung__:

Bei einem angular-cli-Projekt befinden sich im Verzeichnis "src/environments" zwei Dateien.
Die eine mit Namen "environment.ts" und eine mit Namen "environment.prod.ts".
Eigentlich sind beide Dateien optional.
Diese werden nur gebraucht, wenn wir sie in unserem Code referenzieren.
Der Unterschied zwischen den zwei Dateien, ist der Wert für die production-Eigenschaft.
Dieser ist __true__ in der environment.prod.ts-Datei und __false__ in der environment.ts-Datei.

Jetzt sehen wir warum es sinnvoll sein kann die environment-Dateien zu referenzieren.

{title="main.ts", lang=js}
```
import './polyfills.ts';

import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';
import { enableProdMode } from '@angular/core';
import { environment } from './environments/environment';
import { AppModule } from './app/';

if (environment.production) {
  enableProdMode();
}

platformBrowserDynamic().bootstrapModule(AppModule);
```

__Erklärung__:

* Zeile 5: Importiert eine environment-Datei. Ob es die environment.ts- oder die environment.prod.ts-Datei ist, wird von angular-cli zur Bauzeit definiert
* Zeilen 8-10: Hier wird der Produktions-Modus von Angular aktiviert aber nur, wenn angular-cli die environment.prod.ts-Datei nutzt

Als letztes müssen wir unser Projekt mit der `--prod`-Option bauen.

```
ng build --prod
```

Sobald die `--prod`-Option benutzt wird, nutzt angular-cli die environment.prod.ts-Datei.
In allen anderen Fällen z. B. beim `ng serve` wird die environment.ts-Datei benutzt.

### Code

Code auf Github: [02-Basic\_Recipes/05-Production\_Build](https://github.com/jsperts/angular2_kochbuch_code/tree/master/02-Basic_Recipes/05-Production_Build)

Live Demo auf [angular2kochbuch.de](http://angular2kochbuch.de/examples/code/02-Basic_Recipes/05-Production_Build/index.html)

