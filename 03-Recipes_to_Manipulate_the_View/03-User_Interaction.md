## Auf Nutzer-Input reagieren {#c03-user-input}

### Problem

Ich möchte eine Methode in meine Komponente aufrufen, wenn der Nutzer eine Browser-Event wie z. B. "klick" auslöst.

### Zutaten

* [Eine Komponente](#c02-component-definition), kann auch die Hauptkomponente einer [Angular 2 Anwendung](#c02-angular-app) sein
* Ein Browser-Event, wir nutzten hier "klick" als Beispiel
* Methode die Aufgerufen werden soll wenn der Nutzer auf das Element klickt

### Lösung 1

{title="Ausschnitt aus einer Komponente", lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: '<div (click)="clicked()">Click me!</div>'
})
class MyApp {
  clicked () {
    console.log('Clicked');
  }
}

...
```

Erklärung:

* __Zeile 7__: Der Name zwischen den Klammern, hier "click", signalisiert das Event auf das wir hören möchten. Nach dem Gleichheitszeichen folgt die Methode die wir bei klick aufrufen möchten
* __Zeile 10-12__: Die Methode die aufgerufen werden soll wenn der Nutzer auf das Element klickt. Zu beachten ist, dass der Name der Methode identisch sein muss zum Namen den wir im Template nutzen

### Lösung 2

{title="Ausschnitt aus einer Komponente, lang=js}
```
...

@Component({
  selector: 'my-app'
})
@View({
  template: '<div on-click="clicked()">Click me!</div>'
})
class MyApp {
  clicked () {
    console.log('Clicked');
  }
}

...
```

Erklärung:

Das ist eine alternative Schreibweise zu der Schreibweise in Lösung 1. Statt Klammern für den Event-Namen, nutzen wir hier "on-" als Präfix. Die Funktionalität bleibt dabei gleich.

### Diskussion

Die neue Schreibweise mit Klammern für Browser-Events ersetzt alle Event-Direktiven die es in Angular 1.x gibt wie z. B. ng-click, ng-keypress und ng-keydown. Wir haben im Beispiel "click" benutzt aber wir hätten auch andere Event-Namen zwischen den Klammern schreiben können wie z. B. "keypress" und "keydown". Allgemein ist der Namen zwischen den Klammer, der Namen des Events auf das wir reagieren möchten. Nach dem Gleichheitszeichen kommt die Aktion die als Reaktion zum Event ausgeführt werden soll. Wir haben ein Methodenaufruf als Aktion definiert, man kann aber auch andere Aktionen definieren wie z. B. die Zuweisung eines Wertes an einer Variablen.

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/03-User\_Interaction](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/03-User_Interaction)

### Weitere Ressourcen

* Die Angular 2 Dokumentation gibt mehr Informationen über [Event-Bindings](https://angular.io/docs/ts/latest/guide/template-syntax.html#event-binding)

