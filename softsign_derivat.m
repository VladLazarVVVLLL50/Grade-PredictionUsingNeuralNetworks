function y = softsign_derivat(x)
    y = 1 ./ ((1 + abs(x)).^2);
end
