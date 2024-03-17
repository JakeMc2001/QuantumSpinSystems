% reads the list of parent states from text file
% and finds which are active for the given momentum
% k=0:11, corresponds to k points from "kCoeffs.txt"
function [ActiveParents,parentsR]=activeParentsHoney24(k)
    tic
    N=12;
    % read list of parents
    fileID=fopen("Honey24Parents.txt");
    sizeA=[2 Inf];
    parentsData=fscanf(fileID,'%i %i',sizeA);
    fclose(fileID);
    % define list of parents and R values
    parents=parentsData(1,:);
    RList=parentsData(2,:);
    % obtain character table
    CharTable=CharTableHoney24();
    % allocate arrays for active parents and R values
    ActiveParents=[];
    parentsR=[];
    % iterate over parent states
    for i=1:length(parents)
        parent=parents(i);
        R=RList(i);
        if R==1
            if k==0
                ActiveParents=[ActiveParents parent];
                parentsR=[parentsR R];
            end
        else
            sum=1;
            index=R+1;
            while index<N
                sum = sum + conj(CharTable(k+1,index));
                index = index + R;
            end
            if abs(sum)>10^-4
                ActiveParents = [ActiveParents parent];
                parentsR=[parentsR R];
            end
        end
    end
    toc
end