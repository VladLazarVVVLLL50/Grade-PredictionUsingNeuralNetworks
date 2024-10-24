function [date_antrenare, date_testare, nr_exemple_antrenare] = preprocesare_date(fisier)

% Incarcam baza de date 
baza_de_date = readtable(fisier);

% Codificarea caracteristicilor non-numerice în format numeric

% school: Convertim "GP" în 0 și "MS" în 1
baza_de_date.school = categorical(baza_de_date.school);
baza_de_date.school = double(baza_de_date.school == 'MS');

% sex: Convertim "F" în 0 și "M" în 1
baza_de_date.sex = categorical(baza_de_date.sex);
baza_de_date.sex = double(baza_de_date.sex == 'M');

% address: Convertim "U" în 0 și "R" în 1
baza_de_date.address = categorical(baza_de_date.address);
baza_de_date.address = double(baza_de_date.address == 'R');

% famsize: Convertim "LE3" în 0 și "GT3" în 1
baza_de_date.famsize = categorical(baza_de_date.famsize);
baza_de_date.famsize = double(baza_de_date.famsize == 'GT3');

% Pstatus: Convertim "T" în 0 și "A" în 1
baza_de_date.Pstatus = categorical(baza_de_date.Pstatus);
baza_de_date.Pstatus = double(baza_de_date.Pstatus == 'A');

% Mjob și Fjob: Codificăm cu label encoding
baza_de_date.Mjob = categorical(baza_de_date.Mjob);
baza_de_date.Mjob = double(baza_de_date.Mjob);

baza_de_date.Fjob = categorical(baza_de_date.Fjob);
baza_de_date.Fjob = double(baza_de_date.Fjob);

% reason și guardian: Codificăm cu label encoding
baza_de_date.reason = categorical(baza_de_date.reason);
baza_de_date.reason = double(baza_de_date.reason);

baza_de_date.guardian = categorical(baza_de_date.guardian);
baza_de_date.guardian = double(baza_de_date.guardian);

% schoolsup, famsup, paid, activities, nursery, higher, internet, romantic: Convertim "no" în 0 și "yes" în 1
variabile_de_convertit = {'schoolsup', 'famsup', 'paid', 'activities', 'nursery', 'higher', 'internet', 'romantic'};
for i = 1 : length(variabile_de_convertit)
    baza_de_date.(variabile_de_convertit{i}) = categorical(baza_de_date.(variabile_de_convertit{i}));
    baza_de_date.(variabile_de_convertit{i}) = double(baza_de_date.(variabile_de_convertit{i}) == 'yes');
end

% Determinam procentul de date pentru antrenare
procent_antrenare = 0.8; % 80% pentru antrenare

% Determinam numarul de exemple
numarul_de_exmeple = size(baza_de_date, 1);

% Determinam numarul de exeple pentru antrenare
nr_exemple_antrenare = floor(procent_antrenare * numarul_de_exmeple);

% Impartim baza de date
date_antrenare = baza_de_date(1:nr_exemple_antrenare, :);
date_testare = baza_de_date(nr_exemple_antrenare+1:end, :);


end