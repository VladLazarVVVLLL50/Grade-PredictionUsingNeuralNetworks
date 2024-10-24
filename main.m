clc
clear 

%% CITIREA SI PREPROCESAREA DATELOR
fisier = 'student-por.csv'; 
[date_antrenare, date_testare, nr_exemple_antrenare] = preprocesare_date(fisier);

%% IMPLEMENTAREA METODEI GRADIENT

% Definirea parametrilor pentru metoda gradient
A = table2array(date_antrenare(:, 1:32)); 
A = [A, ones(size(A, 1), 1)];  
e = table2array(date_antrenare(:, 33));
n = 32; % nr. de caracteristici ale unei date de intrare
m = 20; % nr. de neuroni din hidden layer
rata_de_invatare = 0.0001;
max_iter = 10000;
prag_gradient = 1e-6;

[X, x_star, errors, norms, times] = metoda_gradient(A, e, n, m, rata_de_invatare, max_iter, prag_gradient);

% Graficele

cumulative_times = zeros(1, max_iter);


for i = 1:max_iter
    cumulative_times(i) = sum(times(1:i));
end

figure('Name', 'Metoda Gradient');
subplot(4, 1, 1);
semilogx(1:max_iter, errors, 'black');
title('Eroarea dupa Iteratii');
xlabel('Iteratii');
ylabel('Error');

subplot(4, 1, 2);
semilogx(1:max_iter, norms, 'black');
title('Norma dupa Iteratii');
xlabel('Iteratii');
ylabel('Norma');

subplot(4, 1, 3);
semilogx(cumulative_times, errors, 'black'); 
title('Eroarea dupa Timp');
xlabel('Timp (s)');
ylabel('Error');

subplot(4, 1, 4);
semilogx(cumulative_times, norms, 'black'); 
title('Norma dupa Timp');
xlabel('Timp (s)');
ylabel('Norma');


%Testarea
A_testare = table2array(date_testare(:, 1:32)); 
A_testare = [A_testare, ones(size(A_testare, 1), 1)];  
e_testare = table2array(date_testare(:, 33));

output_ul = softsign(A_testare * X) * x_star;

combined_vectors = horzcat(e_testare, output_ul);
disp(combined_vectors);

mse = mean((output_ul - e_testare).^2);
disp(['Mean Square Error pentru Metoda Gradient: ', num2str(mse)]);


%% IMPLEMENTAREA METODEI GRADIENT STOCHASTICE

% Definirea parametrilor pentru metoda gradient stochastic
A = table2array(date_antrenare(:, 1:32)); 
A = [A, ones(size(A, 1), 1)];  
e = table2array(date_antrenare(:, 33));
n = 32; % nr. de caracteristici ale unei date de intrare
m = 20; % nr. de neuroni din hidden layer
nr_exemple = 5; % nr de exemple de ales aleatoroiu in met. grad. stochastice
rata_de_invatare = 0.0001;
max_iter = 100000; % iteratiile sunt mai "ieftine" putem mari numarul
prag_gradient = 1e-6;

[X, x_star, errors, norms, times] = metoda_gradient_stochastic(A, e, n, m, rata_de_invatare, max_iter, prag_gradient, nr_exemple);

% Graficele
cumulative_times = zeros(1, max_iter);


for i = 1:max_iter
    cumulative_times(i) = sum(times(1:i));
end

figure('Name', 'Metoda Gradient Stochastic');
subplot(4, 1, 1);
semilogx(1:max_iter, errors, 'black');
title('Eroarea dupa Iteratii');
xlabel('Iteratii');
ylabel('Error');

subplot(4, 1, 2);
semilogx(1:max_iter, norms, 'black');
title('Norma dupa Iteratii');
xlabel('Iteratii');
ylabel('Norma');

subplot(4, 1, 3);
semilogx(cumulative_times, errors, 'black'); 
title('Eroarea dupa Timp');
xlabel('Timp (s)');
ylabel('Error');

subplot(4, 1, 4);
semilogx(cumulative_times, norms, 'black'); 
title('Norma dupa Timp');
xlabel('Timp (s)');
ylabel('Norma');


%Testarea
A_testare = table2array(date_testare(:, 1:32)); 
A_testare = [A_testare, ones(size(A_testare, 1), 1)];  
e_testare = table2array(date_testare(:, 33));

output_ul = softsign(A_testare * X) * x_star;

combined_vectors = horzcat(e_testare, output_ul);
disp(combined_vectors);

mse = mean((output_ul - e_testare).^2);
disp(['Mean Square Error pentru Metoda Gradient Stochastic: ', num2str(mse)]);


%% IMPLEMENTAREA METODEI GRADIENT ACCELERAT

% Definirea parametrilor pentru metoda gradient accelerat
A = table2array(date_antrenare(:, 1:32)); 
A = [A, ones(size(A, 1), 1)];  
e = table2array(date_antrenare(:, 33));
n = 32; % nr. de caracteristici ale unei date de intrare
m = 20; % nr. de neuroni din hidden layer
rata_de_invatare = 0.0001;
max_iter = 10000;
prag_gradient = 1e-10; % metoda converge mai repede => putem marii precizia
momentum = 0.9;

[X, x_star, errors, norms, times] = metoda_gradient_accelerat(A, e, n, m, rata_de_invatare, max_iter, prag_gradient, momentum);

% Graficele

cumulative_times = zeros(1, max_iter);
for i = 1:max_iter
    cumulative_times(i) = sum(times(1:i));
end

figure('Name', 'Metoda Gradient Accelerat');
subplot(4, 1, 1);
semilogx(1:max_iter, errors, 'black');
title('Eroarea dupa Iteratii');
xlabel('Iteratii');
ylabel('Error');

subplot(4, 1, 2);
semilogx(1:max_iter, norms, 'black');
title('Norma dupa Iteratii');
xlabel('Iteratii');
ylabel('Norma');

subplot(4, 1, 3);
semilogx(cumulative_times, errors, 'black'); 
title('Eroarea dupa Timp');
xlabel('Timp (s)');
ylabel('Error');

subplot(4, 1, 4);
semilogx(cumulative_times, norms, 'black'); 
title('Norma dupa Timp');
xlabel('Timp (s)');
ylabel('Norma');


%Testarea
A_testare = table2array(date_testare(:, 1:32)); 
A_testare = [A_testare, ones(size(A_testare, 1), 1)];  
e_testare = table2array(date_testare(:, 33));

output_ul = softsign(A_testare * X) * x_star;

combined_vectors = horzcat(e_testare, output_ul);
disp(combined_vectors);

mse = mean((output_ul - e_testare).^2);
disp(['Mean Square Error pentru Metoda Gradient Accelerat: ', num2str(mse)]);
