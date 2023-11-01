Todo contrato inteligente escrito en Solidity posee algunas características propias del lenguaje que debes conocer para comenzar a programar tu primer smart contract.

### Características y configuraciones de Solidity
Las primeras líneas de un contrato inteligente suelen ser configuraciones y/o comentarios para que el compilador de Solidity funcione correctamente. La estructura básica de un contrato inteligente posee:

```js
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract MyFirstContract {
    // ...
}
```

Licencia: Define qué permisos tendrá el usuario sobre el contrato, pues al ser código abierto, estará a la vista del público. Existen diversas licencias y dependiendo de la misma puede utilizar el contrato libremente, modificarlo o no, etc.
Pragma: Definen la versión del compilador que se usará. Puede ser una versión fija o un rango específico.
Contract: Esta palabra reservada se usa para indicar el cuerpo del contrato, por lo que todo el contenido debe ir dentro del bloque “contract”.
Si bien, la licencia puede ser omitida en algunos casos, el resto de las líneas son obligatorias, pues en los casos de prueba, el despliegue de contratos puede hacerse con menos consideraciones, siempre y cuando se cumplan los requerimientos mínimos.

Los despliegues dentro de la red principal de Ethereum, son irreversibles, por lo que siempre se debe tener cuidado de estos detalles y conocer exactamente el propósito de cada elemento y probar bien tu aplicación antes de pasarla a producción.

La estructura de un contrato inteligente escrito en Solidity será siempre la misma para que el compilador no de problemas y tu contrato sea desplegado correctamente en la EVM y posteriormente ser utilizado.

-----

Al igual que en cualquier lenguaje de programación, las funciones son piezas de código que se encargan de ejecutar instrucciones de forma independiente. Dentro de Solidity son importantes, pues son el vehículo para que clientes interactúen directamente con los smart contracts.

### Declaración de funciones en Solidity
Las funciones son también denominadas métodos en la programación orientada a objetos o procedimientos, si las mismas no devuelven un valor. Todos son términos que se refieren a lo mismo, instrucciones para realizar una tarea en particular.

La sintaxis de una función en Solidity tiene algunas particularidades con respecto a otros lenguajes y hasta permite escribirse de formas diferentes:

```js
function multiplication(int a, int b) returns(int) {
    return a * b;
}

function multiplication(int a, int b) returns(int product) {
    product = a * b;
}
```

En primer lugar, la palabra reservada returns (en plural) indica el tipo de dato de retorno y se requiere un return (en singular) para devolver el mismo. En el segundo ejemplo, el returns indica, además del tipo de dato, la variable que será devuelta, debiendo declararse la misma para que la función la retorno y no es necesario el return.

Si algo está mal en la declaración de una función, el compilador de Solidity nos notificará y no podremos compilar ni desplegar nuestro contrato. Solidity, al ser un lenguaje fuertemente tipado, nos anticipa a posibles errores que nuestro código pueda tener.

### Visibilidad de las funciones
Las funciones al igual que las variables, pueden implementar los tipos de visibilidades public, private, internal y external. Por defecto, las funciones son todas públicas.

Son más importante sobre la visibilidad de las funciones, es el poder utilizarlas o no desde afuera del contrato. Si desplegamos el siguiente contrato en remix:

```js
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ExampleContract {

    function multiplicationPublic(int a, int b) public returns(int) {
        return a * b;
    }

    function multiplicationPrivate(int a, int b) private returns(int) {
        return a * b;
    }
}
```

Si bien las dos funciones son iguales, la pública puede ser accedida y el entorno de Remix nos permite utilizarla. La función privada, no es visible desde afuera del contrato.

### Tipos de funciones
Además de la visibilidad de las funciones, una característica que Solidity implementa es la posibilidad de que cada función tenga un tipo diferente a partir de su comportamiento. Podemos diferenciar tres tipos:

view: Funciones que solo leen y devuelven dato, no realizan ningún tipo de lógica.
pure: Funciones que siempre devuelven un valor de forma determinista. Por ejemplo, una función de suma siempre devolverá el mismo resultado ante una misma entreda.
payable: Funciones especiales capaces de enviar o recibir ETH.
Exploremos cada una de estos tipos de funciones un poco más.

