% this function returns all parent states for the 24-site honeycomb lattice
% uses operations.txt which stores all translations of the spin sites
function [parents,RList]=parentsHoney24()
    tic
    parents=[];
    RList=[];
    N=24;
    numberOfTranslations=12;
    % read list of operations/translations
    fileID = fopen("honeycomb/operations.txt");
    opsData = textscan(fileID,'%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s','HeaderLines',1);
    fclose(fileID);
    ops = [];
    % format operations into a matrix
    for m=1:24
        ops = [ops double(str2sym(opsData{m+1}))];
    end
    for i=0:(2^N-1)
        R=-1;
        % loop over translations - skip first as that is original state
        for g=2:numberOfTranslations
            translation=ops(g,:);
            newState=applyTranslation(i,N,translation);
            if newState < i
                break
            elseif newState==i
                R=g-1;
                parents=[parents i];
                RList=[RList R];
                break
            end
        end
    end
    toc
end