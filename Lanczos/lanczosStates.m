% N = number of spins
% Lambda = number of lanczos iterations
% Psi = ground state approximation
% states = list of states phi_m generated
function states=lanczosStates(N,mz,k,Lambda)
    tic
    % find number of basis states
    [s,~]=findActiveParents(N,mz,k);
    M=length(s);
    % each column of states will be a generated basis state
    states=zeros(M,Lambda);
    nValues=zeros(1,Lambda);
    % generate the initial random state and normalize
    [phi0,n0]=normalise(rand(M,1));
    nValues(1)=n0;
    % append to storage
    states(:,1)=phi0;
    % apply H on phi0
    phi1=hoperation(phi0,N,mz,k);
    % calculate coefficient a0
    a0=dot(phi0,phi1);
    % calculate the un-normalised phi1
    phi1=phi0 - a0*phi1;
    % normalise phi1 and obtain n1=inner product of phi1
    [phi1,n1]=normalise(phi1);
    % store state phi1 and n1
    states(:,2)=phi1;
    nValues(2)=n1;
    nm=n1;
    % carry out remaining lanczos iterations
    for m=2:(Lambda-1)
        % phi0 = phi_(m-1)
        % phi1 = phi_m
        % phi2 = phi_(m+1)
        % apply H to current 
        phi2=hoperation(phi1,N,mz,k);
        % find coefficient am
        am=dot(phi1,phi2);
        % calculate un-normalised phi2
        phi2 = phi2 - am*phi1 - nm*phi0;
        % normalise phi2
        [phi2,nm]=normalise(phi2);
        % orthogonalise w.r.t. all previous states
        %for i=1:m
        %    phii=states(:,i);
        %    q=dot(phi2,phii);
        %    phi2 = (phi2 - q*phii)/(1-q^2);
        %end
        % store phi2 and nm
        states(:,m+1)=phi2;
        nValues(m+1)=nm;
        % check if Lanczos vector has gone to zero
        if all(phi2 == 0)
            states=states(:,1:(m+1));
            toc
            return
        end
        % re-define phi0 and phi1
        phi0=phi1;
        phi1=phi2;
    end
    toc
end