Funciones del tipo vista
Las funciones view pueden considerarse similares a los getters en la programación orientada a objetos. Devuelven un valor y nada más.

```js
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ExampleContract {

    string saludo = "Hola";

    function saludar(int a, int b) public view returns(string) {
        return saludo;
    }
}
```

La función saludar() es marcada como view y solo devuelve el valor de una variable. Es importante también tener en cuenta que las funciones del tipo view no consumen gas.

### Funciones puras
En el mundo de la programación, en general, las funciones puras realizan una tarea y devuelven siempre el mismo valor para una misma entrada. Pero no modifican el valor de ninguna variable, o sea, no cambian el estado del contrato.

```js
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract ExampleContract {

    function multiplication(int a, int b) public pure returns(int) {
        return a * b;
    }
}
```

La función multiplication() es marcada como pure debido a que siempre devolverá el mismo resultado al multiplicar los mismos dos números. Esta función si consume gas debido a que realiza un procesamiento.

### Funciones pagables
Posiblemente las funciones más importantes de todo contrato inteligente. Las funciones payable son las únicas de todo el contrato que tienen permitido enviar o recibir Ether.

```js
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract SendETH {
    
    function sendETH(address payable receiver) public payable {
        receiver.transfer(msg.value);
    }
}
```

La función enviará los ETH que reciba utilizando la función transfer() de una dirección también marcada como payable.

Si despliegas el contrato en Remix, puedes enviar ETH a una dirección de la siguiente manera:

Observa que luego de desplegar el contrato inteligente en Remix, la función del tipo payable se marca en color rojo. Lo primero que debes hacer es seleccionar una cuenta de la lista que el entorno provee para hacer pruebas.

Selecciona la unidad que quieres enviar, pudiendo ser Ether, Wei o Gwei. Recuerda que un ETH es equivalente a 1.000.000.000.000.000.000 Wei mientras que también es equivalente a 1.000.000.000 Gwei. Finalmente, agrega el monto en el campo value para poder hacer clic en el botón rojo y enviar el Ether. Recuerda que la función recibe por parámetro la dirección de otra cuenta.

Anímate a enviar ETH a otra cuenta de prueba de la lista que Remix provee y habrás logrado tu primera transacción en un contrato inteligente.

-----

Las variables pueden tener una ubicación distinta dentro de su almacenamiento en el contrato dependiendo del uso que se les vaya a dar y cómo se utilicen.

### Tipos de almacenamiento de datos
Para especificar la localización de los datos en un contrato, veremos a continuación tres posibilidades y dependiendo la misma, una variable tendrá un comportamiento u otro.

`Storage` Indica que una variable será guardada dentro de la Blockchain. Siempre podremos obtener un valor desde el storage dado que todo en Blockchain es inmutable. A este tipo de memoria se le conoce como memoria persistente.

`Memory` Las variables del tipo memory solo pueden ser usadas mientras se llama a una función. Después de esto, la misma se borrará. Este tipo de variable puede modificarse mientras está en uso.

`Calldata` Similar a memory, con la diferencia de que aquí las variables no se pueden modificar mientras estén en uso. Si se sabe de antemano que una variable no necesitará modificarse, es buena práctica usar calldata para reducir el consumo de gas.

Por defecto, las variables de estado del contrato son guardadas en el storage, mientras que los parámetros de una función son guardados en memory. Los únicos tipos de datos a los que se les puede asignar un almacenamiento distinto son los tipos string, array, struct y mapping.

El tipo de almacenamiento de una variable cambiará el ciclo de vida de la misma. Haciendo que esta sea modificable o persistente dentro del contrato. Es muy importante entender la diferencia entre cada tipo para saber cuándo es conveniente utilizar cada uno y mejorar el rendimiento de un contrato.

-----

Solidity implementa un tipo de función especial denominada Modificadores que nos permiten ejecutar una pieza de código antes o después del comportamiento de la propia función.

### Comportamiento de una función
Los usos más frecuentes de los modificadores suelen ser la validación de datos o la restricción de acceso a una función si el usuario no tiene permisos. Dichas validaciones puedesn realizarse con modificadores que además permiten ser reutilizadas.

