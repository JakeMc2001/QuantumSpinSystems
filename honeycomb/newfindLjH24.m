% findLj function for 24-site honeycomb lattice
function [lj,parent,index]=newfindLjH24(b,lookUpTable)
    % lookUpTable = b-1 | parent | lj+1
    parent=lookUpTable(2,b+1);
    lj=lookUpTable(3,b+1)-1;
    index=lookUpTable(4,b+1);
end