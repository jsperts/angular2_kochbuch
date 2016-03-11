# Glossar {#glossary}

{#gl-angular-app}
__Angular 2 Anwendung__: Eine Angular 2 Anwendung ist ein Baum von Komponenten und hat immer mindestens eine Komponente. Die Komponente die immer vorhanden ist, ist die Hauptkomponente und die wird benutzt, um die Anwendung zu initialisieren und bildet die Spitze des Baums.

{#gl-bootstrap}
__bootstrap__: Das initialisieren einer Angular 2 Anwendung. Der Initialisierungsprozess beginnt in dem wir die bootstrap-Funktion aufrufen und den Hauptkomponent als Parameter übergeben.

{#gl-data-binding}
__Daten-Bindung__: Auf Englisch "data binding" ist die Verbindung zwischen Daten in einem HTML-Template und entsprechende Daten in einer Komponente oder Direktive. Daten-Bindungen können auf verschiedenen Weisen entstehen z. B. durch Interpolation, Event-Bindung mittels Klammern (...) oder Eigenschaft-Bindung mittels eckigen Klammern [...].

{#gl-decorator}
__Decorator__: Ist eine Funktion die Metadaten zu einer Klasse, deren Methoden und Eigenschaften und Funktionsparameter hinzufügen kann. Decorators sind ein TypeScript Feature und fangen immer mit einem "@" an.

{#gl-di}
__Dependency Injection (DI)__: Ist ein Design Pattern, um Abhängigkeiten zu verwalten. Angular nutzt DI, um Abhängigkeiten wie z. B. Services zu instantiieren und der Komponente zu übergeben.

{#gl-directiv}
__Direktive__: Eine Direktive in Angular 2 ist ein UI-Baustein den wir nutzen können um HTML-Elemente zu definieren, zu ändern und deren Verhalten zu beeinflussen. Sie sind die wesentlichen Bausteine von Angular. Direktiven gehören zu eine von drei Kategorien: Komponenten, Attribut-Direktive und strukturelle-Direktive.

{#gl-main-component}
__Hauptkomponent__: Die Komponente die wir der bootstrap-Funktion übergeben. Siehe auch __Komponente__.

{#gl-interpolation}
__Interpolation__: Ein Ausdruck in einem Template wird evaluiert und dann in ein String konvertiert. Der String wird dann mit benachbarten Strings konkateniert und in den DOM gesetzt. Um Angular zu sagen was interpoliert werden muss, wird der Ausdruck zwischen __{{__ und __}}__ gesetzt.

{#gl-component}
__Komponente__: Komponenten sind die Haupt-UI-Bausteine einer Angular 2 Anwendung. Sie kombinieren Logik mit einem HTML-Template (View), um die Anwendung anzuzeigen. Zu einer Komponente gehört immer Metadaten für die Komponente (@Component-Decorator), Metadaten für die View (meistens mit dem @View-Decorator definiert) und eine Klasse (Komponenten-Klasse), die die Logik für die Komponente beinhaltet. Verglichen mit Angular 1.x, ist eine Komponente eine Direktive mit dem dazugehörigen Controller.

{#gl-pipes}
__Pipes__: Sind Funktionen die Eingabewerte transformieren, um die anschließend in eine View anzuzeigen. Ähnliche Funktionen gab es auch in Angular 1.x. Da waren sie unter dem Namen "Filter" bekannt.

{#gl-service}
__Service__: Angular 2 Services sind im Grunde genommen TypeScript Klassen die wir mittels Dependency Injection in unsere Anwendung verwenden können. Z. B. kann ein Service verschiedene Hilfsmethoden beinhalten.

