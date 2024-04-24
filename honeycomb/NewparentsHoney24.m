% this function returns active parent states for the 24-site honeycomb lattice
% with momentum k
% uses operations.txt which stores all translations of the spin sites
function [parents,RList,lookUpTable]=NewparentsHoney24(k)
    tic
    parents=zeros(1,2^24);
    RList=zeros(1,2^24);
    lookUpTable=zeros(2^24,3);
    lookUpTable(:,1)=0:(2^24 -1);
    lookUpTable(:,2)=-1;
    numberOfParents=1;
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
        if lookUpTable(i+1,2)~=-1
            continue
        end
        i
        counter=0;
        orbit=zeros(1,numberOfTranslations);
        for g=1:numberOfTranslations
            translation=ops(g,:);
            newState=applyTranslation(i,N,translation);
            orbit(g)=newState;
            % if newState < i
            %     %notParent="true";
            %     break
            % elseif newState==i
            %     if counter==0
            %         R=0;
            %     else
            %         R=g-1;
            %     end
            %     if R==0
            %         if k==0
            %             parents(numberOfParents)=i;
            %             RList(numberOfParents)=R;
            %             numberOfParents=numberOfParents+1;
            %         end
            %     else
            %         sum=1;
            %         index=R+1;
            %         while index<N
            %             sum=sum+conj(CharTable(k+1,index));
            %             index=index+R;
            %         end
            %         if abs(sum)>10^-4
            %             parents(numberOfParents)=i;
            %             RList(numberOfParents)=R;
            %             numberOfParents=numberOfParents+1;
            %         end
            %     end
            %     break
            % end
            % counter=counter+1;
        end
    end
    parents=parents(1:numberOfParents);
    RList=RList(1:numberOfParents);
    toc
end