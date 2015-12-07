# Glossar {#glossary}

{#gl-angular-app}
__Angular 2 Anwendung__: Eine Angular 2 Anwendung ist ein Baum von Komponenten und hat immer mindestens eine Komponente. Die Komponente die immer vorhanden ist, ist die Hauptkomponente und die wird benutzt, um die Anwendung zu initialisieren und buildet die Spitze des Baums.

{#gl-bootstrap}
__bootstrap__: Das initialisieren einer Angular 2 Anwendung. Der Initialisierungsprozess beginnt in dem wir die bootstrap-Funktion aufrufen und den Hauptkomponent als Parameter übergeben.

{#gl-decorator}
__Decorator__: Ist eine Funktion die Meta-Daten zu einer Klasse, deren Methoden und Eigenschaften und Funktionsparameter hinzufügen kann. Decorators sind ein TypeScript Feature und fangen immer mit einem "@" an.

{#gl-directiv}
__Direktive__: Eine Direktive in Angular 2 ist ein UI-Baustein den wir nutzen können um HTML-Elemente zu definieren, zu ändern und deren Verhalten zu beeinflussen. Sie sind die wesentliche Bausteine von Angular. Direktiven gehören zu eine von drei Kategorien: Komponenten, Attribut-Direktive und strukturelle-Direktive.

{#gl-main-component}
__Hauptkomponent__: Der Komponent den wir der bootstrap-Funktion übergeben. Siehe auch __Komponent__.

{#gl-interpolation}
__Interpolation__: TODO

{#gl-component}
__Komponente__: Komponenten sind die Haupt-UI-Bausteine einer Angular 2 Anwendung. Sie kombinieren Logic mit eine HTML-Template (View), um die Anwendung anzuzeigen. Zu einer Komponente gehört immer meta-Daten für die Komponente (@Component-Decorator), meta-Daten für die View (meistens mit dem @View-Decorator definiert) und eine Klasse (Komponenten-Klasse), die die Logik für die Komponente beinhaltet. Verglichen mit Angular 1.x, ist eine Komponente eine Direktive mit dem dazugehörigen Controller.

{#gl-pipes}
__Pipes__: Sind Funktionen die Eingabewerte transformieren, um die anschließend in eine View anzuzeigen. Ähnliche Funktionen gab es auch in Angular 1.x. Da waren sie unter dem Namen "Filter" bekannt.

{#gl-service}
__Service__: Angular 2 Services sind im grundegenommen TypeScript Klassen die wir mittels Dependency Injection in unsere Anwendung verwenden können. Z. B. kann ein Service verschiedene Hilfmethoden beinhalten.

