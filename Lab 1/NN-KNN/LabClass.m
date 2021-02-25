classdef LabClass
    properties
        N
        Mu
        Sigma
        R
        Cluster
        Contour
    end
    methods
        function obj = LabClass(arg1,arg2,arg3)
            % Assign
            obj.N = arg1;
            obj.Mu = arg2;
            obj.Sigma = arg3;
            
            % Generating Clusters
            obj.R = chol(obj.Sigma);
            obj.Cluster = repmat(obj.Mu,obj.N,1) + randn(obj.N,2)*obj.R;
            unit_circle = [cos((1:1000)/1000*2*pi); sin((1:1000)/1000*2*pi)]';
            obj.Contour = repmat(obj.Mu,length(unit_circle),1) + unit_circle*obj.R;
        end
    end
end