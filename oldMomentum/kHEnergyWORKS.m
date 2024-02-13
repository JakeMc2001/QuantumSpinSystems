% function created by following book as closely as possible
% works, don't touch it!!!!!!!!!!!!!
% this function returns an array of energy eigenvalues for N spins
function energyList=kHEnergyWORKS(N)
    % start timer
    tic
    % define array of momentum values
    m=(-N/2 +1):(N/2);
    kValues=(2*pi/N)*m;
    %initialise cell array to store energy eigenvalues
    energyList={};
    % index used to update position of the next entry to energyList
    index=0;
    % iterate over magnetisation values
    for mz=(-N/2):N/2
        % iterate over momentum values
        for ki=1:length(kValues)
            k=kValues(ki); % current momentum
            a=0; % number of active parents
            s=[]; % array to store active parents
            R=[]; % array to store periodicities of active parents
            % obtain an array of all states with the given magnetisation
            magStates=genMagStates(N,mz);
            % iterate over all states with given magnetisation
            for stateIndex=1:length(magStates)
                sa=magStates(stateIndex); % current state
                % check if current state is an active parent
                % Ra = -1 if sa is not an active parent (or not a parent)
                Ra=checkstate(sa,N,k);
                if Ra>=0
                    % current state is an active parent
                    % update number of active parents and relevant arrays
                    a=a+1;
                    s(a)=sa;
                    R(a)=Ra;
                end
            end
            M=a; % total number of active parents
            H=zeros(M); % initialise momentum block of Hamiltonian
            % iterate over active parent states
            for a=1:M
                sa=s(a); % current state
                sbits=bitget(sa,N:-1:1); % bit rep. of current state
                % iterate over bits/spins of current state
                for i=1:N
                    % find location of the next spin (periodic BCs)
                    j=findNextSpin(i+1,N);
                    % spins are equal, diagonal element in H
                    if sbits(i)==sbits(j)
                        H(a,a) = H(a,a) + 1/4;
                    % spins are not equal, off-diagonal element in H
                    else
                        H(a,a) = H(a,a) - 1/4;
                        % flip spins at sa(i) and sa(j)
                        sflipped=flipSpins(sbits,i,j);
                        % r = parent state of the flipped state
                        % l = number of translations to get from
                        % flipped state to r
                        [l,r]=findLj(sflipped,s);
                        % find the location of r in the array of
                        % active parents, b=-1 if not found
                        b=findState(r,s);
                        if b>=0
                            % location of r is found, update element in H
                            H(a,b) = H(a,b) + 0.5*(R(a)/R(b))^0.5 *exp(i*2*pi*k*l/N);
                        end
                    end
                end
            end
            % find energy eigenvalues
            e=eig(H);
            if isempty(e)
                continue
            end
            % update array of energy eigenvalues
            energyList(index+1,:)={mz,e.'};
            % update index based on size of the array
            [index,~]=size(energyList);
        end
    end
    % end timer and output runtime
    toc
end