Estos nos permiten hacer validaciones antes de ejecutar las funciones. De esta forma, podemos evitar comportamientos inesperados o que alguien sin autorización ejecute la función.

```js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract FunctionModifier {

    address public owner;

    constructor() {
        // Guardamos la información del dueño del contrato para validar al mismo
        owner = msg.sender;
    }

    // Modificador para validar que la llamada la realiza el dueño del contrato
    modifier onlyOwner() {
        require(msg.sender == owner, "No eres el owner");
        _;
    }

    // Solo el dueño del proyecto puede cambiar al mismo
    function changeOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}
```

La sintaxis de un modificador es sencilla, utilizando la palabra reservada `modifier`, declaramos la función y dentro del mismo utilizamos un `require` para realizar una validación y un `_` para indicarle al compilador de Solidity que continúe ejecutando el resto de la función si la condición se cumplió correctamente.

En el caso de que la condición no se cumpla y el modificador rechace la transacción, el `require` realizará un `revert` para volver atrás todos los cambios de estado del contrato por nosotros y que no tengamos que preocuparnos. Las operaciones en Solidity son atómicas, lo que quiere decir que se ejecuta correctamente cada una de las instrucciones o no se ejecuta ninguna.

Finalmente, una función puede implementar el modificador en la declaración de la misma. A lo igual que indicamos que una función es `public` o `pure`, también le implementamos el nombre del modificador que utilizará.

```js
function changeOwner(address _newOwner) public onlyOwner { }
```

La lógica dentro del modificador puede ser del nivel de complejidad que necesitemos, usando condicionales u otros flujos de control. Con esta característica de Solidity, ya estás listo o lista para desarrollar contratos con permisos y validaciones de datos para que el flujo del mismo sea el esperado.

-----

Con cada transacción que un contrato inteligente procesa correctamente, puede haber partes involucradas e interesadas en ser notificadas de estos cambios de estado de un proyecto.

### Envío de notificaciones al exterior de la Blockchain
Los Eventos en Solidity se utilizan para notificar los cambios realizados en un contrato. Cuando un usuario envía ETH y se quiere notificar a otro de su recepción, puedes emplear este mecanismo para que una aplicación externa reciba el mensaje e informe a dicho usuario.

Los eventos deben ser recibidos por medio de aplicaciones Web3 que se encuentren observando el contrato y respondiendo a los eventos. Librerías de Javascript como Web3.js permiten desarrollar este tipo de aplicaciones front end y notificar al usuario de eventos en un contrato.

### Implementando eventos
La declaración de un evento y la emisión de una notificación del mismo se realiza de forma simple:

```js
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Event {

    event Log(address sender, string message);

    function sendMessage() public {
        emit Log(msg.sender, "Este es el mensaje");
    }
}
```

Utilizando la palabra reservada event, declara el evento que puede recibir por parámetro todos los datos que el mismo necesite. Para emitir un evento, utiliza la palabra reservada emit seguido de la declaración del evento y el pasaje de datos que necesita.

Si emiten un evento, la consola de Remix te permitirá observa los datos de este.

```json
[
	{
		"from": "0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B",
		"topic": "0xbb65f02a08ca2759ab26ef9929bf648f890a58e115823859923e3a6d0c6dfca8",
		"event": "ChangeName",
		"args": {
			"0": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
			"1": "tokens",
			"editor": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
			"newName": "tokens"
		}
	}
]
```

También puedes emplear este mecanismo para generar un registro de actividad en un contrato, además de notificar usuarios.

Conclusión
Estos conceptos son algo avanzado de Solidity debido a que, sin un front-end, puede no tener tanto sentido su implementación. Es importante para ti en este punto de tu aprendizaje conocer su existencia para usarlos en el futuro.

-----

En la lógica de un contrato inteligente pueden ocurrir errores que debemos controlar y actuar en consecuencia ante estos escenarios.

### Manejo de errores en Solidity
Solidity permite la declaración de Errores cuya función es similar a la de los eventos, con la diferencia de que estos pueden revertir los cambios de estado hechos. Sin embargo, el gas usado no es devuelto a quien generó la transacción.

