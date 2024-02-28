% N = number of spins
% Lambda = number of lanczos iterations
% Psi = ground state approximation
% states = list of states phi_m generated
% H = non-zero Hamiltonian elements organised by column
function [states,H]=lanczosHamiltonian(N,mz,k,Lambda)
    tic
    % find number of basis states
    [s,~]=findActiveParents(N,mz,k);
    M=length(s);
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
    %phi2=hoperation(phi1,N,mz,k);
    gamma=hoperation(phi1,N,mz,k);
    % calculate coefficient a1
    %a1=dot(phi1,phi2);
    a1=dot(phi1,gamma);
    H(1,1)=a1;
    %H(2,1)=dot(phi2,phi2);
    %H(1,2)=dot(phi2,phi2);
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
        %phi3=hoperation(phi2,N,mz,k);
        gamma=hoperation(phi2,N,mz,k);
        %H(m-1,m)=dot(phi1,phi3);
        % find coefficient am
        am=dot(phi2,gamma);
        bm=dot(phi1,gamma);
        H(m,m)=am;
        H(m-1,m)=bm;
        H(m,m-1)=bm;
        %H(m-1,m)=dot(phi3,phi3);
        %H(m,m)=dot(phi2,phi3);
        %H(m+1,m)=dot(phi3,phi3);
        %H(m,m)=am;
        % calculate un-normalised phi3
        phi3 = gamma - am*phi2 - sqrt(nm)*phi1;
        %phi3 = phi3 - am*phi2 - nm*phi1;
        % normalise phi3
        [phi3,nm]=normalise(phi3);
        %nm=sqrt(nm);
        %H(m+1,m)=nm;
        % orthogonalise w.r.t. all previous states
        %for i=1:m
        %    phii=states(:,i);
        %    q=dot(phi3,phii);
        %    phi3 = (phi3 - q*phii)/(1-q^2);
        %end
        % H(m-1,m)=dot(phi1,phi3);
        % H(m,m)=dot(phi2,phi3);
        % H(m+1,m)=dot(phi3,phi3);
        % store phi3 and nm
        states(:,m+1)=phi3;
        % check if Lanczos vector has gone to zero
        if all(phi3 == 0)
            states=states(:,1:(m+1));
            H=H(1:m,1:m);
            toc
            return
        end
        % re-define phi0 and phi1
        phi1=phi2;
        phi2=phi3;
    end
    % perform final lanczos iteration, m=Lambda
    %phi3=hoperation(phi2,N,mz,k);
    gamma=hoperation(phi2,N,mz,k);
    %am=dot(phi2,phi3);
    am=dot(phi2,gamma);
    bm=dot(phi1,gamma);
    H(Lambda,Lambda)=am;
    H(Lambda-1,Lambda)=bm;
    H(Lambda,Lambda-1)=bm;
    %phi3 = gamma - am*phi2 - sqrt(nm)*phi1;
    %phi3 = phi3 - am*phi2 - nm*phi1;
    %[phi3,~]=normalise(phi3);
    % for i=1:Lambda
    %     phii=states(:,i);
    %     q=dot(phi3,phii);
    %     phi3 = (phi3 - q*phii)/(1-q^2);
    % end
    %H(Lambda-1,Lambda)=dot(phi1,phi3);
    %H(Lambda,Lambda)=dot(phi2,phi3);
    toc
end