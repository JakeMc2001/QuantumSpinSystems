% generate the momentum hamiltonian for magnetisation mz
% ordered by k=0,pi/2,pi,3pi/2
function H=momentumHamiltonian(N,mz)
    % determine the k values in units of pi
    %m=(-N/2 +1):(N/2);
    %m=0:(N/2 +1);
    m=0:N-1;
    k=(2/N)*m;
    % create empty cell array to store the H blocks
    blocks={};
    for i=1:length(k)
        currentH=fixedkHamiltonian(N,mz,k(i));
        blocks{i}=currentH;
    end
    H=blkdiag(blocks{:});
end