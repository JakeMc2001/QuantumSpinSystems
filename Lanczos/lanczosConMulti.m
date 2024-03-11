% stores the energy eigenvalues over Lanczos iterations
% for the 5 lowest energy eigenstates
% with no convergence criteria in place
function H=lanczosConMulti(N,mz,k,Lambda)
    tic
    % find number of basis states
    [e,B,Harray]=numberOfHelements(N,mz,k);
    M=length(e);
    fprintf('numberOfHelements:\n')
    toc
    fprintf('Num of active parents: %d\n',M)
    % initialise H matrix
    H=zeros(Lambda);
    % generate the initial random state and normalize
    [phi1,~]=normalise(rand(M,1));
    % apply H on phi0
    gamma=hoperation(phi1,e,B,Harray);
    % calculate coefficient a1
    a1=dot(phi1,gamma);
    H(1,1)=a1;
    % diagonalise H and find current ground state energy
    energies=eig(H);
    % create array to store ground state energy
    energyList=zeros(5,Lambda);
    energyList(1:5,1)=energies(1:5);
    % calculate the un-normalised phi2
    phi2 = gamma - a1*phi1;
    % normalise phi1 and obtain n2=inner product of phi1
    [phi2,nm]=normalise(phi2);
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
        energyList(1:5,m)=energies(1:5);
        % calculate un-normalised phi3
        phi3 = gamma - am*phi2 - sqrt(nm)*phi1;
        % normalise phi3
        [phi3,nm]=normalise(phi3);
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
    energies=eig(H);
    energyList(1:5,Lambda)=energies(1:5);
    plotlowestEnergies(real(energyList),Lambda,N);
    toc
    memoryUsed=sum([whos().bytes]);
    fprintf('Amount of memory used = %d Bytes\n',memoryUsed)
end