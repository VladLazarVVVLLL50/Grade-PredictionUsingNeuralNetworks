function [X, x_star, errors, norms, times] = metoda_gradient(A, e, n, m, rata_de_invatare, max_iter, prag_gradient)

    % Initializare parametrii
    N = size(A, 1);
    X = randn(n + 1, m);  % marjele pt. conexiunile input-hidden layer 
    x_star = randn(m, 1); % marjele de transfer
    iter = 0;
    norma_gradient = inf;

    % Definirea vectorilor pentru stocarea erorii, normei și timpului
    errors = zeros(1, max_iter);
    norms = zeros(1, max_iter);
    times = zeros(1, max_iter);

    % Bucla pt. metoda gradient
    while iter < max_iter && norma_gradient > prag_gradient

        iter = iter + 1;
        tic;

        %Forward propagation
        hidden_output = softsign(A * X);
        predicted_output = hidden_output * x_star;

        % Calculam eroarea
        error = predicted_output - e;    

        % Calculam gradientul
        dL_dX = zeros(size(X));
        dL_dx_star = zeros(size(x_star));

        hidden_output_derivat = softsign_derivat(A * X); 
        for i = 1 : N
            for j = 1 : m
                dL_dx_star(j) = 1/N * sum(error) * hidden_output(i,j);
                for k = 1 : n+1
                    dL_dX(k,j) = 1/N * sum(error) * (hidden_output_derivat(i,:) * x_star) * A(i,k);
                end
            end
        end

        % Calculam norma gradientului
        norma_gradient = norm([dL_dX(:); dL_dx_star]);

        % Updatarea parametrilor
        X = X - rata_de_invatare * dL_dX;
        x_star = x_star - rata_de_invatare * dL_dx_star;

        % Stocarea timpului
        times(iter) = toc;

        % Stocarea erorii și normei
        errors(iter) = sum(error.^2) / (2 * N);
        norms(iter) = norma_gradient;

        % Afisare progres
        if mod(iter, 1000) == 0
            fprintf('Iteratia: %d: Error = %f, Norma Gradient = %f\n', iter, sum(error.^2) / (2 * N), norma_gradient);
        end
    end

end