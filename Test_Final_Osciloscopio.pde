import processing.serial.*;  // Libreria para el uso del puerto serial

byte[] leer; 

int[] canal;
int [] analog1;     // arreglo respectivo al canal analogico 1
int [] analog2;     // arreglo respectivo al canal analogico 2
int [] digital1;    // arreglo respectivo al canal digital 1
int [] digital2;    // arreglo respectivo al canal digital 2

int i = 0;          // variable de control indicativa de la posicion a llenar de los arreglos
int j = 0;          // variable de control indicativa de los arreglos con data para mostrar 

int ts = 1;         // timescale: 1 = 50ms, 5 = 10ms, 10 = 5ms, 50 = 1ms, 100 = 500us, 500 = 100us, 1000 = 50us
int a1vd = 10;      // analogic 1 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div
int a2vd = 10;      // analogic 2 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div
int d1vd = 10;      // digital 1 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div
int d2vd = 10;      // digital 2 voltage/division: 20 = 0.5V/div, 10 = 1V/div, 5 = 2V/div, 2 = 5V/div

int CA1BX, CA1BY;      // Posiciones del boton del canal Analogico 1
int CA2BX, CA2BY;      // Posiciones del boton del canal Analogico 2
int CD1BX, CD1BY;      // Posiciones del boton del canal Digital 1
int CD2BX, CD2BY;      // Posiciones del boton del canal Digital 2

int VD1BX, VD1BY;      // Posiciones del boton de volt/div 1
int VD2BX, VD2BY;      // Posiciones del boton de volt/div 2
int VD3BX, VD3BY;      // Posiciones del boton de volt/div 3
int VD4BX, VD4BY;      // Posiciones del boton de volt/div 4

int TDBX, TDBY;        // Posiciones del boton de time/div 1

int CHBSize = 45;      // Tamaño del boton CH
int VDBSize = 45;      // Tamaño del boton VD
int TDBSize = 45;      // Tamaño del boton TD

color CA1Color, CA2Color, CD1Color, CD2Color, VD_A1Color, VD_A2Color, VD_D1Color, VD_D2Color, TDColor, baseColor;
color CH_Highlight;           // Indicador de estar sobre un boton
color currentColor;

boolean CA1Over = false;      // booleano indicativo de si el puntero se encuentra sobre el boton del canal analogico 1
boolean CA2Over = false;      // booleano indicativo de si el puntero se encuentra sobre el boton del canal analogico 2
boolean CD1Over = false;      // booleano indicativo de si el puntero se encuentra sobre el boton del canal digital 1
boolean CD2Over = false;      // booleano indicativo de si el puntero se encuentra sobre el boton del canal digital 2

boolean VD_A1Over = false;    // booleano indicativo de si el puntero se encuentra sobre el boton de volt/div del canal analogico 1
boolean VD_A2Over = false;    // booleano indicativo de si el puntero se encuentra sobre el boton de volt/div del canal analogico 2
boolean VD_D1Over = false;    // booleano indicativo de si el puntero se encuentra sobre el boton de volt/div del canal digital 1
boolean VD_D2Over = false;    // booleano indicativo de si el puntero se encuentra sobre el boton de volt/div del canal digital 2

boolean TDOver = false;      // booleano indicativo de si el puntero se encuentra sobre el boton de time/div 1

boolean CA1ON = false;        // booleano indicativo del estado de prendido o apagado del canal analogico 1
boolean CA2ON = false;        // booleano indicativo del estado de prendido o apagado del canal analogico 2
boolean CD1ON = false;        // booleano indicativo del estado de prendido o apagado del canal digital 1
boolean CD2ON = false;        // booleano indicativo del estado de prendido o apagado del canal digital 2

PImage screen;

Serial myPort;  // Crea un objeto de clase serial

