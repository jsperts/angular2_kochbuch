# Change Log

## [unreleased]

### Added

* Neue TypeScript-Typen undefined, null und never
* Neues Rezept: Angular 2 in Produktion nutzen
* Rezepte für Routing
  * Einfaches Routing implementieren
  * Hash-Basiert URLs für das Routing
  * Die aktuelle Route hervorheben
  * Umleitung für unbekannte Pfade
  * Navigation in der Klasse der Komponente
  * Routing-Parameter
* Rezepte für Formulare
  * MDF: Fehlermeldungen für einzelne Formular-Felder anzeigen
  * MDF: Abhängige Eingabefelder validieren
* Rezepte für Komponenten
  * Code ausführen bei der Initialisierung einer Komponente
  * Code ausführen bei der Zerstörung (destroy) einer Komponente
* Online Demos

### Changed

* Schreib-/Grammatikfehler Korrekturen
* Die Rezepte wurden für Angular 2.1.2 und angular-cli 1.0.0-beta.19-3 mit Webpack aktualisiert
* Das Rezept "Formular mit dem FormBuilder und Validierung" hat jetzt 2 mögliche Lösungen
  * Lösung 1 Submit-Button mit disabled-Eigenschaft
  * Lösung 2 Submit-Methode mit Gültigkeitsüberprüfung
* Die Titel der Formular-Rezepten haben jetzt ein "TDF" bzw. "MDF" davor je nachdem, ob sie sich mit Template-Driven oder Model-Driven Formulare befassen

### Removed

* Lösung 1 für die Rezepte "Komponente und HTML-Template trennen" und "Komponente und CSS trennen". Diese funktioniert mit angular-cli und webpack nicht mehr
* Online Demos für Datenaustausch Rezepte. Diese hatten einen Server nur simuliert und das hat dazugeführt, dass es keine Serveranfragen im Networktab gab. Um verwirrung zu vermeiden, wurden diese entfernt.

### Deprecated

## [v0.2.0] - 2016-06-03

### Added

* Rezept für angular-cli (erstes Rezept in Basisrezepte)
* Neuer Begriff "barrel" im Glossar
* Zweite mögliche Lösung für "Komponente und HTML-Template trennen" und "Komponente und CSS trennen"
* Rezept für NgFor trackBy "Die Performance mit trackBy verbessern"
* Appendix B für angular-cli

### Changed

* Link fix in Formular mit dem FormBuilder implementieren
* Rezepte wurden für angular-cli angepasst
* Angular Version aktualisiert (rc.1)
* Rezept: "Liste von Daten anzeigen" Syntax für lokale ngFor-Variable wurde aktualisiert (angular Version beta.17)
* Rezept: "Mit dem Index von ngFor-Elementen arbeiten" Syntax für lokale ngFor-Variable wurde aktualisiert (angular Version beta.17)
* Rezept: "CSS-Klassen auf Basis von booleschen Werten setzen/entfernen" nutzt die styles-Eigenschaft statt <style></style> im Template
* Rezept: "Gerade und ungerade ngFor-Elemente unterscheiden" Syntax für lokale ngFor-Variable wurde aktualisiert (angular Version beta.17)
* Rezept: "Das erste und letzte ngFor-Element finden" Syntax für lokale ngFor-Variable wurde aktualisiert (angular Version beta.17)
* Rezept: "Das erste und letzte ngFor-Element finden" nutzt das ngFor-Konstrukt first für das erste Element
* Die Rezepte nutzten die styles-Eigenschaft statt <style></style> im Template
* Appendix A: "Template-Syntax" Abschnitt über lokale Variablen wurde aktualisiert, wir unterscheiden jetzt zwischen 2 Arten von lokalen Variablen

### Removed

* Das Rezept "Angular 2 Anwendung vorkompilieren" wird mit angular-cli nicht mehr gebraucht
* "Komponente ohne @View-Decorator"

### Deprecated

## [v0.1.0] - 2016-04-07

### Added

* Rezept, um Styles dynamisch zu verändern
* Rezept, um CSS-Styles und Template zu trennen
* Rezept, um CSS-Styles und Komponente zu trennen
* Rezept, um Server-Anfragen abzubrechen (cancel)
* Rezept, um Daten an einer Unterkomponente zu übergeben mittels input-Eigenschaft
* Rezept, um Daten an die Überkomponente zu übergeben mittels output-Eigenschaft

### Changed

* Angular Version aktualisiert (beta 13)
* Es gibt eine neue Validierungsfunktion für Formulare (pattern), diese wird im Rezept "Gültigkeit eines Formulars überprüfen" erwähnt
* Glossar neue Begriffe: input-/output-Eigenschaft. Weitere Begriffe wurden überarbeitet

### Removed

* View-Dekorator wurde aus den Rezepten entfernt. Angular wird diesen Decorator in einem späteren Release (vermutlich RC 1) auch entfernen

### Deprecated

* Das Rezepte "Komponente ohne @View-Decorator" wurde mit eine Warnung versehen und wird im nächsten Release entfernt, da die Rezepte @View nicht mehr verwenden

