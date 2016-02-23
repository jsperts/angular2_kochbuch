# Rezepte für Formulare

Angular bietet uns mehrere Möglichkeiten, um Formulare zu implementieren.
Grob können wir in Angular 2 zwischen zwei Arten von Formularen unterscheiden: "Template Driven Forms" und "Model Driven Forms".

Bei den "Template Driven Forms" ist ein Großteil der Logik wie z. B. die Validierung im Template.
Auch die Synchronisation zwischen den Daten, die der Nutzer sieht und den Daten in der Klasse der Komponente (dem Modell) wird im Template definiert.
So werden Formulare in Angular 1.x implementiert wo wir direkt im Template z. B. mit dem required-Attribut definieren, dass das Feld ein Pflichtfeld ist.
Da "Template Driven Forms" einfacher und in der Regel mit weniger Code zu implementieren sind, werden wir uns zuerst damit beschäftigen.
Allerdings haben diese Formulare auch Nachteile.
Da die Logik im Template ist, ist es schwer bis unmöglich diese in Unit-Tests zu testen.
Des Weiteren kann das Template bei Formulare mit komplexe Validierung sehr schnell unübersichtlich werden.

Bei den "Model Driven Forms" befindet sich die meiste Logik in der Klasse der Komponente.
Das Template hat nur die nötigen Informationen, um die Formular-Felder mit dem Formular-Modell zu verbinden.
Als Formular-Modell bezeichnen wir in diesem Zusammenhang die Implementierung des Formulars in der Klasse der Komponente.
"Model Driven Forms" benötigen in der Regel mehr Code.
Wir müssen das Formular im Template implementieren und dann die Logik in der Klasse.
Da die Logik sich in der Klasse befindet, können wir die Komponente gut Unit-Testen.

Wir werden jetzt mit einem einfachen "Template Driven" Formular anfangen und werden nach und nach komplexere "Model Driven" Formulare implementieren.

