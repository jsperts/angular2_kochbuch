# Einleitung

Angular 2 ist eine von Null auf neu geschriebene Version des populären Google Frameworks Angular 1.x.
Die neue Version des Frameworks wurde im März 2014 in einem Blog Artikel angekündigt. Anfangs war es geplant das Framework in eine neue Sprache zu schreiben namens AtScript.
Letztendlich wurde aber entschieden es in Microsofts [TypeScript](http://www.typescriptlang.org/) zu schreiben und es dann in JavaScript zu kompilieren.
Wir als Entwickler haben die Möglichkeit Angular 2 Anwendungen in TypeScript, ECMAScript 6 (ES6) / ECMAScript 2015 (ES2015), ECMAScript 5 (ES5) oder Dart zu schreiben.
In diesem Buch werden wir uns auf TypeScript konzentrieren, da es vermutlich die am häufigste verwendete Sprache ist um Projekten mit Angular 2 zu schreiben.

## Angular 1.x vs 2

Wie schon bei der Ankündigung zu sehen war, gibt es teilweise große Unterschiede zwischen Angular 2 und 1.x.
Diese Unterschiede haben dafür gesorgt, dass die Community die Entscheidung des Angular-Teams das Framework neu zu schreiben, mit gemischten Gefühlen aufgenommen hat.
Die templating-Sprache wurde geändert und viele Direktiven wie z. B. ng-click und ng-keyup wurden von eine neue Schreibweise für Events ersetzt.
Controllers und $scope wurden aus dem Framework entfernt und durch Komponenten ersetzt.
Die Definition eines Services wurde auch vereinfacht. Sachen wie "value", "constant" und "factory" gibt es in diese Form nicht mehr. Services in Angular 2 sind einfach Klassen.
Außer den Unterschieden die uns als Entwickler direkt betreffen, gibt es auch jede Menge technische Unterschiede mit denen wir uns in den meisten Fällen nicht beschäftigen brauchen wie z. B. hierarchische Dependency Incjection und hierarchische Change Detection.

## Ziel des Buches

Ziel des Buches ist es dem Leser fertige Lösungen für häufige Probleme bereit zu stellen die er mit wenig Aufwand in neue oder existierende Angular 2 Anwendungen einbauen kann.
Es ist nicht Teil dieses Buches in den Tiefen von Angular 2 vor zu dringen und den Leser über die gesamte Funktionalität und Aufbau von Angular 2 zu informieren.

## Für wen ist dieses Buch

Dieses Buch ist für Entwickler gedacht mit keine oder wenig Angular 2 Erfahrung, die schnell bestimmte Probleme lösen möchten.
Auch wenn wir in den Rezepten mit TypeScript arbeiten, ist TypeScript-Wissen keine Voraussetzung. Dafür gibt es in Kapitel 1 eine kurze Einführung in TypeScript.
Das Buch ist nur bedingt geeignet für Entwickler die ein tiefes Verständnis für Angular 2 entwickeln möchten.

## Aufbau des Buches

Das Buch ist in mehreren Kapitel unterteilt und jedes Kapitel beinhaltet ein oder mehrere Rezepte, die Lösungen zu bestimmte Problemen bieten. Der Aufbau eines Rezepts ist wie folgt:

1. Problem: Für was ist dieses Rezept gut? Was möchte man erreichen?
2. Zutaten: Hier wird alles was gebraucht wird, um ein Rezept zu implementieren, aufgelistet
3. Lösung(en): Eine oder mehrere Lösungsmöglichkeiten für das besagte Problem
4. Diskussion: Vor-/Nachteile einer Lösung, Probleme auf die man stoßen könnte, etc.
5. Links zu Code-Beispiele: Links zu Github mit Beispiel-Code, Links zu Webseiten mit Online-Demos
6. Weitere Ressourcen: Links zu Seiten mit tiefer reichende Informationen über ein Thema. Hier geht es hauptsächlich um technische Themen

Die Punkten 1, 2 und 3 sind in jedem Rezept vertreten, die restliche nur nach bedarf.

## Überblick

__Kapitel 1: Einführung zu TypeScript__ beinhaltet genügend Informationen über TypeScript, damit der TypeScript-Anteil der Rezepten verständlich ist.

__Kapitel 2: Basisrezepte__, die für die Lösungen benötigt werden die in weiter Kapitel präsentiert werden.

__Kapitel 3: Rezepte um mit der Anzeige zu interagieren__ beinhaltet Rezepte mit denen man die Anzeige (View) abhängig von Daten in einer Komponenten, verändern können.

__Kapitel 4: Rezepte für Formulare__ beinhaltet Rezepte, um Formulare zu bauen. In diesem Kapitel wird auch die Validierung von Nutzer-Input behandelt.

__Kapitel 5: Rezepte für den Datenaustausch__ beinhaltet Lösungen die man anwenden kann, um Daten mit einem Server auszutauschen.

__Kapitel 6: Rezepte für Routing__, enthält Lösungen zu Problemen die mit dem Client-Seitigen Routing einer Single Page Anwendung zu tun haben.

__Kapitel 7: Rezepte für Komponenten__, enthält Lösungen zu Problemen die Komponenten betreffen.

__Kapitel 8: Rezepte für ngFor-Listen__, enthält Lösungsvorschläge die uns bei der Arbeit mit Listen helfen können.

## Hilfe und Support

Bei Fragen und Anregungen über das Buch und/oder den Beispiel-Code, gibt es die Möglichkeit Issues bzw. Pull-Request über Github zu öffnen.

* Github für das Buch: [https://github.com/jsperts/angular2\_kochbuch](https://github.com/jsperts/angular2_kochbuch)
* Github für den Beispiel-Code: [https://github.com/jsperts/angular2\_kochbuch\_code](https://github.com/jsperts/angular2_kochbuch_code)

Bei allen anderen Fragen und Anregungen steht die E-Mail-Adresse [info@angular2kochbuch.de](mailto:info@angular2kochbuch.de) zur Verfügung.

