function b=flipSpins(a,i,j)
    b=a;
    b(i)=a(j);
    b(j)=a(i);
    b=bin2dec(num2str(b));
end