La declaración de errores permite dar información más detallada sobre el error que acaba de ocurrir y generar una notificación, similar que los eventos. Los cambios previos en la transacción se revierten, por lo que no debes preocuparte si cambiaste el valor de alguna variable previamente.

```js
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Event {

    error SendError(string message);

    function doSomething() public {
        revert SendError("Mensaje del error");
    }
}
```

La declaración de los errores personalizables se realiza con la palabra clave `error` y `recibe` todos los parámetros que el mismo pueda necesitar. Su posterior lanzamiento se realiza con revert e invocando el error a través de su nombre.

Si lanzas un error desde Remix, verás la `X` roja y la información respectiva al error que acaba de ocurrir.

Combina esa característica de Solidity para desarrollar flujos en el código que te permitan controlar todos los escenarios posibles y actuar en consecuencia. Informarle a los usuarios del proyecto qué está ocurriendo en el contrato te ayudará a mejorar su experiencia de usuario interactuando con una aplicación.

-----

La complejidad de un contrato inteligente puede ser de un nivel tan alto que no nos alcancen los tipos de variables que este lenguaje tiene para ofrecer y debamos declarar nuestros tipos de datos personalizados.

### Estructuras de datos
Puedes declarar un nuevo tipo de dato conocido como estructuras que permiten agrupar N cantidad de variables relacionadas entre sí, cada una de un tipo diferente.

Si tienes conocimiento en programación orientada a objetos, sabrás lo que es una clase y cómo instanciar la misma te genera un objeto. También puedes entender el uso de las estructuras similar que las Interfaces en TypeScript. Conjuntos de datos relacionados que suelen representar un registro. Solidity implementa el concepto de estructura inspirado en C/C++.

1. Utiliza la palabra reservada struct para crear una estructura de datos. Así podrás tener dentro cada propiedad la estructura y su respectivo tipo.

```js
struct Persona {
    string nombre;
    string apellido;
    uint edad;
}
```

2. Genera una variable de este tipo, basta con invocar el constructor de la estructura y asignarle el tipo a la variable.

```js
Persona p = Persona("Lionel", "Messi", 35);
```

3. Emplea los datos dentro de una estructura de manera intuitiva, ten en cuenta que es prácticamente igual a la utilización de un objeto.

```js
p.nombre;     // Lionel
p.apellido;   // Messi
p.edad;       // 35
```

Dentro de una estructura, podrás tener otra estructura, arrays o cualquier otro tipo de dato.

Estos conocimientos te permitirán desarrollar mejores contratos y, sobre todo, más limpios. Cuando necesitamos manipular una gran cantidad de datos, podemos agruparlos de forma lógica en una estructura para garantizar un acceso más organizado.

-----

Un `enum type` o `tipo enumerado` es un grupo de datos especiales a los que se les puede asignar una variable que corresponda a un conjunto de constantes predefinidas. Son implementados en muchos lenguajes de programación fuertemente tipados y Solidity los utiliza para la creación de tipos personalizados de datos y definir los valores que estos puedan tener.

Los enumerados emplean una lista de los valores que una variable puede tomar haciendo uso de un texto para visualizar el nombre a cada valor, pero guardándose un número entero por detrás. Podemos tener una máquina de estados cuyos valores sean 0, 1 y 2. Para que sea más intuitivo y fácilmente legible el significado de cada número, podemos asignarle un “pendiente” al 0, “en proceso” al 1 y “finalizado” al 2.

De esta forma, no necesitamos recortar que “finalizado” se representa por un 2, solo con utilizar el texto de cada valor del enumerado, el compilador de Solidity lo hará por nosotros. En programación, cuando necesitamos clasificar y limitar los posibles valores de una variable, podemos utilizar listas y crear nuestros propios tipos de datos con todos los valores que una variable puede tener gracias a la enumeración.

### Cómo implementar enumerados en Solidity
La implementación de Solidity es muy sencilla, basta con utilizar la palabra reservada enum seguido del nombre del enumerado y sus posibles valores.

`enum State { Pendiente, EnProceso, Finalizado };`

La posición de cada valor del enumerado determina el índice que le corresponde siendo `Pendiente = 0`, `EnProceso = 1` y `Finalizado = 2`. Ahora puedes declarar variables de este nuevo tipo de dato personalizado.

