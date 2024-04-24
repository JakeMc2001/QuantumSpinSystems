% this function returns all parent states for the 24-site honeycomb lattice
% uses operations.txt which stores all translations of the spin sites
function [parents,RList,lookUpTable]=parentsHoney24(k)
    tic
    %parents=[];
    parents=zeros(1,2^24);
    %RList=[];
    RList=zeros(1,2^24);
    lookUpTable=zeros(2^24,2);
    lookUpTable(:,1)=0:(2^24 -1);
    lookUpTable(:,2)=-1;
    numberOfParents=1;
    N=24;
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
        i
        %R=-1;
        % loop over translations - skip first as that is original state
        %for g=numberOfTranslations:-1:1
        %notParent="false";
        %for g=2:numberOfTranslations
        counter=0;
        for g=numberOfTranslations:-1:1
            translation=ops(g,:);
            newState=applyTranslation(i,N,translation);
            if newState < i
                %notParent="true";
                break
            elseif newState==i
                if counter==0
                    R=0;
                else
                    R=g-1;
                end
                %parents=[parents i];
                parents(numberOfParents)=i;
                RList(numberOfParents)=R;
                numberOfParents=numberOfParents+1;
                %RList=[RList R];
                %notParent="true";
                break
            end
            counter=counter+1;
        end
        % if notParent=="false"
        %     R=1;
        %     parents=[parents i];
        %     RList=[RList R];
        % end
    end
    parents=parents(1:numberOfParents);
    RList=RList(1:numberOfParents);
    toc
end