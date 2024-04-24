function storage=parentLookUp(parents)
    tic
    fileID = fopen("honeycomb/operations.txt");
    opsData = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','HeaderLines',1);
    fclose(fileID);
    %ops = [];
    ops=zeros(12,24);
    % format operations into a matrix
    for m=1:24
        %ops = [ops double(str2sym(opsData{m+1}))];
        ops(:,m)=double(str2sym(opsData{m+1}));
    end
    totalStates=2^24;
    %totalStates=1000;
    % storage = state | parent | lj
    %storage=zeros(totalStates,3,'uint32');
    storage=zeros(totalStates,3);
    %states=uint32(0:2^24 -1);
    states=0:2^24-1;
    for i=1:totalStates
        state=states(i)
        storage(i,1)=state;
        bitState=bitget(state,24:-1:1);
        [lj,parent]=findLjH24(bitState,parents,ops);
        %storage(i,2)=uint32(parent);
        storage(i,2)=parent;
        %storage(i,3)=uint32(lj);
        storage(i,3)=lj;
    end
    toc
end