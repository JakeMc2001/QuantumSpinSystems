% N = number of spins
% Lambda = number of lanczos iterations
% Psi = ground state approximation
% states = list of states phi_m generated
% H = non-zero Hamiltonian elements organised by column
function [states,H]=lanczosHamiltonian(N,mz,k,Lambda)
    % each column of states will be a generated basis state
    states=zeros(N,Lambda);
    nValues=zeros(1,Lambda);
    % initialise H matrix
    H=zeros(Lambda);
    % generate the initial random state and normalize
    [phi1,n1]=normalise(rand(N,1));
    nValues(1)=n1;
    % append to storage
    states(:,1)=phi1;
    % apply H on phi0
    phi2=hoperation(phi1,N,mz,k);
    % calculate coefficient a1
    a1=dot(phi1,phi2);
    H(1,1)=a1;
    % calculate the un-normalised phi2
    phi2=phi1 - a1*phi2;
    % normalise phi1 and obtain n2=inner product of phi1
    [phi2,n2]=normalise(phi2);
    % store state phi2 and n2
    states(:,2)=phi2;
    nValues(2)=n2;
    H(2,1)=n2;
    nm=n2;
    % carry out lanczos iterations to Lambda-1
    for m=2:(Lambda-1)
        % phi1 = phi_(m-1)
        % phi2 = phi_m
        % phi3 = phi_(m+1)
        % apply H to current
        phi3=hoperation(phi2,N,mz,k);
        %H(m-1,m)=dot(phi1,phi3);
        % find coefficient am
        am=dot(phi2,phi3);
        %H(m,m)=am;
        % calculate un-normalised phi3
        phi3 = phi3 - am*phi2 - nm*phi1;
        % normalise phi3
        [phi3,nm]=normalise(phi3);
        %H(m+1,m)=nm;
        % orthogonalise w.r.t. all previous states
        for i=1:m
            phii=states(:,i);
            q=dot(phi3,phii);
            phi3 = (phi3 - q*phii)/(1-q^2);
        end
        H(m-1,m)=dot(phi1,phi3);
        H(m,m)=dot(phi2,phi3);
        H(m+1,m)=dot(phi3,phi3);
        % store phi3 and nm
        states(:,m+1)=phi3;
        nValues(m+1)=nm;
        % re-define phi0 and phi1
        phi1=phi2;
        phi2=phi3;
    end
    % perform final lanczos iteration, m=Lambda
    phi3=hoperation(phi2,N,mz,k);
    am=dot(phi2,phi3);
    phi3 = phi3 - am*phi2 - nm*phi1;
    [phi3,~]=normalise(phi3);
    for i=1:Lambda
        phii=states(:,i);
        q=dot(phi3,phii);
        phi3 = (phi3 - q*phii)/(1-q^2);
    end
    H(Lambda-1,Lambda)=dot(phi1,phi3);
    H(Lambda,Lambda)=dot(phi2,phi3);
end