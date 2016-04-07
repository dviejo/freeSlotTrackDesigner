/**

Cuenta vueltas y stop n' go

Se dispone de un biestable, creado con un 555, por carril que mantendra su salida 
a nivel alto cuando el puente detecte el paso de un coche por ese carril. El procesador
sera el encargado de volver a poner el biestable a nivel bajo.

Por cada carril 
  Monitorizamos un pin digital cada ciclo de reloj
  Si ese pin tiene nivel alto, se detecta el paso de un coche
    Se calcula el tiempo de vuelta
    Si el tiempo de vuelta es mayor que el tiempo minimo
      Se incrementa el numero de vueltas
      Se apunta/muestra el tiempo de vuelta
    Se pone a nivel bajo un pin digital (pinReset) para resetear el biestable a nivel bajo
    Se inicializa contadorReset para volver a poner a nivel alto pinReset 
  Si contadorReset>0
    contadorReset--;
    Si contadorReset==0
      Poner a nivel alto pinReset
