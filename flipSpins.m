function b=flipSpins(a,i,j)
    b=zeros(1,length(a));
    for n=1:length(a)
        if n==i
            b(n)=a(j);
        elseif n==j
            b(n)=a(i);
        else
            b(n)=a(n);
        end
    end
    b=bin2dec(num2str(b));
end