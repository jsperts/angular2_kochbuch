## Auf Nutzer-Input reagieren {#c03-user-input}

### Problem

Ich möchte in meiner Komponente eine Methode aufrufen, wenn der Nutzer einen Browser-Event wie z. B. "click" auslöst.

### Zutaten

* [Angular 2 Anwendung](#c02-angular-app)
* Ein Browser-Event, wir nutzen hier "click" als Beispiel
* Methode, die aufgerufen werden soll, wenn der Nutzer auf das Element klickt

### Lösung 1

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  template: '<div (click)="clicked()">Click me</div>'
})
export class AppComponent {
  clicked() {
    console.log('Clicked');
  }
}
```

__Erklärung__:

* Zeile 5: Hier findet eine Event-Bindung statt. In diesem Fall wird das click-Event gebunden
* Zeilen 8-10: Die Methode, die aufgerufen werden soll, wenn der Nutzer auf das Element klickt. Zu beachten ist, dass der Name der Methode identisch zu dem Namen, den wir im Template nutzen, sein muss

### Lösung 2

{title="app.component.ts", lang=js}
```
...

@Component({
  selector: 'app-root',
  template: '<div on-click="clicked()">Click me</div>'
})
export class AppComponent {
  clicked() {
    console.log('Clicked');
  }
}
```

__Erklärung__:

Das ist eine alternative Schreibweise zu der Schreibweise in Lösung 1. Statt Klammern für den Event-Namen nutzen wir hier "on-" als Präfix. Die Funktionalität bleibt dabei jedoch gleich.

### Diskussion

Die Event-Bindung ersetzt alle Event-Direktiven, die es in Angular 1.x gibt wie z. B. "ng-click", "ng-keypress" und "ng-keydown".
Wir haben im Beispiel "click" benutzt, aber wir hätten auch andere Event-Namen zwischen den Klammern schreiben können wie z. B. "keypress".
Allgemein ist der Namen zwischen den Klammern der Namen des Events, auf das wir reagieren möchten. Nach dem Gleichheitszeichen kommt die Aktion, die als Reaktion zum Event ausgeführt werden soll.
Die Event-Bindung ist eine Form der [Datenbindung](#gl-data-binding).

### Code

Code auf Github: [03-Recipes\_to\_Manipulate\_the\_View/03-User\_Interaction](https://github.com/jsperts/angular2_kochbuch_code/tree/master/03-Recipes_to_Manipulate_the_View/03-User_Interaction)

### Weitere Ressourcen

* Weitere informationen zur Event-Bindung gibt es in [Appendix A: Template-Syntax](#appendix-a)

