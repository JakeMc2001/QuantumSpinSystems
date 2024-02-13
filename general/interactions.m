classdef interactions
    properties
        name = []
        Nsites = []
        sites = {}
        strength = []
    end
    methods
        function obj=addHterm(obj,label,numOfSites,actsOnSites,amplitude)
            obj.name = [obj.name label];
            obj.Nsites = [obj.Nsites numOfSites];
            obj.sites = [obj.sites actsOnSites];
            obj.strength = [obj.strength amplitude];
        end
    end
end