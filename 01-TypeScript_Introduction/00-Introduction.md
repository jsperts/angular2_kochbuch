# Einführung zu TypeScript

Vermutlich ist TypeScript für einige Leser Neuland, und aus diesem Grund habenm wir uns entschieden, dass das Buch auch eine kurze Einführung zu TypeScript beinhalten soll.
TypeScript ist eine von Microsoft geschriebene Programmiersprache mit derer man Anwendungen schreiben kann, die dann später zu JavaScript kompiliert werden, damit sie z. B. im Browser funktionieren. Es ist eine typisierte Übermenge von JavaScript (ES5). Außer Typen unterstützt TypeScript auch gewisse Features aus ES6/ES2015 aber auch Features die vermutlich in ES7/ES2016 standarisiert werden. Da TypeScript eine Übermenge von JavaScript ist, ist auch jede JavaScript Anwendung zumindest Anwendungen die mit ES5 geschrieben wurden sind, auch eine valide TypeScript Anwendung.

Wir werden uns nicht die komplette TypeScript Funktionalität anschauen, sondern nur die Teile die wir auch in den verschiedenen Rezepten brauchen werden.
Der Grund dafür ist einfach, wir möchten uns auf Angular 2 konzentrieren und nicht zu viele Zeit mit TypeScript verbringen.
Um die komplette Funktionalität von TypeScript abzudecken, bräuchte man ein eigenes Buch dafür.
Der große Vorteile von TypeScript gegenüber von plain JavaScript, ist das Typ-System das uns TypeScript zu verfügung stellt.
Dieses ermöglicht uns Typinformationen zu hinterlegen für Variablen, Funktionen, Objekten und mehr.
In kleineren Anwendungen ist dieser Vorteil vielleicht nicht so relevant, da wir dort relativ schnell ein Überblick bekommen kann, welche Datentypen wo verwendet werden.
Wer aber größere JavaScript Anwendungen geschrieben hat, weißt wie schwer es sein kann den Überblick zu bewahren und heraus zu finden z. B. welche Eigenschaften ein bestimmtes Objekt hat.
Mit Hilfe von Typinformationen können wir solche Probleme vermeiden.
Da Typen ein so wichtiger Aspekt von TypeScript sind, werden wir uns als erstes damit befassen.

