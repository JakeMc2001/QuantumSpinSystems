% find the states and k values for a list of parent states
% with their associated periodicities in the periods array
function states=findMomentumStates(parents,periods,N)
    n=length(parents);
    statesNum=sum(periods);
    states=zeros(3,statesNum);
    startBlock=0;
    for i=1:n
        currentParent=bitget(parents(i),N:-1:1);
        endBlock=startBlock+periods(i);
        orbit=getOrbit(currentParent,periods(i));
        states(1:2,startBlock+1:endBlock)=orbit(:,:);
        states(3,startBlock+1:endBlock)=periods(i);
        startBlock=endBlock;
    end
end