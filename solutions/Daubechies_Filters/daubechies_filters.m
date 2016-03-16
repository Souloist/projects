clear; clc

om = linspace(-pi, pi, 201);
j = sqrt(-1);

% LOW PASS DAUBECHIES FILTERS. K = 4, 6, 8
% K = 4, Q(z)(1 + z)^4

l = [1 1];
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
h1 = h1*sqrt(max(p)/sum(abs(h1).^2))  % filter...?


b1 = h1; a = 1;
Hf = polyval(b1, exp(j*om)) ./ polyval(a, exp(j*om));

figure(1)
subplot(3,1,1);
stem(h1);
title('Impulse Response, LP Length 4')
subplot(3,1,2);
zplane(b1, a);
title('Z Plane, LP Length 4')
subplot(3,1,3);
plot(om/(2*pi), abs(Hf))
title('|H^f(\omega)|, LP Length 4')
xlabel('\omega/(2\pi)')

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
h2 = poly(s);
h2 = real(h2);
h2 = h2*sqrt(max(p)/sum(abs(h2).^2))  % filter...?

b2 = h2; a = 1;
Hf2 = polyval(b2, exp(j*om)) ./ polyval(a, exp(j*om));

figure(2)
subplot(3,1,1);
stem(h2);
title('Impulse Response, LP Length 6')
subplot(3,1,2);
zplane(b2, a);
title('Z Plane, LP Length 6')
subplot(3,1,3);
plot(om/(2*pi), abs(Hf2))
title('|H^f(\omega)|, LP Length 6')
xlabel('\omega/(2\pi)')

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
h3 = poly(s);
h3 = real(h3);
h3 = h3*sqrt(max(p)/sum(abs(h3).^2))  % filter...?

b3 = h3; a = 1;
Hf3 = polyval(b3, exp(j*om)) ./ polyval(a, exp(j*om));

figure(3)
subplot(3,1,1);
stem(h3);
title('Impulse Response, LP Length 8')
subplot(3,1,2);
zplane(b3, a);
title('Z Plane, LP Length 8')
subplot(3,1,3);
plot(om/(2*pi), abs(Hf3))
title('|H^f(\omega)|, LP Length 8')
xlabel('\omega/(2\pi)')


% HIGH PASS DAUBECHIES FILTERS (time reverse and modulate)

% TIME REVERSE
hh = fliplr(h1);
hh2 = fliplr(h2);
hh3 = fliplr(h3);

% MODULATE
hh(1,1) = -1*hh(1,1);
hh(1,3) = -1*hh(1,3);
hh2(1,1) = -1*hh2(1,1);
hh2(1,3) = -1*hh2(1,3);
hh2(1,5) = -1*hh2(1,5);
hh3(1,1) = -1*hh3(1,1);
hh3(1,3) = -1*hh3(1,3);
hh3(1,5) = -1*hh3(1,5);
hh3(1,7) = -1*hh3(1,7);

hh

hb = hh;
HHf = polyval(hb, exp(j*om)) ./ polyval(a, exp(j*om));

figure(4)
subplot(3,1,1);
stem(hh);
title('Impulse Response, HP Length 4')
subplot(3,1,2);
zplane(hb, a);
title('Z Plane, HP Length 4')
subplot(3,1,3);
plot(om/(2*pi), abs(HHf))
title('|H^f(\omega)|, HP Length 4')
xlabel('\omega/(2\pi)')

hh2

hb2 = hh2;
HHf2 = polyval(hb2, exp(j*om)) ./ polyval(a, exp(j*om));

figure(5)
subplot(3,1,1);
stem(hh2);
title('Impulse Response, HP Length 6')
subplot(3,1,2);
zplane(hb2, a);
title('Z Plane, HP Length 6')
subplot(3,1,3);
plot(om/(2*pi), abs(HHf2))
title('|H^f(\omega)|, HP Length 6')
xlabel('\omega/(2\pi)')

hh3

hb3 = hh3;
HHf3 = polyval(hb3, exp(j*om)) ./ polyval(a, exp(j*om));

figure(6)
subplot(3,1,1);
stem(hh3);
title('Impulse Response, HP Length 8')
subplot(3,1,2);
zplane(hb3, a);
title('Z Plane, HP Length 8')
subplot(3,1,3);
plot(om/(2*pi), abs(HHf3))
title('|H^f(\omega)|, HP Length 8')
xlabel('\omega/(2\pi)')
