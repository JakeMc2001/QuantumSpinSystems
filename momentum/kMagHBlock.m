function [H,energy]=kMagHBlock(N,mz,k)
    tic
    % initialise energy eigenstate cell array
    energy={};
    % find the active parents for given mz and k
    [s,R]=findActiveParents(N,mz,k);
    toc
    % M = number of active parents
    M=length(s);
    % output number of active parents
    fprintf('Num of active parents: %d\n',M)
    % initialise H matrix for current k block
    H=zeros(M);
    % iterate over active parent states
    for a=1:M
        % sa = current active parent state
        sa=s(a);
        % get bit representation of sa
        sbits=bitget(sa,N:-1:1);
        % iterate over spins/bits of parent
        for i=1:N
            % find position of the next spin
            j=findNextSpin(i+1,N);
            % check if neighboring spins are parallel
            if sbits(i)==sbits(j)
                % spins parallel
                H(a,a)=H(a,a) + 1/4;
            else
                % spins anti-parallel
                H(a,a) = H(a,a) - 1/4;
                % flip spins in positions i and j
                sflipped = flipSpins(sbits,i,j);
                % find the parent of the flipped state
                [l,r]=findLj(sflipped,s);
                % find position of parent of flipped state
                b=findState(r,s);
                if b>=0
                    H(a,b) = H(a,b) + 0.5*(R(a)/R(b))^0.5 *exp(sqrt(-1)*2*pi*k*l/N);
                end
            end
        end
    end
    % calculate energy eigenvalues
    e=eig(H);
    if isempty(e)
        return
    end
    energy={mz,real(e.'),k};
    toc
    memoryUsed=sum([whos().bytes]);
    fprintf('Amount of memory used = %d Bytes\n',memoryUsed)
end
