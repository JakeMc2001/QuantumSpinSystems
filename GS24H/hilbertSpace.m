% function takes the value of spin S to determine the matrices Sx Sy and Sz
% in the Sz-basis
function [Sx, Sy, Sz] = hilbertSpace(S)
    % calculate Hilbert space size
    size = 2*S +1;
    % initialise Sz, S+ and S- matrices
    Sz = zeros(size,size);
    Sp = zeros(size,size);
    Sm = zeros(size,size);
    mList=S:-1:-S;
    % loop through the rows and columns to find elements where the value of
    % an operator should be non-zero
    for column=1:size
        M = mList(column);
        for row=1:size
            rowM = mList(row);
            if row==column
                %using relation Sz|S,M>=M|S,M>
                Sz(row,column)=M;
            elseif M+1==rowM
                %equation for finding element of S+ (Sp) matrix
                Sp(row,column)=sqrt(S*(S+1) - M*(M+1));
            elseif M-1==rowM
                %equation for finding element of S- (Sm) matrix
                Sm(row,column)=sqrt(S*(S+1) - M*(M-1));
            end
        end
    end
    %relations to find Sx and Sy matrices from S+ (Sp) and S- (Sm)
    Sx=(Sp+Sm)/2;
    Sy=(Sp-Sm)/2i;
end