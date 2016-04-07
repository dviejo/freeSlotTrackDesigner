/*

Cuenta vueltas y stop n' go

======================================================
STOP 'N' GO
======================================================

======================================================
CONFIGURACION
======================================================
Botones del aparato
  Boton Start
  Boton Avanza >>
  Boton Retrocede <<
  Boton Set
  
  Al menu de configuracion se podra acceder pulsando el boton set cuando no haya una
  carrera en marcha desde los modos de velocidad y rally. Cada modo tendra opciones 
  de configuracion diferentes.
  Configuracion modo velocidad
    Se establece el tiempo de carrera (por defecto 5'00'')
    Cada pulsacion a >> añade 1 segundo al tiempo de carrera
    Cada pulsacion a << resta 1 segundo al tiempo de carrera
    Si los botones >> y << se mantienen pulsados continuamente los incrementos/decrementos
    seran mayores
  Configuracion modo rally
    Se establece el numero de vueltas a completar (por defecto 5)
    Cada pulsacion a >> añade 1 vuelta a la carrera
    Cada pulsacion a << resta 1 vuelta a la carrera
  Para salir del modo de configuracion se pulsara el boton Set
  


======================================================
MODOS DE CARRERA
======================================================
Para cambiar de modo de carrera utilizaremos los botones >> << En secuencia:
  Entrenamiento <-> Velocidad <-> Rally <-> Entrenamiento
Solo se podra cambiar de modo si no se esta en mitad de una carrera

CARRERA POR TIEMPO (MODO VELOCIDAD)
  Se establece un tiempo de carrera
  Se pulsa el boton Start
  La corriente de la pista se activa 
  se activa el procedimiento de salida (semaforo)
  Se inicia el contador del tiempo de carrera
  Se contabilizan las vueltas y los dos mejores tiempos por vuelta de cada pista
  Cuando el tiempo llega a cero, la carrera termina y se corta la corriente
  La pulsacion del boton start durante carrera da comienzo al procedimiento de pausa:
    Se corta corriente
    Se detienen los contadores de tiempo
    Tras 2 segundos, se dejan de contabilizar vueltas
    La corriente y la carrera se reanudan al volver a pulsar start
    La carrera se aborta al pulsar set
  
CARRERA POR VUELTAS (MODO RALLY)
  Se establece un numero de vueltas a completar
  Se pulsa el boton Start
  La corriente de la pista se activa
  Se activa el procedimiento de salida (semaforo)
  Se inicia un contador de tiempo
  Cuando algun participante alcanza el numero de vueltas
    Se contabiliza el tiempo total empleado
    Se corta corriente
  La pulsacion del boton start durante carrera aborta la carrera. Se corta la corriente
    
ENTRENAMIENTO
  Modo de funcionamiento por defecto
  Se inicia con el contador de vueltas a cero
  Se contabilizan las vueltas y los dos mejores tiempos de vuelta por cada pista
  La pulsacion del boton start durante el entrenamiento reinicia las vueltas y los tiempos


======================================================
CUENTA VUELTAS
======================================================

Se dispone de un biestable, creado con un 555, por carril que mantendra su salida 
a nivel alto cuando el puente detecte el paso de un coche por ese carril. El procesador
sera el encargado de volver a poner el biestable a nivel bajo.

finDeCarrera = false;
mientras no finDeCarrera
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
  Si se cumple condicion de finalDeCarrera
    finDeCarrera = true;
  Si no
    se actualiza estado de carrera (si es necesario)
Emitir señal acustica de final
Cortar corriente en la pista activando/desactivando pinPower
*/

#include <LiquidCrystal.h>


// Modos de funcionamiento
#define MODO_ENTRENAMIENTO 0
#define MODO_VELOCIDAD 1
#define MODO_RALLY 2

int modoFuncionamiento;

// Configuracion
#define LAPS_DEFAULT 5
#define TIME_DEFAULT 300 //in seconds

int maxLaps;
int maxTime;

//variables de carrera
#define MAX_TIME 999999999999

int lapCounter1;
long int bestTime1; //milliseconds
long int secondTime1; //milliseconds
int lapCounter2;
long int bestTime2; //milliseconds
long int secondTime2; //milliseconds
int running;

LiquidCrystal lcd(12, 11, 7, 6, 5, 4);

void setup()
{
  modoFuncionamiento = MODO_ENTRENAMIENTO;
  
  maxLaps = LAPS_DEFAULT;
  maxTime = TIME_DEFAULT;
  
  resetRaceStatus();  
  running = false;
  
  lcd.begin(20, 4);
  lcd.print("Lap Counter")
  
  delay(1000);
}

void loop()
{
}

void resetRaceStatus()
{
  lapCounter1 = lapCounter2 = 0;
  
  bestTime1 = bestTime2 = secondTime1 = secondTime2 = MAX_TIME;
}
