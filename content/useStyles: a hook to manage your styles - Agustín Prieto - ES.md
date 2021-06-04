![Banner React Native](images/useStylesBanner.jpg)

# useStyles: el hook para manejar estilos en React Native

¿Alguno tiene una idea clara de cómo manejar estilos en React Native? Yo no.

Hace unos años que trabajo con este framework y nunca pude conseguir una forma concisa de utilizar estilos. En este último año he intentado con algunas librerías con conceptos innovadores como Styled Components, las cuales no me han convencido por completo. Como resultado de esta insatisfacción con las actuales alternativas se creó la librería useStyles.

![Un hook para gobernarlos a todos](images/useStylesMeme.jpg)

## ¿Qué es useStyles y cómo puede ayudarme?

Organizar los estilos en React Native puede ser complicado, un dolor de cabeza si no aplicas buenas práctias de programación. useStyles viene con la idea de alivianar dicha carga brindando las herramientas para que puedas generar aplicaciones donde los estilos tengan su propio lugar y puedan residir de forma armónica con los componentes.

Si resumimos qué hace useStyles: es un hook, el cual te permite consumir de forma sencilla, limpia y eficiente los estilos de tu aplicación. Por lo que si te atrae la idea de mejorar la forma en que escribes tus estilos y así generar aplicaciones más limpias, te invito a que pases por el [repositorio](https://github.com/rootstrap/react-native-use-styles) y lo pruebes por ti mismo.

A continuación veremos un ejemplo de uso.

## Uso

El siguiente ejemplo muestra cómo aplicaríamos estilos de forma nativa para generar un simple container con un texto dentro.

https://gist.github.com/agustito37/cca8292de8f3639972af9d9130dc2784

Visto de esta forma, no parece un mal código, ¿verdad? Ahora qué pasa cuando el componente empieza a crecer.

El componente unas semanas después, unas muy malas semanas después:
https://gist.github.com/agustito37/d89db60561fbe5073e340f3b6c6c35b4

Como verán, nuestro lindo componente empezó a ser devorado lentamente por nuestros feos estilos. Si bien hay muchas formas de mejorar este código, dado que React Native no tiene una forma clara y sencilla de manejar estilos, estas malas prácticas se vuelven algo común.

Ahora implementemos lo mismo pero con useStyles:
https://gist.github.com/agustito37/2f49201ea6f7a7cfce3318181f6e00c4

Perdonen :cry:. Mis ojos se llenaron de alegría al ver el código organizado. Sniff. Capaz esto les hace acordar un poco al uso de CSS. Si bien useStyles está inspirado en el uso de clases CSS, esta es una solución creada especialmente para React Native; poco tiene que ver con CSS.

Volviendo al previo ejemplo, se puede ver cómo el hook `useStyles` devuelve una función, que es utilizada luego para consumir nuestros estilos. Ya habrán notado algunas declaraciones peculiares, como un hook al que se le pasan dependencias, y algunos prefijos como `.`, `&`, `$` y `:`. A continuación, cuando veamos la definición de los estilos, vamos a ver qué significan.

useStyles te provee las interfaces `GlobalStyles` y `Styles` para definir estilos globales y locales.

Estilos globales:
https://gist.github.com/agustito37/7a41cb267e558ede30086575ef922ae6

Estilos del componente:
https://gist.github.com/agustito37/2759b5e981d2810ceb77bdfd36a1851a

La idea no es analizar en detalle cada una de las funcionalidades, para eso pueden chequear el [repositorio](https://github.com/rootstrap/react-native-use-styles). Pero en forma resumida se pueden explicar de la siguiente manera:

- Constantes (`$`): podemos reutilizarlas en otros estilos y componentes.
- Estilos estáticos (`.`): estilos regulares que pueden ser reutilizados en otros estilos y componentes.
- Estilos computados (`&`): estilos que dependen de ciertas dependencias pasadas en el hook. Si alguna dependencia cambia, estos estilos son re-computados.
- Paths (`:`): abreviaciones de los estilos. Por ejemplo: para definir la propiedad `backgroundColor: 'red'` se puede utilizar el path `bg:color:red`.

## Resumen

useStyles es una librería creada con la finalidad de solucionar un problema recurrente que solemos tener los desarrolladores en React Native: estilos desorganizados e invasivos en nuestros componentes. Con useStyles utilizamos un hook para consumir los estilos, el cual nos da una interfaz sencilla, limpia y eficiente.

Te invito a chequear el [repositorio](https://github.com/rootstrap/react-native-use-styles) para ver qué más puedes hacer con useStyles y compruebes que esta librería realmente te facilitará tu trabajo como desarrollador. Por supuesto, cualquier contribución es bienvenida.

### References

[1] https://github.com/rootstrap/react-native-use-styles

[2] https://styled-components.com/
