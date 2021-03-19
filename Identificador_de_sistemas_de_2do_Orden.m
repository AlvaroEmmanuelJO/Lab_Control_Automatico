%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Identificador de sistemas de 2do Orden
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%by AlvaroEmmanuelJO, A01632255
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;

%Cargamos los datos de obtenidos en el Experimento
load('MasasLazoAbierto1.mat')

Y_values = Salida.signals.values;
tiempo = Salida.time;

%Graficamos para comparar con el resultado final
plot(tiempo,Y_values);

%Ref = Entrada.signals.valuese(end)
Ref = Entrada.signals.values(end);

%Ts = Tiempo de establecimiento = Val(X) --> cuando Y_values = Ref
%¿En que posicion del arreglo Y_values llega a la Ref?
Find_PosicionTs = find(Y_values == Ref);
%Se crea otro arreglo del cual utilizamos la primera posición
PosicionTs = Find_PosicionTs(1);
%Guardamos el valor de esa posición en el arreglo del tiempo
Ts = tiempo(PosicionTs)-1;

%Tp = Tiempo punto más alto = Val(x) --> cunado Y_values(max)
%¿En que posicion del arreglo Y_values llega al punto MAXIMO?
Y_MAX = max(Y_values);
Find_PosicionTp = find(Y_values == Y_MAX);
PosicionTp = Find_PosicionTp(1);
Tp = tiempo(PosicionTp)-1;
%Utilizamos formulas de control moderno para obtener los valores deseados
Mp = Y_MAX - Ref;
Wd = pi/Tp;
R = (log(Mp)/pi);
syms x;
%Donde x = Delta del sistema
Ecua = ((-x)/(sqrt(1 - (x)^2))) == R;
Delta_sym = vpasolve(Ecua,x);
Delta = double(Delta_sym); 
Wn_sym = Wd/(sqrt(1-Delta^2));
Wn = double(Wn_sym);
A_sym = Wn^2;
B_sym = Delta*Wn*2;
C_sym = A_sym;
%Asignamos los valores de los coeficientes de nuestra TF
A = double(A_sym);
B = double(B_sym);
C = A;
%Sustutuimos los valores en la TF
G = tf([A],[1 B C]);
%Imprimimos la TF
G;

%Note: A las variables Ts & Tp se les resta 1 por que el sistema
%Cambia de estado en el segundo 1