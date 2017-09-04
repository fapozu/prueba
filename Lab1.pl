% ------------------------------------------------------------------------------
%
% CI-1441 Paradigmas computacionales
% II-2017, Prof. Alvaro de la Ossa O., Dr.rer.nat.
%
% Laboratorio de programación Prolog
% 22 de agosto de 2017
%
% ------------------------------------------------------------------------------

:- dynamic sobre/2, limpio/1. % Debe permitirse añadir y borrar clásulas de este predicado

% ------------------------------------------------------------------------------
%
% El mundo de los cubos
%
% En este juego se tienen N cubos sobre una meta, cada uno etiquetado con un
% símbolo distinto, y el propósito del juego es dada una descripción de un
% estado meta del juego, planificar y realizar los cambios necesarios para
% llevar el mundo a ese estado.
%
% Problema: Programar un agente que puedan jugar el juego de los cubos.
%
% Objetivo del laboratorio: Comprender cómo el lenguaje Prolog puede ser
%    utilizado para construir un modelo de un agente planificador, en este caso
%    una versión simplificada del jugador en el mundo de los cubos.
%
% ------------------------------------------------------------------------------
%
% 1. Supuestos:
%
%      * Inicialmente hay una cantidad determinada de cubos sobre la mesa,
%        organizados en una o más columnas.
%      * La mesa es de capacidad ilimitada, es decir, que es posible poner todos
%        los cubos del mundo directamente sobre la mesa.
%      * Los cubos son todos del mismo tamaño.
%
% 2. Representación del mundo
%
%      * Cubos: son representados mediante símbolos (átomos) que sirven de
%           etiquetas: a, b, etc., y un hecho cubo(etiqueta) para cada uno.
%      * La mesa: el átomo mesa; sobre ella se pueden poner cubos, pero no es
%           posible poner la mesa sobre un cubo.
%      * Estado del mundo: colección de hechos del predicado sobre/2, que
%        representan las relaciones entre los cubos en el presente
%
%      Ejemplo: en el estado inicial hay dos columnas de cubos sobre la mesa,
%      una con los cubos etiquetados con a, b y c, de arriba hacia abajo, y la
%      otra con los cubos d y e. Los cubos a y d están "limpios" o "libres" (no
%      hay cubos sobre ellos), y los cubos c y e están sobre la mesa:
%
%          x---x
%          x a x
%          x---x   x---x
%          x b x   x d x
%          x---x   x---x
%          x c x   x e x
%      x---x---x---x---x---x
%      x       mesa        x
%      x-------------------x
%
% ------------------------------------------------------------------------------

% -- cubo/1(?Cubo): Cubo es un cubo
%       Cubo: átomo

cubo(a). cubo(z). cubo(b). cubo(c). cubo(d). cubo(e). cubo(x).

% ------------------------------------------------------------------------------
% Ejercicio 1: Consultas básicas a la base de conocimientos
%
% Pruebe en Prolog las preguntas siguientes. Siempre que sea posible, obligue al
% intérprete a hacer "backtracking" (presionando el espaciador en lugar de ENTER
% cada vez que le da una respuesta).
%
% ?- cubo(X).
% ?- setof(X,cubo(X),Z).
% ------------------------------------------------------------------------------

% -- sobre/2(?Cubo1,?Cubo2): el Cubo1 está puesto sobre el Cubo 2
%       Cubo1, Cubo2: átomos
%       Cubo2 puede ser el átomo mesa

sobre(a,b).    % Primera columna: el cubo a está sobre el b,
sobre(b,c).    % este sobre el c,
sobre(c,mesa). % y el c sobre la mesa.
sobre(d,e).    % Segunda columna: el cubo d está sobre el e,
sobre(e,mesa). % y el e sobre la mesa.

% ------------------------------------------------------------------------------
% Ejercicio 2: Distintas formas de visualizar los hechos.
%
% Pruebe en Prolog las preguntas siguientes:
%
% ?- setof((X,Y),sobre(X,Y),Z).
% ?- setof([X,Y],sobre(X,Y),Z).
% ?- setof(X/Y,sobre(X,Y),Z).
% ------------------------------------------------------------------------------

% -- limpio/1(?Cubo): el Cubo no tiene nada sobre él
%       Cubo: átomo

limpio(a).     % Sobre a no hay nada.
limpio(d).     % Sobre d no hay nada.

% 3. Métodos para conocer el estado del mundo
%
%      El método principal es un predicado estado/1, que devuelve construye y
%      devuelve una descripción del estado presente del mundo.

% -- estado/1(-E): E es una lista que contiene todos los hechos de los
%       predicados sobre/2 y limpio/1.
%       E: variable libre

