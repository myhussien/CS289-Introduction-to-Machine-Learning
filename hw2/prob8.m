a=0;
for i=0:24
    for j=0:i
        a=a+exp(-20)*10^i/factorial(j)/factorial(i-j);
    end
end
b=0;
for i=0:24
    for j=0:i
        b=b+exp(-30)*15^i/factorial(j)/factorial(i-j);
    end
end
c=1-b;
PE=0.5*(1-a)+0.5*(1-c);