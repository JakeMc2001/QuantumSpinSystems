% this function returns active parent states for the 24-site honeycomb lattice
% with momentum k
% uses operations.txt which stores all translations of the spin sites
function [parents,RList,lookUpTable]=activeNewparentsHoney24(k)
    tic
    parents=zeros(1,2^24);
    RList=zeros(1,2^24);
    % lookUpTable = b-1 | parent | lj+1 | index of parent
    lookUpTable=zeros(4,2^24);
    lookUpTable(1,:)=0:(2^24 -1);
    lookUpTable(2,:)=-1;
    numberOfParents=0;
    N=24;
    CharTable=CharTableHoney24();
    numberOfTranslations=12;
    % read list of operations/translations
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
    for i=0:(2^24 -1)
    %for i=0:1000
        if lookUpTable(2,i+1)~=-1
            continue
        end
        i
        orbit=zeros(1,numberOfTranslations);
        for g=1:numberOfTranslations
            translation=ops(g,:);
            newState=applyTranslation(i,N,translation);
            orbit(g)=newState;
        end
        % identify parent
        uniqueOrbit=unique(orbit,'stable');
        numberOfChildren=length(uniqueOrbit);
        [parent,R]=min(orbit);
        % check if parent is active
        if R==1 && k==0
            numberOfParents=numberOfParents+1;
            parents(numberOfParents)=parent;
            RList(numberOfParents)=R;
            lookUpTable(2,uniqueOrbit+1)=parent;
            lookUpTable(3,uniqueOrbit+1)=1:numberOfChildren;
            lookUpTable(4,uniqueOrbit+1)=numberOfParents;
        else
            sum=1;
            index=R+1;
            while index<numberOfTranslations
                sum = sum + conj(CharTable(k+1,index));
                index = index +R;
            end
            if abs(sum)>10^-4
                numberOfParents=numberOfParents+1;
                parents(numberOfParents)=parent;
                RList(numberOfParents)=R;
                lookUpTable(2,uniqueOrbit+1)=parent;
                lookUpTable(3,uniqueOrbit+1)=1:numberOfChildren;
                lookUpTable(4,uniqueOrbit+1)=numberOfParents;
            end
        end
    end
    parents=parents(1:numberOfParents);
    RList=RList(1:numberOfParents);
    toc
end