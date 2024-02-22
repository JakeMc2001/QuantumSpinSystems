% computes n = <phi|phi> = sum_i phi(i)^2
% then rescales phi so <phi|phi>=1
% phi is a vector with components i
function [newPhi,n]=normalize(phi)
    % create variable to store normalised state
    newPhi=phi;
    % calculate inner product
    n=dot(phi,phi);
    % initialise inner product
    %n=0;
    % calculate inner product by iterating over components
    %for i=1:length(phi)
    %    n = n + phi(i)^2;
    %end
    % this if statement may need to be changed into a range instead of ==
    if n==1
        return
    end
    % rescale newPhi so n==1
    newPhi=phi/sqrt(n);
end