void setup() {
  size(1280, 800);                   // Tamano de la pantalla que usara el ociloscopio
  background(120);                   // le doy un color al fondo
  
  CA1Color = color(#0E7298);         // Color del boton del canal 1
  CA2Color = color(#0E7298);         // Color del boton del canal 2
  CD1Color = color(#0E7298);         // Color del boton del canal 3
  CD2Color = color(#0E7298);         // Color del boton del canal 4
  VD_A1Color = color(#0E7298);       // Color del boton del Volt/Div 1
  VD_A2Color = color(#0E7298);       // Color del boton del Volt/Div 2
  VD_D1Color = color(#0E7298);       // Color del boton del Volt/Div 3
  VD_D2Color = color(#0E7298);       // Color del boton del Volt/Div 4
  TDColor = color(#0E7298);          // Color del boton del Time/Div 1
  
  CH_Highlight = color(#56536C);       // Indicador de posicion sobre uno de los botones
  CA1BX = 1050;                   // Posicion X del CH1B
  CA1BY = 600;                    // Posicion Y del CH1B
  CA2BX = 1100;                   // Posicion X del CH2B
  CA2BY = 600;                    // Posicion Y del CH2B
  CD1BX = 1150;                   // Posicion X del CH3B
  CD1BY = 600;                    // Posicion Y del CH3B
  CD2BX = 1200;                   // Posicion X del CH4B
  CD2BY = 600;                    // Posicion Y del CH4B 
  VD1BX = 1050;                   // Posicion X del VD1B
  VD1BY = 500;                    // Posicion Y del VD1B
  VD2BX = 1100;                   // Posicion X del VD2B
  VD2BY = 500;                    // Posicion Y del VD2B
  VD3BX = 1150;                   // Posicion X del VD3B
  VD3BY = 500;                    // Posicion Y del VD3B
  VD4BX = 1200;                   // Posicion X del VD4B
  VD4BY = 500;                    // Posicion Y del VD4B
  TDBX = 1125;                    // Posicion X del TD1B
  TDBY = 700;                     // Posicion Y del TD1B
  
  background(#7F7B93);            // Color del tablero de botones

  textSize(15);
  fill(#080808);
  text("CH1",1035,650);
  fill(#080808);
  text("CH2",1085,650);
  fill(#080808);
  text("CH3",1135,650);
  fill(#080808);
  text("CH4",1185,650);
  fill(#080808);
  text("V/D1",1030,550);
  fill(#080808);
  text("V/D2",1080,550);
  fill(#080808);
  text("V/D3",1130,550);
  fill(#080808);
  text("V/D4",1180,550);
  fill(#080808);
  text("T/D",1110,750);
  
  pantalla();
  screen = get(0,0,1010,800);
  
  ellipseMode(CENTER); 
  
  leer = new byte[4];  
  canal = new int[4];
  analog1 = new int[1000];
  analog2 = new int[1000];
  digital1 = new int[1000];
  digital2 = new int[1000];
  
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  myPort.buffer(400);
  image(screen,0,0);
}

void draw() {
  
  Estatus_botones_puntero();
  
  if (j == 1){
    
    image(screen,0,0);            // Limpia la pantalla
    
    Estatus_escalas();
    
    if(CA1ON == true)
      Analog1();
      
    if(CA2ON == true)  
      Analog2();
      
    if(CD1ON == true)  
      Digital1();
      
    if(CD2ON == true)  
      Digital2();      
      
   // myPort.clear();               // Limpieza del buffer del puerto serial
    i = 0;                        // Reset de los arreglos que guardan los datos desempaquetados
    j = 0;                        // Variable de control que activa la recepcion de datos y deshabilita la opcion de graficar
    
  }
  
}

/////////////// Funciones ///////////////////

void mousePressed() {             // Funcion que comprueba que boton ha sido presionado y su efecto
  
  if (CA1Over) {                  // Comprobacion de que el boton del mouse fue presionado encima del boton del canal analogico 1
    if(CA1ON == false) {          // Comprobacion que indica si el canal analogico 1 estaba previamente apagado
      CA1ON = true;               // Activacion del canal analogico 1
    } else {CA1ON = false;}       // Desactivacion del canal analogico 1
  }

  if (CA2Over) {                  // Comprobacion de que el boton del mouse fue presionado encima del boton del canal analogico 2
    if(CA2ON == false) {          // Comprobacion que indica si el canal analogico 2 estaba previamente apagado
      CA2ON = true;               // Activacion del canal analogico 2
    } else {CA2ON = false;}       // Desactivacion del canal analogico 2
  }  
  
  if (CD1Over) {                  // Comprobacion de que el boton del mouse fue presionado encima del boton del canal digital 1
    if(CD1ON == false) {          // Comprobacion que indica si el canal digital 1 estaba previamente apagado
      CD1ON = true;               // Activacion del canal digital 1
    } else {CD1ON = false;}       // Desactivacion del canal digital 1
  }  
 
  if (CD2Over) {                  // Comprobacion de que el boton del mouse fue presionado encima del boton del canal digital 2
    if(CD2ON == false) {          // Comprobacion que indica si el canal digital 2 estaba previamente apagado
      CD2ON = true;               // Activacion del canal digital 2
    } else {CD2ON = false;}       // Desactivacion del canal digital 2
  }  
  
  if (VD_A1Over) {                // Comprobacion de que el boton del mouse fue presionado encima del boton del voltage division del canal analogico 1
    if(CA1ON == true) {           // Comprobacion que indica si el canal analogico 1 esta activo
      if(a1vd == 10)              // Cambio de los valores del voltage division
        a1vd = 5;
      else if (a1vd == 5)
        a1vd = 2;
      else if (a1vd == 2)
        a1vd = 20;  
      else if (a1vd == 20)
        a1vd = 10;      
    } 
  }   
  
  if (VD_A2Over) {                // Comprobacion de que el boton del mouse fue presionado encima del boton del voltage division del canal analogico 2
    if(CA2ON == true) {           // Comprobacion que indica si el canal analogico 1 esta activo
      if(a2vd == 10)              // Cambio de los valores del voltage division
        a2vd = 5;
      else if (a2vd == 5)
        a2vd = 2;
      else if (a2vd == 2)
        a2vd = 20;  
      else if (a2vd == 20)
        a2vd = 10;    
    } 
  }    
  
  if (VD_D1Over) {                // Comprobacion de que el boton del mouse fue presionado encima del boton del voltage division del canal digital 1
    if(CD1ON == true) {           // Comprobacion que indica si el canal digital 1 esta activo
      if(d1vd == 10)              // Cambio de los valores del voltage division
        d1vd = 5;
      else if (d1vd == 5)
        d1vd = 2;
      else if (d1vd == 2)
        d1vd = 20;  
      else if (d1vd == 20)
        d1vd = 10;    
    } 
  }   
  
  if (VD_D2Over) {                // Comprobacion de que el boton del mouse fue presionado encima del boton del voltage division del canal digital 2
    if(CD2ON == true) {           // Comprobacion que indica si el canal digital 2 esta activo
      if(d2vd == 10)              // Cambio de los valores del voltage division
        d2vd = 5;
      else if (d2vd == 5)
        d2vd = 2;
      else if (d2vd == 2)
        d2vd = 20;  
      else if (d2vd == 20)
        d2vd = 10; 
    } 
  }  
  
  if (TDOver) {                   // Comprobacion de que el boton del mouse fue presionado encima del boton del time division
     if(ts == 1)                  // Cambio de los valores del voltage division
        ts = 5;
      else if (ts == 5)
        ts= 10;
      else if (ts == 10)
        ts = 50;  
      else if (ts == 50)
        ts = 100; 
      else if (ts == 100)
        ts = 1;         
  }  
  
}

boolean overCircle(int x, int y, int diameter) {    //  Funcion que le permite identificar si el puntero esta sobre uno de los botones
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
} 

void update(int x, int y) {                      // Funcion que permite comprobar la posicion del puntero del raton respecto al area de los botones
  if ( overCircle(CA1BX, CA1BY, CHBSize) ) {
    CA1Over = true;
    CA2Over = false;
    CD1Over = false;
    CD2Over = false;
    VD_A1Over = false;
    VD_A2Over = false;
    VD_D1Over = false;
    VD_D2Over = false;
    TDOver = false;
       
  } else if ( overCircle(CA2BX, CA2BY, CHBSize) ) {
    CA1Over = false;
    CA2Over = true;
    CD1Over = false;
    CD2Over = false;
    VD_A1Over = false;
    VD_A2Over = false;
    VD_D1Over = false;
    VD_D2Over = false;
    TDOver = false;
    
  } else if ( overCircle(CD1BX, CD1BY, CHBSize) ) {
    CA1Over = false;
    CA2Over = false;
    CD1Over = true;
    CD2Over = false;
    VD_A1Over = false;
    VD_A2Over = false;
    VD_D1Over = false;
    VD_D2Over = false;
    TDOver = false;
    
  } else if ( overCircle(CD2BX, CD2BY, CHBSize) ) {
    CA1Over = false;
    CA2Over = false;
    CD1Over = false;
    CD2Over = true;
    VD_A1Over = false;
    VD_A2Over = false;
    VD_D1Over = false;
    VD_D2Over = false;
    TDOver = false;
    
  } else if ( overCircle(VD1BX, VD1BY, CHBSize) ) {
    CA1Over = false;
    CA2Over = false;
    CD1Over = false;
    CD2Over = false;
    VD_A1Over = true;
    VD_A2Over = false;
    VD_D1Over = false;
    VD_D2Over = false;
    TDOver = false;
    
  } else if ( overCircle(VD2BX, VD2BY, CHBSize) ) {
    CA1Over = false;
    CA2Over = false;
    CD1Over = false;
    CD2Over = false;
    VD_A1Over = false;
    VD_A2Over = true;
    VD_D1Over = false;
    VD_D2Over = false;
    TDOver = false;
    
  } else if ( overCircle(VD3BX, VD3BY, CHBSize) ) {
    CA1Over = false;
    CA2Over = false;
    CD1Over = false;
    CD2Over = false;
    VD_A1Over = false;
    VD_A2Over = false;
    VD_D1Over = true;
    VD_D2Over = false;
    TDOver = false;
    
  } else if ( overCircle(VD4BX, VD4BY, CHBSize) ) {
    CA1Over = false;
    CA2Over = false;
    CD1Over = false;
    CD2Over = false;
    VD_A1Over = false;
    VD_A2Over = false;
    VD_D1Over = false;
    VD_D2Over = true;
    TDOver = false;
    
  } else if ( overCircle(TDBX, TDBY, CHBSize) ) {
    CA1Over = false;
    CA2Over = false;
    CD1Over = false;
    CD2Over = false;
    VD_A1Over = false;
    VD_A2Over = false;
    VD_D1Over = false;
    VD_D2Over = false;
    TDOver = true;
    
  } else {
    CA1Over = CA2Over = CD1Over = CD2Over = VD_A1Over = VD_A2Over = VD_D1Over = VD_D2Over= TDOver = false;
  }
  
}

void Estatus_botones_puntero(){

  update(mouseX, mouseY);       // Comprueba el estado de la posicion del puntero respecto a los botones
  
 // seccion para el dibujo de los botones
  
  if (CA1Over) {
    fill(CH_Highlight);
  } else {
    fill(CA1Color);
  }
  stroke(255);
  ellipse(CA1BX, CA1BY, CHBSize, CHBSize);
  
  if (CA2Over) {
    fill(CH_Highlight);
  } else {
    fill(CA2Color);
  }
  stroke(255);
  ellipse(CA2BX, CA2BY, CHBSize, CHBSize);
  
    if (CD1Over) {
    fill(CH_Highlight);
  } else {
    fill(CD1Color);
  }
  stroke(255);
  ellipse(CD1BX, CD1BY, CHBSize, CHBSize);
  
  if (CD2Over) {
    fill(CH_Highlight);
  } else {
    fill(CD2Color);
  }
  stroke(255);
  ellipse(CD2BX, CD2BY, CHBSize, CHBSize);
  
    if (VD_A1Over) {
    fill(CH_Highlight);
  } else {
    fill(VD_A1Color);
  }
  stroke(255);
  ellipse(VD1BX, VD1BY, VDBSize, VDBSize);
  
    if (VD_A2Over) {
    fill(CH_Highlight);
  } else {
    fill(VD_A2Color);
  }
  stroke(255);
  ellipse(VD2BX, VD2BY, VDBSize, VDBSize);
  
    if (VD_D1Over) {
    fill(CH_Highlight);
  } else {
    fill(VD_D1Color);
  }
  stroke(255);
  ellipse(VD3BX, VD3BY, VDBSize, VDBSize);
  
    if (VD_D2Over) {
    fill(CH_Highlight);
  } else {
    fill(VD_D2Color);
  }
  stroke(255);
  ellipse(VD4BX, VD4BY, VDBSize, VDBSize);
  
    if (TDOver) {
    fill(CH_Highlight);
  } else {
    fill(TDColor);
  }
  stroke(255);
  ellipse(TDBX, TDBY, TDBSize, TDBSize);

}

void Estatus_escalas(){   // Funciones que ponen en pantalla el valor de las escalas de tiempo y voltaje de los canales activos
    
    textSize(20);
  
    fill(255);
    text("Time:",20,740);
    
    if(ts == 1)
      text(ts*50+"ms",20,765);
    if(ts == 5)
      text(ts*2+"ms",20,765);
    if(ts == 10)
      text(ts/2+"ms",20,765);
    if(ts == 50)
      text(ts/50+"ms",20,765);
    if(ts == 100)
      text(ts*5+"us",20,765);
      
    fill(200,0,0);
    text("CH1:",120,740);
    
    if(CA1ON == false)
      text("OFF",120,765);
    if(CA1ON == true && a1vd == 10)
      text("1V/Div",120,765);
    if(CA1ON == true && a1vd == 5)
      text("2V/Div",120,765);
    if(CA1ON == true && a1vd == 2)
      text("5V/Div",120,765);
    if(CA1ON == true && a1vd == 20)
      text("0.5V/Div",120,765); 
 
    fill(0,200,0);
    text("CH2:",220,740);      
      
    if(CA2ON == false)
      text("OFF",220,765);
    if(CA2ON == true && a2vd == 10)
      text("1V/Div",220,765);
    if(CA2ON == true && a2vd == 5)
      text("2V/Div",220,765);
    if(CA2ON == true && a2vd == 2)
      text("5V/Div",220,765);
    if(CA2ON == true && a2vd == 20)
      text("0.5V/Div",220,765);      
  
    fill(200,0,200);
    text("CH3:",320,740);      
      
    if(CD1ON == false)
      text("OFF",320,765);
    if(CD1ON == true && d1vd == 10)
      text("1V/Div",320,765);
    if(CD1ON == true && d1vd == 5)
      text("2V/Div",320,765);
    if(CD1ON == true && d1vd == 2)
      text("5V/Div",320,765);
    if(CD1ON == true && d1vd == 20)
      text("0.5V/Div",320,765);  
      
    fill(0,200,200);
    text("CH4:",420,740);      
      
    if(CD2ON == false)
      text("OFF",420,765);
    if(CD2ON == true && d2vd == 10)
      text("1V/Div",420,765);
    if(CD2ON == true && d2vd == 5)
      text("2V/Div",420,765);
    if(CD2ON == true && d2vd == 2)
      text("5V/Div",420,765);
    if(CD2ON == true && d2vd == 20)
      text("0.5V/Div",420,765);       
  
}

void serialEvent(Serial myPort) {

 if ((myPort.available() > 0) && (j == 0)) {
    do {
    leer[0] = byte(myPort.read());
    } while (int(leer[0]) < 127);
    leer[1] = byte(myPort.read());
    leer[2] = byte(myPort.read());
    leer[3] = byte(myPort.read());
 } 
 if (j == 0){
    Desempaquetado();
    print(" ( "+ int(leer[0]) + " "+ int(leer[1]) +" "+ int(leer[2]) +" "+ int(leer[3]) +" ) ");
 } 
 
}

void Desempaquetado() {
  
  int[] aux = new int[2];
  
  aux[0] = int(leer[0]);                 
  aux[0] = int(byte(aux[0]) & byte(63)); 
  aux[0] = int(byte(aux[0]) << byte(6));
  aux[1] = int(leer[1]);
  aux[1] = int(byte(aux[1]) & byte(63));
  canal[0] = (aux[0] + aux[1])/13;       // Canal Analogico 1 Listo
  
  aux[0] = int(leer[2]);
  aux[0] = int(byte(aux[0]) & byte(63));
  aux[0] = int(byte(aux[0]) << byte(6));
  aux[1] = int(leer[3]);
  aux[1] = int(byte(aux[1]) & byte(63));
  canal[1] = (aux[0] + aux[1])/13;      // Canal Analogico 2 Listo
  
  aux[0] = int(leer[0] & byte(64))/64;
  canal[2] = aux[0]*10;                  // Canal Digital 1 listo
  
  aux[0] = int(leer[1] & byte(64))/64;
  canal[3] = aux[0]*10;                  // Canal Digital 2 listo
  
  analog1[i] = canal[0];                 // Guardo los datos desempaquetados en sus respectivas variables para graficar 
  analog2[i] = canal[1]; 
  digital1[i] = canal[2]; 
  digital2[i] = canal[3]; 
  i = i + 1;
  
  if (i > 999) {                         // Condicion que define cuando ya este lleno el vector para graficar
     j = 1;                              // Variable de control que me permite graficar en pantalla los canales activos y detiene la recepcion de datos 
   }
  
}

void Analog1() {
  for (int x = 0; x < 999; x += 1)  {
       stroke(color(200,0,0));
     if (x*ts < 1000)
       line(x*ts, 400 - analog1[x]*a1vd/10, (x+1)*ts, 400 - analog1[(x+1)]*a1vd/10); 
       //point(x*ts, 400 - analog1[x]*a1vd/10);
           }
}

void Analog2() {
  for (int x = 0; x < 999; x += 1)  {
       stroke(color(0,200,0));
     if (x*ts < 1000)
       line(x*ts, 400 - analog2[x]*a2vd/10, (x+1)*ts, 400 - analog2[(x+1)]*a2vd/10); 
       //point(x*ts, 400 - analog2[x]*a1vd/10);
           }
}

void Digital1() {
  for (int x = 0; x < 999; x += 1)  {
       stroke(color(200,0,200));
     if (x*ts < 1000)
       line(x*ts, 400 - digital1[x]*d1vd, (x+1)*ts, 400 - digital1[(x+1)]*d1vd); 
       //point(x*ts, 400 - digital1[x]*a1vd/10);
           }
}

void Digital2() {
  for (int x = 0; x < 999; x += 1)  {
       stroke(color(0,200,200));
     if (x*ts < 1000)
       line(x*ts, 400 - digital2[x]*d2vd, (x+1)*ts, 400 - digital2[(x+1)]*d2vd); 
       //point(x*ts, 400 - digital2[x]*a1vd/10);
           }
}

void pantalla() {
  stroke(255);
  fill(0);
  rect(0,0,1000,800);
  
  for (int y = 0; y <= 800; y += 20) {
    for (int x = 0; x <= 1000; x += 100) {
      stroke(255);
      line(x,y-1,x,y+1);
    }
  } 
  
  for (int y = 0; y <= 800; y += 100) {
    for (int x = 0; x <= 1000; x += 20) {
      stroke(255);
      line(x-1,y,x+1,y);
    }
  } 
  
  for (int y = 0; y < 800; y += 20) {
    for (int x = 0; x < 1000; x += 20)  {
      stroke(255);
      line(495,y,505,y);
      line(x,395,x,405);
      }  
    }
} 
