% checks to see if given parent state is active for the given momentum
% kj = the index value of momentum, k=(kj-1)/2
function isActive=checkParent(N,R,k)
    isActive="false";
    % use periodicity to determine which terms of character table to add
    % calculate sum and determine if parent is active or not
    if R<N && R>0
        % may not be active - must calculate sum
        % determine index of momentum
        %kj=(N/2)*k +1;
        kj=round((N/2)*k +1);
        index=R+1;
        sum=1;
        charTable=CharacterTable(N);
        while index<N
            sum = sum + charTable(kj,index);
            index = index + R;
        end
        if abs(sum) > 10^-4
            isActive="true";
        end
    elseif R==N
        % must be active - sum equals 1
        isActive="true";
    end
end