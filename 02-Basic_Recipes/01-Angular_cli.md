## Entwicklungsprozess für Angular 2 Projekte {#c02-angular-cli}

### Problem

Ich möchte einen möglichst einfachen Weg haben, ein Angular 2 Projekt zu initialisieren, zu bauen und das Resultat im Browser anzuschauen.

### Zutaten

* Node.js
* npm
* angular-cli

### Lösung

Der derzeit einfachste Weg, ein Angular 2 Projekt zu starten, zu bauen und sich das Resultat im Browser anzuschauen, ist ein Tool namens "angular-cli".
Das Tool befindet sich noch im beta-Stadium. Nichtsdestotrotz werden wir es nutzen, da die Alternative (alles selbst einzurichten) sehr aufwändig ist.

Als Erstes müssen wir __Node.js__ und __npm__ installieren, damit wir im zweiten Schritt __angular-cli__ installieren können.
Am einfachsten können wir Node.js installieren, indem wir es von der [offiziellen Webseite](https://nodejs.org/en/download/) herunterladen.
Bei der Installation von Node.js, wird npm mitinstalliert.
Jetzt können wir angular-cli installieren mit:

```bash
npm install -g angular-cli@1.0.0-beta.5
```

Wir installieren angular-cli global und können es daher in jedem Angular 2 Projekt nutzen.

I> #### Node.js/npm Versionen
I>
I> angular-cli braucht eine relativ neue Version von Node.js und npm. Laut der Dokumentation soll die Version von Node.js ≥ 4 sein. Für das Buch wurde angular-cli mit der Version 5.3.0 von Node.js und Version 3.3.12 von npm getestet.

I> #### Fehler bei der Installation/Projekt-Initialisierung
I>
I> Bei Fehlern hilft es, angular-cli zu löschen und neu zu installieren. Fehler können vor allem auftreten, wenn eine alte Version von angular-cli schon installiert ist.

Jetzt können wir ein Projekt initialisieren.
Dafür gibt es die Kommandos "new" und "init".

```bash
ng new projektName --skip-git
```

Dieses Kommando wird ein Verzeichnis mit dem Namen "projektName" erzeugen. Darin wird es die nötigen Verzeichnisse/Dateien anlegen und alle Abhängigkeiten mittels npm installieren.
Falls `--skip-git` nicht angegeben wird, wird angular-cli auch ein git-Repository anlegen,  vorausgesetzt, dass wir nicht schon in einem git-Repository sind.

Das init-Kommando macht das gleiche wie das new-Kommando aber für ein existierendes Verzeichnis.

```bash
ng init --name projektName
```

Falls `--name projektName` nicht angegeben wird, wird der Name des Verzeichnisses als Projektname benutzt.

W> #### Namen von Projekten
W>
W> Derzeit wird nicht jeder beliebige Name als Projektname unterstützt. Z. B. ist "test" kein gültiger Projektname. Das Tool wird eine Fehlermeldung ausgeben, falls der Projektname nicht zulässig ist.

#### Anwendung starten

Nachdem alle Abhängigkeiten installiert worden sind, können wir die Anwendung starten.
Angular-cli hat einen eingebauten HTTP-Server, den wir dafür nutzen können.
Um den Server zu starten, müssen wir im Projekt-Verzeichnis (das mit der package.json-Datei) folgendes Kommando aufrufen:

```bash
ng serve
```

In der Konsole steht dann, zu welcher URL wir navigieren müssen, um die Demo-Anwendung von angular-cli zu sehen (Zeile: "Serving on http://...").
Das Nette an diesem Webserver ist der Live-Reload-Support.
Das heißt, wenn wir Änderungen im Code machen, werden diese sofort im Browser sichtbar, ohne dass wir das Projekt selbst erneut kompilieren müssen.

### Diskussion

Alle Rezepte in diesem Buch wurden mit `angular-cli` initialisiert.
Es ist also nicht nötig `ng init` oder `ng new` aufzurufen.
Es reicht, wenn `npm install` aufgerufen wird, um die Abhängigkeiten zu installieren.
Danach können wir, wie oben gezeigt, mit `ng serve` die Anwendung starten.

Da das Tool eine eigene Meinung hat, wie die Verzeichnisstruktur, eine Komponente usw. auszusehen hat, wurden aus den Code-Beispielen ein paar Verzeichnisse/Dateien, die nicht für das jeweilige Beispiel relevant sind, gelöscht bzw. angepasst.
Wir wollen nicht, dass überflüssige Verzeichnisse, Dateien und Code-Zeilen uns vom eigentlichen Thema eines Rezeptes ablenken.
Wir schauen uns also nur die relevanten Dateien für ein Rezept an und ignorieren den Rest.
Auch gewisse Abhängigkeiten wurden aus der package.json-Datei entfernt, um die Installationszeit zu verkürzen.
Es ist also möglich, dass nicht alle angular-cli Kommandos mit jedem Rezept funktionieren.
Für die meisten Rezepte ist das src-Verzeichnis am Wichtigsten.
Darin befindet sich der Code für eine Angular 2 Anwendung.
Mehr Informationen über die Verzeichnisstruktur gibt es in [Appendix-B: angular-cli](#appendix-b).

### Weitere Ressourcen

* Offizielle Webseite von [angular-cli](https://cli.angular.io/)
* Github von [angular-cli](https://github.com/angular/angular-cli)
* [Appendix-B: angular-cli](#appendix-b)

