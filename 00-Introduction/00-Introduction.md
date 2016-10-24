# Einleitung

Angular 2 ist eine von null auf neu geschriebene Version des populären Google Frameworks AngularJS.
Die neue Version des Frameworks wurde im März 2014 in einem Blog Artikel angekündigt. Anfangs war es geplant, das Framework in einer neuen Sprache names AtScript zu schreiben.
Letztendlich wurde aber entschieden, es in Microsofts [TypeScript](http://www.typescriptlang.org/) zu schreiben und es dann in JavaScript zu kompilieren.
Wir als Entwickler haben die Möglichkeit, Angular 2 Anwendungen in TypeScript, ECMAScript 6 (ES6) / ECMAScript 2015 (ES2015), ECMAScript 5 (ES5) oder Dart zu schreiben.
In diesem Buch werden wir uns auf TypeScript konzentrieren, da diese vermutlich die am häufigsten verwendete Sprache sein wird, um Projekte mit Angular 2 zu schreiben.

## Angular 1.x. vs. 2

Wie schon bei der Ankündigung zu lesen war, gibt es teilweise große Unterschiede zwischen Angular 2 und 1.x.
Diese Unterschiede haben dafür gesorgt, dass die Community die Entscheidung des Angular-Teams, das Framework neu zu schreiben, mit gemischten Gefühlen aufgenommen hat.
Die templating-Sprache wurde geändert und alle Event-Direktiven wie z. B. ng-click und ng-keyup wurden von eine neue Schreibweise für Events ersetzt.
Controllers und $scope wurden aus dem Framework entfernt und durch Komponenten ersetzt.
Die Definition von Services wurde vereinfacht.
In den meisten Fällen ist ein Service einfach eine Klasse.
Außer den Unterschieden die uns als Entwickler bei der Implementierung von Angular 2 Anwendungen direkt betreffen wie z. B. die neue Syntax für Templates, gibt es auch jede Menge technische Unterschiede mit denen wir uns in den meisten Fällen nicht beschäftigen brauchen wie z. B. hierarchische Dependency Incjection und hierarchische Change Detection.
Trotz den Unterschieden sind die 1.x. und 2 Versionen von der Vogelperspektive betrachtet sehr ähnlich.
Die meiste Begriffen die wir aus Angular 1.x. kennen, können weiterhin verwendet werden.

## Ziel des Buches

Ziel des Buches ist es dem/r Leser/in fertige Lösungen für häufige Probleme bereitzustellen, die er/sie mit wenig Aufwand in neue oder existierende Angular 2 Anwendungen einbauen kann.
Es ist nicht die Absicht dieses Buches, in die Tiefen von Angular 2 vorzudringen und den/die Leser/in über die gesamte Funktionalität und Implementierung von Angular 2 zu informieren.

## Für wen ist dieses Buch

Dieses Buch ist für Entwickler/inen mit wenig oder keiner Angular 2 Erfahrung gedacht, die schnell bestimmte Probleme lösen möchten.
Auch wenn wir in den Rezepten mit TypeScript arbeiten, ist TypeScript-Wissen keine Voraussetzung. Dafür gibt es in [Kapitel 1](#c01) eine kurze Einführung in TypeScript.

## Aufbau des Buches

Das Buch ist in mehrere Kapitel unterteilt. Jedes Kapitel beinhaltet ein oder mehrere Rezepte, die Lösungen zu bestimmten Problemen bieten. Der Aufbau eines Rezepts ist wie folgt:

1. Problem: Für was ist dieses Rezept gut? Was können wir mit diesem Rezept erreichen?
2. Zutaten: Hier wird alles aufgelistet, was gebraucht wird, um die Lösung(en) zu implementieren
3. Lösung(en): Eine oder mehrere Lösungsmöglichkeiten für das besagte Problem
4. Diskussion: Vor-/Nachteile einer Lösung, Probleme auf die man stoßen könnte, etc.
5. Code: Links zu Github-Repositories mit Beispiel-Code, Links zu Webseiten mit Online-Demos
6. Weitere Ressourcen: Links zu Webseiten/Teilen des Buches mit tiefer reichenden Informationen zum Thema. Hier geht es hauptsächlich um technische Themen

Die Punkte 1, 2, 3 und 5 sind in jedem Rezept vertreten, die Restlichen nur nach Bedarf.

## Überblick

__Kapitel 1: Einführung in TypeScript__ beinhaltet genügend Informationen über TypeScript, damit die Rezepte verständlich ist.

__Kapitel 2: Basisrezepte__, die für die Lösungen benötigt werden, die in weiteren Kapitel präsentiert werden.

__Kapitel 3: Rezepte, um mit der Anzeige zu interagieren__ beinhaltet Rezepte mit denen wir die Anzeige (View) abhängig von Daten in einer Komponente verändern können.

__Kapitel 4: Rezepte für Formulare__ beinhaltet Rezepte, um Formulare zu bauen. In diesem Kapitel wird auch die Validierung von Nutzer-Input behandelt.

__Kapitel 5: Rezepte für den Datenaustausch__ beinhaltet Lösungen die wir anwenden können, um Daten mit einem Server auszutauschen.

__Kapitel 6: Rezepte für Routing__ enthält Lösungen zu Problemen, die mit dem clientseitigen Routing einer Single Page Anwendung zu tun haben.

__Kapitel 7: Rezepte für Komponenten__ enthält Lösungen zu Problemen, die Komponenten betreffen, wie z. B. Kommunikation zwischen Komponenten.

__Kapitel 8: Rezepte für ngFor-Listen__ enthält Lösungsvorschläge, die uns bei der Arbeit mit Listen helfen können.

## Hilfe und Support

Bei Fragen und Anregungen zum Buch und/oder dem Beispiel-Code gibt es die Möglichkeit, Issues bzw. Pull-Request über Github zu öffnen.

* [Github für das Buch](https://github.com/jsperts/angular2_kochbuch)
* [Github für den Beispiel-Code](https://github.com/jsperts/angular2_kochbuch_code)

Bei allen anderen Fragen und Anregungen steht die E-Mail-Adresse [info@angular2kochbuch.de](mailto:info@angular2kochbuch.de) zur Verfügung.

