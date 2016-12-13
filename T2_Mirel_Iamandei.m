P=40;    %perioada
D=12;    %durata semnalului
N=50;    %numarul de coeficienti
w0=2*pi/P; %pulsatia
t_tr=0:0.02:D;
x_tr= sawtooth((pi/12)*t_tr,0.5)/2+0.5;   %semnal triunghiular
t = 0:0.02:P; 
x = zeros(1,length(t));             
x(t<=D)=x_tr;                             %semnal reconstruit
figure(1); 
plot(t,x); 
title('x(t)(linie solida) si semnalul reconstruit folosind N coeficienti (linie punctata)');
hold on;


for k=-N:N
    x_t = x_tr;
    x_t = x_t .* exp(-j*k*w0*t_tr);                                      %coeficienti SFE
    X(k+51)=0; 
    for i = 1: length(t_tr)-1
        X(k+51) = X(k+51) + (t_tr(i+1)-t_tr(i))* (x_t(i)+x_t(i+1))/2; 
    end
end
    


for i = 1: length(t)
    x_finit(i) = 0;
    for k=-N:N
        x_finit(i) = x_finit(i) + (1/P)*X(k+51)*exp(j*k*w0*t(i));            
    end
end
plot(t,x_finit,'--');                                                     %spectru amplitudini
figure(2);
w=-N*w0:w0:N*w0; 
stem(w/(2*pi),abs(X));      
% Teoria seriilor Fourier spune ca orice semnal periodic poate fi aproximat printr-o suma infinita de sinusuri si
% cosinusuri de diferite frecvente,fiecare avand un anumit coeficient. Acesti coeficienti reprezinta spectrul de amplitudini.
% Semnalul reconstruit folosind un numar finit de termeni se apropie ca  forma de semnalul original cu o anumita marja de eroare. 
% In plus se observa faptul ca semnalul poate fi aproximat printr-o suma de sinusoide(variatiile semnalului au un caracter de sinusoida).