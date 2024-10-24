function output = softsign(z)
    output = z ./ (1 + abs(z));
end