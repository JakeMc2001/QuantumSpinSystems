% acts Hamiltonian on state vector
% |gamma> = H|phi>
% ea = number of nonzero elements of H
% phi = array of components of |phi>
function gamma=hoperation(phi,e,B,H)
    % M = number of basis states = num of active parents
    M=length(e);
    i=0;
    gamma=zeros(M,1);
    for a=1:M
        ea=e(a);
        for j=1:ea
            i=i+1;
            gamma(a)=gamma(a)+H(i)*phi(B(i));
        end
    end
end