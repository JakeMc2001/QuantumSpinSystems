% acts Hamiltonian on state vector
% |gamma> = H|phi>
% ea = number of nonzero elements of H
% phi = array of components of |phi>
function gamma=hoperation(phi,N,mz,k)
    i=0;
    % obtain arrays of nonzero H elements and positons
    [e,B,H]=numberOfHelements(N,mz,k);
    % M = number of basis states = num of active parents
    [s,~]=findActiveParents(N,mz,k);
    M=length(s);
    gamma=zeros(M,1);
    %gamma=phi;
    for a=1:M
        ea=e(a);
        for j=1:ea
            i=i+1;
            %gamma(B(i))=gamma(B(i))+H(i)*phi(a);
            gamma(a)=gamma(a)+H(i)*phi(B(i));
            % if B(i)==a
            %     % divide by 2 as diagonal elements are double counted
            %     % as the two triangles of H have been combined
            %     gamma(a)=gamma(a)/2;
            % end
        end
    end
end