`State status;`
Dentro de esta variable guardas el enumerado y puedes utilizarlo como condicionante para determinar el flujo de tu programa o asignarle nuevos valores a través del propio enumerado.

```js
status = State.Finalizado;    // 2

if (status == State.Finalizado) {
    // ...
}
```

El simple uso del enumerado State nos ayuda a no tener que recordar el valor de cada elemento del enumerado utilizando el “Finalizado” y volviendo el código fuente mucho más legible y mantenible.

Aprovecha esta característica del lenguaje para escribir mejor código el día de mañana y que otro desarrollador o desarrolladora de software pueda entender rápidamente. Las buenas prácticas de programación hacen a la calidad del código y este tipo de característica te permitirá ser más claro con el propósito de un programa.

-----

Un contrato inteligente puede almacenar cientos o miles de datos a lo largo de su vida útil. En estos casos debemos implementar estructuras de datos que nos permitan manipular gran cantidad de datos de forma fácil y organizada.

### Qué son los array o vectores de datos
La primera estructura de datos, típica de cualquier lenguaje de programación, son los Arrays. Los arrays almacenan de forma secuencial datos de un mismo tipo y los mismos pueden ser accedidos a través de su índice o posición dentro del mismo. Pueden ser de una longitud determinada o de longitud dinámica dependiendo la necesidad.

```js
// Array de números de hasta 3 posiciones
uint[3] numbers = [1, 2, 3];

// Array de números de longitud variable
uint[] numbers;
```

En cualquier tipo de array, puedes agregar o quitar elementos utilizando los métodos `push(x)` y `pop()`.

`push(x)` agrega un nuevo elemento pasado como argumento al final del array, mientras que `pop()` remueve el último elemento.

El acceso a estos datos debe realizarse a través del índice del elemento comenzando por cero. Si tenemos el array `string words = ["Bienvenido", "a", "Mundo"]`, el elemento 2 corresponde al string Mundo y accedes a este con la sintaxis words[2].

Finalmente, puedes conocer la longitud de un array a través de su método myArr.length. El mismo devolverá un número entero que representa el tamaño del mismo.

### Qué son los mappings o asignaciones de datos
Los arrays tiene sus limitaciones. Si tenemos un array con miles de datos, acceder a un valor en el medio de este puede ser costoso. Tener que recorrer todo el mismo para encontrar un valor requiere procesamiento y, por ende, consumo de gas. Los Mappings solucionan este problema permitiendo asignar valores a una clave única para acceder al dato.

Similar a un objeto donde acceder a sus propiedades a través de un nombre específico. Los mappings permiten utilizar cualquier tipo de clave para acceder a un valor y el mismo puede crecer y guardar tantos valores como necesitemos.

La declaración de un mapping requiere de especificar el tipo de dato de la clave, y el tipo de dato del valor que esta guardará.

`mapping(string => uint) public myMapping;`

Uno de los usos más habituales de los mappings es para guardar el balance económico de una cuenta en el contrato. Cada clave guarda una address y el valor es el valor en ETH que esta posee.

`mapping(address => uint) public balances;`

El contenido del mapping puedes imaginarlo de la siguiente manera.

```js
balances = {
    "direccion123": 1000,
    "direccion456": 2000,
    "direccion789": 5000
}
```
A través de `direccion123`, `direccion456` y `direccion789` puedes acceder rápidamente al balance de cada cuenta y su llamado se realiza de la forma `balances["direccion123"]`.

Los mappings son completamente dinámicos, pudiendo almacenar un mapping dentro de otro.

`mapping(address => mapping(uint => bool)) public nested;`

Aumentando así su complejidad y las posibilidades de guardar información.

Una desventaja de los mapping es que no permiten ser recorridos como un array u obtener su longitud. Para esto puedes hacer uso de extensiones y utilidades para darle más funcionalidad a esta estructura de datos si necesitas resolver casos de uso complejos.

Conclusión
Tanto los Arrays como los Mappings tienen sus ventajas y desventajas y pueden ser implementados para almacenar información. Comprender estas diferentes estructuras de datos que Solidity implementa nos permitirá tener más herramientas para el desarrollo contratos inteligentes, organizar la información y el acceso a estos.
