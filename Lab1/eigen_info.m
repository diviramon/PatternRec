function [theta,contAxes] = eigen_info(sigma)
    %returns angle from horizontal axis to equiprobability contour axis as 
    %well as the square roots of the eigenvalues in a matrix (for the
    %lengths of the axes
    [eigvec, eigval] = eig(sigma) ;
    theta = atan(eigvec(2,1)/eigvec(1,1));
    
    if (theta < 0) || (theta > pi) || (eigvec(2,1) < 0 && eigvec(1,1) < 0)
        theta = atan(eigvec(2,2)/eigvec(1,2));
    end
    
    contAxes = sqrt(eigval);
end