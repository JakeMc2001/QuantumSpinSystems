% returns arrays of valid parent states 's'
% and their periodicities 'R'
% for given N, mz and k values
function [s,R]=findValidParents(N,mz,k)
    a=0;
    s=[];
    R=[];
    magStates=genMagStates(N,mz);
    for stateIndex=1:length(magStates)
        sa=magStates(stateIndex);
        Ra=checkstate(sa,N,k);
        if Ra>=0
            a=a+1;
            s(a)=sa;
            R(a)=Ra;
        end
    end
end