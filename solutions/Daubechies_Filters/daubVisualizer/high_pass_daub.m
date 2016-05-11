% Created by Richard Shen
% DSP II
function [hh, hb, HHf] = high_pass_daub(length)

    om = linspace(-pi, pi, 201);
    j = sqrt(-1);
    a = 1;
    l = [1 1];
    
    if length == 4;
        % K = 4, Q(z)(1 + z)^4
        r = conv(l, l);
        r = conv(r, r); % LENGTH 4

        % From the notes, we want the matrix A to be solved:
        A = [4 1 0 0; ...
            4 6 4 1; ...
            0 1 4 0];

        B = rref(A);  % Solutions are in the last column
        q = [B(1,4) B(2,4) B(3,4)];

        p = conv(q, r);

        % SPECTRAL FACTORIZATION
        s = seprts(p);
        h1 = poly(s);
        h1 = real(h1);   
        h1 = h1*sqrt(max(p)/sum(abs(h1).^2));  % filter
        
        % HIGH PASS DAUBECHIES FILTERS (time reverse and modulate)

        % TIME REVERSE
        hh = fliplr(h1);
        
        % MODULATE
        hh(1,1) = -1*hh(1,1);
        hh(1,3) = -1*hh(1,3);
        
        hh
        hb = hh
        HHf = polyval(hb, exp(j*om)) ./ polyval(a, exp(j*om))
    elseif length == 6;
        % K = 6, Q(z)(1 + z)^6

        r = conv(l,l);
        r = conv(r,l);
        r = conv(r,r); % LENGTH 6

        % From the notes, our A matrix is:
        A = [6 1 0 0 0 0; ...
            20 15 6 1 0 0; ...
            6 15 20 15 6 1; ...
            0 1 6 15 20 0; ...
            0 0 0 1 6 0];

        B = rref(A);
        q = [B(1,6) B(2,6) B(3,6) B(4,6) B(5,6)];
        p = conv(q, r);

        % SPECTRAL FACTORIZATION
        s = seprts(p);
        h1 = poly(s);
        h1 = real(h1);     
        h1 = h1*sqrt(max(p)/sum(abs(h1).^2));  % filter
        
        % HIGH PASS DAUBECHIES FILTERS (time reverse and modulate)

        % TIME REVERSE
        hh = fliplr(h1);
        
        % MODULATE
        hh(1,1) = -1*hh(1,1);
        hh(1,3) = -1*hh(1,3);
        hh(1,5) = -1*hh(1,5);
        
        hh
        hb = hh
        HHf = polyval(hb, exp(j*om)) ./ polyval(a, exp(j*om))      
        
    elseif length == 8;
        % K = 8, Q(z)(1 + z)^8
        r = conv(l, l);
        r = conv(r, r); 
        r = conv(r, r); % LENGTH 8

        % From the notes, our A matrix is:
        A = [8 1 0 0 0 0 0 0; ...
            56 28 8 1 0 0 0 0; ...
            56 70 56 28 8 1 0 0; ...
            8 28 56 70 56 288 8 1; ...
            0 1 8 28 56 70 56 0; ...
            0 0 0 1 8 28 56 0; ...
            0 0 0 0 0 1 8 0];

        B = rref(A);
        q = [B(1,8) B(2,8) B(3,8) B(4,8) B(5,8) B(6,8) B(7,8)];
        p = conv(q, r);

        % SPECTRAL FACTORIZATION
        s = seprts(p);
        h1 = poly(s);
        h1 = real(h1);
        
        h1 = h1*sqrt(max(p)/sum(abs(h1).^2));  % filter
        
        % HIGH PASS DAUBECHIES FILTERS (time reverse and modulate)

        % TIME REVERSE
        hh = fliplr(h1);
        
        % MODULATE
        hh(1,1) = -1*hh(1,1);
        hh(1,3) = -1*hh(1,3);
        hh(1,5) = -1*hh(1,5);
        hh(1,7) = -1*hh(1,7);
        
        hh
        hb = hh
        HHf = polyval(hb, exp(j*om)) ./ polyval(a, exp(j*om)) 
    end
end