estado(E) :-
   setof(cubo(B),cubo(B),C),
   setof(sobre(X,Y),sobre(X,Y),S),
   setof(limpio(Z),limpio(Z),L),
   append(C,S,CS), append(CS,L,E).

% ------------------------------------------------------------------------------
% Ejercicio 3: El contenido de la base de conocimientos (hechos).
%
% Pruebe en Prolog las preguntas siguientes:
%
% ?- setof(cubo(B),cubo(B),C).
% ?- setof(sobre(X,Y),sobre(X,Y),S).
% ?- setof(limpio(B),limpio(B),C).
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Ejercicio 4: El predicado primitivo append/3 (concatenación de listas)
% Pruebe en Prolog las preguntas siguientes. En cada caso, obligue al intérprete
%
% Pruebe en Prolog las preguntas siguientes. En cada caso, obligue al intérprete
% al "backtracking", hasta que no haya más respuestas.
%
% ?- append([a,b,c],[d,e],Z).
% ?- append(X,[d,e],[a,b,c,d,e]).
% ?- append([a,b,c],Y,[a,b,c,d,e]).
% ?- append(X,Y,[a,b,c,d,e]).
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Ejercicio 5: Concatenación de dos listas
%
% Programe el predicado append, llámelo concatena/3, que reciba dos listas L1 y
% L2 y devuelva en L3 la concatenación de ambas. Defina el predicado como sigue:
%
% * Regla 1: si la primera lista es vacía, la concatenación es la segunda.
%
% * Regla 2 (en otro caso): sean X la cabeza y XC la cola de la primera lista;
%   Y la 2da. lista; y Z la cabeza y ZC la cola de la concatenación. Z es la
%   concatenación de X y Y si ZC es la concatenación de XC y Y.
%
% -- concatena/3(+L1,+L2,-L3): L3 resulta de concatenar L1 y L2
%       L1, L2: listas
%       L3: variable libre

%%% concatena(L1,L2,L3) :- ..
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Ejercicio 6: Prueba de concatena/3
%
% Pruebe su predicado con las mismas consultas del ejercicio anterior, para
% asegurarse que se comportamiento es igual al de append/3:
%
% ?- concatena([a,b,c],[d,e],Z).
% ?- concatena(X,[d,e],[a,b,c,d,e]).
% ?- concatena([a,b,c],Y,[a,b,c,d,e]).
% ?- concatena(X,Y,[a,b,c,d,e]).
% ------------------------------------------------------------------------------

% 4. Métodos para modificar el estado del mundo

% ------------------------------------------------------------------------------
% Ejercicio 7: limpia/1
%
% limpia(+C)/1: lleva a cabo las acciones necesarias para que el cubo C quede
%    limpio; esas acciones consisten en bajar a la mesa, uno a uno, a los cubos
%    que están encima de C, desde el primero de la columna hasta el que está
%    sobre C

limpia(C) :- limpio(C).  % Si ya está limpio, no se hace nada.
limpia(C) :- sobre(X,C), % En caso contrario, se determina qué cubo está sobre C
             limpia(X),  % y se limpia, y luego...
             retract(sobre(X,C)), assert(sobre(X,mesa)), assert(limpia(C)). % se baja a la mesa

% Pruebe este predicado con la pregunta siguiente:
%
% ?- limpia(c). % esto deja a los cubos a y b sobre la mesa.
%
% Para ver el resultado, haga las preguntas siguientes:
%
% ?- setof(sobre(X,Y),sobre(X,Y),S).
% ?- setof(limpio(B),limpio(B),C).
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Ejercicio 8: Programe el predicado encima/2 que se describe a continuación:
%
% -- encima/2(+C,-L): L es la lista de cubos que entán encima del cubo C. Por
%       ejemplo, en el estado inicial del ejemplo: encima(c,[a,b]).
%
%%% encima(C,L) :- ..
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Ejercicio 9: Programe el predicado mueve/2 que se describe a continuación:
%
% -- mueve/2(+X,+Y,-L): L es una lista (secuencia) de acciones que cambian el
%       estado del mundo para que se cumpla sobre(X,Y)
%       X, Y: átomos
%       L: variable libre
%
%       Notas:
%       * Note que mueve/2 no modifica el estado del mundo, sino que construye
%         una lista de las acciones para modificarlo.
%       * mueve/2 debe llamar primero a estado/1 para conocer el estado presente
%         y a partir de ahí construir la lista L de acciones para lograr
%         sobre(X,Y).

%%% mueve(X,Y,L) :- ..
% ------------------------------------------------------------------------------
