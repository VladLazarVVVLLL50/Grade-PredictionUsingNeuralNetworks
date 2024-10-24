function [X, x_star, errors, norms, times] = metoda_gradient_stochastic(A, e, n, m, rata_de_invatare, max_iter, prag_gradient, nr_exemple)

     %Initializare parametrii
   N = size(A, 1);
    X = randn(n + 1, m);   
    x_star = randn(m, 1); 
    iter = 0;
    norma_gradient = inf;

    % Definirea vectorilor pentru stocarea erorii, normei și timpului
    errors = zeros(1, max_iter);
    norms = zeros(1, max_iter);
    times = zeros(1, max_iter);

    % Bucla pt. metoda gradient stochastic
    while iter < max_iter && norma_gradient > prag_gradient

        iter = iter + 1;
        tic;

        % Alegem elementele pt. gradient aleatoriu
        idx = randperm(N, nr_exemple);

        % Forward propagation
        hidden_output = softsign(A(idx, :) * X);
        predicted_output = hidden_output * x_star;

        % Calculam eroarea
        error = predicted_output - e(idx);    

        % Calculam gradientii
        dL_dX = zeros(size(X));
        dL_dx_star = zeros(size(x_star));

        hidden_output_derivat = softsign_derivat(A(idx, :) * X);
        for j = 1 : m
            dL_dx_star(j) = 1/nr_exemple * sum(error .* hidden_output(:, j));
            for k = 1 : n+1
                dL_dX(k,j) = 1/nr_exemple *  sum(error .* hidden_output_derivat(:, j) .* x_star(j) .* A(idx, k));
            end
        end

        % Calculate gradient norm
        norma_gradient = norm([dL_dX(:); dL_dx_star]);

        % Updatarea parametrilor 
        X = X - rata_de_invatare * dL_dX;
        x_star = x_star - rata_de_invatare * dL_dx_star;

        % Stocarea timpului
        times(iter) = toc;

        % Stocarea erorii si normei
        errors(iter) = sum(error.^2) / 2;
        norms(iter) = norma_gradient;

        % Afisare progres
        if mod(iter, 10000) == 0
            fprintf('Iteratia: %d: Error = %f, Norma Gradient = %f\n', iter, errors(iter), norma_gradient);
        end
    end

end
