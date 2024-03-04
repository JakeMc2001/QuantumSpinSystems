% N = number of spins
% Lambda = number of lanczos iterations
% Psi = ground state approximation
% states = list of states phi_m generated
% H = non-zero Hamiltonian elements organised by column
function [states,H]=lanczosConverge(N,mz,k,Lambda)
    tic
    % find number of basis states
    [e,B,Harray]=numberOfHelements(N,mz,k);
    M=length(e);
    fprintf('numberOfHelements:\n')
    toc
    fprintf('Num of active parents: %d\n',M)
    % each column of states will be a generated basis state
    states=zeros(M,Lambda);
    % initialise H matrix
    H=zeros(Lambda);
    % generate the initial random state and normalize
    [phi1,~]=normalise(rand(M,1));
    % append to storage
    states(:,1)=phi1;
    % apply H on phi0
    gamma=hoperation(phi1,e,B,Harray);
    % calculate coefficient a1
    a1=dot(phi1,gamma);
    H(1,1)=a1;
    % diagonalise H and find current ground state energy
    energies=eig(H);
    % create array to store ground state energy
    energyList=zeros(1,Lambda);
    energyList(1)=min(energies);
    % calculate the un-normalised phi2
    phi2 = gamma - a1*phi1;
    % normalise phi1 and obtain n2=inner product of phi1
    [phi2,nm]=normalise(phi2);
    % store state phi2 and n2
    states(:,2)=phi2;
    % check if phi2 has gone to zero
    if all(phi2 == 0)
        states=states(:,1:2);
        H=H(1:2,1:2);
        toc
        return
    end
    % carry out lanczos iterations to Lambda-1
    for m=2:(Lambda-1)
        % phi1 = phi_(m-1)
        % phi2 = phi_m
        % phi3 = phi_(m+1)
        % apply H to current
        gamma=hoperation(phi2,e,B,Harray);
        % find coefficients am and bm
        am=dot(phi2,gamma);
        bm=dot(phi1,gamma);
        H(m,m)=am;
        H(m-1,m)=bm;
        H(m,m-1)=bm;
        % diagonalise H and find current ground state energy
        energies=eig(H);
        energyList(m)=min(energies);
        % check if ground state energy has converged
        % within a tolerance, currently 10^-10
        if abs(energyList(m-1)-energyList(m))<10^-10
            states=states(:,1:m);
            H=H(1:m,1:m);
            energyList=energyList(1:m);
            plotGSEnergy(energyList,m,N);
            toc
            memoryUsed=sum([whos().bytes]);
            fprintf('Amount of memory used = %d Bytes\n',memoryUsed)
            return
        end
        % calculate un-normalised phi3
        phi3 = gamma - am*phi2 - sqrt(nm)*phi1;
        % normalise phi3
        [phi3,nm]=normalise(phi3);
        % store phi3 and nm
        states(:,m+1)=phi3;
        % re-define phi0 and phi1
        phi1=phi2;
        phi2=phi3;
    end
    % perform final lanczos iteration, m=Lambda
    gamma=hoperation(phi2,e,B,Harray);
    am=dot(phi2,gamma);
    bm=dot(phi1,gamma);
    H(Lambda,Lambda)=am;
    H(Lambda-1,Lambda)=bm;
    H(Lambda,Lambda-1)=bm;
    plotGSEnergy(energyList,m,N);
    toc
    memoryUsed=sum([whos().bytes]);
    fprintf('Amount of memory used = %d Bytes\n',memoryUsed)
end